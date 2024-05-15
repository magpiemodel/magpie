# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: EAT2p0 project simulations 2024
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode2)
library(magclass)
library(gms)

# Load start function needed to start MAgPIE runs
source("scripts/start_functions.R")
# obtain settings from default config
source("config/default.cfg")

# set title and date
cfg$results_folder <- "output/:title::date:"
cfg$force_download <- TRUE

# Special outputs required for Deep Dive
cfg$qos <- "standby_maxMem_dayMax"
cfg$output <- c(
  "output_check",
  "extra/highres",
  "extra/disaggregation",
  "projects/FSEC_nitrogenPollution",
  "projects/FSEC_water",
  "agmip_report",
  "rds_report",
  "runBlackmagicc"
  # add output file: pb_report (magpie (special mif created by getReportPBindicators & remind mif (REMIND_generic_scenName.mif))

)

#######################
# SCENARIO DEFINITION #
#######################
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NPI", "EL2_default"))
# Note: The climate change impacts setting differs from the global AgMIP model comparision set-up.
#       We do not include climate change impacts in the coupled REMIND-MAgPIE runs for the PB Deep Dive
#       because we focus exclusively on the mitigation aspect without climate change impacts.

### BAU Scenario ###
# SSP: SSP2
# Diet: BAU-SSP2
# Waste: BAU-SSP2
# Crop and Livestock productivity: BAU-SSP2
# Mitigation policies: current policies
# Land-use policies: current policies
# RCP/GCM: 7p0 shocks on crops, livestock, labor
# Trade: BAU
bau <- function(cfg) {
  ### Components for Decomposition ###
  # Diets: exogenous EATLancet diet
  cfg$gms$s15_exo_diet  <- 0 # default
  cfg$gms$c15_kcal_scen <- "healthy_BMI" # default (but not active b/c of s15_exo_diet = 0)
  cfg$gms$c15_EAT_scen  <- "FLX" # default (but not active b/c of s15_exo_diet = 0)
  # Waste: half food waste
  cfg$gms$s15_exo_waste  <- 0 # default
  cfg$gms$s15_waste_scen <- 1.2 # default (but not active b/c of s15_exo_waste = 0)
  # Default interest rate (for default productivity)
  cfg$gms$s12_interest_lic <- 0.1 # default
  cfg$gms$s12_interest_hic <- 0.04 # default
  # Default livestock productivity
  cfg$gms$c70_feed_scen <- "ssp2" # default
  # Mitigation: no mitigation beyond NPi
  cfg$gms$c56_emis_policy      <- "none"
  cfg$path_to_report_ghgprices <- "/p/projects/magpie/users/beier/EL2_DeepDive_new/remind/output/C_SSP2EU-NPi-rem-5/REMIND_generic_C_SSP2EU-NPi-rem-5.mif"
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$path_to_report_bioenergy <- "/p/projects/magpie/users/beier/EL2_DeepDive_new/remind/output/C_SSP2EU-NPi-rem-5/REMIND_generic_C_SSP2EU-NPi-rem-5.mif"
  cfg$gms$c60_2ndgen_biodem    <- "coupling"

  # Setting REMIND scenario for blackmagicc
  cfg$magicc_emis_scen <- "REMIND_generic_C_SSP2EU-DSPkB650-DS_betax-rem-5.mif"

  return(cfg)
}

### Diet component ##
# Globally achieves EL2 diet by 2050
diet <- function(cfg) {
  # Transition towards EL2 food intake recommendations until 2050
  cfg$gms$s15_exo_diet <- 3
  # Physical inactivity levels are reduced to 0 from 2020 to 2050
  cfg$gms$c09_pal_scenario <- "SDP"
  return(cfg)
}

