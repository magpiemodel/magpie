# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: MESSAGE-MAgPIE Emulator SCP Demand Setup
# position: 1
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

cfg$force_replace <- TRUE
cfg$qos <- "standby"

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

### GHG
gV <- c(0, 10, 20, 50, 100, 200, 400, 600, 1000, 2000, 3000, 4000)

### Biodiv
blV <- c(0, 0.7, 0.74, 0.78) #BII lower bound (0-1), default 0

### Food
pV <- c(0, 20, 50, 76) #0, 20, 50, 76


for (bl in blV) {
  bd <- 0
  if (bl == 0) {
   bd <- 1
  }

  cfg$gms$c44_bii_decrease <- bd
  cfg$gms$s44_bii_lower_bound <- bl

  for (mp in mpV) {

    if (mp != 0){
      cfg$gms$c15_rumdairy_scp_scen <- paste0("MP", str_pad(mp, 2, pad = "0"))
    } else {
      cfg$gms$c15_rumdairy_scp_scen <- "constant"
    }

    preflag <- paste0("MP", str_pad(mp, 2, pad = "0"),
      "BI", str_pad(bl * 100, 2, pad = "0")
    )
    cfg$results_folder <- paste(
      "output", identifierFlag, preflag, ":title:", sep = "/"
    )

    for (be in beV) {

      be <- paste0("E", str_pad(be, 2, pad = "0"))
      cfg$gms$c60_2ndgen_biodem <- paste0(preflag, be)

      for (g in gV){

        g <- paste0("G", str_pad(g, 4, pad = "0"))

        #cfg$gms$c56_pollutant_prices <- g
        cfg$gms$c56_pollutant_prices <- paste0(g, "exp2110")

        ##############################################
        runflag <- "demand"

        cfg$title <- paste0(preflag, be, g, runflag)

        start_run(cfg, codeCheck = FALSE)

      } # GHG
    } # BE
  } # MP replacement
} # BII lower bound
