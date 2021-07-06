# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Forestry paper simulations
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode2)
library(magclass)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

log_folder = "run_details"
dir.create(log_folder,showWarnings = FALSE)

identifier_flag = "JUL01"
cat(paste0("Building demand runs with higher rotations"), file=paste0(log_folder,"/",identifier_flag,".txt"),append=F)

xx <- c()
all_configs <- list()

#scen_vector <- c("ForestryOff","ForestryEndo","ForestryExo")
scen_vector <- c("ForestryEndo")

for(c73_wood_scen in c("default")){

  for(s80_maxiter in c(30)){
    for(scen in scen_vector){

        for(ssp in c("SSP2")){
          source("config/default.cfg")

          cfg$gms$s80_maxiter = s80_maxiter

          cfg = setScenario(cfg,c(ssp,"NPI",scen))

          for(c21_trade_liberalization in c("l909090r808080")) {

            cfg$gms$c21_trade_liberalization <- c21_trade_liberalization

            if(cfg$gms$c21_trade_liberalization=="l909090r808080")    trade_flag="DefTrade"
            if(cfg$gms$c21_trade_liberalization=="l908080r807070")    trade_flag="LibTrade"

            for (c73_build_demand in c("BAU","10pc", "50pc", "90pc")) {

              for(c35_protect_scenario in c("WDPA")){

                for(s73_expansion in c(0)){

                  cfg$gms$c35_protect_scenario <- c35_protect_scenario

                  cfg$gms$s73_expansion <- s73_expansion

                  #cfg$gms$tc <- "exo"

                  cfg$gms$c73_build_demand <- c73_build_demand
                  cfg$gms$s15_elastic_demand <- 0

                  if(cfg$gms$s73_foresight == 1) foresight_flag = "Forward"
                  if(cfg$gms$s73_foresight != 1) foresight_flag = "Myopic"

                  cfg$force_download <- TRUE
                  cfg$recalibrate <- "ifneeded"     # def = "ifneeded"

                  if(scen=="ForestryOff")           scen_flag="Default"
                  if(scen=="ForestryEndo")          scen_flag="Forestry"
                  if(scen=="ForestryExo")           scen_flag="ForestryExo"

                  cfg$gms$c73_wood_scen = c73_wood_scen

                  cfg$title   = paste0(identifier_flag,"_",trade_flag,"_",c73_build_demand,"_",c35_protect_scenario)
                  cfg$output  = c("extra/timestep_duration")

                  xx = c(xx,cfg$title)
                  all_configs[[cfg$title]] <- cfg
                  #cfg$gms$s80_optfile <- 1
                  cfg$results_folder = "output/:title:"
                  start_run(cfg,codeCheck=FALSE)
                }
              }
            }

          }
        }
     }
  }
}

#for(i in names(all_configs)){
#  message(i)
#  print(all_configs[[i]]$gms$c73_build_demand)
#}


#          cfg$gms$c56_pollutant_prices = "coupling"
#          cfg$gms$c60_2ndgen_biodem = "coupling"

#          file.copy(from = paste0("input/input_bioen_dem_",co2_price_path,".csv"), to = "modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv",overwrite = TRUE)
#          file.copy(from = paste0("input/input_ghg_price_",co2_price_path,".cs3"), to = "modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3",overwrite = TRUE)
