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

cfg$title <- "SSP2_Ref"
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP2_26_Aff33"
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA2"
cfg$gms$c56_aff_policy <- "vegc33"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP2_26_Aff50"
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA2"
cfg$gms$c56_aff_policy <- "vegc50"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP2_26_Aff75"
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA2"
cfg$gms$c56_aff_policy <- "vegc75"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP2_26_Aff100"
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA2"
cfg$gms$c56_aff_policy <- "vegc100"
start_run(cfg,codeCheck=FALSE)

