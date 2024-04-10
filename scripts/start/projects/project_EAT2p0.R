# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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
               # "extra/highres", # do manually on last magpie run
                "extra/disaggregation",
               # "projects/FSEC_nitrogenPollution", # do manually on last (high-res) magpie run
               # "projects/FSEC_water", # do manually on last (high-res) magpie run
                "agmip_report",
                # add output file: pb_report (magpie (special mif created by getReportPBindicators & remind mif (REMIND_generic_scenName.mif))
                "rds_report")

#######################
# SCENARIO DEFINITION #
#######################
cfg <- setScenario(cfg, c("SSP2", "NPI"))

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
  ### General settings ###
  # For impacts of CC on labor:
  cfg$gms$factor_costs  <- "sticky_labor" # @Alex/Edna/Florian: Should we use this one?
  cfg$gms$labor_prod    <- "exo"
  cfg$gms$c37_labor_rcp <- "rcp585"
  # Note: the effect of labor impacts is very low in MAgPIE and we don't have the
  #       Nelson data implemented. We therefore use the existing data from LAMACLIMA
  #       and the scenarios rcp119 and rcp585.

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
  cfg$gms$c70_feed_scen <- "ssp2"
  # Mitigation: no mitigation beyond NPI (NPI already set in setScenario)
  cfg$gms$c56_emis_policy      <- "redd+natveg_nosoil"   # default
  cfg$path_to_report_ghgprices <- NA
  cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"      # default
  cfg$path_to_report_bioenergy <- NA
  cfg$gms$c60_2ndgen_biodem    <- "R21M42-SSP2-NPi"      # default

  # Climate Change
  cfg$input['cellular'] <- "rev4.99_h12_c6a7458f_cellularmagpie_c200_IPSL-CM6A-LR-ssp370_lpjml-8e6c5eb1.tgz"
  
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
# starting from 2020.
# Please note that with the diet shift, a lower ghg price would be necessary.
# However, to be consistent with the other models and for the decomposition
# scenarios to be "additive", we choose to use the same ghg price for all scenarios
# where miti is active.
# Reference: Humpenöder, F., Popp, A., Merfort, L., Luderer, G., Weindl, I., Bodirsky, B., Stevanović, M., Klein, D., Rodrigues, R., Bauer, N., Dietrich, J., Lotze-Campen, H., & Rockström, J. (2023). Data repository - Dietary shifts increase the feasibility of 1.5°C pathways (Version 1) [Data set]. Zenodo. https://doi.org/10.5281/zenodo.8328217
miti <- function(cfg) {
  # NDCs
  cfg <- setScenario(cfg, c("SSP2", "NDC"))

  # Mitigation: consistent with 1.5C
  cfg$path_to_report_ghgprices <- "/p/projects/magpie/users/florianh/projects/paper/LandEnergy/modelrunsGrassland7/remind/output/C_SSP2EU-PkBudg500-rem-5/REMIND_generic_C_SSP2EU-PkBudg500-rem-5.mif"
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$path_to_report_bioenergy <- "/p/projects/magpie/users/florianh/projects/paper/LandEnergy/modelrunsGrassland7/remind/output/C_SSP2EU-PkBudg500-rem-5/REMIND_generic_C_SSP2EU-PkBudg500-rem-5.mif"
  cfg$gms$c60_2ndgen_biodem    <- "coupling"

  return(cfg)
}

### NoCC component ##
# No climate change impacts
noCC <- function(cfg) {
  # deactivate climate change impacts
  cfg$gms$c59_som_scenario        <- "nocc"
  cfg$gms$c14_yields_scenario     <- "nocc"
  cfg$gms$c31_grassl_yld_scenario <- "nocc" # Note: anyway not active in current default.
  cfg$gms$c42_watdem_scenario     <- "nocc"
  cfg$gms$c43_watavail_scenario   <- "nocc"
  cfg$gms$c52_carbon_scenario     <- "nocc"
  return(cfg)
}

