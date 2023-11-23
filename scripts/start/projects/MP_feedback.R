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

#cfg$qos <- "standby"
cfg$qos <- "priority"

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public" = NULL,
                               "./patch_input" = NULL),
                           getOption("magpie_repos"))

#R11: a10a580c, R12: 26df900e
cfg$input <- c(regional    = "rev4.87_26df900e_magpie.tgz",
               cellular    = "rev4.87_26df900e_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
               validation  = "rev4.87_26df900e_validation.tgz",
               additional  = "additional_data_rev4.43.tgz",
               patch = "MMEmuR12_rev4.87.tgz")

cfg$force_replace <- FALSE

ssp <-  "SSP2"
cfg <- setScenario(cfg, c(ssp)) #load config presets

### Identifier and folder
###############################################
identifierFlag <- "SCP_23-10-11_set-36_exp2110"
f_flag <- ""
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


### GHG
cfg$gms$c56_mute_ghgprices_until <- "y2020"


### Tau / Yield
cfg$gms$c14_yields_scenario <- "nocc_hist"
cfg$gms$c13_tccost <- "high" #default: medium
cfg$gms$tc <- "exo" 


### Biodiv
cfg$gms$biodiversity <- "bii_target"
blV <- c(0) #BII lower bound (0-1), default 0
#0, 0.7, 0.74, 0.78
cfg$gms$s44_cost_bii_missing <- 10 * 1000000


### Cropland
cfg$gms$s30_annual_max_growth <- 0.02
#cfg$gms$s30_annual_max_growth <- 0.5

### Foresty
cfg$gms$s56_c_price_induced_aff <- 1
cfg$gms$s32_max_aff_cell_2025 <- 0.005
# def = inf # 0.005 = globally 1Mha Aff allowed in 2025 #nolint


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
   "BD", bd, "BI", str_pad(bl * 100, 2, pad = "0")
  )
  cfg$results_folder <- paste(
  # "output", identifierFlag, preflag, ":title:", sep = "/"
  "output", identifierFlag, ":title:", sep = "/"
  )
  
  #n <- paste("Feedback", preflag, sep = "_")
  n <- "Feedback_step13_400f"
  m <- n
  #cfg$gms$c60_2ndgen_biodem <- paste(n, f_flag, sep = "_")
  cfg$gms$c60_2ndgen_biodem <- n
  #cfg$gms$c56_pollutant_prices <- paste(n, f_flag, sep = "_")
  cfg$gms$c56_pollutant_prices <- m
  #cfg$gms$c56_pollutant_prices <- "Feedback_MP00BD1BI00_1000f_maxPrice"


  ##############################################
  #runflag <- paste("feedback", f_flag, sep = "_")
  runflag <- paste0(m, "") 

  cfg$title <- paste0(preflag, runflag)

  start_run(cfg, codeCheck = FALSE)


 } # MP replacement
} # BII lower bound
