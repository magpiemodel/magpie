# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
#cfg$results_folder <- "output/:title:"
cfg$gms$c_timesteps <- 11

cfg$recalc_indc <- TRUE     

cfg$title <- "SSP2_BASE"
cfg <- setScenario(cfg,c("SSP2","BASE"))
start_run(cfg,codeCheck=FALSE)

cfg$recalc_indc <-FALSE 

cfg$recalibrate <- FALSE

cfg$title <- "SSP2_NPI"
cfg <- setScenario(cfg,c("SSP2","NPI"))
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP2_INDC"
cfg <- setScenario(cfg,c("SSP2","INDC"))
start_run(cfg,codeCheck=FALSE)
