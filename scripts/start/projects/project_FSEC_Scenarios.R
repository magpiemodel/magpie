# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Scenarios for FSEC
# ----------------------------------------------------------

library(gms)
source("scripts/start_functions.R")
source("config/default.cfg")

# Set defaults
codeCheck <- FALSE

input <- c(regional    = "rev4.67FSECmodeling_e2bdb6cd_magpie.tgz",
           cellular    = "rev4.67FSECmodeling_e2bdb6cd_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
           validation  = "rev4.67FSECmodeling_e2bdb6cd_validation.tgz",
           additional  = "additional_data_rev4.08.tgz",
           calibration = "calibration_FSEC_20Mar22.tgz")

# -----------------------------------------------------------------------------------------------------------------
# General settings:
general_settings <- function(title) {
  source("config/default.cfg")
  cfg$input       <- input
  cfg$title       <- paste0("v1_", title)
  cfg$recalibrate <- FALSE
  cfg$qos         <- "priority_maxMem"
  cfg$output      <- c(cfg$output,
                  "extra/disaggregation_BII", "projects/FSEC_dietaryIndicators",
                  "projects/FSEC_environmentalPollution_grid")

  # Climate change impacts activated, SSP2 default settings, NDC activated, endogenous forestry activated
  cfg <- gms::setScenario(cfg, c("cc", "SSP2", "NDC", "ForestryEndo"))

  # Nitrogen module with IPCC emissions factors rescaled with efficiency
  cfg$gms$nitrogen            <- "rescaled_jan21"
  # emission policy not including any GHG sources
  cfg$gms$c56_emis_policy     <-	"none"
  # no peatland GHG emission pricing
  cfg$gms$s56_peatland_policy <- "0"
  # residue on field burning is set to "constant"
  cfg$gms$c18_burn_scen       <- "constant"

  return(cfg)
}

# -----------------------------------------------------------------------------------------------------------------
# Settings of transformation clusters:
### (1) Population and Health ###
population_transformation <- function(cfg) {
  # Population birth rate and demographic structure of SSP1 scenario:
  cfg$gms$c09_pop_scenario <- "SSP1"          # same as SDP scenario

  return(cfg)
}

### (2) Reduced inequality transformation ###
inequalityANDeducation_transformation <- function(cfg) {
  # Changed GDP path (Managing the global commons)
  cfg$gms$c09_gdp_scenario <- "SDP_MC"
  # Only cap top incomes
  # (not available yet)

  return(cfg)
}

### (3) Improved institutions ###
institution_transformation <- function(cfg) {
  # Improved institutions: lower interest rates
  # Interest rates are still regionally specific (dependent on GDP), but
  # set to lower levels for low income countries
  cfg$gms$s12_interest_lic <- "0.06" # def: "0.1"
  cfg$gms$s12_interest_hic <- "0.04" # def: "0.04"

  return(cfg)
}

### (4) Energy and transport transformation ###
energy_transformation <- function(cfg) {
  # Air pollution reduction and other health risks
  # (cannot be covered)
  #Higher PAL due to active transportation
  # Lower non-agricultural water demand
  cfg$gms$s42_watdem_nonagr_scenario <- "1"

  # Reduction of traditional fuels and manure burning
  # (not available yet)

  # More sustainable urbanization path
  cfg$gms$c34_urban_scenario	<- "SSP1"

  return(cfg)
}

### (5) Diet health transformation ###
diet_transformation <- function(cfg) {
  # Food transition towards healthy & sustainable diets
  cfg$gms$c15_food_scenario	      <- "SSP1"
  cfg$gms$s15_elastic_demand      <-	"0"
  cfg$gms$c15_rumdairy_scp_scen	  <- "constant"
  cfg$gms$c15_exo_scen_targetyear <- "y2050"
  cfg$gms$s15_exo_diet	          <- "1"
  cfg$gms$c15_kcal_scen	          <- "healthy_BMI"
  cfg$gms$c15_EAT_scen	          <- "FLX"
  # Income transfer to enable diets
  # (not available yet)
  # Change in life expectancy
  # (cannot be implemented)

  return(cfg)
}

### (6) Diet waste transformation ###
waste_transformation <- function(cfg) {
  # Lower food waste
  cfg$gms$s15_exo_waste	          <- "1"
  cfg$gms$s15_waste_scen	        <- "1.2"

  return(cfg)
}

### (7) Diet inclustion transformation ###
dietInclusion_transformation <- function(cfg) {
  # Breastfeeding
  # (cannot be implemented)
  # Care work
  # (cannot be implemented)
  # Shifting to female consumption
  # (cannot be implemented)
  # Reducing intake inequality
  # (cannot be implemented)

  return(cfg)
}

