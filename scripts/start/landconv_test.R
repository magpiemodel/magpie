# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
cfg$results_folder <- "output/:title:"
cfg <- setScenario(cfg,"SSP2")

cfg$title <- "Default"
start_run(cfg,codeCheck=FALSE)

cfg$recalibrate <- TRUE

cfg$title <- "EstHigh_ClearMedium_calib"
cfg$gms$c39_cost_scenario_establish <- "high"
cfg$gms$c39_cost_scenario_clearing <- "medium"
start_run(cfg,codeCheck=FALSE)
