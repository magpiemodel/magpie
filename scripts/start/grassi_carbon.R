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
cfg$recalibrate <- FALSE

# cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev34_c200_690d3718e151be1b450b394c1064b1c5.tgz",
#                "rev4.14_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
#                "rev4.14_690d3718e151be1b450b394c1064b1c5_validation.tgz",
#                "additional_data_rev3.65.tgz",
#                "calibration_H12_c200_12Sep18.tgz")

#SSP2 Ref noCC
cfg$title <- "SSP2_Ref_noCC_04"
cfg$gms$land <- "dec18"
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
start_run(cfg,codeCheck=FALSE)

#SSP2 Ref CC
cfg$title <- "SSP2_Ref_CC_04"
cfg$gms$land <- "dec18"
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
cfg$gms$c14_yields_scenario  <- "cc"
cfg$gms$c42_watdem_scenario  <- "cc"
cfg$gms$c52_carbon_scenario  <- "cc"
cfg$gms$c59_som_scenario  <- "cc"
start_run(cfg,codeCheck=FALSE)

##SSP2 26 CC
cfg$title <- "SSP2_26_CC_04"
cfg$gms$land <- "dec18"
cfg <- setScenario(cfg,c("SSP2","NDC"))
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA2"
cfg$gms$c14_yields_scenario  <- "cc"
cfg$gms$c42_watdem_scenario  <- "cc"
cfg$gms$c52_carbon_scenario  <- "cc"
cfg$gms$c59_som_scenario  <- "cc"
start_run(cfg,codeCheck=FALSE)
