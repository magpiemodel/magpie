# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
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
library(gdx)
library(magpie4)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"

cfg$output <- c("rds_report")

prefix <- "hr04"

# start low resolution runs
res <- "c200"
#cfg$qos <- "priority"

cfg$input <- c(paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev42_",res,"_690d3718e151be1b450b394c1064b1c5.tgz"),
               "rev4.42_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
               "rev4.42_690d3718e151be1b450b394c1064b1c5_validation.tgz",
               paste0("calibration_H12_",res,"_highres.tgz"),
               "additional_data_rev3.78.tgz")

download_and_update(cfg)

ssps <- c("SSP1","SSP2","SSP3","SSP4","SSP5")
scen <- "2p6"
  
for (ssp in ssps) {
  cfg$title <- paste(prefix,ssp,scen,res,sep="_")
  cfg <- setScenario(cfg,c(ssp,"NDC"))
  cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-26-REMIND-MAGPIE"
  cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-26-REMIND-MAGPIE"
  start_run(cfg,codeCheck=FALSE)
}

#wait until the low resolution runs are finished
report_files <- paste0("output/",paste(prefix,ssps,scen,res,sep="_"),"/report.rds")
while (all(!file.exists(report_files))) {
  Sys.sleep(300)
}

#start high resolution runs

res <- "c1000"
cfg$qos <- "priority_maxMem"
#magpie4::submitCalibration("H12_c1000")
#c1000 with endoTC

cfg$input <- c(paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev42_",res,"_690d3718e151be1b450b394c1064b1c5.tgz"),
               "rev4.42_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
               "rev4.42_690d3718e151be1b450b394c1064b1c5_validation.tgz",
               paste0("calibration_H12_",res,"_highres.tgz"),
               "additional_data_rev3.78.tgz")

download_and_update(cfg)

for (ssp in ssps) {
  cfg$title <- paste(prefix,ssp,scen,res,sep="_")
  cfg <- setScenario(cfg,c(ssp,"NDC"))
  
  #get trade pattern from low resolution run with c200
  gdx <- paste0("output/",paste(prefix,ssp,scen,"c200",sep="_"),"/fulldata.gdx")
  ov_prod_reg <- readGDX(gdx,"ov_prod_reg",select=list(type="level"))
  ov_supply <- readGDX(gdx,"ov_supply",select=list(type="level"))
  f21_trade_balance <- ov_prod_reg - ov_supply
  write.magpie(round(f21_trade_balance,6),paste0("modules/21_trade/input/f21_trade_balance.cs3"))
  
  #get tau from low resolution run with c200, not used.
  tau(gdx,file = "modules/13_tc/input/f13_tau_scenario.csv",digits = 4)
  
  #use exo trade and parallel optimization
  cfg$gms$trade <- "exo"
  cfg$gms$optimization <- "nlp_par"
  #cfg$gms$s15_elastic_demand <- 0
  #cfg$gms$tc <- "exo"
  
  #cfg$gms$c60_bioenergy_subsidy <- 0
  
  cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-26-REMIND-MAGPIE"
  cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-26-REMIND-MAGPIE"
  start_run(cfg,codeCheck=FALSE)
}
