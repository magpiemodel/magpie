# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: EAT2p0 project simulations 2023
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode2)
library(magclass)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# start MAgPIE runs
source("config/default.cfg")

cfg$force_download <- FALSE

#cfg$results_folder <- "output/:title:"
cfg$results_folder <- "output/:title::date:"


#########################
# 1 Baseline BAU_RCP4.5 #
#########################
# SSP: SSP2
# Diet: BAU-SSP2
# Waste: BAU-SSP2
# Crop and Livestock productivity: BAU-SSP2
# Mitigation policies: current policies
# Land-use policies: current policies
# RCP/GCM: tba
# Trade: BAU-SSP2
cfg$title <- "BAU_RCP4p5"
cfg       <- gms::setScenario(cfg, c("SSP2", "NPI"))
start_run(cfg, codeCheck = FALSE)

#########################
# 2 Baseline PHD_RCP4.5 #
#########################
# SSP: SSP2
# Diet: EL2p0
# Waste: half
# Crop and Livestock productivity: high (SSP1?)
# Mitigation policies: current policies
# Land-use policies: current policies
# RCP/GCM: tba
# Trade: BAU-SSP2
cfg$title             <- "PHD_RCP4p5"
cfg                   <- gms::setScenario(cfg, c("SSP2", "NPI"))
# Diets: exogenous EATLancet diet
cfg$gms$s15_exo_diet  <- 1             # Note: switch to 3 once implementation is ready
cfg$gms$c15_kcal_scen <- "healthy_BMI"
cfg$gms$c15_EAT_scen  <- "FLX"
# Waste: half food waste
cfg$gms$s15_exo_waste  <- 1
cfg$gms$s15_waste_scen <- 1.2
start_run(cfg, codeCheck = FALSE)

#########################
# 3 Baseline PHD_MIT1p9 #
#########################
# SSP: SSP2
# Diet: EL2p0
# Waste: half
# Crop and Livestock productivity: high (SSP1?)
# Mitigation policies: 1.5 degrees
# Land-use policies: 1.5 degrees
# RCP/GCM: tba
# Trade: BAU-SSP2
cfg$title <- "PHD_MIT1p9"
cfg       <- gms::setScenario(cfg, c("SSP2", "NPI"))
# Diets: exogenous EATLancet diet
cfg$gms$s15_exo_diet  <- 1             # Note: switch to 3 once implementation is ready
cfg$gms$c15_kcal_scen <- "healthy_BMI"
cfg$gms$c15_EAT_scen  <- "FLX"
# Waste: half food waste
cfg$gms$s15_exo_waste  <- 1
cfg$gms$s15_waste_scen <- 1.2
# Mitigation
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg1300"
cfg$gms$c56_emis_policy      <- "sdp_all"
start_run(cfg, codeCheck = FALSE)
