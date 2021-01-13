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

identifier_flag = "DEC52"

cat(paste0("Revert bugfix in forest protetcion according to initial distribution. Coup2100 runs"), file=paste0(log_folder,"/",identifier_flag,".txt"),append=F)

xx <- c()
for(scen in c("forestry","nocc")){

  for(ssp in c("SSP2")){

    source("config/default.cfg")

    cfg$gms$s80_maxiter = 5

    cfg$results_folder = "output/:title:"

    cfg$recalc_npi_ndc = "ifneeded"

    cfg = setScenario(cfg,c(ssp,scen))


    if(cfg$gms$s32_fix_plant == 1 && cfg$gms$s73_foresight == 1) break

    if(cfg$gms$s73_foresight == 1) foresight_flag = "Forward"
    if(cfg$gms$s73_foresight != 1) foresight_flag = "Myopic"

    if(cfg$gms$s73_demand_switch == 1) timber_flag = "timberON"
    if(cfg$gms$s73_demand_switch == 0) timber_flag = "timberOFF"

    if(cfg$gms$s32_fix_plant == 0) plant_area_flag = "Baseline"
    if(cfg$gms$s32_fix_plant == 1) plant_area_flag = "Constrained"

    if(cfg$gms$s32_distribution_type == 0) init_flag = "Equal"
    if(cfg$gms$s32_distribution_type == 1) init_flag = "FAO"
    if(cfg$gms$s32_distribution_type == 2) init_flag = "Poulter"

    if(cfg$gms$s35_secdf_distribution == 0) dist_flag = "ACx"
    if(cfg$gms$s35_secdf_distribution == 1) dist_flag = "Equal"
    if(cfg$gms$s35_secdf_distribution == 2) dist_flag = "Poulter"

    if(cfg$gms$s35_forest_damage == 0) damage_flg = "None"
    if(cfg$gms$s35_forest_damage == 1) damage_flg = "Wildfire"
    if(cfg$gms$s35_forest_damage == 2) damage_flg = "Combined"

    if(scen=="nocc") scen_flag="Default"
    if(scen=="forestry") scen_flag="Forestry"

    cfg$title   = paste0(identifier_flag,"_",scen_flag,"_",plant_area_flag)
    cfg$output  = c("extra/timestep_duration")

     xx = c(xx,cfg$title)
     start_run(cfg,codeCheck=FALSE)
  }
}
#########################################################################################

#### COPY FROM ABOV FIRST #####

#          cfg$gms$c56_pollutant_prices = "coupling"
#          cfg$gms$c60_2ndgen_biodem = "coupling"

#          file.copy(from = paste0("input/input_bioen_dem_",co2_price_path,".csv"), to = "modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv",overwrite = TRUE)
#          file.copy(from = paste0("input/input_ghg_price_",co2_price_path,".cs3"), to = "modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3",overwrite = TRUE)
