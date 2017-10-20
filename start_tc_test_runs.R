# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(lucode)

source("scripts/start_functions.R")
source("config/default.cfg")
cfg$results_folder <- "output/:title::date:"
cfg$gms$c_timesteps <- 11

#set defaults
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
scenario <- "SSP2"
codeCheck <- FALSE

cfg$title  <- "default-RCP26"
cfg$gms$tc <- "endo_JUN16"
start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck)


cfg$title <- "extended_tc_RCP26"
cfg$gms$tc <- "curve_SEP17"
start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck)
