# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(gms)
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
                             resolution      = "c200",
                             archive_rev     = "34",
                             madrat_rev      = "4.14",
                             validation_rev  = "4.14",
                             calibration     = "calibration_agmip_c200_19Dec18.tgz",
                             additional_data = "additional_data_rev3.65.tgz") {
  mappings <- c(h11="8a828c6ed5004e77d1ba2025e8ea2261",
                h12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a",
                inms="69c65bb3c88e8033cf8df6b5ac5d52a9",
                inms2="ef2ae7cd6110d5d142a9f8bd7d5a68f2",
                agmip="c77f075908c3bc29bdbe1976165eccaf")
  archive_name=paste(project_name,climate_model,climatescen_name,co2,sep="-")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings[regionmapping], ".tgz")
  madrat  <- paste0("rev", madrat_rev,"_", mappings[regionmapping], "_magpie.tgz")
  validation  <- paste0("rev",validation_rev,"_", mappings[regionmapping], "_validation", ".tgz")
  return(c(archive,madrat,validation,additional_data))
}



### Single runs ###
#general settings
cfg$gms$c_timesteps <- 12

# clalibration runs

cfg$title <- "SSP2_RCP4p5_PolicyMed_v1"
cfg<-gms::setScenario(cfg,"SUSTAg2")
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
cfg$gms$c60_2ndgen_biodem    <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
cfg$force_download <- TRUE
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5",regionmapping="agmip")
cfg$gms$som<-"cellpool_aug16"
#cfg$gms$factor_costs <- "sticky_feb18"
start_run(cfg=cfg,codeCheck=codeCheck)


#SSP1,5 family

cfg$title <- "SSP1_RCP4p5_PolicyHighDiet_v1"

cfg$title <- "SSP1_RCP2p6_PolicyHigh_v1"

cfg$title <- "SSP1_RCP4p5_PolicyHigh_v1"
cfg<-gms::setScenario(cfg,"SUSTAg1")
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-IMAGE"
cfg$gms$c60_2ndgen_biodem    <- "SSPDB-SSP1-26-IMAGE"
cfg$force_download <- TRUE
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp2p6",regionmapping="agmip")
cfg$gms$som<-"cellpool_aug16"
#cfg$gms$factor_costs <- "sticky_feb18"
cfg$gms$c50_scen_neff  <- "neff80_85_starty2010"
start_run(cfg=cfg,codeCheck=codeCheck)

cfg$title <- "INMS_SSP1_RCP45_Nhigh"
cfg<-gms::setScenario(cfg,"SUSTAg1")
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-45-IMAGE"
cfg$gms$c60_2ndgen_biodem    <- "SSPDB-SSP1-45-IMAGE"
cfg$force_download <- TRUE
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5",regionmapping="agmip")
cfg$gms$som<-"cellpool_aug16"
#cfg$gms$factor_costs <- "sticky_feb18"
cfg$gms$c50_scen_neff  <- "neff80_85_starty2010"
start_run(cfg=cfg,codeCheck=codeCheck)


cfg$title <- "SSP2_RCP4p5_PolicyLow_v1"
cfg<-gms::setScenario(cfg,"SUSTAg2")
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
cfg$gms$c60_2ndgen_biodem    <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
cfg$force_download <- TRUE
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5",regionmapping="agmip")
cfg$gms$som<-"cellpool_aug16"
cfg$gms$c50_scen_neff  <- "constant"
#cfg$gms$factor_costs <- "sticky_feb18"
start_run(cfg=cfg,codeCheck=codeCheck)

cfg$title <- "SSP2_RCP4p5_PolicyHigh_v1"
cfg<-gms::setScenario(cfg,"SUSTAg2")
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
cfg$gms$c60_2ndgen_biodem    <- "SSPDB-SSP2-45-MESSAGE-GLOBIOM"
cfg$force_download <- TRUE
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5",regionmapping="agmip")
cfg$gms$som<-"cellpool_aug16"
cfg$gms$c50_scen_neff  <- "neff80_85_starty2010"
#cfg$gms$factor_costs <- "sticky_feb18"
start_run(cfg=cfg,codeCheck=codeCheck)

cfg$title <- "SSP5_RCP8p5_PolicyLow_v1"
cfg<-gms::setScenario(cfg,"SUSTAg5")
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP5-Ref-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem    <- "SSPDB-SSP5-Ref-REMIND-MAGPIE"
cfg$force_download <- TRUE
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp8p5",regionmapping="agmip")
cfg$gms$som<-"cellpool_aug16"
cfg$gms$c50_scen_neff  <- "constant"
#cfg$gms$factor_costs <- "sticky_feb18"
start_run(cfg=cfg,codeCheck=codeCheck)
