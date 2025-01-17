# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test routine for standardized test runs
# position: 5
# ----------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

#download default input data
download_and_update(cfg)

# create additional information to describe the runs
cfg$info$flag <- "weeklyTests"

source("scripts/runTestRuns.R")
runTestRuns(cfg)

#####################################################
### FSEC Test runs (BAU + FSDP) with FSEC regions ###
#####################################################
source("scripts/projects/fsec.R")

codeCheck <- FALSE

### Business-as-usual
cfg <- fsecScenario(scenario = "c_BAU")
cfg$force_replace <- TRUE
cfg$results_folder <- "output/:title:"
cfg$results_folder_highres <- "output"
start_run(cfg = cfg, codeCheck = codeCheck)

### NatureSparing
cfg <- fsecScenario(scenario = "b_NatureSparing")
cfg$force_replace <- TRUE
cfg$results_folder <- "output/:title:"
cfg$results_folder_highres <- "output"
start_run(cfg = cfg, codeCheck = codeCheck)

### LandscapeElements
cfg <- fsecScenario(scenario = "a_LandscapeElements")
cfg$force_replace <- TRUE
cfg$results_folder <- "output/:title:"
cfg$results_folder_highres <- "output"
start_run(cfg = cfg, codeCheck = codeCheck)

### FSDP Scenario
cfg <- fsecScenario(scenario = "e_FSDP")
cfg$force_replace <- TRUE
cfg$results_folder <- "output/:title:"
cfg$results_folder_highres <- "output"
start_run(cfg = cfg, codeCheck = codeCheck)
