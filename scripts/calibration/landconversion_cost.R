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
withLogging <- function(expr, logfile, putfolder) {
  # create putfolder for the calib run
  cat(paste0("Deleting putfolder: ", putfolder, "\n"))
  unlink(putfolder, recursive = TRUE)
  cat(paste0("Creating putfolder: ", putfolder, "\n"))
  dir.create(putfolder)
  # Open file connection for logging
  logfileConn <- file(paste0(putfolder, "/", logfile), open = "a")

  # Redirect both stdout and stderr to the same log file
  sink(logfileConn)
  sink(logfileConn, type = "message")

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
      try(close(logfileConn), silent = TRUE)
      stop(e)  # Re-throw the error after logging
    },
    finally = {
      cat("=== LOGGING SESSION COMPLETE ===\n")
      # Close sinks and connection safely even if an error occurred
      try(sink(type = "message"), silent = TRUE)
      try(sink(), silent = TRUE)
      try(close(logfileConn), silent = TRUE)
    }
  )
}

calibrationRun <- function(putfolder, calibMagpieName, logoption, useGDX) {
  require(lucode2)
  require(magpie4)

  cat("=== CALIBRATION_RUN START ===\n")
  cat(paste0("Putfolder: ", putfolder, ", useGDX: ", useGDX, "\n"))

  # create a modified magpie.gms for the calibration run
  unlink(paste(calibMagpieName, ".gms", sep = ""))
  unlink("fulldata.gdx")

  if (!file.copy("main.gms", paste(calibMagpieName, ".gms", sep = ""), overwrite = TRUE)) {
    stop(paste("Unable to create", paste(calibMagpieName, ".gms", sep = "")))
  }
  lucode2::manipulateConfig(paste(calibMagpieName, ".gms", sep = ""), c_timesteps = "calib")
  lucode2::manipulateConfig(paste(calibMagpieName, ".gms", sep = ""), useGDX = useGDX)
  file.copy(paste(calibMagpieName, ".gms", sep = ""), putfolder, overwrite = TRUE)

  # execute calibration run
  cat("Starting GAMS run...\n")
  system(paste("gams ", calibMagpieName, ".gms", " -errmsg=1 -PUTDIR ./", putfolder, " -LOGOPTION=", logoption, sep = ""), wait = TRUE)
  cat("GAMS run completed\n")
  file.copy("fulldata.gdx", putfolder)

  cat("=== CALIBRATION_RUN END ===\n")
}

