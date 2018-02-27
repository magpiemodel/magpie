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
							 "npi_ndc_rev3.0.tgz")

cfg$recalibrate <- FALSE
cfg$force_download <- FALSE

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/npi_ndc/start_npi_ndc.R")
start_npi_ndc_preprocessing(cfg, policyregions="iso")

#start MAgPIE run
cfg$gms$c_timesteps <- 11

cfg$title <- "SSP2_BASE"
cfg <- setScenario(cfg,c("SSP2","BASE"))
start_run(cfg,codeCheck=FALSE)

if(cfg$force_download == TRUE) cfg$force_download <- FALSE

cfg$recalc_npi_ndc <- "ifneeded"

cfg$title <- "SSP2_NPI"
cfg <- setScenario(cfg,c("SSP2","NPI"))
start_run(cfg,codeCheck=FALSE)

cfg$recalc_npi_ndc <- FALSE

cfg$title <- "SSP2_NDC"
cfg <- setScenario(cfg,c("SSP2","NDC"))
start_run(cfg,codeCheck=FALSE)

# china 1995 test

cfg$recalc_npi_ndc <- TRUE

cfg$title <- "SSP2_NPI_chn_ad_1995"
cfg <- setScenario(cfg,c("SSP2","NPI"))
start_run(cfg,codeCheck=FALSE)
