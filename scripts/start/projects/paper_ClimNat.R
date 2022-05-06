# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Paper Climate vs. Nature
# ----------------------------------------------------------


######################################
#### Script to start a MAgPIE run ####
######################################

library(gms)
library(lucode2)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"
cfg$output <- c("rds_report","extra/disaggregation")#"extra/highres"

prefix <- "CN45"

cfg$qos <- "priority"

for (pol in c("Ref","Climate","Nature","Climate+Nature","Climate+Nature+Food")) {
  for (ssp in c("SSP2")) {
    if (pol == "Ref") {
      cfg <- setScenario(cfg,c(ssp,"NPI","rcp7p0"))
      cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"#"PIK_NPI"
      cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"#"PIK_NPI"
      cfg$gms$c60_biodem_level <- 1
      cfg$gms$s32_aff_plantation <- 0
      cfg$gms$s32_aff_bii_coeff <- 0
      cfg$gms$s44_target_price <- 0
      cfg$gms$c35_protect_scenario <- "WDPA"
      cfg$gms$c30_set_aside_target <- "none"
      cfg$gms$s30_set_aside_shr <- 0
      cfg$gms$c56_emis_policy <- "redd+_nosoil"
    } else if (pol == "Climate") {
      cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9"))
      cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"#"PIK_LIN"
      cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"#"PIK_LIN"
      cfg$gms$c60_biodem_level <- 1
      cfg$gms$s32_aff_plantation <- 0
      cfg$gms$s32_aff_bii_coeff <- 0
      cfg$gms$c35_forest_damage_end <- "by2030"
      cfg$gms$s44_target_price <- 0
      cfg$gms$c35_protect_scenario <- "WDPA"
      cfg$gms$c30_set_aside_target <- "none"
      cfg$gms$s30_set_aside_shr <- 0
      cfg$gms$c56_emis_policy <- "redd+_nosoil"
    } else if (pol == "Nature") {
      cfg <- setScenario(cfg,c(ssp,"NDC","rcp7p0"))
      cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"#"PIK_NPI"
      cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"#"PIK_NPI"
      cfg$gms$c60_biodem_level <- 1
      cfg$gms$s32_aff_plantation <- 0
      cfg$gms$s32_aff_bii_coeff <- 0
      cfg$gms$c35_forest_damage_end <- "by2030"
      cfg$gms$s44_target_price <- 2000
      cfg$gms$c35_protect_scenario <- "BH_IFL"
      cfg$gms$c30_set_aside_target <- "by2030"
      cfg$gms$s30_set_aside_shr <- 0.2
      cfg$gms$c56_emis_policy <- "redd+_nosoil"
    } else if (pol == "Climate+Nature") {
      cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9"))
      cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"#"PIK_LIN"
      cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"#"PIK_NPI"
      cfg$gms$c60_biodem_level <- 1
      cfg$gms$s32_aff_plantation <- 0
      cfg$gms$s32_aff_bii_coeff <- 0
      cfg$gms$c35_forest_damage_end <- "by2030"
      cfg$gms$s44_target_price <- 2000
      cfg$gms$c35_protect_scenario <- "BH_IFL"
      cfg$gms$c30_set_aside_target <- "by2030"
      cfg$gms$s30_set_aside_shr <- 0.2
      cfg$gms$c56_emis_policy <- "redd+_nosoil"
    } else if (pol == "Climate+Nature+Food") {
      cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9"))
      cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"#"PIK_LIN"
      cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"#"PIK_NPI"
      cfg$gms$s15_exo_diet <- 1
      cfg$gms$s15_exo_waste <- 1
      cfg$gms$c60_biodem_level <- 1
      cfg$gms$s32_aff_plantation <- 0
      cfg$gms$s32_aff_bii_coeff <- 0
      cfg$gms$c35_forest_damage_end <- "by2030"
      cfg$gms$s44_target_price <- 2000
      cfg$gms$c35_protect_scenario <- "BH_IFL"
      cfg$gms$c30_set_aside_target <- "by2030"
      cfg$gms$s30_set_aside_shr <- 0.2
      cfg$gms$c56_emis_policy <- "redd+_nosoil"
    } 
    cfg$title <- paste(prefix,paste0(ssp,"-",pol),sep="_")
    start_run(cfg,codeCheck=FALSE)
    #    cfg$recalibrate <- FALSE
  }
}
