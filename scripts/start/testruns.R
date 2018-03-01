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
                             additional_data = "additional_data_rev3.18.tgz") {
  mappings <- c(h11="8a828c6ed5004e77d1ba2025e8ea2261",
                h12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a")
  archive_name=paste(project_name,climate_model,climatescen_name,co2,sep="-")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings[regionmapping], ".tgz")
  madrat  <- paste0("rev", madrat_rev, "_", mappings[regionmapping], "_magpie.tgz")
  validation  <- paste0("rev", validation_rev, "_", mappings[regionmapping], "_validation.tgz")
  return(c(archive,madrat,validation,calibration,additional_data))
}

### test run definitions ###

default <- function(cfg, calibration=NULL) {
  cfg$force_download <- TRUE
  cfg$title <- "default"
  cfg$input <- buildInputVector(calibration=calibration)
  try(start_run(cfg=cfg, codeCheck=FALSE))
  return(submitCalibration("ValidationDefault"))
}

performance_bau <- function(cfg, calibration=NULL) {
  cfg$title <- "bau"
  cfg$input <- buildInputVector(calibration=calibration)
  try(performance_start(cfg=cfg, id=cfg$title, sequential=NA))
}

performance_rcp26 <- function(cfg, calibration=NULL) {
  cfg$title <- "rcp26"
  cfg$input <- buildInputVector(calibration=calibration)
  cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
  cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
  try(performance_start(cfg=cfg, id=cfg$title, sequential=NA))
}

rum_const <- function(cfg, calibration=NULL) {
  cfg$title <- "rum_const"
  cfg$input <- buildInputVector(calibration=calibration)
  cfg$gms$c15_rumscen <- "constant"
  try(start_run(cfg=cfg, codeCheck=FALSE))
}

pastcost0 <- function(cfg, calibration=NULL) {
  cfg$title <- "pastcost0"
  cfg$input <- buildInputVector(calibration=calibration)
  cfg$gms$s31_fac_req_past  <- 0
  try(start_run(cfg=cfg, codeCheck=FALSE))
}

pastswitch <- function(cfg, calibration=NULL) {
  for(ps in c(0,25,50,75)) {
    cfg$gms$s14_yld_past_switch <- ps/100
    cfg$title <- paste0("past_switch",ps)
    cfg$input <- buildInputVector(calibration=calibration)
    try(start_run(cfg=cfg, codeCheck=FALSE))
  }
}

cc_default <- function(cfg, calibration=NULL) {
  cfg$title <- "cc_default"
  cfg$input <- buildInputVector(calibration=calibration)
  cfg <- setScenario(cfg, "cc")
  try(start_run(cfg=cfg, codeCheck=FALSE))
}

timesteps <- function(cfg, calibration=NULL) { 
  cfg$title <- "timesteps"
  cfg$input <- buildInputVector(calibration=calibration)
  cfg$gms$c_timesteps <- "test_TS"
  try(start_run(cfg=cfg, codeCheck=FALSE))
}

flex_demand <- function(cfg, calibration=NULL) {
  cfg$title <- "flex_demand"
  cfg$input <- buildInputVector(calibration=calibration)
  cfg$gms$s15_elastic_demand <- 1
  try(start_run(cfg=cfg, codeCheck=FALSE))
}
  
ssp1 <- function(cfg, calibration=NULL) {
  cfg$title <- "ssp1"
  cfg$input <- buildInputVector(calibration=calibration)
  try(start_run(cfg=cfg,scenario="SSP1",codeCheck=FALSE))
}

ssp5 <- function(cfg, calibration=NULL) {
  cfg$title <- "ssp5"
  cfg$input <- buildInputVector(calibration=calibration)
  try(start_run(cfg=cfg,scenario="SSP5",codeCheck=FALSE))
}

default_rcp26 <- function(cfg, calibration=NULL) {
  cfg$title <- "default_rcp26"
  cfg$input <- buildInputVector(calibration=calibration)
  cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
  cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
  try(start_run(cfg=cfg, codeCheck=FALSE))
}

cc_default_rcp26 <- function(cfg, calibration=NULL) {
  cfg$title <- "cc_default_rcp26"
  cfg$input <- buildInputVector(calibration=calibration)
  cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
  cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
  cfg <- setScenario(cfg, "cc")
  try(start_run(cfg=cfg, codeCheck=FALSE))
}
  
