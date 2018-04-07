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
cfg$gms$c_timesteps <- "TS_benni"
cfg$output <- c("report","validation","interpolation","LU_DiffPlots","LandusePlots")
#cfg$gms$s15_elastic_demand = 0


#cfg$force_download <- TRUE
cfg$recalibrate <- TRUE
cfg$recalc_base_run <- TRUE

cfg$gms$s14_yld_past_switch <- 0.75
cfg$gms$landconversion <- "gdp_vegc_apr18"

## run with per ton costs
cfg$gms$factor_costs <- "fixed_per_ton_mar18"
cfg$title <- "LChighNEW_fixed"
cfg$gms$c39_cost_scenario <- "high"
try(start_run(cfg=cfg, codeCheck=FALSE))
file.copy(from = "scripts/npi_ndc/policies/npi_ndc_base.tgz",to = "output/npi_ndc_base_SSP2_fixed.tgz", overwrite = TRUE)

## run with mixed costs
cfg$gms$factor_costs <- "mixed_feb17"
cfg$title <- "LChighNEW_mixed"
cfg$gms$c39_cost_scenario <- "high"
try(start_run(cfg=cfg, codeCheck=FALSE))
file.copy(from = "scripts/npi_ndc/policies/npi_ndc_base.tgz",to = "output/npi_ndc_base_SSP2_mixed.tgz", overwrite = TRUE)

#other fixed runs
cfg$gms$factor_costs <- "fixed_per_ton_mar18"
cfg$title <- "LCmediumNEW_fixed"
cfg$gms$c39_cost_scenario <- "medium"
try(start_run(cfg=cfg, codeCheck=FALSE))

cfg$gms$factor_costs <- "fixed_per_ton_mar18"
cfg$title <- "LClowNEW_fixed"
cfg$gms$c39_cost_scenario <- "low"
try(start_run(cfg=cfg, codeCheck=FALSE))

#other mixed runs
cfg$gms$factor_costs <- "mixed_feb17"
cfg$title <- "LCmediumNEW_mixed"
cfg$gms$c39_cost_scenario <- "medium"
try(start_run(cfg=cfg, codeCheck=FALSE))

cfg$gms$factor_costs <- "mixed_feb17"
cfg$title <- "LClowNEW_mixed"
cfg$gms$c39_cost_scenario <- "low"
try(start_run(cfg=cfg, codeCheck=FALSE))

