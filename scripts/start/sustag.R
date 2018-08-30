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

buildInputVector <- function(regionmapping   = "h11",
                             project_name    = "isimip_rcp",
                             climatescen_name= "rcp2p6",
                             co2             = "noco2",
                             climate_model   = "IPSL_CM5A_LR",
                             resolution      = "h200",
                             archive_rev     = "30",
                             madrat_rev      = "4",
                             validation_rev  = "4",
                             additional_data = "additional_data_rev3.30.tgz") {
  mappings <- c(h11="8a828c6ed5004e77d1ba2025e8ea2261",
                h12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a",
                capri="e7e72fddc44cc3d546af7b038c651f51")
  archive_name=paste(project_name,climate_model,climatescen_name,co2,sep="-")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings[regionmapping], ".tgz")
  madrat  <- paste0("rev", madrat_rev,"_", mappings[regionmapping], "_magpie", ".tgz")
  validation  <- paste0("rev", validation_rev,"_", mappings[regionmapping], "_validation", ".tgz")
  return(c(archive,madrat,validation,additional_data))
}

### Single runs ###
#general settings
cfg$gms$c_timesteps <- 12
cfg$input <- buildInputVector(regionmapping="h11")
cfg$output <- c(cfg$output,"sustag_report")

# clalibration runs

cfg$title <- "SUSTAg2"
cfg<-lucode::setScenario(cfg,"SUSTAg2")
cfg$force_download <- TRUE
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp2p6")
cfg$recalibrate <- FALSE
start_run(cfg=cfg,codeCheck=codeCheck)
cfg$recalibrate <- FALSE

# SSP1 family

cfg$title <- "SUSTAg1"
cfg<-lucode::setScenario(cfg,"SUSTAg1")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp2p6")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP3 family

cfg$title <- "SUSTAg3"
cfg<-lucode::setScenario(cfg,"SUSTAg3")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp6p0")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP4 family

cfg$title <- "SUSTAg4"
cfg<-lucode::setScenario(cfg,"SUSTAg4")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP5 family

cfg$title <- "SUSTAg5"
cfg<-lucode::setScenario(cfg,"SUSTAg5")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5")
start_run(cfg=cfg,codeCheck=codeCheck)



#SSP2 family

# SSP2 control run
cfg$title <- "SSP2"
cfg<-lucode::setScenario(cfg,"SSP2")
cfg$input <- buildInputVector(co2="noco2")
start_run(cfg=cfg,codeCheck=codeCheck)

cfg$title <- "SUSTAg2_Ref"
cfg<-lucode::setScenario(cfg,"SUSTAg2")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp6p0")
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"
start_run(cfg=cfg,codeCheck=codeCheck)

cfg$title <- "SUSTAg2_nocc"
cfg<-lucode::setScenario(cfg,"SUSTAg2")
cfg$input <- buildInputVector(co2="noco2")
cfg<-lucode::setScenario(cfg,"nocc")
start_run(cfg=cfg,codeCheck=codeCheck)

cfg$title <- "SUSTAg2_co2fix"
cfg<-lucode::setScenario(cfg,"SUSTAg2")
cfg$input <- buildInputVector(co2="noco2")
start_run(cfg=cfg,codeCheck=codeCheck)

cfg$title <- "SUSTAg2_Ref_co2fix"
cfg<-lucode::setScenario(cfg,"SUSTAg2")
cfg$input <- buildInputVector(co2="noco2",climatescen_name="rcp6p0")
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"
start_run(cfg=cfg,codeCheck=codeCheck)

cfg$title <- "SUSTAg2_fixedperton"
cfg<-lucode::setScenario(cfg,"SUSTAg2")
cfg$gms$factor_costs="fixed_per_ton_nov16"
cfg$input <- buildInputVector(co2="co2")
start_run(cfg=cfg,codeCheck=codeCheck)
cfg$gms$factor_costs="mixed_feb17"




### bioenergy experiments
