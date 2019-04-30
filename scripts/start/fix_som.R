
# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(lucode)
source("scripts/start_functions.R")
source("config/default.cfg")

cfg$title   <- "BAU_dynamic_som_irr"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"

cfg$title   <- "GHG_dynamic_som_irr"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
start_run(cfg=cfg,codeCheck=TRUE)

source("config/default.cfg")
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA2"

cfg$title   <- "BECCS_dynamic_som_irr"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"

cfg$title   <- "SSP2-26-SPA2_dynamic_som_irr"
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_irrigation_scenario  <- "on"
start_run(cfg=cfg,codeCheck=TRUE)
