# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
library(magclass)
library(gdx)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"

cfg$output <- c("rds_report")

prefix <- "hr03"
res <- "c200"

cfg$input <- c(paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev42_",res,"_690d3718e151be1b450b394c1064b1c5.tgz"),
               "rev4.42_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
               "rev4.42_690d3718e151be1b450b394c1064b1c5_validation.tgz",
               paste0("calibration_H12_",res,"_highres.tgz"),
               "additional_data_rev3.78.tgz")

download_and_update(cfg)

for (ssp in c("SSP1","SSP2","SSP3","SSP4","SSP5")) {
  cfg$title <- paste(prefix,ssp,"2p6",res,"glo",sep="_")
  cfg <- setScenario(cfg,c(ssp,"NDC"))
  cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-26-REMIND-MAGPIE"
  cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-26-REMIND-MAGPIE"
  start_run(cfg,codeCheck=FALSE)
}
