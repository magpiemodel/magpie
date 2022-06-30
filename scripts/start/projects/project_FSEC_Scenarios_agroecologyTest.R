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

input <- c(regional    = "rev4.73FSECmodeling_e2bdb6cd_magpie.tgz",
           cellular    = "rev4.73FSECmodeling_e2bdb6cd_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
           validation  = "rev4.73FSECmodeling_e2bdb6cd_validation.tgz",
           additional  = "additional_data_rev4.26.tgz",
           calibration = "calibration_FSEC_29Jun22.tgz")

# General settings:
general_settings <- function(title) {

  source("config/default.cfg")

  cfg$input       <- input
  cfg$title       <- paste0("v9a_", title)
  cfg$recalibrate <- FALSE
  cfg$qos         <- "priority_maxMem"
  cfg$output      <- c(cfg$output #,
                       #"extra/disaggregation_BII", "projects/FSEC_dietaryIndicators",
                       #"projects/FSEC_environmentalPollution_grid"
                      )

  # Climate change impacts activated, SSP2 default settings, NDC activated, endogenous forestry activated
  cfg <- gms::setScenario(cfg, c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"))
  cfg$input['cellular'] <- "rev4.73FSECmodeling_e2bdb6cd_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz"
  cfg$force_download    <- TRUE

  # Nitrogen module with IPCC emissions factors rescaled with efficiency
  cfg$gms$nitrogen                <- "rescaled_jan21"
  # emission policy not including any GHG sources
  cfg$gms$c56_emis_policy         <- "none"
  # ghg price setting (only relevant when activated by c56_emis_policy)
  cfg$gms$c56_pollutant_prices    <- "R21M42-SDP-PkBudg1000"
  # residue on field burning is set to "constant"
  cfg$gms$c18_burn_scen           <- "constant"
  # C price driven afforestation is off by default
  cfg$gms$s56_c_price_induced_aff <- "0"
  # Soil organic carbon dynamics activated
  cfg$gms$som                     <- "cellpool_aug16"
  # Cost module: sticky - dynamic mode
  cfg$gms$factor_costs            <- "sticky_feb18"

  # Regional factor requirement costs (crop and livestock)
  cfg$gms$c38_fac_req             <- "reg"
  cfg$gms$c70_fac_req_regr        <- "reg"

  # Agroecology general settings
  cfg$gms$crop                        <- "penalty_apr22"
  cfg$gms$c30_rotation_scenario       <- "default"
  cfg$gms$c30_rotation_scenario_speed <- "by2050"

  return(cfg)
}

# -----------------------------------------------------------------------------------------------------------------
# Settings of transformation clusters:
### (1) Population and General Health ###
population_transformation <- function(cfg) {
  # Population birth rate and demographic structure of SSP1 scenario:
  cfg$gms$c09_pop_scenario <- "SSP1"          # same as SDP scenario

  return(cfg)
}

### (2) Reduced inequality transformation ###
inequalityANDeducation_transformation <- function(cfg) {
  # GDP following SSP1 path
  cfg$gms$c09_gdp_scenario <- "SSP1"
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
  # Higher PAL due to active transportation
  cfg$gms$c09_pal_scenario           <- "SSP1" ### Note: new scenario needed! (not available yet)
  # Lower non-agricultural water demand
  cfg$gms$s42_watdem_nonagr_scenario <- "1"

  # Reduction of traditional fuels and manure burning
  # (not available yet)

  # More sustainable urbanization path
  cfg$gms$c34_urban_scenario	<- "SSP1"

  # 2nd gen. bioenergy demand following "well-below 1.5" pathway
  cfg$gms$c60_2ndgen_biodem	   <- "R21M42-SDP-PkBudg1000"
  # 2nd gen. bioenergy residues following sustainable development pathway
  cfg$gms$c60_res_2ndgenBE_dem <-	"sdp"

  return(cfg)
}

### (5) Diet health transformation ###
diet_transformation <- function(cfg) {
  # Food transition towards healthy & sustainable diets
  cfg$gms$c15_food_scenario	      <- "SSP1"
  cfg$gms$s15_elastic_demand      <-	"0"
  cfg$gms$c15_rumdairy_scp_scen	  <- "constant"
  #cfg$gms$c15_exo_scen_targetyear <- "y2050" # need to be updated, switch changed
  cfg$gms$s15_exo_diet	          <- "1"
  cfg$gms$c15_kcal_scen	          <- "healthy_BMI"
  cfg$gms$c15_EAT_scen	          <- "FLX"
  # Change in life expectancy
  # (cannot be implemented)

  return(cfg)
}

### (6) Diet meat transformation ###
meat_transformation <- function(cfg) {
  # Food transition towards reduced meat consumption
  cfg$gms$c15_livescen_target <- "lin_zero_20_50"

  return(cfg)
}

### (7) Diet waste transformation ###
waste_transformation <- function(cfg) {
  # Lower food waste
  cfg$gms$s15_exo_waste	          <- "1"
  cfg$gms$s15_waste_scen	        <- "1.2"

  return(cfg)
}

### (NA) Diet inclustion transformation ###
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
  # CH4 price for livestock
  cfg$gms$c56_emis_policy <- "sdp_livestock"

  return(cfg)
}

