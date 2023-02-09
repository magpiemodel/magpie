# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: MESSAGE-MAgPIE Emulator Debug Setup
# position: 1
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode2)
library(magclass)
library(gms)
library(stringr)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R") #nolinter
# Source the default config and then over-write it before starting the run.
source("config/default.cfg") #nolinter

cfg$output <- c("output_check", "rds_report")
cfg$force_replace <- TRUE

ssp <-  "SSP2"
cfg <- setScenario(cfg, c(ssp)) #load config presets

### Identifier and folder
###############################################
identifierFlag <- "Emulator_debug"
cfg$title <- "4_yields_A_NOCC_hist"
###############################################
cfg$info$flag <- identifierFlag
cfg$results_folder <- paste0("output/", identifierFlag, "/:title:")

cfg$gms$c14_yields_scenario <- "nocc_hist"

start_run(cfg, codeCheck = FALSE)