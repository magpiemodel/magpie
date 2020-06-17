# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")

library(magpie4)
library(gms)

buildInputVector <- function(regionmapping   = "aus",
                             project_name    = "isimip_rcp",
                             climatescen_name= "rcp2p6",
                             co2             = "co2",
                             climate_model   = "IPSL_CM5A_LR",
                             resolution      = "c200",
                             archive_rev     = "34",
                             madrat_rev      = "4.18",
                             validation_rev  = "4.18",
                             calibration     = NULL,
                             additional_data = "additional_data_rev3.66.tgz") {
  mappings <- c(h12="690d3718e151be1b450b394c1064b1c5")
  archive_name=paste(project_name,climate_model,climatescen_name,co2,sep="-")
  if(regionmapping=="h12") archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings["h12"], ".tgz")
  else  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", toupper(regionmapping),"4_",mappings["h12"], ".tgz")
  madrat  <- paste0("rev", madrat_rev, "_", mappings["h12"], "_magpie.tgz")
  validation  <- paste0("rev", validation_rev, "_", mappings["h12"], "_validation.tgz")
  return(c(archive,madrat,validation,calibration,additional_data))
}

calib_date <- "21Mar19"

for(x in c("h12","ind","cha")) {
  if(exists("calib_date") && !is.null(calib_date)) {
    calibration <- paste0("calibration_",x,"_",calib_date,".tgz")
    if(x=="h12") calibration <- "calibration_H12_c200_12Sep18.tgz"
  } else {
    calibration <-  NULL
  }
  cfg$title <- x
  cfg$input <- buildInputVector(regionmapping=x, calibration=calibration)
  if(is.null(calibration)){
    start_run(cfg=cfg)
    calib <- submitCalibration(x)
    cfg$input <- c(cfg$input,calib)
  }
  if(x=="h12") x <- "default"
  gms::publish_data(input=cfg, name=paste0("magpie4.1_",x,"_apr19"), target=".")
}
