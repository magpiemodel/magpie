# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de


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
                             project_name    = "GLUES2",
                             climatescen_name= "sresa2",
                             co2             = "constant_co2",
                             climate_model   = "miub_echo_g",
                             resolution      = "h200",
                             archive_rev     = "24",
                             madrat_rev      = "2.61",
                             validation_rev  = "2.61",
                             additional_data = "additional_data_rev3.14.tgz") {
  mappings <- c(h11="8a828c6ed5004e77d1ba2025e8ea2261",
                h12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a")
  archive_name=paste(project_name,climatescen_name,co2,climate_model,sep="-")
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

cfg$title <- "SSP2"
lucode::setScenario(cfg,"SSP2")
cfg$force_download <- TRUE
cfg$input <- buildInputVector()
cfg$recalibrate <- TRUE
start_run(cfg=cfg,codeCheck=codeCheck)
cfg$recalibrate <- FALSE

#SSP2 family

cfg$title <- "SUSTAg2"
lucode::setScenario(cfg,"SUSTAg2")
cfg$input <- buildInputVector(co2="dynamic_co2")
start_run(cfg=cfg,codeCheck=codeCheck)

cfg$title <- "SUSTAg2_Ref"
lucode::setScenario(cfg,"SUSTAg2")
cfg$input <- buildInputVector(co2="dynamic_co2")
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"
start_run(cfg=cfg,codeCheck=codeCheck)

cfg$title <- "SUSTAg2_co2fix"
lucode::setScenario(cfg,"SUSTAg2")
cfg$input <- buildInputVector(co2="constant_co2")
start_run(cfg=cfg,codeCheck=codeCheck)

cfg$title <- "SUSTAg2_Ref_co2fix"
lucode::setScenario(cfg,"SUSTAg2")
cfg$input <- buildInputVector(co2="constant_co2")
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"
start_run(cfg=cfg,codeCheck=codeCheck)

cfg$title <- "SUSTAg2_fixedperton"
lucode::setScenario(cfg,"SUSTAg2")
cfg$gms$factor_costs="fixed_per_ton_nov16"
cfg$input <- buildInputVector(co2="dynamic_co2")
start_run(cfg=cfg,codeCheck=codeCheck)
cfg$gms$factor_costs="mixed_feb17"

# SSP1 family

cfg$title <- "SUSTAg1"
lucode::setScenario(cfg,"SUSTAg1")
cfg$input <- buildInputVector(co2="dynamic_co2")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP3 family

cfg$title <- "SUSTAg3"
lucode::setScenario(cfg,"SUSTAg3")
cfg$input <- buildInputVector(co2="dynamic_co2")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP4 family

cfg$title <- "SUSTAg4"
lucode::setScenario(cfg,"SUSTAg4")
cfg$input <- buildInputVector(co2="dynamic_co2")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP5 family

cfg$title <- "SUSTAg5"
lucode::setScenario(cfg,"SUSTAg5")
cfg$input <- buildInputVector(co2="dynamic_co2")
start_run(cfg=cfg,codeCheck=codeCheck)