### Productivity component ##
# High productivity growth rate similar to productivity trends
# associated with SSP1 (e.g., PRD 1 in Stehfest et al.)
prod <- function(cfg) {
  # Higher endogenous productivity achieved through lower interest rates
  # representing more trust and therefore easier investments
  cfg$gms$s12_interest_lic <- 0.06
  cfg$gms$s12_interest_hic <- 0.04
  # Livestock productivity follows SSP1
  cfg$gms$c70_feed_scen <- "ssp1"
  return(cfg)
}

### Waste component ##
# Reduction (halving) of food loss and waste
waste <- function(cfg) {
  # Waste: half food waste
  cfg$gms$s15_exo_waste <- 1
  cfg$gms$s15_waste_scen <- 1.2
  return(cfg)
}

### Mitigation component ##
# Adds mitigation and land-use policies consistent with 1.5C by 2050 to BAU
# Note on our implementation:
# We use a GHG pricing pathway based on a peak budget of 500 with overshoot
# starting from 2020 and diet shift.
miti <- function(cfg) {
  # Mitigation: consistent with 1.5C considering Diet change
  cfg$path_to_report_ghgprices <- "/p/projects/magpie/users/beier/EL2_DeepDive_new/remind/output/C_SSP2EU-DSPkB650-DS_betax-rem-5/REMIND_generic_C_SSP2EU-DSPkB650-DS_betax-rem-5.mif"
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$path_to_report_bioenergy <- "/p/projects/magpie/users/beier/EL2_DeepDive_new/remind/output/C_SSP2EU-DSPkB650-DS_betax-rem-5/REMIND_generic_C_SSP2EU-DSPkB650-DS_betax-rem-5.mif"
  cfg$gms$c60_2ndgen_biodem <- "coupling"
  # ecoSysProtAll:               (Above ground CO2 emis from LUC in forest, forestry, natveg; All types of emis from peatland; All CH4 and N2O emis),
  cfg$gms$c56_emis_policy <- "ecoSysProtAll"

  return(cfg)
}

# Bioenergy demand only. No carbon price on land included.
bioenergy <- function(cfg) {
  # Mitigation: only Bioenergy demand from coupled REMIND-MAgPIE run where 1.5 is reached with ghg prices on land and considering diet shift
  cfg$path_to_report_bioenergy <- "/p/projects/magpie/users/beier/EL2_DeepDive_new/remind/output/C_SSP2EU-DSPkB650-DS_betax-rem-5/REMIND_generic_C_SSP2EU-DSPkB650-DS_betax-rem-5.mif"
  cfg$gms$c60_2ndgen_biodem <- "coupling"

  return(cfg)
}

# CO2 from land use change is priced.
priceCO2 <- function(cfg) {
  # Mitigation: only price land CO2
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$path_to_report_ghgprices <- "/p/projects/magpie/users/beier/EL2_DeepDive_new/remind/output/C_SSP2EU-DSPkB650-DS_betax-rem-5/REMIND_generic_C_SSP2EU-DSPkB650-DS_betax-rem-5.mif"
  cfg$gms$c56_emis_policy <- "ecoSysProtAll_agMgmtOff" #### double-check Florian

  return(cfg)
}

# Pricing of all CH4 and N2O emissions except for peatland
priceNonCO2 <- function(cfg) {
  # Mitigation: only CH4 and N2O price
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$path_to_report_ghgprices <- "/p/projects/magpie/users/beier/EL2_DeepDive_new/remind/output/C_SSP2EU-DSPkB650-DS_betax-rem-5/REMIND_generic_C_SSP2EU-DSPkB650-DS_betax-rem-5.mif"
  cfg$gms$c56_emis_policy <- "ecoSysProtOff" ### double-check Florian

  return(cfg)
}


