# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: gmd-2021-76 forestry paper
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

identifier_flag = "gmd-2021-76_03"
cat(paste0("Higher rotation, more share from EUR."), file=paste0(log_folder,"/",identifier_flag,".txt"),append=F)

xx <- c()

#scen_vector <- c("ForestryOff","ForestryEndo","ForestryExo")
scen_vector <- c("ForestryOff","ForestryEndo")

for(c73_wood_scen in c("default")){

  for(s80_maxiter in c(30)){
    for(scen in scen_vector){

        for(ssp in c("SSP2")){
          source("config/default.cfg")

          cfg$gms$s80_maxiter = s80_maxiter

          cfg = setScenario(cfg,c(ssp,"NPI",scen))

          # Should input data be downloaded from source even if cfg$input did not change?
          cfg$force_download <- TRUE

            #cfg$gms$c_timesteps <- "5year"

            for(c32_rot_calc_type in c("mean_annual_increment","current_annual_increment","instantaneous_growth_rate")){
              cfg$gms$s15_elastic_demand <- 0
              cfg$gms$c32_rot_calc_type <- c32_rot_calc_type

              if(cfg$gms$s73_foresight == 1) foresight_flag = "Forward"
              if(cfg$gms$s73_foresight != 1) foresight_flag = "Myopic"

    #          cfg$gms$c57_macc_version = "PBL_2019"

              if(scen=="ForestryOff")           scen_flag="Default"
              if(scen=="ForestryEndo")          scen_flag="Forestry"
              if(scen=="ForestryExo")           scen_flag="ForestryExo"

              if(c32_rot_calc_type=="mean_annual_increment")       rl_flag="MAI"
              if(c32_rot_calc_type=="current_annual_increment")    rl_flag="CAI"
              if(c32_rot_calc_type=="instantaneous_growth_rate")   rl_flag="IGR"

              cfg$gms$c73_wood_scen = c73_wood_scen

              cfg$title   = paste0(identifier_flag,"_",scen_flag,"_",rl_flag)
              cfg$output  = c("extra/timestep_duration")

               xx = c(xx,cfg$title)
               cfg$gms$s80_optfile <- 0
               cfg$results_folder = "output/:title:"
               start_run(cfg,codeCheck=FALSE)
            }
        }
     }
  }

}
