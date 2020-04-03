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

cfg$recalc_npi_ndc <- "ifneeded"

log_folder <- "run_details"
dir.create(log_folder,showWarnings = FALSE)

identifier_flag <- "BF05"
cat(paste0("ZERO DIV BUGFIX FOR OFF REALIZATION. Manual copy paste from latest develop 3rd Apr 2020. Needed because carbonstock calculation throws warning."),file=paste0(log_folder,"/",identifier_flag,".txt"),append=F)

for(ssp in c("SSP1","SSP2","SSP3","SSP4","SSP5")){

  for(c32_rotation_extension in c(0)){

    cfg$gms$c32_rotation_extension <- c32_rotation_extension

    for(timber_demand in c("biomass_mar20","off")){ ## Add "off" here to turn off timber demand

      cfg$gms$timber <- timber_demand

      for (co2_price_path in c("NPI","2deg")) { ## Add "2deg" here for CO2 price runs

        if (co2_price_path == "NPI") {
          cfg <- setScenario(cfg,c(ssp,"NPI"))
        } else {
          cfg <- setScenario(cfg,c(ssp,"NDC"))
        }

        for(emis_policy in c("redd+_nosoil","ssp_nosoil")){ ## Add "ssp_nosoil" for policy penalizing only natveg emissions

          cfg$gms$c56_emis_policy <- emis_policy

          cfg$gms$c56_pollutant_prices_select <- "coupling"
          cfg$gms$c60_2ndgen_biodem_select <- "coupling"

          file.copy(from = paste0("input/input_bioen_dem_",co2_price_path,".csv"), to = "modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv",overwrite = TRUE)
          file.copy(from = paste0("input/input_ghg_price_",co2_price_path,".cs3"), to = "modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3",overwrite = TRUE)

          ### Create flags

          if(timber_demand == "biomass_mar20") demand_flag = "tON"
          if(timber_demand == "off") demand_flag = "tOFF"

          if(emis_policy == "redd+_nosoil") pol_flag = "REDD"
          if(emis_policy == "ssp_nosoil") pol_flag = "SNS"

          cfg$title <- paste0(identifier_flag,"_",ssp,"_",demand_flag,"_",co2_price_path,"_",pol_flag)

          cfg$output <- c("rds_report")

#          cat(cfg$title,"\n")

          start_run(cfg,codeCheck=FALSE)
        }
      }
    }
  }
}

#*******************************************************************************

library(lucode)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"

cfg$recalc_npi_ndc <- TRUE

for(ssp in c("SSP1","SSP2","SSP3","SSP4","SSP5")){

  for(c32_rotation_extension in c(0)){

    cfg$gms$c32_rotation_extension <- c32_rotation_extension

    for(timber_demand in c("biomass_mar20","off")){

      cfg$gms$timber <- timber_demand

      for (co2_price_path in c("NPI")) { ## Add "2deg" here for CO2 price runs

        cfg <- setScenario(cfg,c(ssp,"NDC"))

        for(emis_policy in c("ssp_nosoil")){

          cfg$gms$c56_emis_policy <- emis_policy

          cfg$gms$c56_pollutant_prices <- "coupling"
          cfg$gms$c60_2ndgen_biodem <- "coupling"

          file.copy(from = paste0("input/input_bioen_dem_",co2_price_path,".csv"), to = "modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv",overwrite = TRUE)
          file.copy(from = paste0("input/input_ghg_price_",co2_price_path,".cs3"), to = "modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3",overwrite = TRUE)

          ### Create flags

          if(timber_demand == "biomass_mar20") demand_flag = "TimberON"
          if(timber_demand == "off") demand_flag = "TimberOFF"

          if(emis_policy == "redd+_nosoil") pol_flag = "REDD"
          if(emis_policy == "ssp_nosoil") pol_flag = "SSP"

          cfg$title <- paste0(identifier_flag,"_",ssp,"_",demand_flag,"_","c",co2_price_path,"_",pol_flag,"_",cfg$gms$c32_aff_policy)

          cfg$output <- c("rds_report")

#          cat(cfg$title,"\n")

          start_run(cfg,codeCheck=FALSE)
        }
      }
    }
  }
}
