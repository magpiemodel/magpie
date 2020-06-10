# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


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

### TIME
#cfg$gms$c_timesteps <- "5year"

### Other settings
#cfg$gms$land <- "feb15"
#cfg$gms$c60_bioenergy_subsidy <- 0

## Bioenergy demand 0=GLO
cfg$gms$c60_biodem_level <- 0

### TIMBER
# * (biomass_mar20): WIP
cfg$gms$timber <- "biomass_mar20"                  # def = biomass_mar20

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

identifier_flag <- "PR187_03"

cat(paste0("Last for edits"), file=paste0(log_folder,"/",identifier_flag,".txt"),append=F)

for(secdf_distribution in c(0)){ 					## (0) for all in highest acx (1) for equal dist (2) for poulter dist

  cfg$gms$s35_secdf_distribution <- secdf_distribution

  for(ssp in c("SSP2")){

    for(timber_demand in c("biomass_mar20")){ ## Add "off" here to turn off timber demand

      cfg$gms$timber <- timber_demand

      if(timber_demand == "biomass_mar20") cfg$gms$s32_initial_distribution = 1
      if(timber_demand == "off") cfg$gms$s32_initial_distribution = 0

      for(faustmann_switch in c(0)){

        cfg$gms$s32_faustmann_rotation <- faustmann_switch

        for (co2_price_path in c("NPI","2deg")) { ## Add "2deg" here for CO2 price runs

          if (co2_price_path == "NPI") {
            cfg <- setScenario(cfg,c(ssp,"NPI"))
            cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi" #update to most recent coupled runs asap
            cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi" ##update to most recent coupled runs asap
            co2_price_path_flag = "Baseline"
          } else if (co2_price_path == "2deg"){
            cfg <- setScenario(cfg,c(ssp,"NDC"))
            co2_price_path_flag = "Policy"
            cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-26-REMIND-MAGPIE"
            cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-26-REMIND-MAGPIE"
          }
          for(emis_policy in c("redd+_nosoil")){ ## Add "ssp_nosoil" for policy penalizing only natveg emissions

            cfg$gms$c56_emis_policy <- emis_policy

            for(plantation_switch in c(1)){ ## Add 0 here to treat plantations as natural vegetation

              cfg$gms$s14_timber_plantation_yield <- plantation_switch
              cfg$gms$s32_timber_plantation <- cfg$gms$s14_timber_plantation_yield

#                cfg$gms$c56_pollutant_prices <- "coupling"
#                cfg$gms$c60_2ndgen_biodem <- "coupling"

#                file.copy(from = paste0("input/input_bioen_dem_",co2_price_path,".csv"), to = "modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv",overwrite = TRUE)
#                file.copy(from = paste0("input/input_ghg_price_",co2_price_path,".cs3"), to = "modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3",overwrite = TRUE)

              ### Create flags

              if(timber_demand == "biomass_mar20") demand_flag = ""
              if(timber_demand == "off") demand_flag = "NoTimber"

              if(emis_policy == "ssp_nosoil") pol_flag = "SSPnosoil"
              if(emis_policy == "redd+_nosoil") pol_flag = ""

              if(plantation_switch == 1) plantation_flag = ""
              if(plantation_switch == 0) plantation_flag = "NatVeg"

              if(faustmann_switch == 1) faustmann_flag = "Faustmann"
              if(faustmann_switch == 0) faustmann_flag = ""

              if(secdf_distribution == 0) distribution_flag = "xDist"
              if(secdf_distribution == 1) distribution_flag = "kDist"
              if(secdf_distribution == 2) distribution_flag = "pDist"

              cfg$title <- paste0(identifier_flag,"_",ssp,"_",demand_flag,"_",plantation_flag,"_",faustmann_flag,"_",pol_flag,"_",distribution_flag,"_",co2_price_path_flag)

              cfg$output <- c("rds_report")

#                cat(cfg$title,"\n")

              start_run(cfg,codeCheck=FALSE)
            }
          }
        }
      }
    }
  }
}

##### Version log (YYYYMMDD - Description - Author(s))
## 20200527 - Default SSP2 Baseline and Policy runs - FH,AM,EMJB,JPD

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

# Use user name and model version defined in default.cfg for generating the titel
#identifier_flag <- "PR187_02"

# Grab user name
user <- Sys.info()[["user"]]
#version <- cfg$model_version ## Havong this somehow throws compilation errors in maccs module

cfg$results_folder <- "output/:title:"

## Create a set of runs based on default.cfg

for(ssp in c("SSP2")) { ## Add SSP* here for testing other SSPs. Basic test should be for SSP2

  for (co2_price_path in c("BAU","POL")) {

    if (co2_price_path == "BAU") {
      cfg <- setScenario(cfg,c(ssp,"NPI"))
      cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi" #update to most recent coupled runs asap
      cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi" ##update to most recent coupled runs asap

    } else if (co2_price_path == "POL"){
      cfg <- setScenario(cfg,c(ssp,"NDC"))
      cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-26-REMIND-MAGPIE" #update to most recent coupled runs asap
      cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-26-REMIND-MAGPIE" ##update to most recent coupled runs asap
    }

    cfg$title <- paste0(identifier_flag,"_",user,"_",ssp,"-",co2_price_path) #Create easily distinguishable run title

    cfg$output <- c("rds_report") # Only run rds_report after model run

    start_run(cfg,codeCheck=TRUE) # Start MAgPIE run
    #cat(cfg$title)
  }
}
