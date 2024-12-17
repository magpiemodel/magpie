# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# *********************************************************************
# ***    This script calculates a regional calibration factor       ***
# ***              based on a pre run of magpie                     ***
# *********************************************************************

calibration_run <- function(putfolder, calib_magpie_name, logoption = 3, s_use_gdx = 0) {
  require(lucode2)

  # create putfolder for the calib run
  unlink(putfolder, recursive = TRUE)
  dir.create(putfolder)

  # create a modified magpie.gms for the calibration run
  unlink(paste(calib_magpie_name, ".gms", sep = ""))
  unlink("fulldata.gdx")

  if (!file.copy("main.gms", paste(calib_magpie_name, ".gms", sep = ""))) {
    stop(paste("Unable to create", paste(calib_magpie_name, ".gms", sep = "")))
  }
  lucode2::manipulateConfig(paste(calib_magpie_name, ".gms", sep = ""), c_timesteps = "calib")
  lucode2::manipulateConfig(paste(calib_magpie_name, ".gms", sep = ""), s_use_gdx = s_use_gdx)
  file.copy(paste(calib_magpie_name, ".gms", sep = ""), putfolder)

  # execute calibration run
  system(paste("gams ", calib_magpie_name, ".gms", " -errmsg=1 -PUTDIR ./", putfolder, " -LOGOPTION=", logoption, sep = ""), wait = TRUE)
  file.copy("fulldata.gdx", putfolder)
}

# get ratio between modelled area and reference area

getCalibFactor <- function(gdx_file, mode = "cost", calib_accuracy = 0.05, lowpass_filter = 1) {
  require(magclass)
  require(magpie4)
  require(gdx2)
  y <- readGDX(gdx_file,"t")
  magpie <- land(gdx_file)[, y, "crop"]
  hist <- dimSums(readGDX(gdx_file, "f10_land")[, , "crop"], dim = 1.2)
  data <- hist[, y, "crop"]
  shrLost <- (setYears(hist[getRegions(magpie), 2015, ], NULL) - setYears(hist[getRegions(magpie), 1995, ], NULL)) / setYears(hist[getRegions(magpie), 1995, ], NULL)
  if (nregions(magpie) != nregions(data) | !all(getRegions(magpie) %in% getRegions(data))) {
    stop("Regions in MAgPIE do not agree with regions in reference calibration area data set!")
  }
  if (mode == "cost") {
    out <- magpie / data
    out[out == 0] <- 1
    out[is.na(out)] <- 1
    getNames(out) <- NULL

    out[which(out < 0, arr.ind = T)] <- 1
  } else if (mode == "reward") {
    out <- magpie / data - 1
    out[is.na(out)] <- 0
    getNames(out) <- NULL

    # only reward if share of cropland lost between 1995 and 2015 exceeds a certain threshold. Otherwise set to 0.
    out[rownames(which(shrLost > -calib_accuracy, arr.ind = T)),,] <- 0
    out[which(out < 0, arr.ind = T)] <- 0
  }
  out <- lowpass(out,i = lowpass_filter)
  return(magpiesort(out))
}

time_series_cost <- function(calib_factor) {
  out2 <- new.magpie(getRegions(calib_factor), years = c(seq(1995, 2015, by = 5), seq(2050, 2150, by = 5)), fill = 1)
  out2[, getYears(calib_factor), ] <- calib_factor
  out2050 <- setYears(calib_factor[,2015,],NULL)
  out2050[out2050 < 1] <- 1
  out2[, seq(2050, 2150, by = 5), ] <- out2050
  out2 <- time_interpolate(out2, seq(2020, 2050, by = 5), integrate_interpolated_years = T)
  return(out2)
}

time_series_reward <- function(calib_factor) {
  out2 <- new.magpie(getRegions(calib_factor), years = c(seq(1995, 2015, by = 5), seq(2050, 2150, by = 5)), fill = 0)
  out2[, getYears(calib_factor), ] <- calib_factor
  out2 <- time_interpolate(out2, seq(2020, 2050, by = 5), integrate_interpolated_years = T)
  return(out2)
}

