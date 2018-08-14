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
                             archive_rev     = "29",
                             madrat_rev      = "3.15",
                             validation_rev  = "3.15",
                             additional_data = "additional_data_rev3.26.tgz",
                             npi="npi_ndc_base_SSP2_fixed.tgz") {
  mappings <- c(h11="8a828c6ed5004e77d1ba2025e8ea2261",
                h12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a",
                inms="69c65bb3c88e8033cf8df6b5ac5d52a9",
                inms2="ef2ae7cd6110d5d142a9f8bd7d5a68f2")
  archive_name=paste(project_name,climate_model,climatescen_name,co2,sep="-")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings[regionmapping], ".tgz")
  madrat  <- paste0("rev", madrat_rev,"_", mappings[regionmapping], "_magpie.tgz")
  validation  <- paste0("rev",validation_rev,"_", mappings[regionmapping], "_validation", ".tgz")
  return(c(archive,madrat,validation,additional_data,npi))
}



### Single runs ###
#general settings
cfg$gms$c_timesteps <- 12

# clalibration runs

cfg$title <- "INMS2_casestudies"
cfg<-lucode::setScenario(cfg,"SUSTAg2")
cfg$gms$s15_elastic_demand = 1
cfg$gms$c56_pollutant_prices <- "SSP2-60-SPA2-V15-MESSAGE-GLOBIOM"
cfg$gms$c60_2ndgen_biodem    <- "SSP2-60-SPA2"
cfg$force_download <- TRUE
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp6p0",regionmapping="inms")
#cfg$gms$som<-"cellpool_aug16"
cfg$gms$factor_costs <- "sticky_feb18"
cfg$recalc_npi_ndc <- FALSE
cfg$gms$c32_aff_policy <- "none"
cfg$gms$c35_ad_policy <- "none"
cfg$recalibrate <- TRUE
start_run(cfg=cfg,codeCheck=codeCheck)
cfg$recalibrate <- FALSE


#SSP1,5 family


cfg$title <- "INMS1_casestudies"
cfg<-lucode::setScenario(cfg,"SUSTAg1")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp2p6",regionmapping="inms")
cfg$gms$c56_pollutant_prices <- "SSP5-26-SPA5-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem    <- "SSP5-26-SPA5"
start_run(cfg=cfg,codeCheck=codeCheck)

cfg$title <- "INMS5_casestudies"
cfg<-lucode::setScenario(cfg,"SUSTAg5")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5",regionmapping="inms")
cfg$gms$c56_pollutant_prices <- "SSP1-45-SPA1-V15-IMAGE"
cfg$gms$c60_2ndgen_biodem    <- "SSP1-45-SPA1"
start_run(cfg=cfg,codeCheck=codeCheck)
