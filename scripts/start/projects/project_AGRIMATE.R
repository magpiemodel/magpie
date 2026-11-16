# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: MAgPIE simulations for AGRIMATE
# ----------------------------------------------------------

###################################################
#### Script to start a MAgPIE run for AGRIMATE ####
###################################################

library(lucode2)
library(magclass)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# start MAgPIE runs
source("config/default.cfg")

cfg$force_download <- FALSE

cfg$results_folder <- "output/:title::date:"

###########################
### Different scenarios ###
###########################

# SSP2
cfg$title <- "SSP2"
# extract SSP2 settings from scenario config and activate climate change impacts
cfg <- gms::setScenario(cfg, c("cc", "SSP2"))
# switch on bilateral trade realization
cfg$gms <- "selfsuff_reduced_bilateral22"
start_run(cfg, codeCheck = FALSE)

# SSP3
cfg$title <- "SSP3"
# extract SSP3 settings from scenario config and activate climate change impacts
cfg <- gms::setScenario(cfg, c("cc", "SSP3"))
# switch on bilateral trade realization
cfg$gms <- "selfsuff_reduced_bilateral22"
start_run(cfg, codeCheck = FALSE)

