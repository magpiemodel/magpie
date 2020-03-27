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

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"

cfg$output <- c("rds_report")

prefix <- "hr01"
res <- "c1000"

cfg$input <- c(paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev42_",res,"_690d3718e151be1b450b394c1064b1c5.tgz"),
               "rev4.42_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
               "rev4.42_690d3718e151be1b450b394c1064b1c5_validation.tgz",
               "calibration_H12_c200_26Feb20.tgz",
               "additional_data_rev3.78.tgz")

co2_price_path <- "NPI"
file.copy(from = paste0("input/input_bioen_dem_",co2_price_path,".csv"), to = "modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv",overwrite = TRUE)
file.copy(from = paste0("input/input_ghg_price_",co2_price_path,".cs3"), to = "modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3",overwrite = TRUE)


for (ssp in c("SSP1","SSP2","SSP3","SSP4","SSP5")) {
  cfg$title <- paste(prefix,ssp,"NPI",res,sep="_")
  cfg <- setScenario(cfg,c(ssp,"NPI"))
  
  #get trade pattern from low resolution run with c200
  gdx <- paste0("output/",paste(prefix,ssp,"NPI","c200",sep="_"))
  ov_prod_reg <- readGDX(gdx,"ov_prod_reg",select=list(type="level"))
  ov_supply <- readGDX(gdx,"ov_supply",select=list(type="level"))
  f21_trade_balance <- ov_prod_reg - ov_supply
  write.magpie(round(f21_trade_balance,6),paste0("modules/21_trade/input/f21_trade_balance.cs3"))
  
  #use exo trade and parallel optimization
  cfg$gms$trade <- "exo"
  cfg$gms$optimization <- "nlp_par"
  
  # cfg$gms$c56_pollutant_prices <- "coupling"
  # cfg$gms$c60_2ndgen_biodem <- "coupling"
  start_run(cfg,codeCheck=FALSE)
}