### (9) Crop efficiency transformation ###
cropefficiency_transformation <- function(cfg) {
  # high NUE
  cfg$gms$c50_scen_neff	<- "neff75_80_starty2010"
  # water use efficiency
  # (not available yet)
  # tau
  # (not available yet)
  # rice emission pricing
  cfg$gms$c56_emis_policy <- "sdp_cropeff"

  return(cfg)
}

### (NA) Nitrogen transformation ###
nitrogen_transformation <- function(cfg) {
  # improved N Fixing
  # (not available yet)
  # yield penalty
  # (not available yet)
  # replace rapeseed and sunflower by soybean in processing
  # (not available yet)

  return(cfg)
}

### (10) Biodiversity transformation ###
biodiversity_transformation <- function(cfg) {
  # BII target
  cfg$gms$s44_bii_lower_bound <- 0.81

  return(cfg)

}

### (11) Diversity on land transformation ###
landsharing_transformation <- function(cfg) {
  # stricter crop rotations and agroforestry (2nd gen be with crop rotation)
  cfg$gms$c30_rotation_scenario       <- "agroecology"

  # increase labor costs based on value-difference between organic and conventional
  # (not available yet)

  return(cfg)
}

### (NA) Supply chain transformation ###
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

### (12) Fair trade transformation ###
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

### (13) Bioeconomy transformation ###
bioeconomy_transformation <- function(cfg) {
  # Timber demand: higher demand for buildings from wood
  cfg$gms$c73_build_demand  <- "50pc"
  # Biomaterial demand increases (therefore no phaseout of 1stgen bioenergy, but rather constant)
  cfg$gms$c60_1stgen_biodem	<- "const2030"

  return(cfg)
}

### (14) Afforestation (REDDaff) transformation ###
REDDaff_transformation <- function(cfg) {
  # Afforestation policy following Nationally determined contributions
  # and limited to tropical regions and 500 Mha because of the albedo effect
  # (see also Fuss et al. 2018)
  cfg$gms$c32_aff_policy   <- "ndc"
  cfg$gms$c32_aff_mask     <- "onlytropical"
  cfg$gms$s32_max_aff_area <-	"500"

  # C price driven afforestation activated
  cfg$gms$s56_c_price_induced_aff <- "1"
  # all carbon pools
  cfg$gms$c56_emis_policy         <- "sdp_redd"

  return(cfg)
}

### (15) Reducing emissions from deforestation (REDD) transformation ###
REDD_transformation <- function(cfg) {

  # all carbon pools
  cfg$gms$c56_emis_policy <- "sdp_redd"

  return(cfg)
}


### (16) Land and water sparing transformation ###
landsparing_transformation <- function(cfg) {
  # land protection following strict protection scenario (half or land's surface)
  cfg$gms$c22_protect_scenario <- "HalfEarth"
  # Water protection through environmental flow protection
  cfg$gms$c42_env_flow_policy	 <- "on"
  cfg$gms$c30_bioen_water	     <- "rainfed"  # (already default anyways)

  return(cfg)
}

