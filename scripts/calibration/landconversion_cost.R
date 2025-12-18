# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# *********************************************************************
# ***    This script calculates a regional calibration factor       ***
# ***              based on a pre run of magpie                     ***
# *********************************************************************

# Wrapper function that executes code with comprehensive logging
# Captures cat(), messages, warnings, and errors
with_logging <- function(expr, logfile, putfolder) {
  # create putfolder for the calib run
  cat(paste0("Deleting putfolder: ", putfolder, "\n"))
  unlink(putfolder, recursive = TRUE)
  cat(paste0("Creating putfolder: ", putfolder, "\n"))
  dir.create(putfolder)
  # Open file connection for logging
  logfile_conn <- file(paste0(putfolder, "/", logfile), open = "a")

  # Redirect both stdout and stderr to the same log file
  sink(logfile_conn)
  sink(logfile_conn, type = "message")

  tryCatch(
    {
      cat("=== COMPREHENSIVE LOGGING ACTIVE (cat/messages/warnings/errors) ===\n")
      force(expr)  # Execute the expression
    },
    error = function(e) {
      timestamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
      cat(paste0("[", timestamp, "] ERROR: ", conditionMessage(e), "\n"))
      # Error already logged, now close sinks and connection
      try(sink(type = "message"), silent = TRUE)
      try(sink(), silent = TRUE)
      try(close(logfile_conn), silent = TRUE)
      stop(e)  # Re-throw the error after logging
    },
    finally = {
      cat("=== LOGGING SESSION COMPLETE ===\n")
      # Close sinks and connection safely even if an error occurred
      try(sink(type = "message"), silent = TRUE)
      try(sink(), silent = TRUE)
      try(close(logfile_conn), silent = TRUE)
    }
  )
}

calibration_run <- function(putfolder, calib_magpie_name, logoption, s_use_gdx) {
  require(lucode2)
  require(magpie4)

  cat("=== CALIBRATION_RUN START ===\n")
  cat(paste0("Putfolder: ", putfolder, ", s_use_gdx: ", s_use_gdx, "\n"))

  # create a modified magpie.gms for the calibration run
  unlink(paste(calib_magpie_name, ".gms", sep = ""))
  unlink("fulldata.gdx")

  if (!file.copy("main.gms", paste(calib_magpie_name, ".gms", sep = ""), overwrite = TRUE)) {
    stop(paste("Unable to create", paste(calib_magpie_name, ".gms", sep = "")))
  }
  lucode2::manipulateConfig(paste(calib_magpie_name, ".gms", sep = ""), c_timesteps = "calib")
  lucode2::manipulateConfig(paste(calib_magpie_name, ".gms", sep = ""), s_use_gdx = s_use_gdx)
  file.copy(paste(calib_magpie_name, ".gms", sep = ""), putfolder, overwrite = TRUE)

  # execute calibration run
  cat("Starting GAMS run...\n")
  system(paste("gams ", calib_magpie_name, ".gms", " -errmsg=1 -PUTDIR ./", putfolder, " -LOGOPTION=", logoption, sep = ""), wait = TRUE)
  cat("GAMS run completed\n")
  file.copy("fulldata.gdx", putfolder)

  cat("Clearing cache...\n")
  # Clear memoise cache immediately after GAMS completes
  clearCacheMagpie4()

  cat("=== CALIBRATION_RUN END ===\n")
}

