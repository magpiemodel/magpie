# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: GENIE project MESSAGE-MAgPIE Emulator Default script
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

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public" = NULL,
                                "./patch_input" = NULL),
                           getOption("magpie_repos"))

cfg$input <- c(regional    = "rev4.96_26df900e_magpie.tgz",
               cellular    = "rev4.96_26df900e_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
               validation  = "rev4.96_26df900e_validation.tgz",
               additional  = "additional_data_rev4.47.tgz",
               patch       = "MMEmuR12_rev4.96.tgz")


cfg$output <- c("output_check", "rds_report")

#load config presetswrite it before starting the run.
preset <-  "GENIE_SCP"
cfg <- setScenario(cfg, c(preset), scenario_config = "config/projects/scenario_config_genie.csv")

### Identifier and folder
###############################################
identifierFlag <- "MMEmu_default"
cfg$title <- "Default_rev4.96-preset"
###############################################
cfg$info$flag <- identifierFlag

##########################################################
start_run(cfg, codeCheck = FALSE)