#################
# SCENARIO RUNS #
#################
# BAU #
# Business as usual scenario based on SSP2 (NPis)
cfg$title <- "BAU_NPi"
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NPI", "EL2_default"))
cfg <- bau(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

### Composition ###
# Mitigation components:
# (1a) Nationally Determined Contributions (NDCs)
cfg$title <- "BAU_NDC"
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
cfg <- bau(cfg = cfg)
# set path to bioenergy and prices to NDC run
cfg$path_to_report_ghgprices <- "/p/projects/magpie/users/beier/EL2_DeepDive_new/remind/output/C_SSP2EU-NDC-rem-5/REMIND_generic_C_SSP2EU-NDC-rem-5.mif"
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$path_to_report_bioenergy <- "/p/projects/magpie/users/beier/EL2_DeepDive_new/remind/output/C_SSP2EU-NDC-rem-5/REMIND_generic_C_SSP2EU-NDC-rem-5.mif"
cfg$gms$c60_2ndgen_biodem <- "coupling"
start_run(cfg, codeCheck = FALSE)

# (1b) BAU + Bioenergy #
# Decomposition Scenario. Adds bioenergy demand from coupled run with land-use policies consistent with 1.5C by 2050 to BAU
cfg$title <- "BAU_Bioenergy"
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NPI", "EL2_default"))
cfg <- bau(cfg = cfg)
cfg <- bioenergy(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# (1c) BAU + NonCO2 pricing in land sector #
# Decomposition Scenario. Adds non-CO2 pricing with ghg price from coupled run with land-use policies consistent with 1.5C by 2050 to BAU
cfg$title <- "BAU_NonCO2"
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NPI", "EL2_default"))
cfg <- bau(cfg = cfg)
cfg <- priceNonCO2(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# (1d) BAU + pricing of CO2 in land sector #
# Decomposition Scenario. Adds CO2 pricing on land-use change emissions with ghg price from coupled run with land-use policies consistent with 1.5C by 2050 to BAU
cfg$title <- "BAU_CO2"
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NPI", "EL2_default"))
cfg <- bau(cfg = cfg)
cfg <- priceCO2(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# (1a,b,c,d) BAU_MIT #
# All production-side land-based mitigation measures
cfg$title <- "BAU_Miti"
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation (CO2, non-CO2, bioenergy)
cfg <- miti(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# BAU + EL2-Diet #
# PHD components:
# (1e) Productivity 
cfg$title <- "BAU_Prod"
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NPI", "EL2_default"))
cfg <- bau(cfg = cfg)
cfg <- prod(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# (1f) Waste
cfg$title <- "BAU_Waste"
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NPI", "EL2_default"))
cfg <- bau(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# (1g) Diet change
cfg$title <- "BAU_Diet"
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NPI", "EL2_default"))
cfg <- bau(cfg = cfg)
cfg <- diet(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# (1e,f,g) All Globally achieves EL2 (Diet+Waste+Prod) by 2050
cfg$title <- "BAU_PHD"
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NPI", "EL2_default"))
cfg <- bau(cfg = cfg)
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)


### Single measure Decomposition ###
# (2a) MITI_NDC #
# All production-side land-based mitigation measures and demand-side mitigation (diet change), but no NDCs
cfg$title <- "MITI_NDC"
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NPI", "EL2_default"))
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation (CO2, non-CO2, bioenergy)
cfg <- miti(cfg = cfg)
# PHD (diet, prod, waste)
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# MITI_Bioenergy (mitigation - bioenergy) #
# (2b) CO2 and non-CO2 pricing and demand-side mitigation (diet change), but no bioenergy demand from REMIND
cfg$title <- "MITI_Bioenergy"
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation
cfg <- miti(cfg = cfg)
cfg$gms$c60_2ndgen_biodem <- "coupling"
cfg$path_to_report_bioenergy <- "/p/projects/magpie/users/beier/EL2_DeepDive_new/remind/output/C_SSP2EU-NPi-rem-5/REMIND_generic_C_SSP2EU-NPi-rem-5.mif"
# PHD
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# MITI_nonCO2 (mitigation - non-CO2) #
# (2c) CO2 pricing and bioenergy demand from REMIND and demand-side mitigation (diet change), but no non-CO2 pricing in land-system
cfg$title <- "MITI_nonCO2"
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation
cfg <- miti(cfg = cfg)
# ecoSysProtAll_agMgmtOff:     (Above ground CO2 emis from LUC in forest, forestry, natveg; All types of emis from peatland; No further CH4/N2O/other emis related to ag. management)
cfg$gms$c56_emis_policy <- "ecoSysProtAll_agMgmtOff"
# PHD
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# MITI_CO2 (mitigation - CO2) #
# (2d) non-CO2 pricing and bioenergy demand from REMIND and demand-side mitigation (diet change), but no CO2 pricing in land-system
cfg$title <- "MITI_CO2"
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation
cfg <- miti(cfg = cfg)
# ecoSysProtOff:               (All CH4 and N2O emis except peatland),
cfg$gms$c56_emis_policy <- "ecoSysProtOff"
# PHD
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# MITI_MITI #
# (2a,b,c,d) All demand-side mitigation (PHD, but no other miti measures)
cfg$title <- "MITI_Miti"
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NPI", "EL2_default"))
# BAU settings
cfg <- bau(cfg = cfg)
# PHD (diet, prod, waste)
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)


# MITI_Prod #
# (2e) All production-side land-based mitigation measures and demand-side mitigation without Prod
cfg$title <- "MITI_Prod"
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation (CO2, non-CO2, bioenergy)
cfg <- miti(cfg = cfg)
# PHD (diet, prod, waste)
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# MITI_Waste #
# (2f) All production-side land-based mitigation measures and demand-side mitigation without Waste
cfg$title <- "MITI_Waste"
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation (CO2, non-CO2, bioenergy)
cfg <- miti(cfg = cfg)
# PHD (diet, prod, waste)
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# MITI_Diet #
# (2g) All production-side land-based mitigation measures and demand-side mitigation without Diet
cfg$title <- "MITI_Diet"
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation (CO2, non-CO2, bioenergy)
cfg <- miti(cfg = cfg)
# PHD (diet, prod, waste)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# MITI_PHD (mitigation - PHD) #
# (2e,f,g) All production-side land-based mitigation measures, but no demand-side mitigation (PHD)
cfg$title <- "MITI_PHD"
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation
cfg <- miti(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

### Stacked Decomposition ###
# (3a) Stacked 0: BAU_NPi (see above)

# (3b) Stacked 1: BAU_NDC (see above)

# (3c) Stacked 2: BAU_NDC_Bioenergy
cfg$title <- "Stacked2"
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation (bioenergy)
cfg <- bioenergy(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# (3d) Stacked 3: BAU_NDC_Bioenergy_nCO2
cfg$title <- "Stacked3"
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation (non-CO2, bioenergy)
cfg <- bioenergy(cfg = cfg)
cfg <- priceNonCO2(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# (3e) Stacked 4: BAU_NDC_Bioenergy_nCO2_CO2
cfg$title <- "Stacked4"
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation (CO2, non-CO2, bioenergy)
cfg <- miti(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# (3f) Stacked 5: BAU_NDC_Bioenergy_nCO2_CO2_prod
cfg$title <- "Stacked5"
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation (CO2, non-CO2, bioenergy)
cfg <- miti(cfg = cfg)
# PHD (diet, prod, waste)
cfg <- prod(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# (3g) Stacked 6: BAU_NDC_Bioenergy_nCO2_CO2_prod_waste
cfg$title <- "Stacked6"
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation (CO2, non-CO2, bioenergy)
cfg <- miti(cfg = cfg)
# PHD (diet, prod, waste)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# (3h) Stacked 7: BAU_NDC_Bioenergy_nCO2_CO2_prod_waste_diet (same as MITI_All, see below)

### All measures ###
# MITI_All #
# All production-side land-based mitigation measures and demand-side mitigation (diet change)
cfg$title <- "MITI_All"
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation (CO2, non-CO2, bioenergy)
cfg <- miti(cfg = cfg)
# PHD (diet, prod, waste)
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)
