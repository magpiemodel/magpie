# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: EAT2p0 project simulations 2023
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
cfg$output <- c("output_check",
                "extra/highres",
                "extra/disaggregation",
                "projects/FSEC_nitrogenPollution",
                "projects/FSEC_water",
                "agmip_report",
                "runBlackmagicc",
                # add output file: pb_report (magpie (special mif created by getReportPBindicators & remind mif (REMIND_generic_scenName.mif))
                "rds_report")

#######################
# SCENARIO DEFINITION #
#######################
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
# Note: The climate change impacts setting differs from the global AgMIP model comparision set-up.
#       We do not include climate change impacts in the coupled REMIND-MAgPIE runs for the PB Deep Dive.

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
  cfg$gms$s15_exo_diet  <- 0             # default
  cfg$gms$c15_kcal_scen <- "healthy_BMI" # default (but not active b/c of s15_exo_diet = 0)
  cfg$gms$c15_EAT_scen  <- "FLX"         # default (but not active b/c of s15_exo_diet = 0)
  # Waste: half food waste
  cfg$gms$s15_exo_waste  <- 0            # default
  cfg$gms$s15_waste_scen <- 1.2          # default (but not active b/c of s15_exo_waste = 0)
  # Default interest rate (for default productivity)
  cfg$gms$s12_interest_lic <- 0.1        # default
  cfg$gms$s12_interest_hic <- 0.04       # default
  # Default livestock productivity
  cfg$gms$c70_feed_scen <- "ssp2"        # default
  # Mitigation: no mitigation beyond NDC (NDC set in setScenario)
  cfg$gms$c56_emis_policy      <- "none" 
  cfg$path_to_report_ghgprices <- "/p/projects/magpie/users/beier/EL2_DeepDive/remind/output/C_SSP2EU-DSPkB500-noDS-rem-5/REMIND_generic_C_SSP2EU-DSPkB500-noDS-rem-5.mif"
  cfg$gms$c56_pollutant_prices <- "none"
  cfg$path_to_report_bioenergy <- "/p/projects/magpie/users/beier/EL2_DeepDive/remind/output/C_SSP2EU-DSPkB500-noDS-rem-5/REMIND_generic_C_SSP2EU-DSPkB500-noDS-rem-5.mif"
  cfg$gms$c60_2ndgen_biodem    <- "none"

  ### Deactivate certain sustainability standard settings
  # bioenergy plantations can be irrigated
  cfg$gms$c30_bioen_water <- "all"
  # forest plantations allowed for afforestation under ghg price
  cfg$gms$s32_aff_plantation <- 1

  # Setting REMIND scenario for blackmagicc
  cfg$magicc_emis_scen <- "SSP2EU-DSPkB500-DS"
  
  return(cfg)
}

### Diet component ##
# Globally achieves EL2 diet by 2050
diet <- function(cfg) {
  cfg$gms$s15_exo_diet  <- 3
  
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
  cfg$gms$s15_exo_waste  <- 1
  cfg$gms$s15_waste_scen <- 1.2
  return(cfg)
}

### Mitigation component ##
# Adds mitigation and land-use policies consistent with 1.5C by 2050 to BAU
# Note on our implementation:
# We use a GHG pricing pathway based on a peak budget of 500 with overshoot
# starting from 2020 and diet shift.
miti <- function(cfg) {
  # NDCs
  cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC"))

  # Mitigation: consistent with 1.5C considering Diet change
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$gms$c60_2ndgen_biodem    <- "coupling"
  cfg$gms$c56_emis_policy      <- "ecoSysProtAll" 

  return(cfg)
}

# Bioenergy demand only. No carbon price on land included.
bioenergy <- function(cfg) {
  # NDCs
  cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC"))

  # No ghg pricing in land system
  # Bioenergy demand from coupled REMIND-MAgPIE run where 1.5 is reached with ghg prices on land and considering diet shift
  cfg$gms$c60_2ndgen_biodem    <- "coupling"

  return(cfg)
}

# CO2 from land use change is priced.
priceCO2 <- function(cfg) {
  # NDCs
  cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC"))

  # Mitigation: consistent with 1.5C considering Diet change
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$gms$c56_emis_policy      <- "ecoSysProtAll" 

  return(cfg)
}

# Pricing of all CH4 and N2O emissions except for peatland
priceNonCO2 <- function(cfg) {
  # NDCs
  cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC"))

  # Mitigation: consistent with 1.5C considering Diet change
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$gms$c56_emis_policy      <- "ecoSysProtAll_agMgmtOff" 

  return(cfg)
}


#################
# SCENARIO RUNS #
#################
# BAU #
# Business as usual scenario based on SSP2
# with a higher climate impact reflected by RCP 7.0
cfg$title <- "BAU"
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
cfg <- bau(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# MITI_DIET #
# Decomposition scenario.
# Globally achieves EL2 (Diet+Waste+Prod) by 2050
cfg$title <- "MITI_Diet"
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
cfg <- bau(cfg = cfg)
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# MITI_Bioenergy #
# Decomposition Scenario. Adds bioenergy demand from coupled run with land-use policies consistent with 1.5C by 2050 to BAU
cfg$title <- "MITI_Bioenergy"
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
cfg <- bau(cfg = cfg)
cfg <- bioenergy(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# MITI_CO2 #
# Decomposition Scenario. Adds CO2 pricing on land-use change emissions with ghg price from coupled run with land-use policies consistent with 1.5C by 2050 to BAU
cfg$title <- "MITI_CO2"
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
cfg <- bau(cfg = cfg)
cfg <- priceCO2(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# MITI_NonCO2 #
# Decomposition Scenario. Adds non-CO2 pricing with ghg price from coupled run with land-use policies consistent with 1.5C by 2050 to BAU
cfg$title <- "MITI_NonCO2"
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
cfg <- bau(cfg = cfg)
cfg <- priceNonCO2(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# MITI_Prod #
# All production-side land-based mitigation measures
cfg$title <- "MITI_Prod"
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
cfg <- bau(cfg = cfg)
cfg <- miti(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# MITI_Full #
# All production-side land-based mitigation measures and demand-side mitigation (diet change)
cfg$title <- "MITI_Full"
cfg <- setScenario(cfg, c("nocc_hist", "SSP2", "NDC", "EL2_default"))
cfg <- bau(cfg = cfg)
# Mititgation
cfg <- miti(cfg = cfg)
# PHD
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)
