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

identifier_flag <- "BF26"
cat(paste0("Yield from half of rotation length seen at estblishment point didn't work. Possible bug in how model sees future yields?. For now reverted back to normal specification. Price based fix test. 5 year runs. Fixed harvest rule update via loop. Discussed with Florian --- this is okay. Added additional switch to select plantation yield via growing stock calculation. The Growing stock is calculated normally but is divided based on plantation yield flag in two streams of two new parameters. Annual Yields are now calculated from this and used in equations. Separated growing stocks are used for reporting. New flags added to make tests where plantations are treated as natveg. Hotelling rule input file will also be used to make co2 price runs in policy case. CO2 prices in baseline runs bugfix included. Those are fixed to 0. Woodfuel demand 50% across the board. "), file=paste0(log_folder,"/",identifier_flag,".txt"),append=F)

for(s73_price_adjuster in c(0)){
  cfg$gms$s73_price_adjuster <- s73_price_adjuster

  for(ssp in c("SSP2")){

    for(timber_demand in c("biomass_mar20","off")){ ## Add "off" here to turn off timber demand

      cfg$gms$timber <- timber_demand

      if(timber_demand == "biomass_mar20") cfg$gms$c32_initial_distribution = 1
      if(timber_demand == "off") cfg$gms$c32_initial_distribution = 0

      for(faustmann_switch in c(0,1)){

        cfg$gms$c32_faustmann_rotation <- faustmann_switch

        for (co2_price_path in c("NPI","2deg")) { ## Add "2deg" here for CO2 price runs

          if (co2_price_path == "NPI") {
            cfg <- setScenario(cfg,c(ssp,"NPI"))
            co2_price_path_flag = "Baseline"
          } else if (co2_price_path == "2deg"){
            cfg <- setScenario(cfg,c(ssp,"NDC"))
            co2_price_path_flag = "Policy"
          } else if (co2_price_path == "Hotelling"){
            cfg <- setScenario(cfg,c(ssp,"NDC"))
            co2_price_path_flag = "PolicyH"
          }

          for(emis_policy in c("redd+_nosoil")){ ## Add "ssp_nosoil" for policy penalizing only natveg emissions

            cfg$gms$c56_emis_policy <- emis_policy

            for(plantation_switch in c(1)){ ## Add 0 here to treat plantations as natural vegetation

              cfg$gms$s14_timber_plantation_yield <- plantation_switch
              cfg$gms$s32_timber_plantation <- cfg$gms$s14_timber_plantation_yield

              cfg$gms$c56_pollutant_prices <- "coupling"
              cfg$gms$c60_2ndgen_biodem <- "coupling"

              file.copy(from = paste0("input/input_bioen_dem_",co2_price_path,".csv"), to = "modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv",overwrite = TRUE)
              file.copy(from = paste0("input/input_ghg_price_",co2_price_path,".cs3"), to = "modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3",overwrite = TRUE)

              ### Create flags

              if(timber_demand == "biomass_mar20") demand_flag = ""
              if(timber_demand == "off") demand_flag = "NoTimber"

              if(emis_policy == "ssp_nosoil") pol_flag = "SSPnosoil"
              if(emis_policy == "redd+_nosoil") pol_flag = ""

              if(plantation_switch == 1) plantation_flag = ""
              if(plantation_switch == 0) plantation_flag = "NatVeg"

              if(faustmann_switch == 1) faustmann_flag = "Faustmann"
              if(faustmann_switch == 0) faustmann_flag = ""

              if(s73_price_adjuster == 1) adjustment_flag = "PriceAdj"
              if(s73_price_adjuster == 0) adjustment_flag = ""

              cfg$title <- paste0(identifier_flag,"_",ssp,"_",adjustment_flag,"_",demand_flag,"_",plantation_flag,"_",faustmann_flag,"_",pol_flag,"_",co2_price_path_flag)

              cfg$output <- c("rds_report")

    #          cat(cfg$title,"\n")

              start_run(cfg,codeCheck=FALSE)
            }
          }
        }
      }
    }
  }
}
