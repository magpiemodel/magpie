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
cfg$calib_maxiter <- 3

low_res <- "n500"
for(res in c(low_res,paste0(low_res,"_LAM2"),paste0(low_res,"_LAM3"),paste0(low_res,"_LAM4"),paste0(low_res,"_LAM5"),paste0(low_res,"_LAM6"))) {
  cfg$title <- res
  cfg$input <- c(paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev33_",res,"_690d3718e151be1b450b394c1064b1c5.tgz"),
                 "rev4.61_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
                 "rev4.61_690d3718e151be1b450b394c1064b1c5_validation.tgz",
                 "additional_data_rev3.49.tgz",
                 "calibration_H12_06Aug18.tgz")
  start_run(cfg,codeCheck=FALSE)
}