getValData <- function(histData, gdx_file) {
  require(magpie4)
  require(magclass)
  require(gdx2)
  cat("=== retrieve validation data ===\n")
  y <- readGDX(gdx_file,"t")
  magpie <- land(gdx_file)[, y, "crop"]
  if (histData == "MAgPIEown") {
    hist <- dimSums(readGDX(gdx_file, "f10_land")[, , "crop"], dim = 1.2)
    valdata <- hist[, y, "crop"]
  } else if (histData == "FAO") {
    if(file.exists("calib_data.rds")) {
      val <- readRDS("calib_data.rds")
    } else {
      val <- read.report("input/validation.mif", as.list = FALSE)
      val <- val[getRegions(magpie),getYears(magpie),"historical.FAO_crop_past.Resources|Land Cover|+|Cropland (million ha)"]
      names(dimnames(val)) <- names(dimnames(magpie))
      getNames(val) <- "crop"
      saveRDS(val, file = "calib_data.rds")
    }
    valdata <- val[,y,]
  } else {stop("unkown histData")}
  if (nregions(magpie) != nregions(valdata) | !all(getRegions(magpie) %in% getRegions(valdata))) {
    stop("Regions in MAgPIE do not agree with regions in reference calibration area data set!")
  }
  cat("=== validation data retrieved ===\n")
  return(valdata)
}

expandHist <- function(valdata){
  require(magclass)
  # test whether land has expanded or contracted in validation data
  expandHist <- valdata
  for (i in 2:length(getYears(valdata))) {
    expandHist[ , i, ] <- setYears(valdata[, i, ], NULL) - setYears(valdata[, i-1, ], NULL)
  }
  return(expandHist)
}

# get ratio between modelled area and reference area

getCalibFactor <- function(gdx_file, mode, histData) {

  require(magclass)
  cat("=== GET_CALIB_FACTOR START ===\n")
  cat(paste0("GDX file: ", gdx_file, "\n"))
  cat(paste0("Mode: ", mode, ", histData: ", histData, "\n"))

  valdata <- getValData(histData = histData, gdx_file = gdx_file)
  magpie <- land(gdx_file)[, getYears(valdata), "crop"]

  if (mode == "gradient") {
    cat(">>> gradient calibration \n")
    # Calibration should not target absolute difference to goal, but matching the increase over time.
    # Otherwise, calibration of first timestep will implicitly also calibrate all further timesteps.
    expansion_magpie <- expansion_valdata <- valdata * 0
    for (timestep in 2:length(getYears(expansion_magpie))) {
      expansion_magpie[,timestep,] <- magpie[,timestep,] / setYears(magpie[,timestep - 1,], NULL)
      expansion_valdata[,timestep,] <- valdata[,timestep,] / setYears(valdata[,timestep - 1,], NULL)
    }
    # if magpie expands more than valdata, out should be smaller than 1
    out <- expansion_magpie - expansion_valdata + 1
  } else {
    cat(">>> timestep calibration \n")
    out <- magpie / valdata
  }
  getNames(out) <- NULL
  out[out <= 0.1] <- 0.1 # make sure the multiplier doesnt drop to 0, as this could not be reverted in future iterations
#  out[is.na(out)] <- 1 commenting this out, as NA, NAN and Inf should never be the case except for bugs, in which case they should stay visible
#  out[is.nan(out)] <- 1
#  out[is.infinite(out)] <- 1
  
  return(magpiesort(out))
}

time_series_cost <- function(calib_factor) {
  out2 <- new.magpie(getRegions(calib_factor), years = c(seq(1995, 2020, by = 5), seq(2050, 2150, by = 5)), fill = 1)
  out2[, getYears(calib_factor), ] <- calib_factor
  # use average of last two timesteps for 2020
  out2050 <- out2[,"y2020",] <- (setYears(calib_factor[,"y2010",],NULL) + setYears(calib_factor[,"y2015",],NULL))/2
  # in case calibration factors are below 1, increase them to 1 until 2050. If they are above 1, keep them as is.
  out2050[out2050 < 1] <- 1
  out2[, seq(2050, 2150, by = 5), ] <- out2050
  out2 <- time_interpolate(out2, seq(2025, 2050, by = 5), integrate_interpolated_years = T)
  return(out2)
}

time_series_reward <- function(calib_factor) {
  out2 <- new.magpie(getRegions(calib_factor), years = c(seq(1995, 2020, by = 5), seq(2050, 2150, by = 5)), fill = 0)
  out2[, getYears(calib_factor), ] <- calib_factor
  out2[,"y2020",] <- (setYears(calib_factor[,"y2010",],NULL) + setYears(calib_factor[,"y2015",],NULL))/2
  out2 <- time_interpolate(out2, seq(2025, 2050, by = 5), integrate_interpolated_years = T)
  return(out2)
}

