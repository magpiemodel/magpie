# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


############################################################
#### Script for the generation of SIM4NEXUS simulations ####
############################################################

library(lucode)
source("scripts/start_functions.R")
source("scripts/performance_test.R")


#set defaults
codeCheck <- FALSE

buildInputVector <- function(regionmapping   = "H12",
                             project_name    = "isimip_rcp",
                             climatescen_name= "rcp2p6",
                             co2             = "co2",
                             climate_model   = "IPSL_CM5A_LR",
                             resolution      = "c200",
                             archive_rev     = "38",
                             madrat_rev      = "4.22",
                             validation_rev  = "4.22",
                             calibration     = "calibration_sim4nexus_may2019.tgz",
                             additional_data = "additional_data_rev3.70.tgz") {
  mappings <- c(H11="8a828c6ed5004e77d1ba2025e8ea2261",
                H12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a",
                agmip="c77f075908c3bc29bdbe1976165eccaf",
                sim4nexus="25dd7264e8e145385b3bd0b89ec5f3fc",
                inms="44f1e181a3da765729f2f1bfc926425a",
                capri="e7e72fddc44cc3d546af7b038c651f51",
                coacch="c2a48c5eae535d4b8fe9c953d9986f1b")
  archive_name=paste(project_name,climate_model,climatescen_name,co2,sep="-")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings[regionmapping], ".tgz")
  madrat  <- paste0("rev", madrat_rev,"_", mappings[regionmapping], "_magpie", ".tgz")
  validation  <- paste0("rev", validation_rev,"_", mappings[regionmapping], "_validation", ".tgz")
  return(c(archive,madrat,validation,calibration,additional_data))
}

### SIM4NEXUS runs ###
#general settings
general_settings<-function(title) {
  source("config/default.cfg")
  cfg$gms$c_timesteps <- "5year"
  cfg$input <- buildInputVector()
  cfg$output <- c(cfg$output,"sustag_report")
  cfg$recalibrate <- FALSE
  cfg<-lucode::setScenario(cfg,"cc")
  cfg$gms$c56_emis_policy <- "all"
  cfg$gms$som <- "cellpool_aug16"
  cfg$gms$c59_som_scenario  <- "cc"
  cfg$gms$forestry  <- "affore_vegc_dec16"
  cfg$gms$maccs  <- "on_sep16"
  cfg$title <- paste0(title,"_lpjml3_IPSLCM5ALR_sim4nexus_v1")
  #  include costs per-ton
  return(cfg)
}


# SSP control runs###############################################

# SSP2
cfg<-general_settings(title="counterfactual_ssp2_nocc_mitnpi")
cfg<-lucode::setScenario(cfg,"SSP2")
cfg<-lucode::setScenario(cfg,"nocc")
cfg$input <- buildInputVector(regionmapping = "coacch",calibration=NULL)
cfg$gms$c59_som_scenario  <- "nocc"
cfg$recalibrate <- TRUE
start_run(cfg=cfg,codeCheck=codeCheck)
calib<-magpie4::submitCalibration(name = "calibration_sim4nexus_may2019")
cfg$recalibrate <- "ifneeded"


#SIM4NEXUS standard runs#############################################
# SSP2 Family
cfg<-general_settings(title="base_ssp2_rcp60_mitnpi")
cfg<-lucode::setScenario(cfg,"SSP2")
cfg<-lucode::setScenario(cfg,"cc")
cfg$input <- buildInputVector(climatescen_name="rcp6p0",regionmapping = "coacch",calibration=calib)
start_run(cfg=cfg,codeCheck=codeCheck)

### Scenario runs

cfg<-general_settings(title="food_ssp2_rcp60_mitnpi")
# Sustainable food production
  # Healthy and sufficient diet: Transformation towards a flexetarian healthy diet (similar to Lancet diet) with reduced meat consumption. Transformation pathway takes place until 2050
  # Waste: max waste of 15%
  # Agricultural efficiency: Crop production	reduced interest risk premium for interest rate, increasing investments in yield-increasing technological change
  # Livestock production	improved animal waste management systems (Bodirsky et al 2014)
  # Fertilizer: 	70%NUE croplands
cfg<-lucode::setScenario(cfg,"SSP2")
cfg<-lucode::setScenario(cfg,"cc")
cfg$input <- buildInputVector(climatescen_name="rcp6p0",regionmapping = "coacch",calibration=calib)
cfg$gms$c15_food_scenario <- "SSP1"
cfg$gms$s15_exo_waste <- 1
cfg$gms$s15_waste_scen <- 1.15
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "healthy_BMI"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$c50_scen_neff <- "neff70_75_starty2010"
cfg$gms$c12_interest_rate <- "low"
cfg$gms$c55_scen_conf <- "SSP1"
start_run(cfg=cfg,codeCheck=codeCheck)

cfg<-general_settings(title="climate_ssp2_rcp26_mit26")
# CC mitigation (2degree scenario): cost-optimal mitigation pathway based on endogenous trade and fertilization patterns, MAC-curves from Lucas et al. (2007) for non-co2 ghg emissions, and endogenous mitigation for CO2 emissions from landuse change and afforestation
  # RCP 2.6
  # CO2 emissions based on CO2 price
  # non-CO2 ghg emissions based on CO2 eq price
  # carbon price according to SSP2 RCP2.6 scenario
  # bioenergy demand from SSP2 RCP 2.6 scenario
  # afforestation/avoided deforestation: all based on CO2 price
  # 65% NUE croplands