getHistCrop <- function() {
  rep <- read.report("input/validation.mif", as.list = FALSE)
  crop <- collapseNames(rep[, , "historical.FAO_crop_past.Resources|Land Cover|+|Cropland (million ha)"])
  return(crop)
}

# Calculate the correction factor and save it
update_calib <- function(gdx_file, calib_accuracy = 0.05, lowpass_filter = 1, calib_file, cost_max = 3, cost_min = 0.05, calibration_step = "", n_maxcalib = 40, best_calib = FALSE) {
  require(magclass)
  require(magpie4)
  require(gdx2)
  if (!(modelstat(gdx_file)[1, 1, 1] %in% c(1, 2, 7))) stop("Calibration run infeasible")
  
  y <- readGDX(gdx_file,"t")

  calib_correction_cost <- getCalibFactor(gdx_file, mode = "cost", calib_accuracy = calib_accuracy, lowpass_filter = lowpass_filter)
  calib_divergence_cost <- abs(calib_correction_cost - 1)

  calib_correction_reward <- getCalibFactor(gdx_file, mode = "reward", calib_accuracy = calib_accuracy, lowpass_filter = lowpass_filter)
  calib_divergence_reward <- abs(calib_correction_reward)
  
  ### -> in case it is the first step, it forces the initial factors to be equal to 1
  if (file.exists(calib_file)) {
    old_calib <- magpiesort(read.magpie(calib_file))[,y,]
    start_flag <- FALSE
  } else {
    old_calib <- new.magpie(cells_and_regions = getCells(calib_divergence_cost), years = y, names = c("cost", "reward"), fill = 1)
    old_calib[,,"reward"] <- 0
    start_flag <- TRUE
  }

  calib_factor_cost <- setNames(old_calib[, , "cost"], NULL) * calib_correction_cost
  calib_factor_reward <- setNames(old_calib[, , "reward"], NULL) + calib_correction_reward
  calib_factor_reward[calib_factor_reward < 0] <- 0
  
  if (!start_flag) {
    # use calibration factors where accuracy was reached
    # use stricter divergence threshold in first 5 calibration_step steps
    cost_acc_reached <- calib_divergence_cost <= ifelse(calibration_step < 6, 0.01, calib_accuracy)
    calib_factor_cost[cost_acc_reached] <- setNames(old_calib[, , "cost"], NULL)[cost_acc_reached]

    reward_acc_reached <- calib_divergence_reward <= ifelse(calibration_step < 6, 0.01, calib_accuracy)
    calib_factor_reward[reward_acc_reached] <- setNames(old_calib[, , "reward"], NULL)[reward_acc_reached]
  }

  if (!is.null(cost_max)) {
    # if reward exists, set cost calibration to cost_max
    reward_exists <- (calib_factor_reward > 0)
    calib_factor_cost[reward_exists] <- cost_max
    
    # set value for India to cost_max for better convergence
    if ("IND" %in% getRegions(calib_factor_cost)) {
      calib_factor_cost["IND", , ] <- cost_max
    }
    
    # set value for CAZ to cost_max for better convergence
    if ("CAZ" %in% getRegions(calib_factor_cost)) {
      calib_factor_cost["CAZ", , ] <- cost_max
    }
    
    above_limit <- (calib_factor_cost >= cost_max)
    calib_factor_cost[above_limit] <- cost_max
    calib_divergence_cost[getRegions(calib_factor_cost), , ][above_limit] <- 0
  }

  if (!is.null(cost_min)) {
    below_limit <- (calib_factor_cost <= cost_min)
    calib_factor_cost[below_limit] <- cost_min
    calib_divergence_cost[getRegions(calib_factor_cost), , ][below_limit] <- 0
  }

  ### write down current calib factors (and area_factors) for tracking
  write_log <- function(x, file, calibration_step) {
    x <- add_dimension(x, dim = 3.1, add = "iteration", nm = paste0("iter", calibration_step))
    try(write.magpie(round(x, 3), file, append = (calibration_step != 1)))
  }

  write_log(calib_correction_cost, "land_conversion_cost_calib_correction.cs3", calibration_step)
  write_log(calib_divergence_cost, "land_conversion_cost_calib_divergence.cs3", calibration_step)
  write_log(calib_factor_cost, "land_conversion_cost_calib_factor.cs3", calibration_step)

  write_log(calib_correction_reward, "land_conversion_reward_calib_correction.cs3", calibration_step)
  write_log(calib_divergence_reward, "land_conversion_reward_calib_divergence.cs3", calibration_step)
  write_log(calib_factor_reward, "land_conversion_reward_calib_factor.cs3", calibration_step)

  # in case of sufficient convergence, stop here (no additional update of
  # calibration factors!)

  if (all(all(calib_divergence_cost <= calib_accuracy) & all(calib_divergence_reward <= calib_accuracy)) | calibration_step == n_maxcalib) {

    ### Depending on the selected calibration selection type (best_calib FALSE or TRUE)
    # the reported and used regional calibration factors can be either the ones of the last iteration,
    # or the "best" based on the iteration value with the lowest standard deviation of regional divergence.
    if (best_calib == TRUE) {
      divergence_data <- read.magpie("land_conversion_cost_calib_divergence.cs3")
      factors_data <- read.magpie("land_conversion_cost_calib_factor.cs3")
      calib_cost_best <- factors_data[, , which.min(apply(as.array(divergence_data), c(3), sd))]
      getNames(calib_cost_best) <- NULL
      calib_cost_best <- time_series_cost(calib_cost_best)

      divergence_data <- read.magpie("land_conversion_reward_calib_divergence.cs3")
      factors_data <- read.magpie("land_conversion_reward_calib_factor.cs3")
      calib_reward_best <- factors_data[, , which.min(apply(as.array(divergence_data), c(3), sd))]
      getNames(calib_reward_best) <- NULL
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
        paste0(" creation date: ", date())
      )
      write.magpie(round(calib_best_full, 3), calib_file, comment = comment)

      write_log(calib_best_full[, , "cost"], "land_conversion_cost_calib_factor.cs3", "best")
      write_log(calib_best_full[, , "reward"], "land_conversion_reward_calib_factor.cs3", "best")
      ####
      return(TRUE)
    } else {
      return(TRUE)
    }
  } else {
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
      paste0(" creation date: ", date())
    )

    write.magpie(round(calib_full, 3), calib_file, comment = comment)
    return(FALSE)
  }
}




