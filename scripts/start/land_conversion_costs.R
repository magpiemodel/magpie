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

cfg$results_folder <- "output/:title:"
cfg$gms$c_timesteps <- "test_TS"
cfg$output <- c("report","validation")
#cfg$gms$s15_elastic_demand = 0

## runs with per ton costs
cfg$gms$factor_costs <- "fixed_per_ton_mar18"
### BEGIN first run

cfg$force_download <- TRUE
cfg$recalibrate <- TRUE
cfg$recalc_base_run <- TRUE

cfg$title <- "gdp_vegc_high_fixed"
cfg$gms$c39_cost_scenario <- "high"
cfg$gms$landconversion <- "gdp_vegc_mar18"
try(start_run(cfg=cfg, codeCheck=FALSE))

cfg$force_download <- FALSE
# cfg$recalibrate <- FALSE
cfg$recalc_base_run <- FALSE
### END first run

# cfg$title <- "gdp_vegc_medium_fixed"
# cfg$gms$landconversion <- "gdp_vegc_mar18"
# cfg$gms$c39_cost_scenario <- "medium"
# try(start_run(cfg=cfg, codeCheck=FALSE))
# 
# cfg$title <- "gdp_vegc_low_fixed"
# cfg$gms$landconversion <- "gdp_vegc_mar18"
# cfg$gms$c39_cost_scenario <- "low"
# try(start_run(cfg=cfg, codeCheck=FALSE))
# 
# 
# ## runs with mixed costs
# cfg$gms$factor_costs <- "mixed_feb17"
# 
# cfg$title <- "gdp_vegc_high_mixed"
# cfg$gms$c39_cost_scenario <- "high"
# cfg$gms$landconversion <- "gdp_vegc_mar18"
# try(start_run(cfg=cfg, codeCheck=FALSE))
# 
# cfg$title <- "gdp_vegc_medium_mixed"
# cfg$gms$landconversion <- "gdp_vegc_mar18"
# cfg$gms$c39_cost_scenario <- "medium"
# try(start_run(cfg=cfg, codeCheck=FALSE))
# 
# cfg$title <- "gdp_vegc_low_mixed"
# cfg$gms$landconversion <- "gdp_vegc_mar18"
# cfg$gms$c39_cost_scenario <- "low"
# try(start_run(cfg=cfg, codeCheck=FALSE))



