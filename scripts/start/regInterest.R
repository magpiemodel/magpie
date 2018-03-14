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

buildInputVector <- function(regionmapping   = "h11",
                             project_name    = "isimip_rcp",
                             climatescen_name= "rcp2p6",
                             co2             = "noco2",
                             climate_model   = "IPSL_CM5A_LR",
                             resolution      = "h200",
                             archive_rev     = "26.2",
                             madrat_rev      = "3.8",
                             validation_rev  = "3.8",
                             calibration     = NULL,
                             additional_data = "additional_data_rev3.18.tgz",
                             input_reg_interest = "additional_input.tgz") {
  mappings <- c(h11="8a828c6ed5004e77d1ba2025e8ea2261",
                h12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a")
  archive_name=paste(project_name,climate_model,climatescen_name,co2,sep="-")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings[regionmapping], ".tgz")
  madrat  <- paste0("rev", madrat_rev, "_", mappings[regionmapping], "_magpie.tgz")
  validation  <- paste0("rev", validation_rev, "_", mappings[regionmapping], "_validation.tgz")
  return(c(archive,madrat,validation,calibration,additional_data,input_reg_interest))
}


### General settings ###
cfg$gms$c_timesteps <- 11
cfg$gms$s15_elastic_demand <- 0
cfg$gms$trade <- "selfsuff_flexreg"
cfg$gms$interest_rate <- "reg_feb18"
cfg$gms$c12_interest_rate <- "mixed"
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"
cfg <- setScenario(cfg,"SSP2")


cfg$force_download <- FALSE
cfg$title <- "default_regIR"
cfg$input <- buildInputVector(calibration=FALSE)
start_run(cfg=cfg, codeCheck=FALSE)
