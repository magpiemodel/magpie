# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"

cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"
cfg$gms$forestry  <- "dynamic_mar20"
cfg$gms$natveg  <- "dynamic_nov19"

#simple
cfg$gms$land <- "feb15"
cfg$gms$processing <- "off"
cfg$gms$disagg_lvst <- "off"
cfg$gms$maccs  <- "off_jul16"
cfg$gms$residues <- "off"
cfg$gms$c80_nlp_solver <- "conopt4"

identifier_flag <- "F19AM_OS_"

for(trade_module in c("selfsuff_reduced")){

  if(trade_module == "selfsuff_dynamic") trade_flag = "TVar"
  if(trade_module == "selfsuff_reduced") trade_flag = "TDef"

  for(redn_factor in c(0.5,0.1)){
    cfg$gms$s21_redn_factor <- redn_factor

    if(cfg$gms$s21_redn_factor == 0.5) redn_flag = "50pc"
    if(cfg$gms$s21_redn_factor == 0.1) redn_flag = "10pc"

    run_flag <- paste0(identifier_flag,redn_flag,"_",trade_flag,"_")

    cfg <- setScenario(cfg,c("SSP5","NPI"))
    cfg$gms$s15_elastic_demand <- 0
    cfg$title <- paste0(run_flag,"simple_SSP5")
    cfg$gms$timber <- "biomass_feb20"
    cfg$gms$trade <- trade_module
    start_run(cfg,codeCheck=FALSE)

    cfg <- setScenario(cfg,c("SSP2","NPI"))
    cfg$gms$s15_elastic_demand <- 0
    cfg$title <- paste0(run_flag,"simple_SSP2")
    cfg$gms$timber <- "biomass_feb20"
    cfg$gms$trade <- trade_module
    start_run(cfg,codeCheck=FALSE)
  }
}
