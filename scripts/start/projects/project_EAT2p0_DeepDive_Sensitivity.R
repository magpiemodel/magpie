# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: EAT2p0 sensitivity simulations for Beier et al. 2025
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
cfg$qos <- "standby_highMem_dayMax"
cfg$output <- c(
  "output_check",
  "extra/disaggregation",
  "projects/FSEC_nitrogenPollution",
  "projects/FSEC_water",
  "projects/agmip_report",
  "rds_report",
  "runBlackmagicc"
  # add output file: pb_report (magpie (special mif created by getReportPBindicators & remind mif (REMIND_generic_scenName.mif))
)

# Set path to own coupled runs:
path2MitigationRun <- "/p/projects/magpie/users/beier/EL2_DeepDive_release_v3/remind/output/C_SSP2EU-DSPkB650-DS_betax_DeepDive_noNDC-rem-12/REMIND_generic_C_SSP2EU-DSPkB650-DS_betax_DeepDive_noNDC-rem-12.mif"

#####################################
### Sensitivity Settings and Runs ###
#####################################

for (ssp in c("SSP1", "SSP2", "SSP3", "SSP4", "SSP5")) {

#######################
# SCENARIO DEFINITION #
#######################
cfg <- setScenario(cfg, c("nocc_hist", ssp, "NPI"))
cfg <- setScenario(cfg, c("EL2_default"), scenario_config = "config/projects/scenario_config_el2.csv")

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

  # time steps until 2150
  cfg$gms$c_timesteps <- "less_TS"

  # for feasibility
  cfg$gms$s80_optfile <- 1

  cfg$gms$factor_costs <- "sticky_labor"
  ### Components for Decomposition ###
  # Diets: exogenous EATLancet diet
  cfg$gms$s15_exo_diet <- 0 # default
  cfg$gms$c15_kcal_scen <- "healthy_BMI" # default (but not active b/c of s15_exo_diet = 0)
  cfg$gms$c15_EAT_scen <- "FLX" # default (but not active b/c of s15_exo_diet = 0)
  cfg$gms$c09_pal_scenario <- ssp
  # Waste: half food waste
  cfg$gms$s15_exo_waste <- 0 # default
  cfg$gms$s15_waste_scen <- 1.2 # default (but not active b/c of s15_exo_waste = 0)
  # Default interest rate (for default productivity)
  cfg$gms$s12_interest_lic <- 0.1 # default
  cfg$gms$s12_interest_hic <- 0.04 # default
  # Default livestock productivity
  cfg$gms$c70_feed_scen <- ssp
  # Mitigation: no mitigation beyond NPI
  cfg$gms$c56_emis_policy <- "redd+natveg_nosoil" # default
  cfg$path_to_report_ghgprices <- NA
  cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi" # default
  cfg$path_to_report_bioenergy <- NA
  cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi" # default
  
  # Allow irrigated and rainfed bioenergy production
  cfg$gms$c30_bioen_water <- "all"

  # Setting REMIND scenario for blackmagicc
  cfg$magicc_emis_scen <- "REMIND_generic_C_SSP2EU-DSPkB650-DS_betax_DeepDive_noNDC-rem-12.mif"

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
  cfg$path_to_report_ghgprices <- path2MitigationRun
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$path_to_report_bioenergy <- path2MitigationRun
  cfg$gms$c60_2ndgen_biodem    <- "coupling"
  # ecoSysProtAll:               (Above ground CO2 emis from LUC in forest, forestry, natveg; All types of emis from peatland; All CH4 and N2O emis),
  cfg$gms$c56_emis_policy <- "ecoSysProtAll"

  return(cfg)
}

# Bioenergy demand only. No carbon price on land included.
bioenergy <- function(cfg) {
  # Mitigation: only Bioenergy demand from coupled REMIND-MAgPIE run where 1.5 is reached with ghg prices on land and considering diet shift
  cfg$path_to_report_bioenergy <- path2MitigationRun
  cfg$gms$c60_2ndgen_biodem <- "coupling"

  return(cfg)
}

# CO2 from land use change is priced.
priceCO2 <- function(cfg) {
  # Mitigation: only price land CO2
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$path_to_report_ghgprices <- path2MitigationRun
  cfg$gms$c56_emis_policy <- "ecoSysProtAll_agMgmtOff" #### double-check Florian or Leon

  return(cfg)
}

# Pricing of all CH4 and N2O emissions except for peatland
priceNonCO2 <- function(cfg) {
  # Mitigation: only CH4 and N2O price
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$path_to_report_ghgprices <- path2MitigationRun
  cfg$gms$c56_emis_policy <- "ecoSysProtOff" ### double-check Florian or Leon

  return(cfg)
}


#################
# SCENARIO RUNS #
#################
# BAU #
# Business as usual scenario based on SSP2 (NPis)
cfg$title <- paste0(ssp, "_BAU_NPi")
cfg <- setScenario(cfg, c("nocc_hist", ssp, "NPI"))
cfg <- setScenario(cfg, c("EL2_default"), scenario_config = "config/projects/scenario_config_el2.csv")
cfg <- bau(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# (1a,b,c,d) BAU_MIT #
# All production-side land-based mitigation measures
cfg$title <- paste0(ssp, "_BAU_Miti")
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", ssp, "NPI"))
cfg <- setScenario(cfg, c("EL2_default"), scenario_config = "config/projects/scenario_config_el2.csv")
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation (CO2, non-CO2, bioenergy)
cfg <- miti(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# (1e,f,g) Demand-side options (Diet+Waste) by 2050
cfg$title <- paste0(ssp, "_BAU_Dem")
cfg <- setScenario(cfg, c("nocc_hist", ssp, "NPI"))
cfg <- setScenario(cfg, c("EL2_default"), scenario_config = "config/projects/scenario_config_el2.csv")
cfg <- bau(cfg = cfg)
cfg <- diet(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

### All measures ###
# MITI_All #
# All production-side land-based mitigation measures and demand-side mitigation (diet change)
cfg$title <- paste0(ssp, "_MITI_All")
# standard setting, but with NDC for miti
cfg <- setScenario(cfg, c("nocc_hist", ssp, "NPI"))
cfg <- setScenario(cfg, c("EL2_default"), scenario_config = "config/projects/scenario_config_el2.csv")
# BAU settings
cfg <- bau(cfg = cfg)
# Mitigation (CO2, non-CO2, bioenergy)
cfg <- miti(cfg = cfg)
# PHD (diet, waste)
cfg <- diet(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

}
