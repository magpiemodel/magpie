# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: LAMACLIMA WP4 runs
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################


library(gms)
library(magclass)
library(gdx)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

prefix <- "LAMA70"
cfg$force_replace <- TRUE

cfg$gms$factor_costs <- "sticky_labor"
cfg$gms$c38_sticky_mode <- "dynamic"
cfg$input["calibration"] <- "calibration_H12_sticky_feb18_dynamic_13Oct21.tgz"
cfg$input["patch"] <- "patch_timber.tgz"
cfg$gms$c17_prod_init <- "off"

cfg$gms$labor_prod <- "exo"
cfg$gms$c37_labor_rcp <- "rcp119"
cfg$gms$c37_labor_metric <- "ISO"
cfg$gms$c37_labor_intensity <- "400W"
cfg$gms$c37_labor_uncertainty <- "ensmean"

#https://www.oecd-ilibrary.org/docserver/9789264243439-8-en.pdf?expires=1620650049&id=id&accname=guest&checksum=7D894DDBF0C64FCC776D3AE6014FA9F0
oecd90andEU <- "ALB,AUS,AUT,BEL,BIH,BGR,CAN,CYP,CZE,DNK,EST,FIN,FRA,
				DEU,GRC,HUN,HRV,ISL,IRL,ITA,JPN,LUX,LVA,LTU,MLT,MNE,
				NLD,NOR,NZL,POL,PRT,ROU,SRB,SVK,SVN,ESP,SWE,CHE,MKD,TUR,
				GBR,USA"

cfg$results_folder <- "output/:title:"
cfg$output <- c("rds_report","extra/disaggregation","extra/disaggregation_LUH2","extra/highres")
#cfg$files2export$start <- c(cfg$files2export$start,"input/avl_land_full_t_0.5.mz")

cfg$qos <- "priority"

#Global Sustainability, based on SDP
cfg$title <- paste(prefix,"Sustainability",sep="_")
cfg <- setScenario(cfg,c("SDP","NDC","ForestryEndo"))
cfg$gms$c35_protect_scenario <- "FF_BH"
cfg$gms$c35_protect_scenario_noselect <- "FF_BH"
cfg$gms$policy_countries35  <- all_iso_countries
cfg$gms$s30_set_aside_shr <- 0.2
cfg$gms$s30_set_aside_shr_noselect <- 0.2
cfg$gms$c30_set_aside_target <- "by2030"
cfg$gms$policy_countries30 <- all_iso_countries
cfg$gms$c35_forest_damage_end <- "by2030"
#cfg$gms$s35_secdf_distribution <- 0
#1.5 degree policy
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c56_pollutant_prices_noselect <- "R21M42-SSP2-NPi"
cfg$gms$policy_countries56  <- all_iso_countries
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"
#default food scenario
cfg$gms$c15_food_scenario <- "SSP1"
cfg$gms$c15_food_scenario_noselect <- "SSP1"
#exo diet and waste
cfg$gms$c15_exo_scen_targetyear <- "y2050"
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$c15_kcal_scen <- "healthy_BMI"
cfg$gms$s15_exo_waste <- 1
cfg$gms$s15_waste_scen <- 1.2
cfg$gms$scen_countries15  <- all_iso_countries
#AFF
cfg$gms$s32_planing_horizon <- 50
cfg$gms$s32_aff_plantation <- 0
cfg$gms$s32_aff_bii_coeff <- 0
cfg$gms$s32_max_aff_area <- 500
cfg$gms$c32_aff_mask <- "noboreal"
#EFP
cfg$gms$c42_env_flow_policy <- "on"
cfg$gms$EFP_countries  <- all_iso_countries
#AWM
cfg$gms$c50_scen_neff <- "neff75_80_starty2010"
cfg$gms$c50_scen_neff_noselect <- "neff75_80_starty2010"
cfg$gms$cropneff_countries  <- all_iso_countries
#Fert
cfg$gms$c55_scen_conf <- "ssp1"
cfg$gms$c55_scen_conf_noselect <- "ssp1"
cfg$gms$scen_countries55  <- all_iso_countries
#irrig
cfg$gms$s42_irrig_eff_scenario <- 3
cfg$gms$c60_biodem_level <- 1
start_run(cfg,codeCheck=FALSE)

#Global Inequality, based on SSP4
cfg$title <- paste(prefix,"Inequality",sep="_")
cfg <- setScenario(cfg,c("SSP4","NDC","ForestryEndo"))
cfg$gms$c35_protect_scenario <- "FF_BH"
cfg$gms$c35_protect_scenario_noselect <- "WDPA"
cfg$gms$policy_countries35  <- oecd90andEU
cfg$gms$s30_set_aside_shr <- 0.2
cfg$gms$s30_set_aside_shr_noselect <- 0
cfg$gms$c30_set_aside_target <- "by2030"
cfg$gms$policy_countries30 <- oecd90andEU
cfg$gms$c35_forest_damage_end <- "by2030"
#cfg$gms$s35_secdf_distribution <- 0
#1.5 degree policy
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c56_pollutant_prices_noselect <- "R21M42-SSP2-NPi"
cfg$gms$policy_countries56  <- oecd90andEU
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"
#default food scenario
cfg$gms$c15_food_scenario <- "SSP4"
cfg$gms$c15_food_scenario_noselect <- "SSP4"
#exo diet and waste
cfg$gms$s15_exo_diet <- 0
cfg$gms$s15_exo_waste <- 0
cfg$gms$scen_countries15 <- all_iso_countries
#AFF
cfg$gms$s32_planing_horizon <- 50
cfg$gms$s32_aff_plantation <- 0
cfg$gms$s32_aff_bii_coeff <- 0
cfg$gms$s32_max_aff_area <- Inf
cfg$gms$c32_aff_mask <- "noboreal"
#EFP
cfg$gms$c42_env_flow_policy <- "on"
cfg$gms$EFP_countries  <- oecd90andEU
#AWM
cfg$gms$c50_scen_neff <- "neff75_80_starty2010"
cfg$gms$c50_scen_neff_noselect <- "neff65_70_starty2010"
cfg$gms$cropneff_countries  <- oecd90andEU
#Fert
cfg$gms$c55_scen_conf <- "ssp1"
cfg$gms$c55_scen_conf_noselect <- "ssp4"
cfg$gms$scen_countries55  <- oecd90andEU
#irrig
cfg$gms$s42_irrig_eff_scenario <- 3
cfg$gms$c60_biodem_level <- 1
start_run(cfg,codeCheck=FALSE)
