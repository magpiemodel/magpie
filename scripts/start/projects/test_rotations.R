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

cfg$results_folder <- "output/:title:"
prefix <- "rotations"

defaultCalibration <- cfg$input["calibration"]

for (r in c("penalties_sep26", "rules_sep26")) {

  cfg$gms$croparea <- r

  # default policy, recalibrated because the two realizations constrain
  # croparea to a different degree
  cfg$title <- paste(prefix, r, "default", sep = "_")
  cfg$gms$c30_rotation_policy <- "default"
  cfg$input["calibration"] <- defaultCalibration
  cfg$recalibrate <- TRUE
  cfg$recalibrate_landconversion_cost <- TRUE
  start_run(cfg, codeCheck = FALSE)
  calibTgz <- magpie4::submitCalibration(paste("H12", prefix, r, sep = "_"))

  # policy run reuses the calibration factors of its own realization
  cfg$input["calibration"] <- calibTgz
  cfg$recalibrate <- FALSE
  cfg$recalibrate_landconversion_cost <- FALSE

  cfg$title <- paste(prefix, r, "agroecology", sep = "_")
  cfg$gms$c30_rotation_policy <- "agroecology"
  start_run(cfg, codeCheck = FALSE)
}
