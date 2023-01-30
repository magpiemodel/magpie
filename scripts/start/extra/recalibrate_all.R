# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: calculate and store new calibration factors for yields AND land conversion costs for default setup (time consuming; up to 40 model runs with 1 or 5 time steps)
# --------------------------------------------------------

library(magpie4)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
cfg$results_folder <- "output/:title:"

# ------------------
# yield calibration
# ------------------

cfg$recalibrate <- TRUE
# Up to which accuracy shall be recalibrated?
cfg$calib_accuracy <- 0.05         # def = 0.05
# What is the maximum number of iterations if the precision goal is not reached?
cfg$calib_maxiter <- 20           # def = 20
cfg$damping_factor <- 0.96        # def= 0.96

cfg$best_calib <- TRUE   # def = TRUE

# ---------------------------------
# land conversion cost calibration
# ---------------------------------

cfg$recalibrate_landconversion_cost <- TRUE
# Up to which accuracy shall be recalibrated?
cfg$calib_accuracy_landconversion_cost <- 0.05         # def = 0.05
# What is the maximum number of iterations if the precision goal is not reached?
cfg$calib_maxiter_landconversion_cost <- 40           # def = 40
cfg$best_calib_landconversion_cost <- FALSE			# def = FALSE

# set upper limit for cropland calibration factor
cfg$cost_calib_max_landconversion_cost <- 3           # def= 3
# set lower limit for cropland calibration factor
cfg$cost_calib_min_landconversion_cost <- 0.05           # def= 0.05

# factor determining how much the new calibration factor influences the result (0-1)
cfg$damping_factor_landconversion_cost <- 0.96       # def= 0.96


cfg$title <- "calib_run"
cfg$output <- c("rds_report","validation_short")
cfg$force_replace <- TRUE
start_run(cfg,codeCheck=FALSE)
magpie4::submitCalibration("H12")
