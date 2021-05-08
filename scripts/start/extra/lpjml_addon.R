# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
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

cfg$input <- c("additional_data_rev4.02.tgz",
               "rev4.59newparam_h12_magpie_debug.tgz",
               "rev4.59newparam_h12_c5cdbf33_cellularmagpie_debug.tgz",
               "rev4.59newparam_h12_validation_debug.tgz")


cfg$title                            <- "default_lpjml5"
cfg$crop_calib_max                   <- 1
cfg$gms$yields                       <- "managementcalib_aug19"
cfg$gms$s14_yld_past_switch          <- 0.25
cfg$gms$processing                   <- "substitution_may21" 
cfg$gms$c41_initial_irrigation_area  <- "LUH2v2"
cfg                                  <- setScenario(cfg,"cc")

