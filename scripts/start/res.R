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
cfg$recalibrate <- TRUE

cfg$title <- "h200_def"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "h200_weight2"
cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev33_h200_LAM2_SSA2_OAS2_690d3718e151be1b450b394c1064b1c5.tgz",
               "rev4.2_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
               "rev4.2_690d3718e151be1b450b394c1064b1c5_validation.tgz",
               "additional_data_rev3.48.tgz",
               "calibration_H12_06Aug18.tgz")
start_run(cfg,codeCheck=FALSE)

cfg$title <- "h200_weight15"
cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev33_h200_LAM15_SSA15_OAS15_690d3718e151be1b450b394c1064b1c5.tgz",
               "rev4.2_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
               "rev4.2_690d3718e151be1b450b394c1064b1c5_validation.tgz",
               "additional_data_rev3.48.tgz",
               "calibration_H12_06Aug18.tgz")
start_run(cfg,codeCheck=FALSE)
