# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: MESSAGE-MAgPIE Emulator SCP Price Setup
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

cfg$force_replace <- FALSE
cfg$qos <- "standby"

### Identifier and folder
###############################################
identifierFlag <- "SCP_23-11-28_BDPrice"
###############################################
cfg$info$flag <- identifierFlag
cfg$results_folder <- paste0("output/", identifierFlag, "/:title:")

### BE
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"

### GHG
gV <- c(0, 1000)

### Tau / Yield
cfg$gms$tc <- "exo"

### Biodiv
cfg$gms$biodiversity <- "bv_btc_mar21"
bdV <- c(0, 3000, 6000) #BII lower bound (0-1), default 0

### Food
mpV <- c(0, 76)


for (bd in bdV) {
  cfg$gms$s44_target_price <- bd

  for (mp in mpV) {
    preflag <- paste0("MP", str_pad(mp, 2, pad = "0"), "BD", str_pad(bd, 4, pad = "0"))
    cfg$results_folder <- paste("output", identifierFlag, ":title:", sep = "/")

    if (mp != 0){
      cfg$gms$c15_rumdairy_scp_scen <- paste0("MP", str_pad(mp, 2, pad = "0"))
    } else {
      cfg$gms$c15_rumdairy_scp_scen <- "constant"
    }

    for (g in gV) {
      g <- paste0("G", str_pad(g, 4, pad = "0"))
      cfg$gms$c56_pollutant_prices <- paste0(g, "exp2110")

      ##############################################
      cfg$title <- paste0(preflag, g)

      start_run(cfg, codeCheck = FALSE)

    } # GHG
  } # MP replacement
} # BII lower bound
