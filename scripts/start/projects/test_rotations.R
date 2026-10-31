# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Compare the two rotational constraint realizations of module 30_croparea
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################

library(magpie4)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# get default settings
source("config/default.cfg")

cfg$results_folder <- "output/:title::date:"
prefix <- "rotations"

defaultCalibration <- cfg$input["calibration"]

for (r in c("penalties_sep26", "rules_sep26")) {

  cfg$gms$croparea <- r

  # Each realization is recalibrated from the same archive baseline, so the two
  # calibrations are independent of each other and of run order. Resetting
  # cfg$input["calibration"] also makes prepare() redistribute the archive, so the
  # calibration starts from its factors rather than from the previous realization's.
  # Land conversion costs only: yield calibration stays off, matching the default
  # config (s14_use_yield_calib = 0).
  cfg$input["calibration"] <- defaultCalibration
  cfg$recalibrate <- FALSE
  cfg$recalibrate_landconversion_cost <- TRUE

  cfg$title <- paste(prefix, r, "default", sep = "_")
  cfg$gms$c30_rotation_policy <- "default"
  start_run(cfg, codeCheck = FALSE)

  # The calibration above has just written f39_calib.csv and f39_calib_past.csv into
  # modules/39_landconversion/input/, so submitCalibration() archives a complete set.
  calibTgz <- magpie4::submitCalibration(paste("H12", prefix, r, sep = "_"))

  # The policy run reuses its own realization's freshly computed factors instead of
  # recalibrating again, so that the only difference to the run above is the policy.
  cfg$input["calibration"] <- calibTgz
  cfg$recalibrate_landconversion_cost <- FALSE

  cfg$title <- paste(prefix, r, "agroecology", sep = "_")
  cfg$gms$c30_rotation_policy <- "agroecology"
  start_run(cfg, codeCheck = FALSE)
}