cfg<-lucode::setScenario(cfg,"SSP2")
cfg<-lucode::setScenario(cfg,"cc")
cfg$input <- buildInputVector(climatescen_name="rcp2p6",regionmapping = "coacch",calibration=calib)
cfg$gms$c32_aff_policy <- "ndc"
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg1300"
cfg$gms$c60_2ndgen_biodem    <- "R2M41-SSP2-Budg1300"
cfg$gms$c50_scen_neff <- "neff65_70_starty2010"
start_run(cfg=cfg,codeCheck=codeCheck)

cfg<-general_settings(title="water_ssp2_rcp60_mitnpi")
# Irrigation efficiency
  # Irrigation expansion remains endogenous
  # Irrigation efficiency increased
# Water demand:
  # Environmental flow requirements are met
# Water quality:
  # 70% NUE croplands
  # (LATER: max. N concentration)
  # (LATER: improved wastewater treatment for N)
# Fisheries:
  # (LATER: Ocean catches below max sustainable yields)
cfg<-lucode::setScenario(cfg,"SSP2")
cfg<-lucode::setScenario(cfg,"cc")
cfg$input <- buildInputVector(climatescen_name="rcp6p0",regionmapping = "coacch",calibration=calib)
cfg$gms$s42_irrig_eff_scenario <- 1
cfg$gms$s42_irrigation_efficiency <- 0.76
cfg$gms$c42_env_flow_policy <- "on"
cfg$gms$c50_scen_neff <- "neff70_75_starty2010"
start_run(cfg=cfg,codeCheck=codeCheck)

cfg<-general_settings(title="biodiversity_ssp2_rcp60_mitnpi")
# WDPA IUCN categories I + II, protected biodiversity hotspots from Brookes et al (2006)
   # Land protection
    # land productivity increase (lower interest rate)
    # protection of biodiversity hotspots and WDPA
	 # Increased fertilizer efficiency (70% NUE of croplands)
   # Improved animal waste management
	 # (LATER: Improved wastewater treatment)
	 # RCP6.0
cfg<-lucode::setScenario(cfg,"SSP2")
cfg<-lucode::setScenario(cfg,"cc")
cfg$input <- buildInputVector(climatescen_name="rcp6p0",regionmapping = "coacch",calibration=calib)
cfg$gms$c12_interest_rate <- "low"
cfg$gms$c35_protect_scenario <- "BH" # biodiversity hotspots and WDPA
cfg$gms$c50_scen_neff <- "neff70_75_starty2010"
cfg$gms$c55_scen_conf <- "SSP1"
start_run(cfg=cfg,codeCheck=codeCheck)

cfg<-general_settings(title="all_ssp2_rcp26_mit26")
# All scenarios: combination of all scenarios
cfg<-lucode::setScenario(cfg,"SSP2")
cfg<-lucode::setScenario(cfg,"cc")
cfg$input <- buildInputVector(climatescen_name="rcp2p6",regionmapping = "coacch",calibration=calib)
cfg$gms$c32_aff_policy <- "ndc"
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg1300"
cfg$gms$c60_2ndgen_biodem    <- "R2M41-SSP2-Budg1300"
cfg$gms$c42_env_flow_policy <- "on"
cfg$gms$s42_irrig_eff_scenario <- 1
cfg$gms$s42_irrigation_efficiency <- 0.76
cfg$gms$c15_food_scenario <- "SSP1"
cfg$gms$s15_exo_waste <- 1
cfg$gms$s15_waste_scen <- 1.15
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "healthy_BMI"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$c50_scen_neff <- "neff75_80_starty2010"
cfg$gms$c12_interest_rate <- "low"
cfg$gms$c55_scen_conf <- "SSP1"
cfg$gms$c35_protect_scenario <- "BH"
start_run(cfg=cfg,codeCheck=codeCheck)


#SIM4NEXUS regional runs#############################################
# Policies only apply for EU28
EU28 <- "AUT, BEL, BGR, HRV, CYP, CZE, DNK, EST, FIN, FRA, DEU, GRC, HUN, IRL, ITA, LVA, LTU, LUX, MLT, NLD, POL, PRT, ROU, SVK, SVN, ESP, SWE, GBR"

# GHG policy for EU28 only:
#cfg$gms$ghg_policy_countries  <- EU28

# Resource efficiency:
cfg<-general_settings(title="eur_reseff_ssp2_rcp26_mit26")
# In addition to global 2 degree scenario assumptions (climate_ssp2_rcp26_mit26??? or base???),
# resource efficiency policies and technology trends implemented in Europe.
  # increased fertilizer efficiency in Europe (switch for 70% NUE of croplands in EU28)
  # increased crop yields in Europe (switch lower interest rates in EU28, rest: default)

# Diets:
cfg<-general_settings(title="eur_diet_ssp2_rcp26_mit26")
# In addition to global 2 degree scenario assumptions (climate_ssp2_rcp26_mit26??? or base???),
# a shift to sustainable diets takes place in Europe.
  # max food waste of 15%
  # healthy and sufficient (flexitarian) diet in Europe
    # both implemented via "fader switch"!

# Push for renewables:
cfg<-general_settings(title="eur_renewables_ssp2_rcp26_mit26")
# In addition to global 2 degree scenario assumptions (climate_ssp2_rcp26_mit26??? or base???),
# irrigation water withdrawals in Europe are at sustainable level.
  # EFP in Europe (switch for EFRs to be met in EU28)
