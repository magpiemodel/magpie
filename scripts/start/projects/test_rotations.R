# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test new rotational constraint scenarios
# ----------------------------------------------------------


######################################
#### Script to start a MAgPIE run ####
######################################

library(gms)
library(lucode2)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
cfg$gms$s13_max_gdp_shr <- 0.01

cfg$results_folder <- "output/:title:"
#cfg$output <- c("rds_report","extra/disaggregation")#"extra/highres"
prefix <- "rota_penalty18"

cfg$title <- paste(prefix,"olddefault",sep="_")
start_run(cfg,codeCheck=FALSE)

#cfg$title <- paste(prefix,"olddefault_stickydynamic",sep="_")
#cfg$input <- c(regional    = "rev4.68_h12_magpie.tgz",
#               cellular    = "rev4.68_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
#               validation  = "rev4.68_h12_validation.tgz",
#               additional  = "additional_data_rev4.18.tgz",
#               calibration = "calibration_H12_sticky_feb18_dynamic_rotation_14Jun22.tgz")

#cfg$gms$c38_sticky_mode <- "dynamic"
#start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"newdefault",sep="_")
cfg$gms$crop    <- "penalty_apr22"
cfg$gms$som    <- "cellpool_aug16"
cfg$gms$c30_rotation_scenario = "default"


#cfg$qos <- "priority"
cfg$recalibrate <- TRUE
cfg$recalibrate_landconversion_cost <- TRUE
start_run(cfg,codeCheck=FALSE)
magpie4::submitCalibration("H12_sticky_feb18_dynamic_rotation2")
cfg$recalibrate <- FALSE
cfg$recalibrate_landconversion_cost <- FALSE

for (scenario in c("none","default","fallow","legumes","agroforestry","agroecology")){
  for (byyear in c("by2030","by2050")){
    cfg$gms$c30_rotation_scenario = scenario
    cfg$gms$c30_rotation_scenario_speed = byyear
    cfg$title <- paste(prefix,scenario,byyear,sep="_")
    start_run(cfg,codeCheck=FALSE)
  }

}
