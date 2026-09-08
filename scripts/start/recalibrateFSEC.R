# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Derive land conversion cost calibration factors with the FSEC setup
# position: 8
# ----------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Load fsecScenario(), which sources config/default.cfg itself and applies the
# FSEC scenario settings on top of it
source("scripts/projects/fsec.R")

# Settings of the business-as-usual run from scripts/start/test_runs.R
cfg <- fsecScenario(scenario = "c_BAU", highres = FALSE)
cfg$force_replace <- TRUE
cfg$results_folder <- "output/:title:"

# Derive new land conversion cost calibration factors instead of using the ones
# shipped with the calibration input data. The resulting factors are written to
# modules/39_landconversion/input/f39_calib.csv in the model main directory.
cfg$recalibrate_landconversion_cost <- TRUE

start_run(cfg = cfg, codeCheck = FALSE)
