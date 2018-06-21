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

cfg$title <- "SSP2_Ref"
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
start_run(cfg,codeCheck=FALSE)

cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp6p0-noco2_rev32_h200_690d3718e151be1b450b394c1064b1c5.tgz",
               "rev3.25_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
               "rev3.25_690d3718e151be1b450b394c1064b1c5_validation.tgz",
               "additional_data_rev3.36.tgz",
               "calibration_H12_16Jun18.tgz")

cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"

cfg$title <- "noCC"
start_run(cfg,codeCheck=FALSE)

cfg$gms$c14_yields_scenario  <- "cc"
cfg$gms$c42_watdem_scenario  <- "cc"
cfg$gms$c43_watavail_scenario  <- "cc"
cfg$gms$c52_carbon_scenario  <- "cc"

cfg$title <- "CC"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "CC_pastTC25"
cfg$gms$yields <- "biocorrect"
cfg$gms$s14_yld_past_switch <- 0.25
start_run(cfg,codeCheck=FALSE)

cfg$title <- "CC_pastTC100"
cfg$gms$yields <- "biocorrect"
cfg$gms$s14_yld_past_switch <- 1
start_run(cfg,codeCheck=FALSE)
cfg$gms$s14_yld_past_switch <- 0.25
cfg$gms$yields <- "dynamic_apr18"

cfg$title <- "CC_intGlo"
cfg$gms$interest_rate <- "glo_jan16"
start_run(cfg,codeCheck=FALSE)
cfg$gms$interest_rate <- "reg_feb18"