### (8) Livestock management transformation ###
livestock_transformation <- function(cfg) {
  # Higher manure recycling rates
  cfg$gms$c55_scen_conf <- "SSP1"
  # Higher feed efficiency (capped scenario)
  cfg$gms$c70_feed_scen <- "ssp1"
  # Animal welfare
  # (cannot be implemented)

  ### Crop efficiency transformation ###
  # high NUE
  cfg$gms$c50_scen_neff	<- "neff75_80_starty2010"
  # water use efficiency
  # (not available yet)
  # tau
  # (not available yet)

  return(cfg)
}

### (9) Diversity on land transformation ###
biodiversity_transformation <- function(cfg) {
  #BII by price OR land sparing
  cfg$gms$c44_price_bv_loss <- "p1_p10"
  # set-aside land
  cfg$gms$s30_set_aside_shr	<- "0.2"
  #gms$c30_set_aside_target	none
  #@BENNI (or ask Patrick): need to set set_aside_target also?
  # strict crop rotations
  # (not available yet)
  # agroforestry (2nd gen be with crop rotation)
  # (not available yet)
  # livestock distribution
  # (cannot be implemented)
  # cover crops
  # (cannot be implemented)
  # increase labor costs based on value-difference between organic and conventional
  # (not available yet)

  return(cfg)
}

### (10) Supply chain transformation ###
supplyChain_transformation <- function(cfg) {
  # reduce value-added in processing
  # (cannot be implemented)
  # switch to wholegrain
  # (not available yet)
  # reduce sugar-sweetened beverages
  # (cannot be implemented)
  # reduce alcohol
  # (not available yet)
  # reduce salt
  # (not available yet)
  # ban of trans-fatty acids
  # (not available yet)
  # reduce food losses
  # (not available yet)
  # fortification
  # (cannot be implemented)

  return(cfg)
}

### (11) Fair trade transformation ###
fairTrade_transformation <- function(cfg) {
  #reduce subsidies
  # (cannot be implemented)
  #reduce historical trade patterns
  # (not available yet)
  #increase transportation costs
  # (not available yet)
  # Increased trade openness
  cfg$gms$c21_trade_liberalization <-	"l908080r807070"

  return(cfg)
}

### (12) Bioeconomy transformation ###
bioeconomy_transformation <- function(cfg) {
  # Timber demand: higher demand for buildings from wood
  cfg$gms$c73_build_demand  <- "50pc"
  # Biomaterial demand increases (therefore no phaseout of 1stgen bioenergy, but rather constant)
  cfg$gms$c60_1stgen_biodem	<- "const2030"

  return(cfg)
}

### (13) Carbon management transformation ###
carbon_transformation <- function(cfg) {
  # 2nd gen. bioenergy demand following "well-below 1.5" pathway
  cfg$gms$c60_2ndgen_biodem	   <- "R21M42-SDP-PkBudg1000"
  # 2nd gen. bioenergy residues following sustainable development pathway
  cfg$gms$c60_res_2ndgenBE_dem <-	"sdp"

  # Afforestation policy following Nationally determined contributions
  # and limited to tropical regions and 500 Mha because of the albedo effect
  # (see also Fuss et al. 2018)
  cfg$gms$c32_aff_policy   <- "ndc"
  cfg$gms$c32_aff_mask     <- "onlytropical"
  cfg$gms$s32_max_aff_area <-	"500"

  return(cfg)
}

### (14) Land and water sparing transformation ###
protectLandWater_transformation <- function(cfg) {
  # land protection following strict protection scenario (half or land's surface)
  cfg$gms$c35_protect_scenario <-	"HalfEarth"
  # Water protection through environmental flow protection
  cfg$gms$c42_env_flow_policy	 <- "on"
  cfg$gms$c30_bioen_water	     <- "rainfed"  # (already default anyways)
  # MACC curve including Above ground CO2 emis from all LUC; all CH4 emissions and animal-sourced N2O
  cfg$gms$c56_emis_policy <- "maccs_excl_cropland_n2o"

  return(cfg)
}

### (15) Land and water sparing transformation ###
peatland_transformation <- function(cfg) {
  # peatland protection
  cfg$gms$s56_peatland_policy	 <- "1"
  cfg$gms$s58_rewetting_switch <- "Inf" # discuss with Florian

  return(cfg)
}

### (16) Air pollution intervention transformation ###
airPollution_transformation <- function(cfg) {
  # crop residue burning is phasing out rather than at constant levels as in default
  cfg$gms$c18_burn_scen         <- "phaseout"
  # savanna burning
  # (not available yet)
  # deforestation with timber harvest rather than burning
  cfg$gms$c35_forest_damage_end <- "by2030"

  return(cfg)
}

