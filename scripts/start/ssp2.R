# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"

cfg$title <- "F02_SSP2_landfeb15_simpleTrade_processOff_livstoff_maccoff"
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"
cfg$gms$land <- "feb15"
cfg$gms$processing <- "off"
cfg$gms$disagg_lvst <- "off"
cfg$gms$maccs  <- "off_jul16"
#cfg$gms$c32_aff_policy <- "none"
start_run(cfg,codeCheck=FALSE)
