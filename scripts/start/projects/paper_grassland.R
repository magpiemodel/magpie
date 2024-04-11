# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ------------------------------------------------
# description: Runs for Pasture mangagement paper
# ------------------------------------------------
library(gms)
# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run

scenarios <- list(c("SSP1","rcp2p6"), c("SSP2","rcp4p5"), c("SSP3","rcp7p0"), c("SSP4","rcp6p0"), c("SSP5", "rcp8p5"))

for (ssp_setting in scenarios) {
  name = "H12_G11"
  cfg="default.cfg"
  cfg <- setScenario(cfg,ssp_setting)
  if(grepl("FSEC", name)) {
    cfg$input["calibration"]  <- "calibration_FSEC_G3_22Mar22.tgz"
    if(SSP1 %in% ssp_setting){
       cfg$input["cellular"]  <- "rev4.68_e2bdb6cd_6819938d_cellularmagpie_c200_MRI-ESM2-0-ssp126_lpjml-8e6c5eb1.tgz"
    } else if (SSP2 %in% ssp_setting) {
       cfg$input["cellular"]  <- "rev4.68_e2bdb6cd_1b5c3817_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1.tgz"
    } else if (SSP3 %in% ssp_setting) {
       cfg$input["cellular"]  <- "rev4.68_e2bdb6cd_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz"
    } else if (SSP4 %in% ssp_setting) {
       cfg$input["cellular"]  <- "rev4.68_e2bdb6cd_3c888fa5_cellularmagpie_c200_MRI-ESM2-0-ssp460_lpjml-8e6c5eb1.tgz"
    } else if (SSP5 %in% ssp_setting) {
       cfg$input["cellular"]  <- "rev4.68_e2bdb6cd_09a63995_cellularmagpie_c200_MRI-ESM2-0-ssp585_lpjml-8e6c5eb1.tgz"
    } else {
       stop("Select a correct SSP scenario!")
    }
  } else {
    cfg$input["calibration"]  <- "calibration_H12_grassland_mar22.tgz"
  }
  cfg$gms$past <- "grasslands_apr22"
  cfg$title <- paste0(name,"_",ssp_setting[1],"_",ssp_setting[2],"_", substr(Sys.time(), 6,10),"-",gsub(":", "_I_", substr(Sys.time(), 12,16)))
  start_run(cfg)
}
