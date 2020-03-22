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

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"

identifier_flag <- "F33AM"

for(c73_demand_adjuster in c("price_based","manually_adjusted")){
  cfg$gms$c73_demand_adjuster <- c73_demand_adjuster
  for(ssp in c("SSP2")){

    for(c32_rotation_extension in c(0)){

      cfg$gms$c32_rotation_extension <- c32_rotation_extension

      cfg <- setScenario(cfg,c(ssp,"NPI"))

      for(emis_price in c("R2M41-SSP2-NPi")){

        cfg$gms$c56_pollutant_prices <- emis_price
        cfg$gms$c60_2ndgen_biodem <- emis_price

        ### Create flags

        if(c32_rotation_extension == 0) rot_flag = ""
        if(c32_rotation_extension == 1) rot_flag = "5yE"
        if(c32_rotation_extension == 2) rot_flag = "10yE"

        if(emis_price == "R2M41-SSP2-NPi") emis_flag = ""
        if(emis_price == "R2M41-SSP2-Budg1300") emis_flag = "CO2p"

        if(c73_demand_adjuster == "price_based") adj_flag = "PriceFix"
        if(c73_demand_adjuster == "manually_adjusted") adj_flag = "SlackFix"

        cfg$title <- paste0(identifier_flag,"_",adj_flag,"_",emis_flag,"_",rot_flag,"_",ssp)

        cfg$output <- c("rds_report","disaggregation")

        start_run(cfg,codeCheck=FALSE)
      }
    }
  }
}
