# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")

buildInputVector <- function(regionmapping   = "aus",
                             project_name    = "isimip_rcp",
                             climatescen_name= "rcp2p6",
                             co2             = "co2",
                             climate_model   = "IPSL_CM5A_LR",
                             resolution      = "h200",
                             archive_rev     = "33",
                             madrat_rev      = "3.34",
                             validation_rev  = "3.34",
                             calibration     = NULL,
                             additional_data = "additional_data_rev3.41.tgz") {
  mappings <- c(aus="b18f2e819b94edba598984a7da8f553c",
                bra="e90458394d5302941049f44b72ff08dc",
                cha="fb4142b907bc772d14b467365f58c330",
                eth="cc2f7adaab245d3d5cb63f6caff2d76f",
                idn="6f3b58c7e203e8d9d2ea92993d84ee54",
                ind="4431b698acab987e1dedd3a714231643",
                usa="2b409196626ee246982f5ec87323c01a")
  archive_name=paste(project_name,climate_model,climatescen_name,co2,sep="-")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", toupper(regionmapping),"4_",mappings[regionmapping], ".tgz")
  madrat  <- paste0("rev", madrat_rev, "_", mappings[regionmapping], "_magpie.tgz")
  validation  <- paste0("rev", validation_rev, "_", mappings[regionmapping], "_validation.tgz")
  return(c(archive,madrat,validation,calibration,additional_data))
}

calib_date <- "15Jul18"

for(x in c("aus","bra","cha","eth","idn","ind","usa")) {
  calibration <- ifelse(exists("calib_date") && !is.null(calib_date),paste0("calibration_",x,"_",calib_date,".tgz"), NULL)
  cfg$title <- x
  cfg$input <- buildInputVector(regionmapping=x, calibration=calibration)
  if(is.null(calibration)){
    start_run(cfg=cfg)
    calib <- submitCalibration(x)
    cfg$input <- c(cfg$input,calib)
  }
  publish_data(input=cfg, name=paste0("testdata2_",x), target=".")
}
