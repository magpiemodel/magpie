# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test the switches of the land conversion cost calibration (time consuming; includes 5 recalibrations, submit with sbatch)
# ----------------------------------------------------------

# Every run changes one setting from the default, for cropland and pasture separately:
# 1. runs without recalibration, using the archived calibration factors:
#    - the default settings (to compare against a default run of the develop branch)
#    - the development of the calibration factors after the historical period
#      (s39_expansioncost_upwards_convergence, s39_expansioncost_downwards_convergence,
#      s39_contractionreward_downwards_convergence and their _past counterparts)
# 2. runs with recalibration:
#    - the default settings (should reproduce the archived calibration factors)
#    - fixed expansion cost calibration factors in region-timesteps with historical land
#      contraction (expansion_cost_multiplier_during_contraction(_past))
#
# The recalibrations run inside this R process (calibrateLandconversion calls GAMS directly),
# so start this script with sbatch rather than on a login node.

library(magpie4)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# get default settings
source("config/default.cfg")
defaultCfg <- cfg

prefix <- "lcc"
calibFiles <- c("modules/39_landconversion/input/f39_calib.csv",
                "modules/39_landconversion/input/f39_calib_past.csv")

startTest <- function(title, settings = list(), gms = list(), recalibrate = FALSE) {
  cfg <- defaultCfg
  cfg$results_folder <- "output/:title:"
  cfg$force_replace <- TRUE
  cfg$title <- paste(prefix, title, sep = "_")
  cfg$recalibrate <- FALSE
  cfg$recalibrate_landconversion_cost <- recalibrate
  for (n in names(settings)) cfg[[n]] <- settings[[n]]
  for (n in names(gms)) cfg$gms[[n]] <- gms[[n]]
  resultsFolder <- start_run(cfg, codeCheck = FALSE)
  if (recalibrate) {
    # keep the calibration factors of this run next to its results
    file.copy(calibFiles, resultsFolder, overwrite = TRUE)
  }
  return(resultsFolder)
}

### 1. runs with the archived calibration factors
startTest("default")

for (type in c("crop", "past")) {
  suffix <- if (type == "past") "_past" else ""
  up     <- paste0("s39_expansioncost_upwards_convergence", suffix)
  down   <- paste0("s39_expansioncost_downwards_convergence", suffix)
  reward <- paste0("s39_contractionreward_downwards_convergence", suffix)

  # default: cost factors < 1 move up to 1, cost factors > 1 are kept, rewards move down to 0
  startTest(paste(type, "cost_keep", sep = "_"),           gms = setNames(list(0, 0), c(up, down)))
  startTest(paste(type, "cost_converge", sep = "_"),       gms = setNames(list(1, 1), c(up, down)))
  startTest(paste(type, "cost_converge_high", sep = "_"),  gms = setNames(list(0, 1), c(up, down)))
  startTest(paste(type, "reward_keep", sep = "_"),         gms = setNames(list(0), reward))
}

### 2. runs with recalibration
# The calibration writes its factors into the model folder (calibFiles), where all later runs
# would pick them up. Keep the archived factors and put them back after the recalibrations.
backupFolder <- tempfile("calib_backup_")
dir.create(backupFolder)
stopifnot(all(file.copy(calibFiles, backupFolder)))

tryCatch({
  startTest("recalib_default", recalibrate = TRUE)
  for (type in c("crop", "past")) {
    setting <- paste0("expansion_cost_multiplier_during_contraction", if (type == "past") "_past" else "")
    startTest(paste(type, "recalib_contraction_1", sep = "_"),
              settings = setNames(list(1), setting), recalibrate = TRUE)
    startTest(paste(type, "recalib_contraction_costMax", sep = "_"),
              settings = setNames(list("costMax"), setting), recalibrate = TRUE)
  }
}, finally = {
  file.copy(file.path(backupFolder, basename(calibFiles)), calibFiles, overwrite = TRUE)
  message("Archived calibration factors restored in ", paste(calibFiles, collapse = ", "))
})
