# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test new lpjml version in magpie
# ----------------------------------------------------------

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# source default configuration
source("config/default.cfg")
title <- "LPJmL5_sep26"
cfg$recalibrate_landconversion_cost <- TRUE

#################
#### Default ####
#################
cfg$title <- paste0(title, "_Default")

# standard settings
cfg <- setScenario(cfg, c("cc", "SSP2", "NPI"))

start_run(cfg, codeCheck = FALSE)

#####################################
#### Different Climate Scenarios ####
#####################################
# rcp 1.9
cfg$title <- paste0(title, "_RCP1.9")

# standard settings
cfg <- setScenario(cfg, c("cc", "SSP2", "NPI", "rcp1p9"))

start_run(cfg, codeCheck = FALSE)

# rcp 2.6
cfg$title <- paste0(title, "_RCP2.6")

# standard settings
cfg <- setScenario(cfg, c("cc", "SSP2", "NPI", "rcp2p6"))

start_run(cfg, codeCheck = FALSE)

# rcp 4.5
cfg$title <- paste0(title, "_RCP4.5")

# standard settings
cfg <- setScenario(cfg, c("cc", "SSP2", "NPI", "rcp4p5"))

start_run(cfg, codeCheck = FALSE)

# rcp 6.0
cfg$title <- paste0(title, "_RCP6.0")

# standard settings
cfg <- setScenario(cfg, c("cc", "SSP2", "NPI", "rcp6p0"))

start_run(cfg, codeCheck = FALSE)

# rcp 7.0
cfg$title <- paste0(title, "_RCP7.0")

# standard settings
cfg <- setScenario(cfg, c("cc", "SSP2", "NPI", "rcp7p0"))

start_run(cfg, codeCheck = FALSE)

# rcp 8.5
cfg$title <- paste0(title, "_RCP8.5")

# standard settings
cfg <- setScenario(cfg, c("cc", "SSP2", "NPI", "rcp8p5"))

start_run(cfg, codeCheck = FALSE)

# overshoot 
cfg$title <- paste0(title, "_RCP3p4-overshoot")

# standard settings
cfg <- setScenario(cfg, c("cc", "SSP2", "NPI"))
input['cellular'] <- "rev4.134beier-2026-09-16T104204_h12_c5ad1e2c_cellularmagpie_c200_MRI-ESM2-0-ssp534-over_lpjml-501e8913.tgz"

start_run(cfg, codeCheck = FALSE)

######################
#### New Switches ####
######################

# set input back to default
input['cellular'] <- "rev4.134beier-2026-09-16T104204_h12_bb6334c1_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-501e8913.tgz"

# No growing period adaptation 
cfg$title <- paste0(title, "_Nogsadapt")

# standard settings
cfg <- setScenario(cfg, c("cc", "SSP2", "NPI", "rcp4p5"))
cfg$gms$s14_use_gsadapt <- 0
cfg$gms$s14_gsadapt2tau <- 0

start_run(cfg, codeCheck = FALSE)


# Growing period adaptation free of charge
cfg$title <- paste0(title, "_GsadaptFree")

# standard settings
cfg <- setScenario(cfg, c("cc", "SSP2", "NPI", "rcp4p5"))
cfg$gms$s14_use_gsadapt <- 1
cfg$gms$s14_gsadapt2tau <- 0

start_run(cfg, codeCheck = FALSE)


# Growing period adaptation with costs
cfg$title <- paste0(title, "_GsadaptAtTauCost")

# standard settings
cfg <- setScenario(cfg, c("cc", "SSP2", "NPI", "rcp4p5"))
cfg$gms$s14_use_gsadapt <- 1
cfg$gms$s14_gsadapt2tau <- 1

start_run(cfg, codeCheck = FALSE)



#######################################
#### climate impacts in SSP3 world ####
#######################################

# SSP3_Base
cfg$title <- paste0(title, "_SSP3_Base")

# standard settings
cfg <- setScenario(cfg, c("cc", "SSP2", "NPI", "rcp4p5"))
cfg <- setScenario(cfg, c("SSP3_Base"), scenario_config = "config/projects/scenario_config_impacts.csv")

start_run(cfg, codeCheck = FALSE)

# SSP3_GrowON
cfg$title <- paste0(title, "_SSP3_GrowON")

# standard settings
cfg <- setScenario(cfg, c("cc", "SSP2", "NPI", "rcp4p5"))
cfg <- setScenario(cfg, c("SSP3_GrowON"), scenario_config = "config/projects/scenario_config_impacts.csv")

start_run(cfg, codeCheck = FALSE)

# SSP3_IrrigON
cfg$title <- paste0(title, "_SSP3_IrrigON")

# standard settings
cfg <- setScenario(cfg, c("cc", "SSP2", "NPI", "rcp4p5"))
cfg <- setScenario(cfg, c("SSP3_IrrigON"), scenario_config = "config/projects/scenario_config_impacts.csv")

start_run(cfg, codeCheck = FALSE)

