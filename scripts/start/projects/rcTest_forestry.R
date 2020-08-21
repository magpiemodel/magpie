# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: forestry simple test
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode2)
library(magclass)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

#cfg$force_download <- TRUE

###########################################################################
##################### Forestry specific settings ##########################
###########################################################################

cfg$gms$s15_elastic_demand <- 0

### TIME
#cfg$gms$c_timesteps <- "5year"

### Other settings
#cfg$gms$land <- "feb15"
#cfg$gms$c60_bioenergy_subsidy <- 0

## Bioenergy demand 0=GLO
cfg$gms$c60_biodem_level <- 0

### OPTIMIZATION
# * 1: using optfile for specified solver settings
# * 0: default settings (optfile will be ignored)
cfg$gms$s80_optfile <- 1
## Solver maxiter
cfg$gms$s80_maxiter <- 2

###########################################################################

cfg$results_folder <- "output/:title:"

cfg$recalc_npi_ndc <- "ifneeded"

log_folder <- "run_details"
dir.create(log_folder,showWarnings = FALSE)

identifier_flag <- "rc_Forestry_"

cat(paste0("Test dynamic ac set"), file=paste0(log_folder,"/",identifier_flag,".txt"),append=F)

#xx = c()

for (co2_price_path in c("2deg")) {

  for(s32_initial_distribution in c(1)){

    cfg$gms$s32_initial_distribution = s32_initial_distribution
    cfg$gms$s73_demand_switch = s32_initial_distribution

    if(s32_initial_distribution == 1) timber_flag = "timberON"
    if(s32_initial_distribution == 0) timber_flag = "timberOFF"

    for(emis_policy in c("redd+_nosoil")){

      for(ssp in c("SSP2")){
        if(emis_policy == "redd+_nosoil") cfg$gms$s32_plant_carbon_foresight = 1
        if(emis_policy == "ssp_nosoil")   cfg$gms$s32_plant_carbon_foresight = 0

        if (co2_price_path == "NPI" && emis_policy == "redd+_nosoil") {
          cfg <- setScenario(cfg,c(ssp,"NPI"))
          cfg$gms$c56_emis_policy <- emis_policy
          cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi" #update to most recent coupled runs asap
          cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi" ##update to most recent coupled runs asap
          pol_flag = "REDD+"
          co2_price_path_flag = "Baseline"
        } else if (co2_price_path == "2deg"){
          cfg <- setScenario(cfg,c(ssp,"NDC"))
          cfg$gms$c56_emis_policy <- emis_policy
          cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-26-REMIND-MAGPIE"
          cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-26-REMIND-MAGPIE"
          if(emis_policy == "ssp_nosoil") pol_flag = ""
          if(emis_policy == "redd+_nosoil") pol_flag = "REDD+"
          co2_price_path_flag = "Policy"
        } else if (ssp != "SSP2" && emis_policy!="redd+_nosoil"){
          break
        }

        #          cfg$gms$c56_pollutant_prices <- "coupling"
        #          cfg$gms$c60_2ndgen_biodem <- "coupling"

        #          file.copy(from = paste0("input/input_bioen_dem_",co2_price_path,".csv"), to = "modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv",overwrite = TRUE)
        #          file.copy(from = paste0("input/input_ghg_price_",co2_price_path,".cs3"), to = "modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3",overwrite = TRUE)

        #cfg$title <- paste0(identifier_flag,"_",ssp,"_",pol_flag,"_",co2_price_path_flag,"_",timber_flag)
        cfg$title <- paste0(identifier_flag,"_",ssp,"_",co2_price_path_flag)

        cfg$output <- c("rds_report")

#        xx <- c(xx,cfg$title)
        start_run(cfg,codeCheck=FALSE)
      }
    }
  }
}
