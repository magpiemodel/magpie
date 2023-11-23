# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: MESSAGE-MAgPIE Emulator Demand-Driven
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
source("config/default.cfg") #nolinter

cfg$qos <- "standby"
#cfg$qos <- "priority"

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public" = NULL,
                               "./patch_input" = NULL),
                           getOption("magpie_repos"))

#R11: a10a580c, R12: 26df900e
cfg$input <- c(regional    = "rev4.87_26df900e_magpie.tgz",
               cellular    = "rev4.87_26df900e_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
               validation  = "rev4.87_26df900e_validation.tgz",
               additional  = "additional_data_rev4.43.tgz",
               patch = "MMEmuR12_rev4.87.tgz")

cfg$force_replace <- TRUE

ssp <-  "SSP2"
cfg <- setScenario(cfg, c(ssp)) #load config presets

### Identifier and folder
###############################################
identifierFlag <- "SCP_23-10-11_set-36_exp2110"
#identifierFlag <-"23-09-11_forest-check"
###############################################
cfg$info$flag <- identifierFlag
cfg$results_folder <- paste0("output/", identifierFlag, "/:title:")

cfg$gms$c_timesteps <- "coup2110"

### BE 
cfg$gms$bioenergy <- "MMEmu_feb23"
# non-default BE demands
cfg$gms$c60_1stgen_biodem <- "phaseout2020"
cfg$gms$s60_2ndgen_bioenergy_dem_min_post_fix <- 0

# Subsidies / Prices
cfg$gms$c60_bioenergy_subsidy_fix_SSP2 <- 300
cfg$gms$c60_bioenergy_subsidy <- 0
cfg$gms$c60_price_implementation <- "lin"

cfg$gms$s60_bioenergy_gj_price_1st <- 0
cfg$gms$s60_bioenergy_price_2nd <- 0

#beV <- c(0, 5, 7, 10, 15, 25, 45)
beV <- c(10)

### GHG
cfg$gms$c56_mute_ghgprices_until <- "y2020"
#gV <- c(0, 10, 20, 50, 100, 200, 400, 600, 990, 2000, 3000, 4000)
#gV <- c(0, 10, 20, 21, 50, 100, 200, 400, 600, 990, 1000, 1990, 2000, 3000, 4000)
gV <-c (20)
#alternatives: 21, 1990


### Tau / Yield
cfg$gms$c14_yields_scenario <- "nocc_hist"
cfg$gms$c13_tccost <- "high" #default: medium


### Biodiv
cfg$gms$biodiversity <- "bii_target"
blV <- c(0) #BII lower bound in %(0-100), default 0
cfg$gms$s44_cost_bii_missing <- 10 * 1000000


### Cropland
cfg$gms$s30_annual_max_growth <- 0.02


### Foresty
cfg$gms$s56_c_price_induced_aff <- 1
cfg$gms$s32_max_aff_cell_2025 <- 0.005001 
#cfg$gms$s32_max_aff_cell_2025 <- 0.005001
# def = inf #0.005 = globally 1Mha Aff allowed in 2025


### Food
cfg$gms$food <- "anthropometrics_jan18"
cfg$gms$c20_scp_type <- "hydrogen"

mpV <- c(0) #0, 20, 50, 76


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