### (17) Peatland transformation ###
peatland_transformation <- function(cfg) {
  # peatland protection via pricing
  cfg$gms$c56_emis_policy <- "sdp_peatland"
  # peatland restoration
  cfg$gms$s58_rewetting_switch <- "Inf"

  return(cfg)
}

### (18) Air pollution intervention transformation ###
airPollution_transformation <- function(cfg) {
  # crop residue burning is phasing out rather than at constant levels as in default
  cfg$gms$c18_burn_scen         <- "phaseout"
  # savanna burning
  # (not available yet)
  # deforestation with timber harvest rather than burning
  cfg$gms$c35_forest_damage_end <- 2030

  return(cfg)
}

### (NA) Agricultural employment transformation ###
employment_transformation <- function(cfg) {
  # increase minimum wage (at costs of costs)
  # (not available yet)
  # increase labor productivity + wage (at costs of employment)
  # (not available yet)

  return(cfg)
}

### (19) Soil pricing transformation ###
soil_transformation <- function(cfg) {
  # soil pricing
  cfg$gms$c56_emis_policy <- "sdp_soil"

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

### SSP3 + mitigation (RCP 7.0)
cfg <- general_settings(title = "FSEC_SSP370")
cfg <- gms::setScenario(cfg, c("cc", "rcp7p0", "SSP3", "NDC", "ForestryEndo"))
cfg$input['cellular'] <- "rev4.73FSECmodeling_e2bdb6cd_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz"
start_run(cfg = cfg, codeCheck = codeCheck)

### SSP4 + mitigation (RCP 6.0)
cfg <- general_settings(title = "FSEC_SSP460")
cfg <- gms::setScenario(cfg, c("cc", "rcp6p0", "SSP4", "NDC", "ForestryEndo"))
cfg$input['cellular'] <- "rev4.73FSECmodeling_e2bdb6cd_3c888fa5_cellularmagpie_c200_MRI-ESM2-0-ssp460_lpjml-8e6c5eb1.tgz"
start_run(cfg = cfg, codeCheck = codeCheck)

### SSP5 without mitigation (RCP 8.5)
cfg <- general_settings(title = "FSEC_SSP585")
cfg <- gms::setScenario(cfg, c("cc", "rcp8p5", "SSP5", "NDC", "ForestryEndo"))
cfg$input['cellular'] <- "rev4.73FSECmodeling_e2bdb6cd_09a63995_cellularmagpie_c200_MRI-ESM2-0-ssp585_lpjml-8e6c5eb1.tgz"
start_run(cfg = cfg, codeCheck = codeCheck)


#################################################
##          Total SDP Scenario                 ##
#################################################
cfg <- general_settings(title = "FSEC_SDP")
# Climate scenario: RCP 2.6
cfg <- gms::setScenario(cfg, c("cc", "rcp2p6", "SSP1", "NDC", "ForestryEndo"))
cfg$input['cellular'] <- "rev4.73FSECmodeling_e2bdb6cd_6819938d_cellularmagpie_c200_MRI-ESM2-0-ssp126_lpjml-8e6c5eb1.tgz"
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
### (6) Diet meat transformation ###
cfg <- meat_transformation(cfg = cfg)
### (7) Diet waste transformation ###
cfg <- waste_transformation(cfg = cfg)
### (NA) Diet inclustion transformation ###
#cfg <- dietInclusion_transformation(cfg = cfg)
### (8) Livestock management transformation ###
cfg <- livestock_transformation(cfg = cfg)
### (9) Crop efficiency transformation ###
cfg <- cropefficiency_transformation(cfg = cfg)
### (NA) Nitrogen transformation ###
#cfg <- nitrogen_transformation(cfg = cfg)
### (10) Biodiversity transformation ###
cfg <- biodiversity_transformation(cfg = cfg)
### (11) Diversity on land transformation ###
cfg <- landsharing_transformation(cfg = cfg)
### (NA) Supply chain transformation ###
#cfg <- supplyChain_transformation(cfg = cfg)
### (12) Fair trade transformation ###
cfg <- fairTrade_transformation(cfg = cfg)
### (13) Bioeconomy transformation ###
cfg <- bioeconomy_transformation(cfg = cfg)
### (14) REDDaff transformation ###
cfg <- REDDaff_transformation(cfg = cfg)
### (15) REDD Transformation
cfg <- REDD_transformation(cfg = cfg)
### (16) Land and water sparing transformation ###
cfg <- landsparing_transformation(cfg = cfg)
### (17) Land and water sparing transformation ###
cfg <- peatland_transformation(cfg = cfg)
### (18) Air pollution intervention transformation ###
cfg <- airPollution_transformation(cfg = cfg)
### (NA) Agricultural employment transformation ###
#cfg <- employment_transformation(cfg = cfg)
### (19) Soil pricing transformation ##
cfg <- soil_transformation(cfg = cfg)
### Emission policy must be set separately in full-SDP scenario
# (because it would be overwritten in the different transformations)
cfg$gms$c56_emis_policy <- "sdp_all"
start_run(cfg = cfg, codeCheck = codeCheck)

#################################################
##          Disaggregated runs                 ##
#################################################
### (1) Population and Health ###
cfg <- general_settings(title = "FSEC_population")
cfg <- population_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (2) Reduced inequality and Education Transformation ###
cfg <- general_settings(title = "FSEC_gdp_educ_inequ")
cfg <- inequalityANDeducation_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (3) Improved institutions ###
cfg <- general_settings(title = "FSEC_inst")
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

### (6) Diet meat transformation ###
cfg <- general_settings(title = "FSEC_dietLvst")
cfg <- meat_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (7) Diet waste transformation ###
cfg <- general_settings(title = "FSEC_dietWaste")
cfg <- waste_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (NA) Diet inclustion transformation ###
#cfg <- general_settings(title = "FSEC_dietInclusion")
#cfg <- dietInclusion_transformation(cfg = cfg)
#start_run(cfg = cfg, codeCheck = codeCheck)

### (8) Livestock management transformation ###
cfg <- general_settings(title = "FSEC_livestock")
cfg <- livestock_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (9) Crop efficiency transformation ###
cfg <- general_settings(title = "FSEC_cropeff")
cfg <- cropefficiency_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (NA) Nitrogen transformation ###
#cfg <- general_settings(title = "FSEC_nitrogen")
#cfg <- nitrogen_transformation(cfg = cfg)
#start_run(cfg = cfg, codeCheck = codeCheck)

### (10) Biodiversity transformation ###
cfg <- general_settings(title = "FSEC_biodiv")
cfg <- biodiversity_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (11) Diversity on land transformation ###
cfg <- general_settings(title = "FSEC_landSharing")
cfg <- landsharing_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (NA) Supply chain transformation ###
#cfg <- general_settings(title = "FSEC_supplyChain")
#cfg <- supplyChain_transformation(cfg = cfg)
#start_run(cfg = cfg, codeCheck = codeCheck)

### (12) Fair trade transformation ###
cfg <- general_settings(title = "FSEC_fairTrade")
cfg <- fairTrade_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (13) Bioeconomy transformation ###
cfg <- general_settings(title = "FSEC_bioeconomy")
cfg <- bioeconomy_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (14) Afforestation transformation ###
cfg <- general_settings(title = "FSEC_REDDaff")
cfg <- REDDaff_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (15) REDD Transformation
cfg <- general_settings(title = "FSEC_REDD")
cfg <- REDD_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (16) Land and water sparing transformation ###
cfg <- general_settings(title = "FSEC_landSparing")
cfg <- landsparing_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (17) Peatland transformation ###
cfg <- general_settings(title = "FSEC_peatland")
cfg <- peatland_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (18) Air pollution intervention transformation ###
cfg <- general_settings(title = "FSEC_airpollution")
cfg <- airPollution_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)

### (NA) Agricultural employment transformation ###
#cfg <- general_settings(title = "FSEC_employment")
#cfg <- employment_transformation(cfg = cfg)
#start_run(cfg = cfg, codeCheck = codeCheck)

### (19) Soil pricing transformation ##
cfg <- general_settings(title = "FSEC_soil")
cfg <- soil_transformation(cfg = cfg)
start_run(cfg = cfg, codeCheck = codeCheck)
