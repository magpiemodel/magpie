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
source("scripts/start/extra/lpjml_addon.R")


cfg$crop_calib_max                   <- 1

cfg$title          <- "PRtest_default_lpjml5_cropcalib_1"
cfg$force_download <- TRUE
cfg$recalibrate    <- TRUE 
start_run(cfg=cfg)

cfg$title          <- "PRtest_default_lpjml5+newparam_cropcalib_1"
cfg$input <- c("rev4.59irrig_is_rainf_h12_magpie_debug.tgz",
               "rev4.59newparam_h12_c5cdbf33_cellularmagpie_debug.tgz",
               "rev4.59irrig_is_rainf_h12_validation_debug.tgz",
               "additional_data_rev4.02.tgz")


#cfg$input          <- c(cfg$input,"rev4.59newparam_h12_c5cdbf33_cellularmagpie_debug.tgz")
start_run(cfg=cfg)

cfg$title          <- "PRtest_default_lpjml5+oldparam_cropcalib_1"
cfg$input <- c("rev4.59irrig_is_rainf_h12_magpie_debug.tgz",
               "rev4.59oldparam_h12_ea65c621_cellularmagpie_debug.tgz",      
               "rev4.59irrig_is_rainf_h12_validation_debug.tgz",
               "additional_data_rev4.02.tgz")

#cfg$input          <- c(cfg$input,"rev4.59SmashingPumpkins_h12_df1b093f_cellularmagpie_debug.tgz")
start_run(cfg=cfg)
