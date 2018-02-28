# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(lucode)
source("scripts/start_functions.R")
source("scripts/performance_test.R")
source("config/default.cfg")

#set defaults
codeCheck <- FALSE

buildInputVector <- function(regionmapping   = "sim4nexus",
                             project_name    = "isimip_rcp",
                             climatescen_name= "rcp2p6",
                             co2             = "noco2",
                             climate_model   = "IPSL_CM5A_LR",
                             resolution      = "h200",
                             archive_rev     = "24.1",
                             madrat_rev      = "2.105",
                             validation_rev  = "2.105",
                             additional_data = "additional_data_rev3.16.tgz") {
  mappings <- c(h11="8a828c6ed5004e77d1ba2025e8ea2261",
                h12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a",
                sim4nexus= "270870819da5607e288b6d0e5a5e6594")
  archive_name=paste(project_name,climate_model,climatescen_name,co2,sep="-")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings[regionmapping], ".tgz")
  madrat  <- paste0("magpie_", mappings[regionmapping], "_rev", madrat_rev, ".tgz")
  validation  <- paste0("validation_", mappings[regionmapping], "_rev", validation_rev, ".tgz")
  return(c(archive,madrat,validation,additional_data))
}



### Single runs ###
#general settings
cfg$gms$c_timesteps <- 7
cfg$gms$s15_elastic_demand <- 1

# clalibration runs

cfg$title <- "per_ha_ton_mix"
cfg<-lucode::setScenario(cfg,"SUSTAg2")
cfg$force_download <- TRUE
cfg$input <- buildInputVector()
cfg$input <- buildInputVector(co2="co2")
cfg$recalibrate <- TRUE
start_run(cfg=cfg,codeCheck=codeCheck)

cfg$title <- "per_ton"
cfg<-lucode::setScenario(cfg,"SUSTAg2")
cfg$gms$factor_costs="fixed_per_ton_nov16"
cfg$input <- buildInputVector(co2="co2")
cfg$recalibrate <- TRUE
start_run(cfg=cfg,codeCheck=codeCheck)
cfg$gms$factor_costs="mixed_feb17"

cfg$title <- "sticky"
cfg<-lucode::setScenario(cfg,"SUSTAg2")
cfg$gms$factor_costs="sticky_feb18"
cfg$input <- buildInputVector(co2="co2")
cfg$recalibrate <- TRUE
start_run(cfg=cfg,codeCheck=codeCheck)
cfg$gms$factor_costs="mixed_feb17"
