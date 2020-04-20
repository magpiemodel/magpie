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

prefix <- "hr03"
res <- "c1000"
#magpie4::submitCalibration("H12_c1000")
#c1000 with endoTC
#c2000 with exoTC

cfg$input <- c(paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev42_",res,"_690d3718e151be1b450b394c1064b1c5.tgz"),
               "rev4.42_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
               "rev4.42_690d3718e151be1b450b394c1064b1c5_validation.tgz",
               paste0("calibration_H12_",res,"_highres.tgz"),
               "additional_data_rev3.78.tgz")

download_and_update(cfg)

calib <- FALSE

if(calib) {
  ssp <- "SSP2"
  cfg$title <- paste(prefix,ssp,"NPI",res,"calib2",sep="_")
  cfg <- setScenario(cfg,c(ssp,"NPI"))
  
  #get trade pattern from low resolution run with c200
  gdx <- paste0("output/",paste("hr01",ssp,"NPI","c200",sep="_"),"/fulldata.gdx")
  ov_prod_reg <- readGDX(gdx,"ov_prod_reg",select=list(type="level"))
  ov_supply <- readGDX(gdx,"ov_supply",select=list(type="level"))
  f21_trade_balance <- ov_prod_reg - ov_supply
  write.magpie(round(f21_trade_balance,6),paste0("modules/21_trade/input/f21_trade_balance.cs3"))

  #use exo trade and parallel optimization
  cfg$gms$trade <- "exo"
  cfg$gms$optimization <- "nlp_par"
  cfg$gms$s15_elastic_demand <- 0
  #cfg$gms$c60_bioenergy_subsidy <- 0
  
  cfg$recalibrate <- TRUE
  
  start_run(cfg,codeCheck=FALSE)
} else {
  for (ssp in c("SSP1","SSP2","SSP3","SSP4","SSP5")) {
    cfg$title <- paste(prefix,ssp,"2p6",res,sep="_")
    cfg <- setScenario(cfg,c(ssp,"NDC"))
    
    #get trade pattern from low resolution run with c200
    gdx <- paste0("output/",paste("hr03",ssp,"2p6","c200","glo",sep="_"),"/fulldata.gdx")
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
}