getValData <- function(histData, gdxFile) {
  require(magpie4)
  require(magclass)
  require(gdx2)
  cat("=== retrieve validation data ===\n")
  y <- readGDX(gdxFile,"t")
  magpie <- land(gdxFile)[, y, "crop"]
  if (histData == "MAgPIEown") {
    hist <- dimSums(readGDX(gdxFile, "f10_land")[, , "crop"], dim = 1.2)
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
  } else {
    stop("unkown histData")
  }
  if (nregions(magpie) != nregions(valdata) || !all(getRegions(magpie) %in% getRegions(valdata))) {
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

getCalibFactor <- function(gdxFile, mode, histData) {

  require(magclass)
  cat("=== GET_CALIB_FACTOR START ===\n")
  cat(paste0("GDX file: ", gdxFile, "\n"))
  cat(paste0("Mode: ", mode, ", histData: ", histData, "\n"))

  valdata <- getValData(histData = histData, gdxFile = gdxFile)
  magpie <- land(gdxFile)[, getYears(valdata), "crop"]

  if (mode == "gradient") {
    cat(">>> gradient calibration \n")
    # Calibration should not target absolute difference to goal, but matching the increase over time.
    # Otherwise, calibration of first timestep will implicitly also calibrate all further timesteps.
    expansionValdata <- valdata * 0
    expansionMagpie <- valdata * 0
    for (timestep in 2:length(getYears(expansionMagpie))) {
      expansionMagpie[,timestep,] <- magpie[,timestep,] / setYears(magpie[,timestep - 1,], NULL)
      expansionValdata[,timestep,] <- valdata[,timestep,] / setYears(valdata[,timestep - 1,], NULL)
    }
    # if magpie expands more than valdata, out should be smaller than 1
    out <- expansionMagpie - expansionValdata + 1
  } else {
    cat(">>> timestep calibration \n")
    out <- magpie / valdata
  }
  getNames(out) <- NULL
  out[out <= 0.1] <- 0.1 # make sure the multiplier doesnt drop to 0, as this could not be reverted in future iterations. 
  # expert guess: 10% of the original land conversion cost estimates seems a reasonable lower limit, as land expansion should also not be free of costs.

  return(magpiesort(out))
}

timeSeriesCost <- function(calibFactor) {
  out2 <- new.magpie(getRegions(calibFactor), years = c(seq(1995, 2015, by = 5), seq(2050, 2150, by = 5)), fill = 1)
  out2[, getYears(calibFactor), ] <- calibFactor
  out2050 <- setYears(calibFactor[,"y2015",],NULL)
  out2050[out2050 < 1] <- 1
  out2[, seq(2050, 2150, by = 5), ] <- out2050
  out2 <- time_interpolate(out2, seq(2020, 2050, by = 5), integrate_interpolated_years = T)
  return(out2)
}

timeSeriesReward <- function(calibFactor) {
  out2 <- new.magpie(getRegions(calibFactor), years = c(seq(1995, 2015, by = 5), seq(2050, 2150, by = 5)), fill = 0)
  out2[, getYears(calibFactor), ] <- calibFactor
  out2 <- time_interpolate(out2, seq(2020, 2050, by = 5), integrate_interpolated_years = T)
  return(out2)
}

# Calculate the correction factor and save it
updateCalib <- function(gdxFile, calibAccuracy, calibFile, costMax, costMin, calibrationStep, nMaxcalib, bestCalib, histData, putfolder, levelGradientMix) {
  require(magclass)
  require(magpie4)
  require(gdx2)

  cat(paste0("=== UPDATE_CALIB ITERATION ", calibrationStep, " START ===\n"))
  cat(paste0("GDX file: ", gdxFile, "\n"))
  cat(paste0("calibAccuracy: ", calibAccuracy, "\n"))

  if (!(modelstat(gdxFile)[1, 1, 1] %in% c(1, 2, 7))) {
    stop("Calibration run infeasible")
  }


  
  # we calculate two different divergence measures: divergence of level (cropland and divergence of gradient (cropland expansion)
  calibDivergenceLevel <- getCalibFactor(gdxFile, mode = "level", histData = histData)
  calibDivergenceGradient <- getCalibFactor(gdxFile, mode = "gradient", histData = histData)
  # mixing calibration approaches for making the best of both approaches
  calibDivergence <- levelGradientMix * calibDivergenceLevel + (1 - levelGradientMix) * calibDivergenceGradient
  
  # we calculate the correction factor based on a mix of the two divergence measures
  # gradient should lead to faster convergence and more continuous gradient with historical data
  # gradient has disadvantage that the error from incomplete convergence accumulates over time
  # level calibration has advantage that errors from one timestep are balanced out in subsequent timestep.
 
  calib_correction <- calibDivergence
  # dont modify calibration in first timestep, as otherwise its like a second yield calibration
  calib_correction[,1,] <- 1
 
  ### -> in case it is the first step, it forces the initial factors to be equal to 1
  if (file.exists(calibFile)) {
    cat(">>> Starting with existing calibration file\n")
    oldCalib <- magpiesort(read.magpie(calibFile))[,getYears(calibDivergence),]
  } else {
    cat(">>> First iteration - initializing calibration factors (cost=1 for expanding countries, cost=2.5 for contracting, reward=0)\n")
    oldCalib <- new.magpie(cells_and_regions = getCells(calibDivergence), years = getYears(calibDivergence), names = c("cost", "reward"), fill = NA)
    oldCalib[,,"cost"] <- (expandHist(getValData(histData = histData, gdxFile = gdxFile)) < 0) * (costMax - 1) + 1
    oldCalib[,,"reward"] <- 0
  }

  ### use first steps to calibrate stronger, such that calibration factors can also achieve low/high levels
  if(calibrationStep <= 8) {
    reinforcement <- 10
  } else if (calibrationStep <= 11) {
    reinforcement <- 5 
  } else {
    reinforcement <- 1
  } 
  
  cat(">>> Calib factors are adjusted where needed\n")
  calibFactorCost <- setNames(oldCalib[, , "cost"], NULL) * calib_correction ^ reinforcement
  calibFactorReward <- setNames(oldCalib[, , "reward"], NULL) + (calib_correction - 1) * reinforcement
  # no rewards in case that validation data shows no contraction
  calibFactorReward[expandHist(getValData(histData = histData, gdxFile = gdxFile)) >= 0] <- 0
  calibFactorReward[calibFactorReward < 0] <- 0

  cat(">>> Account for costMax and costMin\n")
  if (!is.null(costMax)) {
    aboveLimit <- (calibFactorCost >= costMax)
    calibFactorCost[aboveLimit] <- costMax
  }

  if (!is.null(costMin)) {
    belowLimit <- (calibFactorCost <= costMin)
    calibFactorCost[belowLimit] <- costMin
  }

  cat(">>> write down current calib factors (and area_factors) for tracking\n")
  writeLog <- function(x, file, calibrationStep) {
    x <- add_dimension(x, dim = 3.1, add = "iteration", nm = paste0("iter", calibrationStep))
    try(write.magpie(round(x, 3), file, append = (calibrationStep != 1)))
  }

  writeLog(calibDivergenceLevel, paste0(putfolder, "/land_conversion_divergence_level.cs3"), calibrationStep)
  writeLog(calibDivergenceGradient, paste0(putfolder,  "/land_conversion_divergence_gradient.cs3"), calibrationStep)
  writeLog(calibDivergence, paste0(putfolder,  "/land_conversion_divergence.cs3"), calibrationStep)
  writeLog(calibFactorCost, paste0(putfolder,  "/land_conversion_cost_next_calib_factor.cs3"), calibrationStep)
  writeLog(calibFactorReward, paste0(putfolder,  "/land_conversion_reward_next_calib_factor.cs3"), calibrationStep)
  writeLog(setNames(oldCalib[, , "reward"], NULL), paste0(putfolder,  "/land_conversion_reward_current_calib_factor.cs3"), calibrationStep)
  writeLog(setNames(oldCalib[, , "cost"], NULL), paste0(putfolder,  "/land_conversion_cost_current_calib_factor.cs3"), calibrationStep)

  # in case of sufficient convergence, stop here (no additional update of calibration factors!)
  # also stop in case there is no convergence, e.g. because the calib factors are at upper or lower bounds.
  convergenceReached <- abs(calibDivergence - 1) <= calibAccuracy
  noConvergence <- (calibFactorCost == oldCalib[, , "cost"]) & (calibFactorReward == oldCalib[, , "reward"])

  if (all(convergenceReached | noConvergence) || calibrationStep == nMaxcalib) {

    ### Depending on the selected calibration selection type (bestCalib FALSE or TRUE)
    # the reported and used regional calibration factors can be either the ones of the last iteration,
    # or the "best" based on the iteration value with the lowest standard deviation of regional divergence.
    if (bestCalib == TRUE) {
      cat("Choosing the best calibration...\n")
      divergenceData <- read.magpie(paste0(putfolder, "/land_conversion_divergence.cs3"))
      factors_cost <- read.magpie( paste0(putfolder, "/land_conversion_cost_current_calib_factor.cs3"))
      factors_reward <- read.magpie( paste0(putfolder, "/land_conversion_reward_current_calib_factor.cs3"))
      # The best iteration is chosen for each region as the calibration factors where the sum of divergence over all timesteps is minimal.
      # In case multiple iterations have the same value, the first value is returned by which.min
      calibCostBest <- calibRewardBest <- factors_cost[,,1] * 0
      for(i in getRegions(divergenceData)) {
        # use sum(log(divergenceData+1) as divergenceData is (magpie/data-1), and relative divergence should be equally punished in both directions
        bestIteration <- which.min(dimSums(abs(log(divergenceData[i,,])), dim = 2))
        calibCostBest[i,,] <- factors_cost[i,,bestIteration]
        calibRewardBest[i,,] <- factors_reward[i,,bestIteration]
      }
      getNames(calibCostBest) <- NULL
      getNames(calibRewardBest) <- NULL
 
      writeLog(calibCostBest,  paste0(putfolder, "/land_conversion_cost_current_calib_factor.cs3"), "best")
      writeLog(calibRewardBest,  paste0(putfolder, "/land_conversion_reward_current_calib_factor.cs3"), "best")
  
      calibCostBest <- timeSeriesCost(calibCostBest)
      calibRewardBest <- timeSeriesReward(calibRewardBest)
  
      calibBestFull <- mbind(
        add_dimension(calibCostBest, dim = 3.1, nm = "cost"),
        add_dimension(calibRewardBest, dim = 3.1, nm = "reward")
      )
      calibBestFull[is.na(calibBestFull)] <- 1

      comment <- c(
        " description: Regional land conversion cost calibration file",
        " unit: -",
        paste0(" note: Best calibration factor from the run"),
        " origin: scripts/calibration/landconversion_cost.R (path relative to model main directory)",
        paste(" Calibration settings:",  "calibAccuracy=", calibAccuracy, "costMax=", costMax, "costMin=", costMin, "nMaxcalib=",nMaxcalib, "bestCalib=",bestCalib, "histData=",histData),
        paste0(" creation date: ", date())
      )
      write.magpie(round(calibBestFull, 3), calibFile, comment = comment)


      ####
      return(TRUE)
    } else {
      return(TRUE)
    }
  } else {
    cat("Adjust calibration factors for next iteration \n")
    calibFactorCost <- timeSeriesCost(calibFactorCost)
    calibFactorReward <- timeSeriesReward(calibFactorReward)

    calibFull <- mbind(
      add_dimension(calibFactorCost, dim = 3.1, nm = "cost"),
      add_dimension(calibFactorReward, dim = 3.1, nm = "reward")
    )
    calibFull[is.na(calibFull)] <- 1

    comment <- c(
      " description: Regional land conversion cost calibration file",
      " unit: -",
      paste0(" note: Calibration step ", calibrationStep),
      " origin: scripts/calibration/landconversion_cost.R (path relative to model main directory)",
      paste(" Calibration settings:",  "calibAccuracy=", calibAccuracy, "costMax=", costMax, "costMin=", costMin, "nMaxcalib=", nMaxcalib, "bestCalib=", bestCalib, "histData=", histData),
      paste0(" creation date: ", date())
    )

    write.magpie(round(calibFull, 3), calibFile, comment = comment)
    return(FALSE)
  }
}




calibrateLandconversion <- function(nMaxcalib = 20,
                             restart = FALSE,
                             calibAccuracy = 0.01,
                             costMax = 2.5,
                             costMin = 0.2,
                             calibMagpieName = "magpie_calib",
                             calibFile = "modules/39_landconversion/input/f39_calib.csv",
                             putfolder = "land_conversion_cost_calib_run",
                             dataWorkspace = NULL,
                             logoption = 3,
                             debug = FALSE,
                             bestCalib = TRUE,
                             histData = "FAO",
                             levelGradientMix = 0.3) {
  require(magclass)

  if (!restart) {
    cat(paste0("\nStarting land conversion cost calibration from default values\n"))
    if (file.exists(calibFile)) file.remove(calibFile)
  } else {
    if (file.exists(calibFile)) cat(paste0("\nStarting land conversion cost calibration from existing values\n")) else cat(paste0("\nStarting land conversion cost calibration from default values\n"))
  }

  # Clear log file at start
  if (file.exists("calibration_debug.log")) file.remove("calibration_debug.log")
  # Wrap entire calibration process with comprehensive logging
  withLogging({
    cat("##################################################################\n")
    cat("### CALIBRATE_MAGPIE START ###\n")
    cat("##################################################################\n")

    useGDX <- 0
    for (i in seq_len(nMaxcalib)) {
      
      cat(paste0("### ITERATION ", i, " START (useGDX = ", useGDX, ") ###\n"))

      calibrationRun(putfolder = putfolder, calibMagpieName = calibMagpieName, logoption = logoption, useGDX = useGDX)

      if (debug) {
        # Copy listing file with iteration number for debugging
        if (file.exists(paste0(calibMagpieName, ".lst"))) {
          file.copy(paste0(calibMagpieName, ".lst"), paste0(putfolder, "/", calibMagpieName, "_iter", i, ".lst"), overwrite = TRUE)
        }
        file.copy(paste0(putfolder, "/fulldata.gdx"), paste0(putfolder, "/", "fulldata_calib", i, ".gdx"), overwrite = TRUE)
      }

      done <- updateCalib(gdxFile = "fulldata.gdx", calibAccuracy = calibAccuracy, costMax = costMax, costMin = costMin, 
                           calibFile = calibFile, calibrationStep = i, nMaxcalib = nMaxcalib, bestCalib = bestCalib, histData = histData,
                           putfolder = putfolder, levelGradientMix = levelGradientMix)

      if (done && useGDX == 2) {
        useGDX <- 0
        next
      } else if (done && useGDX == 0) {
        break
      } else {
        useGDX <- 2
      }
    }

    # delete calib_magpie_gms in the main folder
    unlink(paste0(calibMagpieName, ".*"))
    unlink("fulldata.gdx")
    unlink("calib_data.rds")

    cat("\nLand conversion cost calibration finished\n")
  }, logfile = "calibration_debug.log", putfolder = putfolder)
}
