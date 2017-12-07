# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(lucode)
library(magpie4)

source("scripts/start_functions.R")
source("scripts/performance_test.R")
source("config/default.cfg")

#set defaults
scenario <- "SSP2"
codeCheck <- FALSE

buildInputVector <- function(regionmapping   = "h11",
                             project_name    = "GLUES2",
                             climatescen_name= "sresa2",
                             co2             = "constant_co2",
                             climate_model   = "miub_echo_g",
                             resolution      = "h200",
                             archive_rev     = "24",
                             madrat_rev      = "3.3",
                             validation_rev  = "3.3",
                             calibration     = NULL,
                             additional_data = "additional_data_rev3.16.tgz") {
  mappings <- c(h11="8a828c6ed5004e77d1ba2025e8ea2261",
                h12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a")
  archive_name=paste(project_name,climatescen_name,co2,climate_model,sep="-")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings[regionmapping], ".tgz")
  madrat  <- paste0("magpie_", mappings[regionmapping], "_rev", madrat_rev, ".tgz")
  validation  <- paste0("validation_", mappings[regionmapping], "_rev", validation_rev, ".tgz")
  return(c(archive,madrat,validation,calibration,additional_data))
}



### Single test runs ###

cfg$force_download <- TRUE

cfg$title <- "default"
cfg$input <- buildInputVector()
cfg$gms$c_timesteps <- 11
cfg$gms$s15_elastic_demand <- 0
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"
try(start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck))

default_calibration <- submitCalibration("ValidationDefault")
cfg$force_download <- FALSE

cfg$title <- "rum_const"
cfg$input <- buildInputVector()
cfg$gms$c_timesteps <- 11
cfg$gms$s15_elastic_demand <- 0
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"
cfg$gms$c15_rumscen <- "constant"
try(start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck))
cfg$gms$c15_rumscen <- "halving2050"

cfg$title <- "pastcost0"
cfg$input <- buildInputVector()
cfg$gms$c_timesteps <- 11
cfg$gms$s15_elastic_demand <- 0
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"
cfg$gms$s31_fac_req_past  <- 0
try(start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck))
cfg$gms$s31_fac_req_past  <- 1

cfg$title <- "cc_default"
cfg$input <- buildInputVector()
cfg$gms$c_timesteps <- 11
cfg$gms$s15_elastic_demand <- 0
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"
cfg <- setScenario(cfg, "cc")
try(start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck))
cfg <- setScenario(cfg, "nocc")

cfg$title <- "timesteps"
cfg$input <- buildInputVector()
cfg$gms$c_timesteps <- "test_TS"
cfg$gms$s15_elastic_demand <- 0
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"
try(start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck))

cfg$title <- "flex_demand"
cfg$input <- buildInputVector()
cfg$gms$c_timesteps <- 11
cfg$gms$s15_elastic_demand <- 1
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"
try(start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck))

cfg$title <- "ssp1"
cfg$input <- buildInputVector()
cfg$gms$c_timesteps <- 11
cfg$gms$s15_elastic_demand <- 0
cfg$gms$c56_pollutant_prices <- "SSP1-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP1-Ref-SPA0"
try(start_run(cfg=cfg,scenario="SSP1",codeCheck=codeCheck))

cfg$title <- "ssp5"
cfg$input <- buildInputVector()
cfg$gms$c_timesteps <- 11
cfg$gms$s15_elastic_demand <- 0
cfg$gms$c56_pollutant_prices <- "SSP5-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP5-Ref-SPA0"
try(start_run(cfg=cfg,scenario="SSP5",codeCheck=codeCheck))

cfg$title <- "default_rcp26"
cfg$input <- buildInputVector()
cfg$gms$c_timesteps <- 11
cfg$gms$s15_elastic_demand <- 0
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
try(start_run(cfg=cfg,scenario=c(scenario,"BASE"),codeCheck=codeCheck))

cfg$title <- "cc_default_rcp26"
cfg$input <- buildInputVector()
cfg$gms$c_timesteps <- 11
cfg$gms$s15_elastic_demand <- 0
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
cfg <- setScenario(cfg, "cc")
try(start_run(cfg=cfg,scenario=c(scenario,"BASE"),codeCheck=codeCheck))
cfg <- setScenario(cfg, "nocc")

cfg$title <- "flex_demand_rcp"
cfg$input <- buildInputVector()
cfg$gms$c_timesteps <- 11
cfg$gms$s15_elastic_demand <- 1
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
try(start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck))

cfg$title <- "timesteps_rcp26"
cfg$input <- buildInputVector()
cfg$gms$c_timesteps <- "test_TS"
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
try(start_run(cfg=cfg,scenario=c(scenario,"BASE"),codeCheck=codeCheck))

cfg$title <- "globio_rcp26"
cfg$input <- buildInputVector()
cfg$gms$c_timesteps <- 11
cfg$gms$c60_biodem_level <- 0
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
try(start_run(cfg=cfg,scenario=c(scenario,"BASE"),codeCheck=codeCheck))
cfg$gms$c60_biodem_level <- 1

cfg$title <- "npi_rcp26"
cfg$input <- buildInputVector()
cfg$gms$c_timesteps <- 11
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
try(start_run(cfg=cfg,scenario=c(scenario,"NPI"),codeCheck=codeCheck))

cfg$title <- "indc_rcp26"
cfg$input <- buildInputVector()
cfg$gms$c_timesteps <- 11
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
try(start_run(cfg=cfg,scenario=c(scenario,"INDC"),codeCheck=codeCheck))

#stop()

cfg$title <- "h12"
cfg$input <- buildInputVector(regionmapping = "h12")
cfg$gms$c_timesteps <- 11
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"
try(start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck))
try(submitCalibration("ValidationH12"))

cfg$title <- "h12_rcp26"
cfg$input <- buildInputVector(regionmapping = "h12")
cfg$gms$c_timesteps <- 11
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
try(start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck))

cfg$title <- "mag"
cfg$input <- buildInputVector(regionmapping = "mag")
cfg$gms$c_timesteps <- 11
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"
try(start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck))
try(submitCalibration("ValidationMag"))

### Cluster resolution tests ###
cfg$gms$c_timesteps <- 11
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"

for(res in c("n200","h100","n100")) {
  cfg$title <- res
  cfg$input <- buildInputVector(resolution = res)
  try(start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck))
  try(submitCalibration(paste0("Validation",res)))
}

### Performance tests ###

cfg$title <- "bau"
cfg$input <- buildInputVector(calibration=default_calibration)
cfg$gms$c_timesteps <- 11
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"
try(performance_start(cfg=cfg, id=cfg$title, sequential=NA))

cfg$title <- "rcp26"
cfg$input <- buildInputVector(calibration=default_calibration)
cfg$gms$c_timesteps <- 11
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
try(performance_start(cfg=cfg, id=cfg$title, sequential=NA))
