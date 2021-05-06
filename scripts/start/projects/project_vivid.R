# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: VIVID
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

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"
cfg$output <- c("rds_report","extra/disaggregation")

prefix <- "VE10"
cfg$qos <- "priority"

cfg$gms$s80_optfile <- 1
cfg$gms$s80_maxiter <- 30

cfg$gms$s32_planing_horizon <- 100
cfg$gms$c35_protect_scenario <- "WDPA"
cfg$gms$c56_emis_policy <- "redd+_nosoil"

#ref
for (pol in c("Ref","Climate","Climate+Nature","ClimatePlant+NatureP10","ClimateNatveg+NatureP0")) {
  if (pol == "Ref") {
    cfg <- setScenario(cfg,c("SSP2","NPI"))
    cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
    cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"
    cfg$gms$s32_aff_plantation <- 0
    cfg$gms$c44_price_bv_loss <- "p0"
  } else if (pol == "Climate") {
    cfg <- setScenario(cfg,c("SSP2","NDC"))
    cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
    cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"
    cfg$gms$s32_aff_plantation <- 1
    cfg$gms$c44_price_bv_loss <- "p0"
  } else if (pol == "Climate+Nature") {
    cfg <- setScenario(cfg,c("SSP2","NDC"))
    cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
    cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"
    cfg$gms$s32_aff_plantation <- 0
    cfg$gms$c44_price_bv_loss <- "p10_p10000"
  } else if (pol == "ClimatePlant+NatureP10") {
    cfg <- setScenario(cfg,c("SSP2","NDC"))
    cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
    cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"
    cfg$gms$s32_aff_plantation <- 1
    cfg$gms$c44_price_bv_loss <- "p10_p10000"
  } else if (pol == "ClimateNatveg+NatureP0") {
    cfg <- setScenario(cfg,c("SSP2","NDC"))
    cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
    cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"
    cfg$gms$s32_aff_plantation <- 0
    cfg$gms$c44_price_bv_loss <- "p0"
  } 
  cfg$title <- paste(prefix,paste0("SSP2-",pol),sep="_")
  start_run(cfg,codeCheck=FALSE)
}
