# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: MESSAGE-MAgPIE Emulator SCP Price Setup
# position: 5
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode2)
library(magclass)
library(gms)
library(stringr)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R") #nolinter
# Source the default config and then over-write it before starting the run.
source("config/mp_default.cfg") #nolinter

cfg$force_replace <- FALSE
cfg$qos <- "priority"

ssp <-  "SSP2"
cfg <- setScenario(cfg, c(ssp)) #load config presets

### Identifier and folder
###############################################
identifierFlag <- "SCP_23-11-22"
###############################################
cfg$info$flag <- identifierFlag
cfg$results_folder <- paste0("output/", identifierFlag, "/:title:")


### BE 
cfg$gms$s60_2ndgen_bioenergy_dem_min_post_fix <- 0
cfg$gms$c60_bioenergy_subsidy <- 0
beV <- c(0, 5, 7, 10, 15, 25, 45)

### Tau / Yield
cfg$gms$tc <- "exo"

### Biodiv
blV <- c(0, 0.7, 0.74, 0.78) #BII lower bound (0-1), default 0

### Food
mpV <- c(0, 30, 50, 76)


for (bl in blV) {
  bd <- 0
  if (bl == 0) {
    bd <- 1
  }

  cfg$gms$c44_bii_decrease <- bd
  cfg$gms$s44_bii_lower_bound <- bl

  for (mp in mpV) {
    preflag <- paste0("MP", str_pad(mp, 2, pad = "0"), "BI", str_pad(bl * 100, 2, pad = "0"))
    cfg$results_folder <- paste("output", identifierFlag, preflag, ":title:", sep = "/")

    if (mp != 0){
      cfg$gms$c15_rumdairy_scp_scen <- paste0("MP", str_pad(mp, 2, pad = "0"))
    } else {
      cfg$gms$c15_rumdairy_scp_scen <- "constant"
    }

    for (be in beV) {
      cfg$gms$s60_bioenergy_gj_price_1st <- be
      cfg$gms$s60_bioenergy_price_2nd <- be

      ##############################################
      runflag <- "price"
      cfg$title <- paste0(preflag, "E", str_pad(be, 2, pad = "0"), "G0000", runflag)

      start_run(cfg, codeCheck = FALSE)

    } # BE
  } # MP replacement
} # BII lower bound