calibrate_magpie <- function(n_maxcalib = 40,
                             restart = TRUE,
                             calib_accuracy = 0.05,
                             cost_max = 3,
                             cost_min = 0.05,
                             calib_magpie_name = "magpie_calib",
                             lowpass_filter = 1,
                             calib_file = "modules/39_landconversion/input/f39_calib.csv",
                             putfolder = "land_conversion_cost_calib_run",
                             data_workspace = NULL,
                             logoption = 3,
                             debug = FALSE,
                             best_calib = FALSE) {
  require(magclass)

  if (!restart) {
    cat(paste0("\nStarting land conversion cost calibration from default values\n"))
    if (file.exists(calib_file)) file.remove(calib_file)
  } else {
    if (file.exists(calib_file)) cat(paste0("\nStarting land conversion cost calibration from existing values\n")) else cat(paste0("\nStarting land conversion cost calibration from default values\n"))
  }

  for (i in 1:n_maxcalib) {
    if (i == 1) s_use_gdx <- 0
    cat(paste("\nStarting land conversion cost calibration iteration", i, "with s_use_gdx =", s_use_gdx, "\n"))
    calibration_run(putfolder = putfolder, calib_magpie_name = calib_magpie_name, logoption = logoption, s_use_gdx = s_use_gdx)
    if (debug) file.copy(paste0(putfolder, "/fulldata.gdx"), paste0("fulldata_calib", i, ".gdx"))
    done <- update_calib(gdx_file = paste0(putfolder, "/fulldata.gdx"), calib_accuracy = calib_accuracy, cost_max = cost_max, cost_min = cost_min, lowpass_filter = lowpass_filter, calib_file = calib_file, calibration_step = i, n_maxcalib = n_maxcalib, best_calib = best_calib)
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

  cat("\nLand conversion cost calibration finished\n")
}
