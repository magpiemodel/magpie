# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

#setwd("C:/Users/bodirsky/Desktop/articles/demand model/manuscript_from_starved_to_stuffed/magpie")

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
cfg$model <- "standalone/demand_model.gms"  
cfg$recalibrate=FALSE
cfg$gms$c_timesteps="pastandfuture"

cfg$title <- "demand_ssp1"
cfg$gms$c09_pop_scenario  <- "SSP1"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP1"    # def = SSP2
start_run(cfg=cfg)

cfg$title <- "demand_ssp2"
cfg$gms$c09_pop_scenario  <- "SSP2"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP2"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)

cfg$title <- "demand_ssp3"
cfg$gms$c09_pop_scenario  <- "SSP3"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP3"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)

cfg$title <- "demand_ssp4"
cfg$gms$c09_pop_scenario  <- "SSP4"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP4"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)

cfg$title <- "demand_ssp5"
cfg$gms$c09_pop_scenario  <- "SSP5"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP5"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)


### calib till 1975

cfg$gms$c_past <- "till_1975"

cfg$title <- "demand_ssp1_calib1975"
cfg$gms$c09_pop_scenario  <- "SSP1"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP1"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)

cfg$title <- "demand_ssp2_calib1975"
cfg$gms$c09_pop_scenario  <- "SSP2"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP2"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)

cfg$title <- "demand_ssp3_calib1975"
cfg$gms$c09_pop_scenario  <- "SSP3"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP3"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)

cfg$title <- "demand_ssp4_calib1975"
cfg$gms$c09_pop_scenario  <- "SSP4"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP4"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)

cfg$title <- "demand_ssp5_calib1975"
cfg$gms$c09_pop_scenario  <- "SSP5"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP5"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)


### no calib

cfg$gms$s15_calibrate = 0

cfg$title <- "demand_ssp1_nocalib"
cfg$gms$c09_pop_scenario  <- "SSP1"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP1"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)

cfg$title <- "demand_ssp2_nocalib"
cfg$gms$c09_pop_scenario  <- "SSP2"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP2"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)

cfg$title <- "demand_ssp3_nocalib"
cfg$gms$c09_pop_scenario  <- "SSP3"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP3"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)

cfg$title <- "demand_ssp4_nocalib"
cfg$gms$c09_pop_scenario  <- "SSP4"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP4"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)

cfg$title <- "demand_ssp5_nocalib"
cfg$gms$c09_pop_scenario  <- "SSP5"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP5"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)


cfg$gms$s15_calibrate = 1