### (17) Agricultural employment transformation ###
employment_transformation <- function(cfg) {
  # increase minimum wage (at costs of costs)
  # (not available yet)
  # increase labor productivity + wage (at costs of employment)
  # (not available yet)

  return(cfg)
}


# -----------------------------------------------------------------------------------------------------------------
# Scenario runs

#################################################
##         Business-as-usual Scenario          ##
#################################################
### Business-as-usual
cfg <- general_settings(title = "FSEC_BAU")
start_run(cfg = cfg, codeCheck = codeCheck)

#################################################
##          Total SDP Scenario                 ##
#################################################
cfg <- general_settings(title = "FSEC_SDP")
### (1) Population and Health ###
cfg <- population_transformation(cfg = cfg)
### (2) Reduced inequality and Education Transformation ###
cfg <- inequalityANDeducation_transformation(cfg = cfg)
### (3) Improved institutions ###
cfg <- institution_transformation(cfg = cfg)
### (4) Energy and transfport transformation ###
cfg <- energy_transformation(cfg = cfg)
### (5) Diet health transformation ###
cfg <- diet_transformation(cfg = cfg)
### (6) Diet waste transformation ###
cfg <- waste_transformation(cfg = cfg)
### (7) Diet inclustion transformation ###
cfg <- dietInclusion_transformation(cfg = cfg)
### (8) Livestock management transformation ###
cfg <- livestock_transformation(cfg = cfg)
### (9) Diversity on land transformation ###
cfg <- biodiversity_transformation(cfg = cfg)
### (10) Supply chain transformation ###
cfg <- supplyChain_transformation(cfg = cfg)
### (11) Fair trade transformation ###
cfg <- fairTrade_transformation(cfg = cfg)
### (12) Bioeconomy transformation ###
cfg <- bioeconomy_transformation(cfg = cfg)
### (13) Carbon management transformation ###
cfg <- carbon_transformation(cfg = cfg)
### (14) Land and water sparing transformation ###
cfg <- protectLandWater_transformation(cfg = cfg)
### (15) Land and water sparing transformation ###
cfg <- peatland_transformation(cfg = cfg)
### (16) Air pollution intervention transformation ###
cfg <- airPollution_transformation(cfg = cfg)
### (17) Agricultural employment transformation ###
cfg <- employment_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

#################################################
##          Disaggregated runs                 ##
#################################################
### (1) Population and Health ###
cfg <- general_settings(title = "FSEC_population")
cfg <- population_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (2) Reduced inequality and Education Transformation ###
cfg <- general_settings(title = "FSEC_educationANDinequality")
cfg <- inequalityANDeducation_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (3) Improved institutions ###
cfg <- general_settings(title = "FSEC_institutions")
cfg <- institution_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (4) Energy and transfport transformation ###
cfg <- general_settings(title = "FSEC_energy")
cfg <- energy_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (5) Diet health transformation ###
cfg <- general_settings(title = "FSEC_dietHealth")
cfg <- diet_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (6) Diet waste transformation ###
cfg <- general_settings(title = "FSEC_dietWaste")
cfg <- waste_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (7) Diet inclustion transformation ###
cfg <- general_settings(title = "FSEC_dietInclusion")
cfg <- dietInclusion_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (8) Livestock management transformation ###
cfg <- general_settings(title = "FSEC_livestock")
cfg <- livestock_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (9) Diversity on land transformation ###
cfg <- general_settings(title = "FSEC_biodiversity")
cfg <- biodiversity_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (10) Supply chain transformation ###
cfg <- general_settings(title = "FSEC_supplyChain")
cfg <- supplyChain_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (11) Fair trade transformation ###
cfg <- general_settings(title = "FSEC_fairTrade")
cfg <- fairTrade_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (12) Bioeconomy transformation ###
cfg <- general_settings(title = "FSEC_bioeconomy")
cfg <- bioeconomy_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (13) Carbon management transformation ###
cfg <- general_settings(title = "FSEC_carbon")
cfg <- carbon_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (14) Land and water sparing transformation ###
cfg <- general_settings(title = "FSEC_landANDwater")
cfg <- protectLandWater_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (15) Peatland transformation ###
cfg <- general_settings(title = "FSEC_peatland")
cfg <- peatland_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (16) Air pollution intervention transformation ###
cfg <- general_settings(title = "FSEC_airpollution")
cfg <- airPollution_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (17) Agricultural employment transformation ###
cfg <- general_settings(title = "FSEC_employment")
cfg <- employment_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)
