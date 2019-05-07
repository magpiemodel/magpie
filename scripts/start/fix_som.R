# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(lucode)
source("scripts/start_functions.R")
source("config/default.cfg")

cfg$title   <- "BAU_dynamic_som"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg1300"
cfg$gms$c60_2ndgen_biodem    <- "R2M41-SSP2-Budg1300"

cfg$title   <- "SSP2-26-SPA2_dynamic_som_none"
cfg$gms$c56_emis_policy <- "none"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title   <- "SSP2-26-SPA2_dynamic_som_all"
cfg$gms$c56_emis_policy <- "all"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title   <- "SSP2-26-SPA2_dynamic_som_spp"
cfg$gms$c56_emis_policy <- "spp"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title   <- "SSP2-26-SPA2_dynamic_som_soiloff"
cfg$gms$c56_emis_policy <- "soiloff"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
start_run(cfg=cfg,codeCheck=TRUE)
