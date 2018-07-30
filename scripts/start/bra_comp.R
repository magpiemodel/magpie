# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(lucode)
library(magpie4)

source("scripts/start_functions.R")
source("scripts/performance_test.R")
source("config/default.cfg")

#### MAgPIE Brazil comparison tests



## Default MAgPIE ##

cfg$title <- "default"
cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp8p5-co2_rev33_h200_690d3718e151be1b450b394c1064b1c5.tgz",
               "rev4_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
               "rev4_690d3718e151be1b450b394c1064b1c5_validation.tgz",
               "additional_data_rev3.45.tgz")
cfg$gms$c_timesteps <- "5year2050"
start_run(cfg=cfg,codeCheck=codeCheck)



## Regionalized MAgPIE ##



cfg$title <- "MAgPIE_Brasil"
cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev33_h200_BRA4_e90458394d5302941049f44b72ff08dc.tgz",
               "rev4_e90458394d5302941049f44b72ff08dc_magpie.tgz",
               "rev4_e90458394d5302941049f44b72ff08dc_validation.tgz",
               "additional_data_rev3.45.tgz")
start_run(cfg=cfg,codeCheck=codeCheck)


#USA test#



cfg$title <- "USA_focused"
cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev33_h200_USA4_2b409196626ee246982f5ec87323c01a.tgz",
               "rev4_2b409196626ee246982f5ec87323c01a_magpie.tgz",
               "rev4_2b409196626ee246982f5ec87323c01a_validation.tgz",
               "additional_data_rev3.45.tgz")
start_run(cfg=cfg,codeCheck=codeCheck)


