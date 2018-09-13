# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
cfg$results_folder <- "output/:title:"
cfg$recalibrate <- FALSE

#res
res <- "c200"
cfg$input[1] <- paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev34_",res,"_690d3718e151be1b450b394c1064b1c5.tgz")
cfg$input[5] <- paste0("calibration_H12_",res,"_12Sep18.tgz")

### Runs without CC

##SSP1
cfg$title <- paste("SSP1_Ref",res,sep="_")
cfg <- setScenario(cfg,c("SSP1","NPI"))
cfg$gms$c56_pollutant_prices <- "SSP1-Ref-SPA0-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP1-Ref-SPA0"
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste("SSP1_26",res,sep="_")
cfg <- setScenario(cfg,c("SSP1","NDC"))
cfg$gms$c56_pollutant_prices <- "SSP1-26-SPA1-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP1-26-SPA1"
start_run(cfg,codeCheck=FALSE)

##SSP2
cfg$title <- paste("SSP2_Ref",res,sep="_")
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste("SSP2_26",res,sep="_")
cfg <- setScenario(cfg,c("SSP2","NDC"))
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA2"
start_run(cfg,codeCheck=FALSE)

##SSP3
cfg$title <- paste("SSP3_Ref",res,sep="_")
cfg <- setScenario(cfg,c("SSP3","NPI"))
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste("SSP3_26",res,sep="_")
cfg <- setScenario(cfg,c("SSP3","NDC"))
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA2"
start_run(cfg,codeCheck=FALSE)

##SSP4
cfg$title <- paste("SSP4_Ref",res,sep="_")
cfg <- setScenario(cfg,c("SSP4","NPI"))
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste("SSP4_26",res,sep="_")
cfg <- setScenario(cfg,c("SSP4","NDC"))
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA2"
start_run(cfg,codeCheck=FALSE)

##SSP5
cfg$title <- paste("SSP5_Ref",res,sep="_")
cfg <- setScenario(cfg,c("SSP5","NPI"))
cfg$gms$c56_pollutant_prices <- "SSP5-Ref-SPA0-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP5-Ref-SPA0"
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste("SSP5_26",res,sep="_")
cfg <- setScenario(cfg,c("SSP5","NDC"))
cfg$gms$c56_pollutant_prices <- "SSP5-26-SPA5-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP5-26-SPA5"
start_run(cfg,codeCheck=FALSE)

### Runs with CC

#CC
cfg$gms$c14_yields_scenario  <- "cc"
cfg$gms$c42_watdem_scenario  <- "cc"
cfg$gms$c43_watavail_scenario  <- "cc"
cfg$gms$c52_carbon_scenario  <- "cc"

##SSP1
cfg$title <- paste("SSP1_Ref_RCP60_co2",res,sep="_")
cfg <- setScenario(cfg,c("SSP1","NPI"))
cfg$gms$c56_pollutant_prices <- "SSP1-Ref-SPA0-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP1-Ref-SPA0"
cfg$input[1] <- paste0("isimip_rcp-IPSL_CM5A_LR-rcp6p0-co2_rev34_",res,"_690d3718e151be1b450b394c1064b1c5.tgz")
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste("SSP1_26_RCP26_co2",res,sep="_")
cfg <- setScenario(cfg,c("SSP1","NDC"))
cfg$gms$c56_pollutant_prices <- "SSP1-26-SPA1-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP1-26-SPA1"
cfg$input[1] <- paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev34_",res,"_690d3718e151be1b450b394c1064b1c5.tgz")
start_run(cfg,codeCheck=FALSE)

##SSP2
cfg$title <- paste("SSP2_Ref_RCP60_co2",res,sep="_")
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
cfg$input[1] <- paste0("isimip_rcp-IPSL_CM5A_LR-rcp6p0-co2_rev34_",res,"_690d3718e151be1b450b394c1064b1c5.tgz")
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste("SSP2_26_RCP26_co2",res,sep="_")
cfg <- setScenario(cfg,c("SSP2","NDC"))
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA2"
cfg$input[1] <- paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev34_",res,"_690d3718e151be1b450b394c1064b1c5.tgz")
start_run(cfg,codeCheck=FALSE)

##SSP3
cfg$title <- paste("SSP3_Ref_RCP60_co2",res,sep="_")
cfg <- setScenario(cfg,c("SSP3","NPI"))
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
cfg$input[1] <- paste0("isimip_rcp-IPSL_CM5A_LR-rcp6p0-co2_rev34_",res,"_690d3718e151be1b450b394c1064b1c5.tgz")
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste("SSP3_26_RCP26_co2",res,sep="_")
cfg <- setScenario(cfg,c("SSP3","NDC"))
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA2"
cfg$input[1] <- paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev34_",res,"_690d3718e151be1b450b394c1064b1c5.tgz")
start_run(cfg,codeCheck=FALSE)

##SSP4
cfg$title <- paste("SSP4_Ref_RCP60_co2",res,sep="_")
cfg <- setScenario(cfg,c("SSP4","NPI"))
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
cfg$input[1] <- paste0("isimip_rcp-IPSL_CM5A_LR-rcp6p0-co2_rev34_",res,"_690d3718e151be1b450b394c1064b1c5.tgz")
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste("SSP4_26_RCP26_co2",res,sep="_")
cfg <- setScenario(cfg,c("SSP4","NDC"))
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA2-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA2"
cfg$input[1] <- paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev34_",res,"_690d3718e151be1b450b394c1064b1c5.tgz")
start_run(cfg,codeCheck=FALSE)

##SSP5
cfg$title <- paste("SSP5_Ref_RCP60_co2",res,sep="_")
cfg <- setScenario(cfg,c("SSP5","NPI"))
cfg$gms$c56_pollutant_prices <- "SSP5-Ref-SPA0-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP5-Ref-SPA0"
cfg$input[1] <- paste0("isimip_rcp-IPSL_CM5A_LR-rcp6p0-co2_rev34_",res,"_690d3718e151be1b450b394c1064b1c5.tgz")
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste("SSP5_26_RCP26_co2",res,sep="_")
cfg <- setScenario(cfg,c("SSP5","NDC"))
cfg$gms$c56_pollutant_prices <- "SSP5-26-SPA5-V15-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSP5-26-SPA5"
cfg$input[1] <- paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev34_",res,"_690d3718e151be1b450b394c1064b1c5.tgz")
start_run(cfg,codeCheck=FALSE)
