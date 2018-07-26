# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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
cfg$results_folder <- "output/:title:"
cfg$gms$c_timesteps <- "coup2100"

cfg$gms$c80_nlp_solver <- "conopt4"
cfg$gms$s80_optfile <- 0

cfg$recalibrate <- TRUE

for (res in c("h200","h600","h1000")) {
  for (scen in c("Base","Pol")) {
    for (food in c("E1","E0")) {
      for (fcost in c("m","f")) {
        cfg$input <- c(paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-noco2_rev30_",res,"_8a828c6ed5004e77d1ba2025e8ea2261.tgz"),
                       "rev3.17_8a828c6ed5004e77d1ba2025e8ea2261_magpie.tgz",
                       "rev3.17_8a828c6ed5004e77d1ba2025e8ea2261_validation.tgz",
                       "additional_data_rev3.32.tgz")
        if (scen == "Base") {
          cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
          cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
        } else {
          cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0-V15-REMIND-MAGPIE"
          cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA0"
        } 
        if (food == "E1") cfg$gms$s15_elastic_demand <- 1 else cfg$gms$s15_elastic_demand <- 0
        if (fcost == "m") cfg$gms$factor_costs <- "mixed_feb17" else cfg$gms$factor_costs <- "fixed_per_ton_mar18"
        
        cfg$title <- paste(res,scen,food,fcost,sep="_")
        print(cfg$title)
        start_run(cfg,codeCheck=FALSE)
      }
    }
  }
}
