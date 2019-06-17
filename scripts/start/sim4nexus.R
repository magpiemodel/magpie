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
                             resolution      = "h200",
                             archive_rev     = "37",
                             madrat_rev      = "4.14",
                             validation_rev  = "4.14",
                             calibration     = "calibration_sim4nexus_may2019.tgz",
                             additional_data = "additional_data_rev3.67.tgz") {
  mappings <- c(H11="8a828c6ed5004e77d1ba2025e8ea2261",
                H12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a",
                agmip="c77f075908c3bc29bdbe1976165eccaf",
                sim4nexus="25dd7264e8e145385b3bd0b89ec5f3fc",
                inms="44f1e181a3da765729f2f1bfc926425a",
                capri="e7e72fddc44cc3d546af7b038c651f51")
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
  cfg$gms$c_timesteps <- "coup2100"
  cfg$input <- buildInputVector()
  cfg$output <- c(cfg$output,"sustag_report")
  cfg$recalibrate <- FALSE
  cfg<-lucode::setScenario(cfg,"cc")
  cfg$gms$c56_emis_policy <- "all"
  cfg$gms$forestry  <- "affore_vegc_dec16"
  cfg$gms$maccs  <- "on_sep16"
  cfg$title <- paste0("v1_",title)
#  include costs per-ton
  return(cfg)
}


# SSP control runs###############################################


# SSP2
cfg<-general_settings(title="SSP2")
cfg<-lucode::setScenario(cfg,"SSP2")
cfg<-lucode::setScenario(cfg,"nocc")
cfg$input <- buildInputVector(regionmapping = "sim4nexus")
cfg$recalibrate <- TRUE
start_run(cfg=cfg,codeCheck=codeCheck)
calib<-magpie4::submitCalibration(name = "calibration_sim4nexus_may2019")
cfg$recalibrate <- "ifneeded"


#SIM4NEXUS standard runs#############################################

#SSP2 family

cfg<-general_settings(title="SSP2_base_rcp6p0")
cfg<-lucode::setScenario(cfg,"SSP2")
cfg$input <- buildInputVector(climatescen_name="rcp6p0",regionmapping = "sim4nexus",calibration=calib)
start_run(cfg=cfg,codeCheck=codeCheck)


cfg<-general_settings(title="SSP2_food")
cfg<-lucode::setScenario(cfg,"SSP2")
cfg$input <- buildInputVector(climatescen_name="rcp6p0",regionmapping = "sim4nexus",calibration=calib)
start_run(cfg=cfg,codeCheck=codeCheck)


cfg<-general_settings(title="SSP2_climate")
cfg<-lucode::setScenario(cfg,"SSP2")
cfg$input <- buildInputVector(climatescen_name="rcp2p6",regionmapping = "sim4nexus",calibration=calib)
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-MESSAGE-GLOBIOM"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA2"
cfg$c50_scen_neff <- "neff65_70_starty2010"
start_run(cfg=cfg,codeCheck=codeCheck)



cfg<-general_settings(title="SSP2_water")
cfg<-lucode::setScenario(cfg,"SSP2")
cfg$input <- buildInputVector(climatescen_name="rcp6p0",regionmapping = "sim4nexus",calibration=calib)
cfg$c50_scen_neff <- "neff70_75_starty2010"
start_run(cfg=cfg,codeCheck=codeCheck)


cfg<-general_settings(title="SSP2_biodiversity")
cfg<-lucode::setScenario(cfg,"SSP2")
cfg<-lucode::setScenario(cfg,"cc")
cfg$input <- buildInputVector(climatescen_name="rcp6p0",regionmapping = "sim4nexus",calibration=calib)
cfg$c50_scen_neff <- "neff70_75_starty2010"
cfg$c55_scen_conf <- "SSP1"
cfg$gms$c12_interest_rate <- "low"
cfg$gms$c35_protect_scenario <- "BH"		
start_run(cfg=cfg,codeCheck=codeCheck)


cfg<-general_settings(title="SSP2_all")
cfg<-lucode::setScenario(cfg,"SSP2")
cfg$input <- buildInputVector(climatescen_name="rcp2p6",regionmapping = "sim4nexus",calibration=calib)
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-MESSAGE-GLOBIOM"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA2"
cfg$gms$c42_env_flow_policy <- "on"
cfg$c50_scen_neff <- "neff75_80_starty2010"
cfg$gms$c12_interest_rate <- "low"
cfg$c55_scen_conf <- "SSP1"
cfg$gms$c35_protect_scenario <- "BH"
start_run(cfg=cfg,codeCheck=codeCheck)