# Calculate the correction factor and save it
update_calib <- function(gdx_file, calib_accuracy, calib_file, cost_max, cost_min, calibration_step, n_maxcalib, best_calib, histData, putfolder, levelGradientMix) {
  require(magclass)
  require(magpie4)
  require(gdx2)

  cat(paste0("=== UPDATE_CALIB ITERATION ", calibration_step, " START ===\n"))
  cat(paste0("GDX file: ", gdx_file, "\n"))
  cat(paste0("calib_accuracy: ", calib_accuracy, "\n"))

  if (!(modelstat(gdx_file)[1, 1, 1] %in% c(1, 2, 7))) stop("Calibration run infeasible")


  
  # we calculate two different divergence measures: divergence of level (cropland and divergence of gradient (cropland expansion)
  calib_divergence_level <- getCalibFactor(gdx_file, mode = "level", histData = histData)
  calib_divergence_gradient <- getCalibFactor(gdx_file, mode = "gradient", histData = histData)
  # mixing calibration approaches for making the best of both approaches
  calib_divergence <- levelGradientMix * calib_divergence_level + (1 - levelGradientMix) * calib_divergence_gradient
  
  # we calculate the correction factor based on a mix of the two divergence measures
  # gradient should lead to faster convergence and better match of gradinet for forwardlooking results
  # gradient has disadvantage that the error from incomplete convergence accumulates over time
  # level calibration has advantage that errors from one timestep are balanced out in subsequent timestep.
 
  calib_correction <- calib_divergence
  # dont modify calibration in first timestep, as otherwise its like a second yield calibration
  calib_correction[,1,] <- 1
 
  ### -> in case it is the first step, it forces the initial factors to be equal to 1
  if (file.exists(calib_file)) {
    cat(">>> Starting with existing calibration file\n")
    old_calib <- magpiesort(read.magpie(calib_file))[,getYears(calib_divergence),]
  } else {
    cat(">>> First iteration - initializing calibration factors (cost=1 for expanding countries, cost=2.5 for contracting, reward=0)\n")
    old_calib <- new.magpie(cells_and_regions = getCells(calib_divergence), years = getYears(calib_divergence), names = c("cost", "reward"), fill = NA)
    old_calib[,,"cost"] <- (expandHist(getValData(histData = histData, gdx_file = gdx_file)) < 0) * (cost_max - 1) + 1
    old_calib[,,"reward"] <- 0
  }

  ### use first steps to calibrate stronger, such that calibration factors can also achieve low/high levels
  if(calibration_step <= 4) {
    reinforcement <- 10
  } else if (calibration_step <= 7) {
    reinforcement <- 5 
  } else {
    reinforcement <- 1
  } 
  
  cat(">>> Calib factors are adjusted where needed\n")
  calib_factor_cost <- setNames(old_calib[, , "cost"], NULL) * calib_correction ^ reinforcement
  calib_factor_reward <- setNames(old_calib[, , "reward"], NULL) + (calib_correction - 1) * reinforcement
  # no rewards in case that validation data shows no contraction
  calib_factor_reward[expandHist(getValData(histData = histData, gdx_file = gdx_file)) >= 0] <- 0
  calib_factor_reward[calib_factor_reward < 0] <- 0

  cat(">>> Account for cost_max and cost_min\n")
  if (!is.null(cost_max)) {
    above_limit <- (calib_factor_cost >= cost_max)
    calib_factor_cost[above_limit] <- cost_max
  }

  if (!is.null(cost_min)) {
    below_limit <- (calib_factor_cost <= cost_min)
    calib_factor_cost[below_limit] <- cost_min
  }

  cat(">>> write down current calib factors (and area_factors) for tracking\n")
  write_log <- function(x, file, calibration_step) {
    x <- add_dimension(x, dim = 3.1, add = "iteration", nm = paste0("iter", calibration_step))
    try(write.magpie(round(x, 3), file, append = (calibration_step != 1)))
  }

  write_log(calib_divergence_level, paste0(putfolder, "/land_conversion_divergence_level.cs3"), calibration_step)
  write_log(calib_divergence_gradient, paste0(putfolder,  "/land_conversion_divergence_gradient.cs3"), calibration_step)
  write_log(calib_divergence, paste0(putfolder,  "/land_conversion_divergence.cs3"), calibration_step)
  write_log(calib_factor_cost, paste0(putfolder,  "/land_conversion_cost_next_calib_factor.cs3"), calibration_step)
  write_log(calib_factor_reward, paste0(putfolder,  "/land_conversion_reward_next_calib_factor.cs3"), calibration_step)
  write_log(setNames(old_calib[, , "reward"], NULL), paste0(putfolder,  "/land_conversion_reward_current_calib_factor.cs3"), calibration_step)
  write_log(setNames(old_calib[, , "cost"], NULL), paste0(putfolder,  "/land_conversion_cost_current_calib_factor.cs3"), calibration_step)

  # in case of sufficient convergence, stop here (no additional update of calibration factors!)

  if (all(abs(calib_divergence - 1) <= calib_accuracy) | calibration_step == n_maxcalib) {

    ### Depending on the selected calibration selection type (best_calib FALSE or TRUE)
    # the reported and used regional calibration factors can be either the ones of the last iteration,
    # or the "best" based on the iteration value with the lowest standard deviation of regional divergence.
    if (best_calib == TRUE) {
      cat("Choosing the best calibration...\n")
      divergence_data <- read.magpie( paste0(putfolder, "/land_conversion_divergence.cs3"))
      factors_cost <- read.magpie( paste0(putfolder, "/land_conversion_cost_current_calib_factor.cs3"))
      factors_reward <- read.magpie( paste0(putfolder, "/land_conversion_reward_current_calib_factor.cs3"))
      # The best iteration is chosen for each region as the calibration factors where the sum of divergence over all timesteps is minimal.
      # In case multiple iterations have the same value, the first value is returned by which.min
      calib_cost_best <- calib_reward_best <- factors_cost[,,1] * 0
      for(i in getRegions(divergence_data)) {
        # use sum(log(divergence_data+1) as divergence_data is (magpie/data-1), and relative divergence should be equally punished in both directions
        best_iteration <- which.min(dimSums(abs(log(divergence_data[i,,])), dim = 2))
        calib_cost_best[i,,] <- factors_cost[i,,best_iteration]
        calib_reward_best[i,,] <- factors_reward[i,,best_iteration]
      }
      getNames(calib_cost_best) <- NULL
      getNames(calib_reward_best) <- NULL
 
      write_log(calib_cost_best,  paste0(putfolder, "/land_conversion_cost_current_calib_factor.cs3"), "best")
      write_log(calib_reward_best,  paste0(putfolder, "/land_conversion_reward_current_calib_factor.cs3"), "best")
  
      calib_cost_best <- time_series_cost(calib_cost_best)
      calib_reward_best <- time_series_reward(calib_reward_best)
  
      calib_best_full <- mbind(
        add_dimension(calib_cost_best, dim = 3.1, nm = "cost"),
        add_dimension(calib_reward_best, dim = 3.1, nm = "reward")
      )
      calib_best_full[is.na(calib_best_full)] <- 1

      comment <- c(
        " description: Regional land conversion cost calibration file",
        " unit: -",
        paste0(" note: Best calibration factor from the run"),
        " origin: scripts/calibration/landconversion_cost.R (path relative to model main directory)",
        paste(" Calibration settings:",  "calib_accuracy=", calib_accuracy, "cost_max=", cost_max, "cost_min=", cost_min, "n_maxcalib=",n_maxcalib, "best_calib=",best_calib, "histData=",histData),
        paste0(" creation date: ", date())
      )
      write.magpie(round(calib_best_full, 3), calib_file, comment = comment)


      ####
      return(TRUE)
    } else {
      return(TRUE)
    }
  } else {
    cat("Adjust calibration factors for next iteration \n")
    calib_factor_cost <- time_series_cost(calib_factor_cost)
    calib_factor_reward <- time_series_reward(calib_factor_reward)

    calib_full <- mbind(
      add_dimension(calib_factor_cost, dim = 3.1, nm = "cost"),
      add_dimension(calib_factor_reward, dim = 3.1, nm = "reward")
    )
    calib_full[is.na(calib_full)] <- 1

    comment <- c(
      " description: Regional land conversion cost calibration file",
      " unit: -",
      paste0(" note: Calibration step ", calibration_step),
      " origin: scripts/calibration/landconversion_cost.R (path relative to model main directory)",
      paste(" Calibration settings:",  "calib_accuracy=", calib_accuracy, "cost_max=", cost_max, "cost_min=", cost_min, "n_maxcalib=",n_maxcalib, "best_calib=",best_calib, "histData=",histData),
      paste0(" creation date: ", date())
    )

    write.magpie(round(calib_full, 3), calib_file, comment = comment)
    return(FALSE)
  }
}




