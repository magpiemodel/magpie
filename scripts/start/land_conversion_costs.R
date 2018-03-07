# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")

cfg$results_folder <- "output/:title:"
cfg$gms$c_timesteps <- "test_TS"

cfg$title <- "gdp_scaled_jun13"
cfg$gms$landconversion <- "gdp_scaled_jun13"
try(start_run(cfg=cfg, codeCheck=FALSE))

cfg$title <- "gdp_vegetation_dev"
cfg$gms$landconversion <- "gdp_vegetation_dev"
try(start_run(cfg=cfg, codeCheck=FALSE))

