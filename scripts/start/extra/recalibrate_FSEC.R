# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: calculate and store new calibration factors for
#              land conversion costs for FSEC regional setup
#              (time consuming; up to 40 model runs with 5 time steps)
# --------------------------------------------------------

library(magpie4)
library(magclass)
library(gms)

source("scripts/start_functions.R")
source("scripts/projects/fsec.R")

# Calibration run
cfg       <- fsecScenario(scenario = "c_BAU")
cfg$title <- "FSEC23Mar2024"
cfg$results_folder                  <- "output/:title:"
cfg$recalibrate                     <- TRUE # required when penality_apr22 activated
cfg$best_calib                      <- TRUE
cfg$recalibrate_landconversion_cost <- TRUE
cfg$best_calib_landconversion_cost  <- FALSE
cfg$output                          <- c("rds_report")
cfg$force_replace                   <- TRUE
cfg$qos <- "priority"
start_run(cfg, codeCheck = FALSE)
magpie4::submitCalibration("FSEC")
