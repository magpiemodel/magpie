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
                             archive_rev     = "29",
                             madrat_rev      = "3.15",
                             validation_rev  = "3.15",
                             calibration     = NULL,
                             additional_data = "additional_data_rev3.29.tgz",
                             npi_base        = "npi_ndc_base_SSP2_mixed.tgz") {
  mappings <- c(h11="8a828c6ed5004e77d1ba2025e8ea2261",
                h12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a")
  archive_name=paste(project_name,climate_model,climatescen_name,co2,sep="-")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings[regionmapping], ".tgz")
  madrat  <- paste0("rev", madrat_rev, "_", mappings[regionmapping], "_magpie.tgz")
  validation  <- paste0("rev", validation_rev, "_", mappings[regionmapping], "_validation.tgz")
  return(c(archive,madrat,validation,calibration,additional_data,npi_base))
}

fixed <- function(cfg, ...) {
  cfg$title <- paste0(cfg$title,"_fixed")
  cfg$gms$factor_costs <- "fixed_per_ton_mar18"
  cfg$input <- buildInputVector(npi_base="npi_ndc_base_SSP2_fixed.tgz", ...)
  return(cfg)
}

mixed <- function(cfg, ...) {
  cfg$title <- paste0(cfg$title,"_mixed")
  cfg$gms$factor_costs <- "mixed_feb17"
  cfg$input <- buildInputVector(npi_base="npi_ndc_base_SSP2_mixed.tgz", ...)
  return(cfg)
}


### test run definitions ###

default <- function(cfg, func=mixed, ...) {
  cfg$force_download <- TRUE
  cfg$title <- "default"
  cfg <- func(cfg, ...)
  try(start_run(cfg=cfg, codeCheck=FALSE))
  return(submitCalibration(cfg$title))
}

default_rcp26 <- function(cfg, func=mixed, ...) {
  cfg$title <- "default_rcp26"
  cfg <- func(cfg, ...)
  cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
  cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA2"
  try(start_run(cfg=cfg, codeCheck=FALSE))
}

performance_bau <- function(cfg, func=mixed, ...) {
  cfg$title <- "bau"
  cfg <- func(cfg,...)
  try(performance_start(cfg=cfg, id=cfg$title, sequential=NA))
}

performance_rcp26 <- function(cfg, func=mixed, ...) {
  cfg$title <- "rcp26"
  cfg <- func(cfg,...)
  cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
  cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA2"
  try(performance_start(cfg=cfg, id=cfg$title, sequential=NA))
}

cc_default <- function(cfg, func=mixed, ...) {
  cfg$title <- "cc_default"
  cfg <- func(cfg,...)
  cfg <- setScenario(cfg, "cc")
  try(start_run(cfg=cfg, codeCheck=FALSE))
}

timesteps <- function(cfg, func=mixed, ...) {
  cfg$title <- "timesteps"
  cfg <- func(cfg,...)
  cfg$gms$c_timesteps <- "test_TS"
  try(start_run(cfg=cfg, codeCheck=FALSE))
}

ssp1 <- function(cfg, func=mixed, ...) {
  cfg$title <- "ssp1"
  cfg <- func(cfg,...)
  try(start_run(cfg=cfg,scenario="SSP1",codeCheck=FALSE))
}

ssp5 <- function(cfg, func=mixed, ...) {
  cfg$title <- "ssp5"
  cfg <- func(cfg,...)
  try(start_run(cfg=cfg,scenario="SSP5",codeCheck=FALSE))
}

cc_rcp26 <- function(cfg, func=mixed, ...) {
  cfg$title <- "cc_rcp26"
  cfg <- func(cfg,...)
  cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
  cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA2"
  cfg <- setScenario(cfg, "cc")
  try(start_run(cfg=cfg, codeCheck=FALSE))
}

cc_co2_rcp26 <- function(cfg, func=mixed, ...) {
  cfg$title <- "cc_co2_rcp26"
  cfg <- func(cfg, co2="co2", ...)
  cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
  cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA2"
  cfg <- setScenario(cfg, "cc")
  try(start_run(cfg=cfg, codeCheck=FALSE))
}

indc <- function(cfg, func=mixed, ...) {
  cfg$title <- "indc"
  cfg <- func(cfg,...)
  try(start_run(cfg=cfg,scenario="INDC",codeCheck=FALSE))
}

indc_rcp26 <- function(cfg, func=mixed, ...) {
  cfg$title <- "indc_rcp26"
  cfg <- func(cfg,...)
  cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
  cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA2"
  try(start_run(cfg=cfg,scenario="INDC",codeCheck=FALSE))
}

h12 <- function(cfg, func=mixed, ...) {
  cfg$title <- "h12"
  cfg <- func(cfg, regionmapping = "h12", ...)
  try(start_run(cfg=cfg, codeCheck=FALSE))
  return(submitCalibration(cfg$title))
}

h12_rcp26 <- function(cfg, func=mixed, ...) {
  cfg$title <- "h12_rcp26"
  cfg <- func(cfg, regionmapping = "h12", ...)
  cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
  cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA2"
  try(start_run(cfg=cfg, codeCheck=FALSE))
}


clusterres <- function(cfg, func=mixed, ...) {
  for(res in c("n200","h100","n100","h600","h1000","h2000")) {
    cfg$title <- res
    cfg <- func(cfg, resolution = res, ...)
    try(start_run(cfg=cfg, codeCheck=FALSE))
  }
}


### General settings ###
cfg$gms$c_timesteps <- "coup2100"
cfg$output <- "rds_report"
cfg <- setScenario(cfg,"SSP2")


### test runs ###

for(func in c(mixed,fixed)){
  calibration <- default(cfg, func)
  default_rcp26(cfg, func, calibration=calibration)

  performance_bau(cfg, func, calibration=calibration)
  performance_rcp26(cfg, func, calibration=calibration)

  cc_default(cfg, func, calibration=calibration)
  cc_rcp26(cfg, func, calibration=calibration)
  cc_co2_rcp26(cfg, func, calibration=calibration)

  timesteps(cfg, func, calibration=calibration)

  ssp1(cfg, func, calibration=calibration)
  ssp5(cfg, func, calibration=calibration)

  indc(cfg, func, calibration=calibration)
  indc_rcp26(cfg, func, calibration=calibration)

  h12calibration <-h12(cfg, func)
  h12_rcp26(cfg, func, calibration=h12calibration)
}