### RCP 2.6 ###
# Decomposition Scenario. Apply lower climate impacts based on RCP 2.6 to BAU using GFDL climate model.
rcp26 <- function(cfg) {
  cfg$input["cellular"] <- "rev4.99_h12_05fd702e_cellularmagpie_c200_GFDL-ESM4-ssp126_lpjml-8e6c5eb1.tgz"
  return(cfg)
}


#################
# SCENARIO RUNS #
#################
# BAU #
# Business as usual scenario based on SSP2
# with a higher climate impact reflected by RCP 7.0
cfg$title <- "BAU"
cfg <- bau(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# BAU_DIET #
# Decomposition scenario. Adds EL2.0 Diet to BAU:
# Globally achieves EL2 diet by 2050              # To Do: Check implemention!
cfg$title <- "BAU_DIET"
cfg <- bau(cfg = cfg)
cfg <- diet(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# BAU_PROD #
# Decomposition scenario adds high productivity to BAU
cfg$title <- "BAU_PROD"
cfg <- bau(cfg = cfg)
cfg <- prod(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# BAU_WAST #
# Decomposition scenario. Adds a reduction (halving) of food loss and waste
cfg$title <- "BAU_WAST"
cfg <- bau(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# BAU_RCP26 #
# Decomposition Scenario. Apply lower climate impacts based on RCP 2.6 to BAU
cfg$title <- "BAU_RCP26"
cfg <- bau(cfg = cfg)
cfg <- rcp26(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# BAU_NoCC #
# Decomposition scenario. Remove climate impacts (NoCC) from BAU to isolate climate effects
cfg$title <- "BAU_NoCC"
cfg <- bau(cfg = cfg)
cfg <- noCC(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# BAU_MITI #
# Decomposition Scenario. Adds mitigation and land-use policies consistent with 1.5C by 2050 to BAU
cfg$title <- "BAU_MITI"
cfg <- bau(cfg = cfg)
cfg <- miti(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# EL2 #
# Full EAT-Lancet Scenario (diet, productivity, FLW) without mitigation and higher climate impacts based on RCP 7.0
cfg$title <- "EL2"
cfg <- bau(cfg = cfg)
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# ELM #
# Full EAT-Lancet scenario (diet, productivity, FLW) with mitigation policies consistent with 1.5C. Climate based on a lower climate impacts with RCP 2.6
cfg$title <- "ELM"
cfg <- bau(cfg = cfg)
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
cfg <- miti(cfg = cfg)
cfg <- rcp26(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# ELM_Diet #
# Decomposition Scenario. Removes Diet from ELM
cfg$title <- "ELM_DIET"
cfg <- bau(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
cfg <- miti(cfg = cfg)
cfg <- rcp26(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# ELM_PROD #
# Decomposition Scenario. Removed productivity trend from ELM
cfg$title <- "ELM_PROD"
cfg <- bau(cfg = cfg)
cfg <- diet(cfg = cfg)
cfg <- waste(cfg = cfg)
cfg <- miti(cfg = cfg)
cfg <- rcp26(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# ELM_WAST #
# Decomposition Scenario. Removes FLW from ELM
cfg$title <- "ELM_WAST"
cfg <- bau(cfg = cfg)
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- miti(cfg = cfg)
cfg <- rcp26(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# ELM_RCP70 #
# Decomposition Scenario. Applies RCP 7.0 climate impacts to ELM
cfg$title <- "ELM_RCP70"
cfg <- bau(cfg = cfg)
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
cfg <- miti(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# ELM_NoCC #
# Decomposition Scenario. Removes climate impacts (NoCC) from ELM
cfg$title <- "ELM_NoCC"
cfg <- bau(cfg = cfg)
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
cfg <- miti(cfg = cfg)
cfg <- noCC(cfg = cfg)
start_run(cfg, codeCheck = FALSE)

# ELM_MITI #
# Decomposition Scenario. Removes climate mitigation and LUC policies from ELM
cfg$title <- "ELM_MITI"
cfg <- bau(cfg = cfg)
cfg <- diet(cfg = cfg)
cfg <- prod(cfg = cfg)
cfg <- waste(cfg = cfg)
cfg <- rcp26(cfg = cfg)
start_run(cfg, codeCheck = FALSE)
