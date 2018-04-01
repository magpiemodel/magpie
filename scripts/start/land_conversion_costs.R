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
#cfg$gms$s15_elastic_demand = 0
#cfg$force_download <- TRUE

cfg$recalibrate <- TRUE
cfg$title <- "gdp_vegc_high"
cfg$gms$c39_cost_scenario <- "high"
cfg$gms$landconversion <- "gdp_vegc_mar18"
try(start_run(cfg=cfg, codeCheck=FALSE))
cfg$recalibrate <- FALSE

cfg$title <- "gdp_vegc_high2"
cfg$gms$c39_cost_scenario <- "high2"
cfg$gms$landconversion <- "gdp_vegc_mar18"
try(start_run(cfg=cfg, codeCheck=FALSE))

cfg$title <- "gdp_vegc_medium"
cfg$gms$landconversion <- "gdp_vegc_mar18"
cfg$gms$c39_cost_scenario <- "medium"
try(start_run(cfg=cfg, codeCheck=FALSE))

cfg$title <- "gdp_vegc_low"
cfg$gms$landconversion <- "gdp_vegc_mar18"
cfg$gms$c39_cost_scenario <- "low"
try(start_run(cfg=cfg, codeCheck=FALSE))

cfg$gms$c_timesteps <- "TS_benni"
cfg$title <- "gdp_vegc_high_y2000"
cfg$gms$c39_cost_scenario <- "high"
cfg$gms$landconversion <- "gdp_vegc_mar18"
try(start_run(cfg=cfg, codeCheck=FALSE))
cfg$gms$c_timesteps <- "test_TS"


cfg$recalibrate <- TRUE

cfg$title <- "gdp_vegc_high_recal"
cfg$gms$c39_cost_scenario <- "high"
cfg$gms$landconversion <- "gdp_vegc_mar18"
try(start_run(cfg=cfg, codeCheck=FALSE))

cfg$title <- "gdp_vegc_high2_recal"
cfg$gms$c39_cost_scenario <- "high2"
cfg$gms$landconversion <- "gdp_vegc_mar18"
try(start_run(cfg=cfg, codeCheck=FALSE))

cfg$title <- "gdp_vegc_medium_recal"
cfg$gms$landconversion <- "gdp_vegc_mar18"
cfg$gms$c39_cost_scenario <- "medium"
try(start_run(cfg=cfg, codeCheck=FALSE))

cfg$title <- "gdp_vegc_low_recal"
cfg$gms$landconversion <- "gdp_vegc_mar18"
cfg$gms$c39_cost_scenario <- "low"
try(start_run(cfg=cfg, codeCheck=FALSE))

