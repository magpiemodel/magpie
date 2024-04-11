# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: INMS simulations (nitrogen)
# ----------------------------------------------------------

library(gms)
source("scripts/start_functions.R")
source("scripts/performance_test.R")
source("config/default.cfg")

### Set defaults
codeCheck <- FALSE

buildInputVector <- function(regionmapping   = "agmip",
                             project_name    = "isimip_rcp",
                             climatescen_name= "rcp2p6",
                             co2             = "co2",
                             climate_model   = "IPSL_CM5A_LR",
                             resolution      = "c200",
                             archive_rev     = "52",
                             madrat_rev      = "4.57bb4",
                             validation_rev  = "4.57bb4",
                             calibration     =  "calibration_INMS_v6_16Feb21.tgz",
                             additional_data = "additional_data_rev3.95.tgz") {
  mappings <- c(h11="8a828c6ed5004e77d1ba2025e8ea2261",
                h12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a",
                inms="1ffb3a6fd3ac74779d7fb03a215fbec6",
                inms2="ef2ae7cd6110d5d142a9f8bd7d5a68f2",
                agmip="c77f075908c3bc29bdbe1976165eccaf")
  archive_name=paste(project_name,climate_model,climatescen_name,co2,sep="-")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings[regionmapping], ".tgz")
  madrat  <- paste0("rev", madrat_rev,"_", mappings[regionmapping], "_magpie.tgz")
  validation  <- paste0("rev",validation_rev,"_", mappings[regionmapping], "_validation", ".tgz")
  return(c(archive,madrat,validation,calibration,additional_data))
}



### General settings ###
general_settings<-function(title) {
  source("config/default.cfg")
  cfg<-setScenario(cfg,"cc")
  cfg$force_download <- TRUE
  cfg$gms$c_timesteps <- 12
  cfg$gms$som <- "cellpool_aug16"
  cfg$gms$factor_costs <- "sticky_feb18"
  cfg$gms$s15_elastic_demand <- 0
  cfg$gms$nitrogen <- "rescaled_jan21"
  cfg$gms$som <- "static_jan19"
  cfg$title <- paste0(title,"_v10")
  cfg$gms$maccs  <- "on_sep16"
  cfg$gms$c56_emis_policy <- "maccs_excl_cropland_n2o"
  #cfg$calib_cropland <- FALSE
  cfg$recalibrate <- FALSE
  return(cfg)
}

###############################################################################
########## Calibration run  ##########
cfg<-general_settings(title="SSP2_RCP4p5_Calib")
cfg<-setScenario(cfg,"SSP2")
cfg<-setScenario(cfg,"cc")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5",regionmapping="inms",calibration="calibration_inms_c200_08Jul2020.tgz")
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
cfg$gms$c60_2ndgen_biodem    <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
cfg$force_download <- TRUE
cfg$recalibrate <- FALSE
start_run(cfg=cfg,codeCheck=codeCheck)
calib<-magpie4::submitCalibration(name = "INMS_v6")

calib<- "calibration_INMS_v6_16Feb21.tgz"


###############################################################################
########## Scenario runs  ##########
### Business-as-usual
cfg<-general_settings(title="SSP5_RCP8p5_PolicyLow")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp8p5",regionmapping="inms",calibration=calib)
# Development: fossil-fuel driven (SSP5)
# Land Use: medium regulation, high productivity
# Diet: meat and dairy-rich
cfg<-setScenario(cfg,"SSP5")
# Climate: no mitigation (RCP8.5)
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP5-Ref-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP5-Ref-REMIND-MAGPIE"
# N policy: low ambition
cfg$gms$c50_scen_neff <- "constant"
cfg$gms$c50_scen_neff_pasture <- "constant"
cfg$gms$c70_feed_scen <- "ssp2"    ##### or ssp5? or not necessary to specify when scenario config selected?
cfg$gms$c55_scen_conf <- "ssp2"    ##### or ssp5? or not necessary to specify when scenario config selected?
start_run(cfg=cfg,codeCheck=codeCheck)

