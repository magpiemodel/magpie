# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
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

identifier_flag = "FEB04"
cat(paste0("MEA planted area cellular fix"), file=paste0(log_folder,"/",identifier_flag,".txt"),append=F)

xx <- c()
for(scen in c("forestry","nocc")){

    for(ssp in c("SSP2")){
      source("config/default.cfg")

      cfg$gms$s80_maxiter = 5

      cfg = setScenario(cfg,c(ssp,scen))

      for(land_conversion in c("devstate_feb21")){
        #cfg$gms$c_timesteps <- "5year"

        cfg$gms$landconversion <- land_conversion

        cfg$gms$recalibrate <- "ifneeded"


        cfg$gms$s15_elastic_demand <- 0


        if(cfg$gms$s73_foresight == 1) foresight_flag = "Forward"
        if(cfg$gms$s73_foresight != 1) foresight_flag = "Myopic"

        cfg$gms$c57_macc_version = "PBL_2019"
        cfg$gms$c60_biodem_level <- 0

        if(cfg$gms$landconversion == "devstate_feb21")      lc_flag = "DevState"
        if(cfg$gms$landconversion == "global_static_aug18") lc_flag = "Default"

        if(scen=="nocc") scen_flag="Default"
        if(scen=="forestry") scen_flag="Forestry"

        cfg$title   = paste0(identifier_flag,"_",scen_flag)
        cfg$output  = c("extra/timestep_duration")

         xx = c(xx,cfg$title)
         cfg$gms$s80_optfile <- 1
         cfg$results_folder = "output/:title:"
         start_run(cfg,codeCheck=FALSE)
      }
    }
}

#          cfg$gms$c56_pollutant_prices = "coupling"
#          cfg$gms$c60_2ndgen_biodem = "coupling"

#          file.copy(from = paste0("input/input_bioen_dem_",co2_price_path,".csv"), to = "modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv",overwrite = TRUE)
#          file.copy(from = paste0("input/input_ghg_price_",co2_price_path,".cs3"), to = "modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3",overwrite = TRUE)
