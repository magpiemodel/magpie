# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(gms)
source("scripts/start_functions.R")
source("config/default.cfg")

cfg$input <- c("rev4.59irrig_is_rainf_h12_magpie_debug.tgz",
               "rev4.59irrig_is_rainf_h12_83796d6b_cellularmagpie_debug.tgz",
               "rev4.59irrig_is_rainf_h12_validation_debug.tgz",
               "additional_data_rev4.02.tgz")

cfg$title                            <- "default_lpjml5"
cfg$crop_calib_max                   <- 1.5
cfg$gms$yields                       <- "managementcalib_aug19"
cfg$gms$s14_yld_past_switch          <- 0.25
cfg$gms$c41_initial_irrigation_area  <- "LUH2v2"
cfg                                  <- setScenario(cfg,"cc")