### Low N regulation
cfg<-general_settings(cfg$title <- "SSP2_RCP4p5_PolicyLow")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5",regionmapping="inms",calibration=calib)
# Development: historical trends (SSP2)
# Land Use: medium regulation, medium productivity
# Diet: medium meat and dairy
cfg<-setScenario(cfg,"SSP2")
# Climate: moderate mitigation (RCP4.5)
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
# N policy: low ambition
cfg$gms$c50_scen_neff <- "constant"
cfg$gms$c50_scen_neff_pasture <- "constant"
cfg$gms$c70_feed_scen <- "ssp2"
cfg$gms$c55_scen_conf <- "ssp2"
start_run(cfg=cfg,codeCheck=codeCheck)

### Medium N regulation
cfg<-general_settings(cfg$title <- "SSP2_RCP4p5_PolicyMed")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5",regionmapping="inms",calibration=calib)
# Development: historical trends (SSP2)
# Land Use: medium regulation, medium productivity
# Diet: medium meat and dairy
cfg<-setScenario(cfg,"SSP2")
# Climate: moderate mitigation (RCP4.5)
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
# N policy: moderate ambition
cfg$gms$c50_scen_neff <- "neff_ZhangBy2050_start2010"
cfg$gms$c50_scen_neff_pasture <- "constant"
cfg$gms$c70_feed_scen <- "ssp1"
cfg$gms$c55_scen_conf <- "ssp1"
start_run(cfg=cfg,codeCheck=codeCheck)

### High N regulation
cfg<-general_settings(cfg$title <- "SSP2_RCP4p5_PolicyHigh")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5",regionmapping="inms",calibration=calib)
# Development: historical trends (SSP2)
# Land Use: medium regulation, medium productivity
# Diet: medium meat and dairy
cfg<-setScenario(cfg,"SSP2")
# Climate: moderate mitigation (RCP4.5)
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
# N policy: high ambition
cfg$gms$c50_scen_neff <- "neff_ZhangBy2030_start2010"
cfg$gms$c50_scen_neff_pasture <- "constant"
cfg$gms$c70_feed_scen <- "ssp1"
cfg$gms$c55_scen_conf <- "GoodPractice"
start_run(cfg=cfg,codeCheck=codeCheck)

### Best-case
cfg<-general_settings(cfg$title <- "SSP1_RCP4p5_PolicyHigh")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5",regionmapping="inms",calibration=calib)
# Development: sustainable development (SSP1)
# Land Use: strong regulation, high productivity (SSP1)
# Diet: low meat and dairy
cfg<-setScenario(cfg,"SSP1")
# Climate: moderate mitigation (RCP4.5)
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-IMAGE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-IMAGE"
# N policy: high ambition
cfg$gms$c50_scen_neff <- "neff_ZhangBy2030_start2010"
cfg$gms$c50_scen_neff_pasture <- "constant"
cfg$gms$c70_feed_scen <- "ssp1"
cfg$gms$c55_scen_conf <- "GoodPractice"
start_run(cfg=cfg,codeCheck=codeCheck)

### Best-case+
cfg<-general_settings(cfg$title <- "SSP1_RCP4p5_PolicyHighDiet")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5",regionmapping="inms",calibration=calib)
# Development: sustainable development (SSP1)
# Land Use: strong regulation, high productivity (SSP1)
cfg<-setScenario(cfg,"SSP1")
# Climate: moderate mitigation (RCP4.5)
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-IMAGE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-IMAGE"
# Diet: ambitious diet shift and food loss/waste reductions (EATLancet)
cfg$gms$c15_food_scenario <- "SSP1"
cfg$gms$s15_exo_waste <- 1
cfg$gms$s15_waste_scen <- 1.2
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "healthy_BMI"
cfg$gms$c15_EAT_scen <- "FLX"
# N policy: high ambition
cfg$gms$c50_scen_neff <- "neff_ZhangBy2030_start2010"
cfg$gms$c50_scen_neff_pasture <- "constant"
cfg$gms$c70_feed_scen <- "ssp1"
cfg$gms$c55_scen_conf <- "GoodPractice"
start_run(cfg=cfg,codeCheck=codeCheck)

