# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: MESSAGE-MAgPIE Emulator SCP Tau Setup
# position: 1
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode2)
library(magclass)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R") #nolinter
source("config/mp_default.cfg") #nolinter

cfg$force_replace <- FALSE
cfg$qos <- "priority"

identifierFlag <- "SCP_23-11-27"

cfg$info$flag <- identifierFlag
cfg$results_folder <- paste0("output/", identifierFlag, "/:title:")

cfg$gms$c44_bii_decrease <- 0

cfg$gms$s60_2ndgen_bioenergy_dem_min_post_fix <- 0
cfg$gms$c60_bioenergy_subsidy <- 0

cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"

cfg$title <- "B00G0000_tau"

#start MAgPIE run
start_run(cfg, codeCheck = FALSE)