flex_demand_rcp26 <- function(cfg, calibration=NULL) {
  cfg$title <- "flex_demand_rcp"
  cfg$input <- buildInputVector(calibration=calibration)
  cfg$gms$s15_elastic_demand <- 1
  cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
  cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
  try(start_run(cfg=cfg, codeCheck=FALSE))
}

timesteps_rcp26 <- function(cfg, calibration=NULL) {
  cfg$title <- "timesteps_rcp26"
  cfg$input <- buildInputVector(calibration=calibration)
  cfg$gms$c_timesteps <- "test_TS"
  cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
  cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
  try(start_run(cfg=cfg, codeCheck=FALSE))
}

globio_rcp26 <- function(cfg, calibration=NULL) {
  cfg$title <- "globio_rcp26"
  cfg$input <- buildInputVector(calibration=calibration)
  cfg$gms$c60_biodem_level <- 0
  cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
  cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
  try(start_run(cfg=cfg, codeCheck=FALSE))
}

npi_rcp26 <- function(cfg, calibration=NULL) {
  cfg$title <- "npi_rcp26"
  cfg$input <- buildInputVector(calibration=calibration)
  cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
  cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
  try(start_run(cfg=cfg,scenario="NPI",codeCheck=FALSE))
}

indc_rcp26 <- function(cfg, calibration=NULL) {
  cfg$title <- "indc_rcp26"
  cfg$input <- buildInputVector(calibration=calibration)
  cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
  cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
  try(start_run(cfg=cfg,scenario="INDC",codeCheck=FALSE))
}

h12 <- function(cfg) {
  cfg$title <- "h12"
  cfg$input <- buildInputVector(regionmapping = "h12")
  try(start_run(cfg=cfg, codeCheck=FALSE))
  return(submitCalibration("h12Default"))
}

h12_rcp26 <- function(cfg, calibration=NULL) { 
  cfg$title <- "h12_rcp26"
  cfg$input <- buildInputVector(regionmapping = "h12", calibration=calibration)
  cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
  cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
  try(start_run(cfg=cfg, codeCheck=FALSE))
}

mag <- function(cfg) {
  cfg$title <- "mag"
  cfg$input <- buildInputVector(regionmapping = "mag")
  try(start_run(cfg=cfg, codeCheck=FALSE))
  return(submitCalibration("MAgPIEDefault"))
}

clusterres <- function(cfg, calibration=NULL) {
  for(res in c("n200","h100","n100","h600","h1000","h2000")) {
    cfg$title <- res
    cfg$input <- buildInputVector(resolution = res, calibration=calibration)
    try(start_run(cfg=cfg, codeCheck=FALSE))
  }
}

### General settings ###
cfg$gms$c_timesteps <- 11
cfg$gms$s15_elastic_demand <- 0
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"
cfg <- setScenario(cfg,"SSP2")


### test runs ###

default_calibration <- default(cfg)

#cc_default(cfg, default_calibration)
default_rcp26(cfg, default_calibration)
cc_default_rcp26(cfg, default_calibration)

performance_bau(cfg, default_calibration)
performance_rcp26(cfg, default_calibration)

rum_const(cfg, default_calibration)

<<<<<<< HEAD
cfg$title <- "ndc_rcp26"
cfg$input <- buildInputVector()
cfg$gms$c_timesteps <- 11
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
try(start_run(cfg=cfg,scenario=c(scenario,"NDC"),codeCheck=codeCheck))
=======
pastcost0(cfg, default_calibration)
pastswitch(cfg, default_calibration)
>>>>>>> release

timesteps(cfg, default_calibration)
#timesteps_rcp26(cfg, default_calibration)

flex_demand(cfg, default_calibration)
flex_demand_rcp26(cfg, default_calibration)

ssp1(cfg, default_calibration)
ssp5(cfg, default_calibration)

globio_rcp26(cfg, default_calibration)

npi_rcp26(cfg, default_calibration)
indc_rcp26(cfg, default_calibration)

clusterres(cfg, default_calibration)

h12_calibration <- h12(cfg)
h12_rcp26(cfg, h12_calibration)

mag(cfg)

