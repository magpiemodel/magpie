# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(lucode)
source("scripts/start_functions.R")
source("config/default.cfg")

buildInputVector <- function(base            = "magpie4.1_default_apr19.tgz",
                             archive         = "LPJmL5",         #NULL,
                             climate_model   = "IPSL_CM5A_LR",
                             climatescen_name= "rcp2p6",
                             co2             = NULL,
                             archive_rev     = "39",
                             resolution      = "c200",
                             regionmapping   = "H12",
                             addings         = NULL,                 #"_IND4", #NULL,
                             madrat          = "4.21",                 #NULL
                             validation      = "4.21",               #NULL
                             calibration     = NULL,                 #NULL
                             additional_data = "3.68",               #NULL
                             patch           = NULL){

  mappings <- c(H11="8a828c6ed5004e77d1ba2025e8ea2261",
                H12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a",
                agmip="c77f075908c3bc29bdbe1976165eccaf",
                sim4nexus="25dd7264e8e145385b3bd0b89ec5f3fc",
                capri="e7e72fddc44cc3d546af7b038c651f51",
		BRATRADE="d49a7a8baaab0edc754ebfc09462be0a")

  archive_name <- paste(archive,climate_model,climatescen_name,co2,sep="-")
  if(!is.null(archive))    archive     <- paste0(archive_name, "_rev", archive_rev, "_", resolution, addings,"_", mappings[regionmapping], ".tgz")
  if(!is.null(madrat))     madrat      <- paste0("rev", madrat,"_", mappings[regionmapping], "_magpie", ".tgz")
  if(!is.null(validation)) validation  <- paste0("rev", validation,"_", mappings[regionmapping], "_validation", ".tgz")
  if(!is.null(additional_data)) additional_data <- paste0("additional_data_rev",additional_data,".tgz")

  return(c(base,archive,madrat,validation,calibration,additional_data,patch))
}

cfg$input <- buildInputVector()


cfg$recalibrate <- TRUE

cfg$gms$s14_limit_calib <- 1
cfg$title    <- "lpjml5_limited_calib"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$recalibrate <- FALSE

cfg$gms$s14_limit_calib <- 0
cfg$title    <- "lpjml5_purerel_calib"
start_run(cfg=cfg,codeCheck=TRUE)

cfg<-lucode::setScenario(cfg,"cc")

cfg$gms$s14_limit_calib <- 1
cfg$title    <- "lpjml5_limited_calib_cc"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$gms$s14_limit_calib <- 0
cfg$title    <- "lpjml5_purerel_calib_cc"
start_run(cfg=cfg,codeCheck=TRUE)