### Bioenergy
cfg<-general_settings(cfg$title <- "SSP1_RCP2p6_PolicyHigh")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp2p6",regionmapping="inms",calibration=calib)
# Development: sustainable development (SSP1)
# Land Use: strong regulation, high productivity (SSP1)
# Diet: low meat and dairy
cfg<-setScenario(cfg,"SSP1")
# Climate: high mitigation (RCP2.6)
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-IMAGE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-IMAGE"
# N policy: high ambition
cfg$gms$c50_scen_neff <- "neff_ZhangBy2030_start2010"
cfg$gms$c50_scen_neff_pasture <- "constant"
cfg$gms$c70_feed_scen <- "ssp1"
cfg$gms$c55_scen_conf <- "GoodPractice"
start_run(cfg=cfg,codeCheck=codeCheck)

###############################################################################
########## Sensitivity runs  ##########
### Sensitivity 1: Only NUE (high ambition)
cfg<-general_settings(cfg$title <- "SSP2_RCP4p5_SensitivityNUEhigh")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5",regionmapping="inms",calibration=calib)
# Development: historical trends (SSP2)
# Land Use: medium regulation, medium productivity (SSP2)
# Diet: medium meat and dairy
cfg<-setScenario(cfg,"SSP2")
# Climate: moderate mitigation (RCP4.5)
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
# N policy: Only NUE
cfg$gms$c50_scen_neff <- "neff_ZhangBy2030_start2010"
cfg$gms$c50_scen_neff_pasture <- "constant"
start_run(cfg=cfg,codeCheck=codeCheck)

### Sensitivity 2: Only NUE (moderate ambition)
cfg<-general_settings(cfg$title <- "SSP2_RCP4p5_SensitivityNUEhigh")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5",regionmapping="inms",calibration=calib)
# Development: historical trends (SSP2)
# Land Use: medium regulation, medium productivity (SSP2)
# Diet: medium meat and dairy
cfg<-setScenario(cfg,"SSP2")
# Climate: moderate mitigation (RCP4.5)
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
# N policy: Only NUE
cfg$gms$c50_scen_neff <- "neff_ZhangBy2050_start2010"
cfg$gms$c50_scen_neff_pasture <- "constant"
start_run(cfg=cfg,codeCheck=codeCheck)

### Sensitivity 2: Only AWS (high ambition)
cfg<-general_settings(cfg$title <- "SSP2_RCP4p5_SensitivityAWShigh")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5",regionmapping="inms",calibration=calib)
# Development: historical trends (SSP2)
# Land Use: medium regulation, medium productivity (SSP2)
cfg<-setScenario(cfg,"SSP2")
# Climate: moderate mitigation (RCP4.5)
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
# N policy: Best
cfg$gms$c70_feed_scen <- "ssp1"
cfg$gms$c55_scen_conf <- "GoodPractice"
start_run(cfg=cfg,codeCheck=codeCheck)

### Sensitivity 3: Only AWS (moderate ambition)
cfg<-general_settings(cfg$title <- "SSP2_RCP4p5_SensitivityAWSmoderate") ###
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5",regionmapping="inms",calibration=calib)
# Development: historical trends (SSP2)
# Land Use: medium regulation, medium productivity (SSP2)
cfg<-setScenario(cfg,"SSP2")
# Climate: moderate mitigation (RCP4.5)
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
# N policy: Only AWS
cfg$gms$c70_feed_scen <- "ssp1"
cfg$gms$c55_scen_conf <- "ssp1"
start_run(cfg=cfg,codeCheck=codeCheck)
