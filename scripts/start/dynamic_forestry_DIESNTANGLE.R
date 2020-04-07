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

identifier_flag <- "DUMMY01" #"BF08"
cat(paste0("Possible bugfix for carbonstock warning. CO2 prices in baseline runs bugfix included. Those are fixed to 0. Woodfuel demand 50% across the board. This is a dummy run to check if all systems are OK."),file=paste0(log_folder,"/",identifier_flag,".txt"),append=F)

for(ssp in c("SSP2")){

  for(c32_rotation_extension in c(0)){

    cfg$gms$c32_rotation_extension <- c32_rotation_extension

    for(timber_demand in c("biomass_mar20")){ ## Add "off" here to turn off timber demand

      cfg$gms$timber <- timber_demand

      for (co2_price_path in c("NPI")) { ## Add "2deg" here for CO2 price runs

        if (co2_price_path == "NPI") {
          cfg <- setScenario(cfg,c(ssp,"NPI"))
          co2_price_path_flag = "Baseline"
        } else {
          cfg <- setScenario(cfg,c(ssp,"NDC"))
          co2_price_path_flag = "Policy"
        }

        for(emis_policy in c("redd+_nosoil")){ ## Add "ssp_nosoil" for policy penalizing only natveg emissions

          cfg$gms$c56_emis_policy <- emis_policy

          for(plantation_switch in c(1)){

            cfg$gms$s32_timber_plantation <- plantation_switch

            cfg$gms$c56_pollutant_prices_select <- "coupling"
            cfg$gms$c60_2ndgen_biodem_select <- "coupling"

            file.copy(from = paste0("input/input_bioen_dem_",co2_price_path,".csv"), to = "modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv",overwrite = TRUE)
            file.copy(from = paste0("input/input_ghg_price_",co2_price_path,".cs3"), to = "modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3",overwrite = TRUE)

            ### Create flags

            if(timber_demand == "biomass_mar20") demand_flag = ""
            if(timber_demand == "off") demand_flag = "tOFF"

            if(emis_policy == "ssp_nosoil") pol_flag = ""
            if(emis_policy == "redd+_nosoil") pol_flag = "REDD"

            if(plantation_switch == 1) plantation_flag = ""
            if(plantation_switch == 0) plantation_flag = "pNatVeg"

            cfg$title <- paste0(identifier_flag,"_",plantation_switch,"_",ssp,"_",demand_flag,"_",co2_price_path_flag,"_",pol_flag)

            cfg$output <- c("rds_report")

  #          cat(cfg$title,"\n")

            start_run(cfg,codeCheck=FALSE)
          }
        }
      }
    }
  }
}
