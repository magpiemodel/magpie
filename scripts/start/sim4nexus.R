# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


############################################################
#### Script for the generation of SIM4NEXUS simulations ####
############################################################

library(lucode)
source("scripts/start_functions.R")
source("scripts/performance_test.R")
source("config/default.cfg")

#set defaults
codeCheck <- FALSE

buildInputVector <- function(regionmapping   = "agmip",
                             project_name    = "isimip_rcp",
                             climatescen_name= "rcp2p6",
                             co2             = "noco2",
                             climate_model   = "IPSL_CM5A_LR",
                             resolution      = "c400",
                             archive_rev     = "34",
                             madrat_rev      = "4.14",
                             validation_rev  = "4.14",
			                       calibration     = "",
                             additional_data = "additional_data_rev3.65.tgz") {
  mappings <- c(H11="8a828c6ed5004e77d1ba2025e8ea2261",
                H12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a",
		agmip="c77f075908c3bc29bdbe1976165eccaf",
		sim4nexus="25dd7264e8e145385b3bd0b89ec5f3fc",
                capri="e7e72fddc44cc3d546af7b038c651f51")
  archive_name=paste(project_name,climate_model,climatescen_name,co2,sep="-")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings[regionmapping], ".tgz")
  madrat  <- paste0("rev", madrat_rev,"_", mappings[regionmapping], "_magpie", ".tgz")
  validation  <- paste0("rev", validation_rev,"_", mappings[regionmapping], "_validation", ".tgz")
  return(c(archive,madrat,validation,calibration,additional_data))
}

### SIM4NEXUS runs ###
#general settings
cfg$gms$c_timesteps <- "coup2100"
cfg$input <- buildInputVector()
cfg$output <- c(cfg$output,"sustag_report")
cfg$recalibrate <- FALSE

# SSP control runs###############################################

# SSP2
cfg$title <- "SSP2_standard"
cfg<-lucode::setScenario(cfg,"SSP2")
cfg<-lucode::setScenario(cfg,"nocc")
cfg$force_download <- TRUE
cfg$input <- buildInputVector(co2="co2")
#cfg$recalibrate <- TRUE
start_run(cfg=cfg,codeCheck=codeCheck)
#cfg$recalibrate <- FALSE


# SSP1
cfg$title <- "SSP1"
cfg<-lucode::setScenario(cfg,"SSP1")
cfg<-lucode::setScenario(cfg,"nocc")
cfg$recalibrate <- TRUE
cfg$input <- buildInputVector(co2="co2",regionmapping = "sim4nexus")
start_run(cfg=cfg,codeCheck=codeCheck)
cfg$recalibrate <- FALSE

# SSP2
cfg$title <- "SSP2"
cfg<-lucode::setScenario(cfg,"SSP2")
cfg<-lucode::setScenario(cfg,"nocc")
cfg$input <- buildInputVector(co2="co2",regionmapping = "sim4nexus")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP3
cfg$title <- "SSP3"
cfg<-lucode::setScenario(cfg,"SSP3")
cfg<-lucode::setScenario(cfg,"nocc")
cfg$input <- buildInputVector(co2="co2",regionmapping = "sim4nexus")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP4
cfg$title <- "SSP4"
cfg<-lucode::setScenario(cfg,"SSP4")
cfg<-lucode::setScenario(cfg,"nocc")
cfg$input <- buildInputVector(co2="co2",regionmapping = "sim4nexus")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP5
cfg$title <- "SSP5"
cfg<-lucode::setScenario(cfg,"SSP5")
cfg<-lucode::setScenario(cfg,"nocc")
cfg$input <- buildInputVector(co2="co2",regionmapping = "sim4nexus")
start_run(cfg=cfg,codeCheck=codeCheck)





#SIM4NEXUS standard runs#############################################

#SSP2 family

# SSP2 Baseline RCP6.0 without CC mitigation 
cfg$title <- "base_rcp6p0"
cfg<-lucode::setScenario(cfg,"SSP2")
cfg<-lucode::setScenario(cfg,"cc")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp6p0",regionmapping = "sim4nexus")
start_run(cfg=cfg,codeCheck=codeCheck)


# SSP2 Mitigation RCP2.6 
cfg$title <- "policy_rcp2p6"
cfg<-lucode::setScenario(cfg,"SSP2")
cfg<-lucode::setScenario(cfg,"cc")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp2p6",regionmapping = "sim4nexus")
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-MESSAGE-GLOBIOM"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA2"
cfg$gms$forestry  <- "affore_vegc_dec16"
cfg$gms$maccs  <- "on_sep16"
start_run(cfg=cfg,codeCheck=codeCheck)


# SSP2 Baseline RCP6.0 without CC mitigation with EFP
cfg$title <- "base_rcp6p0_efp"
cfg<-lucode::setScenario(cfg,"SSP2")
cfg<-lucode::setScenario(cfg,"cc")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp6p0",regionmapping = "sim4nexus")
cfg$gms$c42_env_flow_policy <- "on"
start_run(cfg=cfg,codeCheck=codeCheck)


# SSP2 Mitigation RCP2.6 with EFP
cfg$title <- "policy_rcp2p6_efp"
cfg<-lucode::setScenario(cfg,"SSP2")
cfg<-lucode::setScenario(cfg,"cc")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp2p6",regionmapping = "sim4nexus")
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-MESSAGE-GLOBIOM"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA2"
cfg$gms$forestry  <- "affore_vegc_dec16"
cfg$gms$maccs  <- "on_sep16"
cfg$gms$c42_env_flow_policy <- "on"
start_run(cfg=cfg,codeCheck=codeCheck)



