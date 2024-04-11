# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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

source("scripts/start_functions.R")

source("config/default.cfg")

#cfg$force_download <- TRUE
cfg$force_replace <- TRUE

cfg$results_folder <- "output/:title:"
cfg$output <- c("rds_report","extra/disaggregation")#"extra/highres"

prefix <- "CN72"


cfg$qos <- "priority"

cfg$gms$c_timesteps <- "5year"
cfg$gms$biodiversity <- "bii_target"

for (pol in c("CurPol","Carbon","Biodiversity","Integrated")) {
  for (ssp in c("SSP2")) {
    if (pol == "CurPol") {
      cfg <- setScenario(cfg,c(ssp,"NPI","rcp4p5"))
      cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"#"PIK_NPI"
      cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"#"PIK_NPI"
      cfg$gms$s15_exo_diet <- 0
      cfg$gms$s15_exo_waste <- 0
      cfg$gms$c60_biodem_level <- 1
      cfg$gms$s32_aff_plantation <- 0
      cfg$gms$s32_aff_bii_coeff <- 0
      cfg$gms$s32_max_aff_area <- Inf
      cfg$gms$s44_target_price <- 0
      cfg$gms$s44_bii_target <- 0
      cfg$gms$c35_protect_scenario <- "WDPA"
      cfg$gms$c30_snv_target <- "none"
      cfg$gms$s30_snv_shr <- 0
      cfg$gms$s56_c_price_induced_aff <- 0
    } else if (pol == "Carbon") {
      cfg <- setScenario(cfg,c(ssp,"NPI","rcp1p9"))
      cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"#"PIK_LIN"
      cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"#"PIK_NPI"
      cfg$gms$s15_exo_diet <- 0
      cfg$gms$s15_exo_waste <- 0
      cfg$gms$c60_biodem_level <- 1
      cfg$gms$s32_aff_plantation <- 0
      cfg$gms$s32_aff_bii_coeff <- 0
      cfg$gms$s32_max_aff_area <- Inf
      cfg$gms$c35_forest_damage_end <- "by2030"
      cfg$gms$s44_target_price <- 0
      cfg$gms$s44_bii_target <- 0
      cfg$gms$c35_protect_scenario <- "WDPA"
      cfg$gms$c30_snv_target <- "none"
      cfg$gms$s30_snv_shr <- 0
      cfg$gms$s56_c_price_induced_aff <- 1
    } else if (pol == "Biodiversity") {
      cfg <- setScenario(cfg,c(ssp,"NPI","rcp4p5"))
      cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"#"PIK_NPI"
      cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"#"PIK_NPI"
      cfg$gms$s15_exo_diet <- 0
      cfg$gms$s15_exo_waste <- 0
      cfg$gms$c60_biodem_level <- 1
      cfg$gms$s32_aff_plantation <- 0
      cfg$gms$s32_aff_bii_coeff <- 0
      cfg$gms$s32_max_aff_area <- Inf
      cfg$gms$c35_forest_damage_end <- "by2030"
      cfg$gms$s44_bii_target <- 0.81
      cfg$gms$c35_protect_scenario <- "BH_IFL"
      cfg$gms$c30_snv_target <- "by2030"
      cfg$gms$s30_snv_shr <- 0.2
      cfg$gms$s56_c_price_induced_aff <- 0
    } else if (pol == "Integrated") {
      cfg <- setScenario(cfg,c(ssp,"NPI","rcp1p9"))
      cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"#"PIK_LIN"
      cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"#"PIK_NPI"
      cfg$gms$s15_exo_diet <- 0
      cfg$gms$s15_exo_waste <- 0
      cfg$gms$c60_biodem_level <- 1
      cfg$gms$s32_aff_plantation <- 0
      cfg$gms$s32_aff_bii_coeff <- 0
      cfg$gms$s32_max_aff_area <- Inf
      cfg$gms$c35_forest_damage_end <- "by2030"
      cfg$gms$s44_bii_target <- 0.81
      cfg$gms$c35_protect_scenario <- "BH_IFL"
      cfg$gms$c30_snv_target <- "by2030"
      cfg$gms$s30_snv_shr <- 0.2
      cfg$gms$s56_c_price_induced_aff <- 1
    }
    cfg$title <- paste(prefix,paste0(ssp,"-",pol),sep="_")
    start_run(cfg,codeCheck=FALSE)
  }
}
