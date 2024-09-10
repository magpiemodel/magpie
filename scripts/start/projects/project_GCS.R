# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test of scenario design for the GCS project
# position: 5
# ----------------------------------------------------------


##### Version log (YYYYMMDD - Description - Author(s))
## v0.1 - 20210927 - GCS scenarios - IW

library(lucode2)
library(magclass)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Sources the default configuration file
source("config/default.cfg")




#################################################################
# SSP1 and SSP2 variants without carbon pricing                          #
#################################################################


### SSP2 NDC rcp7p0 ##########################
cfg$title <- "SSP2_NDC_rcp7p0"
cfg <- setScenario(cfg,c("SSP2","NDC","cc","rcp7p0"))
start_run(cfg,codeCheck=FALSE)

### SSP2 NDC rcp6p0 ##########################
cfg$title <- "SSP2_NDC_rcp6p0"
cfg <- setScenario(cfg,c("SSP2","NDC","cc","rcp6p0"))
start_run(cfg,codeCheck=FALSE)

### SSP2 NDC rcp2p6 ##########################
cfg$title <- "SSP2_NDC_rcp2p6"
cfg <- setScenario(cfg,c("SSP2","NDC","cc","rcp2p6"))
start_run(cfg,codeCheck=FALSE)

### SSP2 NDC nocc ############################
cfg$title <- "SSP2_NDC_nocc"
cfg <- setScenario(cfg,c("SSP2","NDC","nocc"))
start_run(cfg,codeCheck=FALSE)

### SSP2-Tland NDC rcp2p6 ##########################
cfg$title <- "SSP2-Tland_NDC_rcp2p6"
cfg <- setScenario(cfg,c("SSP2","NDC","cc","rcp2p6"))
cfg <- setScenario(cfg, c("Tland"), scenario_config = "config/projects/scenario_config_gcs.csv")
start_run(cfg,codeCheck=FALSE)

### SSP1 NDC rcp2p6 ##########################
cfg$title <- "SSP1_NDC_rcp2p6"
cfg <- setScenario(cfg,c("SSP1","NDC","cc","rcp2p6"))
start_run(cfg,codeCheck=FALSE)



#################################################################
# SSP2 with two carbon pricing variants                          #
#################################################################


### SSP2 with climate policy parametrized from R21M42-SSP2-PkBudg900
cfg$title <- "SSP2_ssp2pkbudg900_rcp2p6"
cfg <- setScenario(cfg,c("SSP2","NDC","cc","rcp2p6"))
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"
start_run(cfg,codeCheck=FALSE)

### SSP2 with climate policy parametrized from R21M42-SDP-PkBudg1000
cfg$title <- "SSP2_sdppkbudg1000_rcp2p6"
cfg <- setScenario(cfg,c("SSP2","NDC","cc","rcp2p6"))
cfg$gms$c56_pollutant_prices <- "R21M42-SDP-PkBudg1000"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SDP-PkBudg1000"
start_run(cfg,codeCheck=FALSE)



#################################################################
# SSP2 with sustainable land transformation (Tland)
# and with two carbon pricing variants                          #
#################################################################


### SSP2-Tland with climate policy parametrized from R21M42-SSP2-PkBudg900
cfg$title <- "SSP2-Tland_ssp2pkbudg900_rcp2p6"
cfg <- setScenario(cfg,c("SSP2","NDC","cc","rcp2p6"))
cfg <- setScenario(cfg, c("Tland"), scenario_config = "config/projects/scenario_config_gcs.csv")
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"
start_run(cfg,codeCheck=FALSE)

### SSP2-Tland with climate policy parametrized from R21M42-SDP-PkBudg1000
cfg$title <- "SSP2-Tland_sdppkbudg1000_rcp2p6"
cfg <- setScenario(cfg,c("SSP2","NDC","cc","rcp2p6"))
cfg <- setScenario(cfg, c("Tland"), scenario_config = "config/projects/scenario_config_gcs.csv")
cfg$gms$c56_pollutant_prices <- "R21M42-SDP-PkBudg1000"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SDP-PkBudg1000"
start_run(cfg,codeCheck=FALSE)


#################################################################
# SSP1 with sustainable land transformation (Tland)
# and with two carbon pricing variants                          #
#################################################################


### SSP1-Tland with climate policy parametrized from R21M42-SSP1-PkBudg900
cfg$title <- "SSP1-Tland_ssp1pkbudg900_rcp2p6"
cfg <- setScenario(cfg,c("SSP1","NDC","cc","rcp2p6"))
cfg <- setScenario(cfg, c("Tland"), scenario_config = "config/projects/scenario_config_gcs.csv")
cfg$gms$c56_pollutant_prices <- "R21M42-SSP1-PkBudg900"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP1-PkBudg900"
start_run(cfg,codeCheck=FALSE)

### SSP1-Tland with climate policy parametrized from R21M42-SDP-PkBudg1000
cfg$title <- "SSP1-Tland_sdppkbudg1000_rcp2p6"
cfg <- setScenario(cfg,c("SSP1","NDC","cc","rcp2p6"))
cfg <- setScenario(cfg, c("Tland"), scenario_config = "config/projects/scenario_config_gcs.csv")
cfg$gms$c56_pollutant_prices <- "R21M42-SDP-PkBudg1000"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SDP-PkBudg1000"
start_run(cfg,codeCheck=FALSE)


##revert
cfg <- setScenario(cfg,c("SSP2","NPI","cc","rcp7p0"))
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"