calibrate_landconversion <- function(n_maxcalib = 20,
                             restart = FALSE,
                             calib_accuracy = 0.01,
                             cost_max = 2.5,
                             cost_min = 0.2,
                             calib_magpie_name = "magpie_calib",
                             calib_file = "modules/39_landconversion/input/f39_calib.csv",
                             putfolder = "land_conversion_cost_calib_run",
                             data_workspace = NULL,
                             logoption = 3,
                             debug = FALSE,
                             best_calib = TRUE,
                             histData = "FAO",
                             levelGradientMix = 0.3) {
  require(magclass)

  if (!restart) {
    cat(paste0("\nStarting land conversion cost calibration from default values\n"))
    if (file.exists(calib_file)) file.remove(calib_file)
  } else {
    if (file.exists(calib_file)) cat(paste0("\nStarting land conversion cost calibration from existing values\n")) else cat(paste0("\nStarting land conversion cost calibration from default values\n"))
  }

  # Clear log file at start
  if (file.exists("calibration_debug.log")) file.remove("calibration_debug.log")
  # Wrap entire calibration process with comprehensive logging
  with_logging({
    cat("##################################################################\n")
    cat("### CALIBRATE_MAGPIE START ###\n")
    cat("##################################################################\n")
	
	s_use_gdx <- 0
    for (i in 1:n_maxcalib) {
      
      cat(paste0("### ITERATION ", i, " START (s_use_gdx = ", s_use_gdx, ") ###\n"))

      calibration_run(putfolder = putfolder, calib_magpie_name = calib_magpie_name, logoption = logoption, s_use_gdx = s_use_gdx)

      if (debug) {
        # Copy listing file with iteration number for debugging
        if (file.exists(paste0(calib_magpie_name, ".lst"))) {
          file.copy(paste0(calib_magpie_name, ".lst"), paste0(putfolder, "/", calib_magpie_name, "_iter", i, ".lst"), overwrite = TRUE)
        }
        file.copy(paste0(putfolder, "/fulldata.gdx"), paste0(putfolder, "/", "fulldata_calib", i, ".gdx"), overwrite = TRUE)
      }

      done <- update_calib(gdx_file = "fulldata.gdx", calib_accuracy = calib_accuracy, cost_max = cost_max, cost_min = cost_min, 
                           calib_file = calib_file, calibration_step = i, n_maxcalib = n_maxcalib, best_calib = best_calib, histData = histData,
                           putfolder = putfolder, levelGradientMix = levelGradientMix)

      if (done & s_use_gdx == 2) {
        s_use_gdx <- 0
        next
      } else if (done & s_use_gdx == 0) {
        break
      } else {
        s_use_gdx <- 2
      }
    }

    # delete calib_magpie_gms in the main folder
    unlink(paste0(calib_magpie_name, ".*"))
    unlink("fulldata.gdx")
    unlink("calib_data.rds")

    cat("\nLand conversion cost calibration finished\n")
  }, logfile = "calibration_debug.log", putfolder = putfolder)
}
