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

source("config/default.cfg")
    
cfg$input <- c(cfg$input, 
							 "indc_rev2.1.tgz")

cfg$recalibrate <- FALSE
cfg$force_download <- FALSE

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/indc/start_indc.R")
start_indc_preprocessing(cfg, policyregions="iso")

#start MAgPIE run
cfg$results_folder <- paste0("output/:title:_",gsub(".","_",indc,fixed=TRUE))
cfg$gms$c_timesteps <- "5year_ge"

cfg$title <- "SSP2_BASE"
cfg <- setScenario(cfg,c("SSP2","BASE"))
start_run(cfg,codeCheck=FALSE)


cfg$title <- "SSP2_NPI"
cfg <- setScenario(cfg,c("SSP2","NPI"))
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP2_INDC"
cfg <- setScenario(cfg,c("SSP2","INDC"))
start_run(cfg,codeCheck=FALSE)
