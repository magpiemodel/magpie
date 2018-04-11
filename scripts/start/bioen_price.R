# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")

cfg <- setScenario(cfg,"SSP2")

cfg$results_folder <- "output/:title:"
cfg$gms$c_timesteps <- 11
cfg$output <- c("report","validation","interpolation","LU_DiffPlots","LandusePlots")
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA0"
#cfg$gms$s15_elastic_demand = 0



#cfg$force_download <- TRUE
cfg$recalibrate <- TRUE
cfg$recalc_base_run <- TRUE

## runs with per ton costs
cfg$gms$factor_costs <- "fixed_per_ton_mar18"

cfg$gms$c60_biodem_level <- 1
cfg$title <- "bioen_reg_fixed"
try(start_run(cfg=cfg, codeCheck=FALSE))

cfg$gms$c60_biodem_level <- 0
cfg$title <- "bioen_glo_fixed"
try(start_run(cfg=cfg, codeCheck=FALSE))



## run with mixed costs
cfg$gms$factor_costs <- "mixed_feb17"

cfg$gms$c60_biodem_level <- 1
cfg$title <- "bioen_reg_mixed"
try(start_run(cfg=cfg, codeCheck=FALSE))

cfg$gms$c60_biodem_level <- 0
cfg$title <- "bioen_glo_mixed"
try(start_run(cfg=cfg, codeCheck=FALSE))

