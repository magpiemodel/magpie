# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: GENIE project MESSAGE-MAgPIE Emulator - Step 3 - ghg price sensitivity for step 2 biomass demands
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

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public" = NULL,
                                "./patch_input" = NULL),
                           getOption("magpie_repos"))

cfg$input <- c(regional    = "rev4.96_26df900e_magpie.tgz",
               cellular    = "rev4.96_26df900e_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
               validation  = "rev4.96_26df900e_validation.tgz",
               additional  = "additional_data_rev4.47.tgz",
               patch       = "MMEmuR12_rev4.96.tgz")


cfg$output <- c("output_check", "extra/disaggregation", "rds_report")

#load config presetswrite it before starting the run.
preset <-  "GENIE_SCP"
cfg <- setScenario(cfg, c(preset), scenario_config = "config/projects/scenario_config_genie.csv")

cfg$force_replace <- TRUE
cfg$qos <- "standby"

### Identifier and folder
###############################################
identifierFlag <- "SCP_24_02_29"
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
mpV <- c(0, 25, 50, 75)

### Forest
cfg$gms$s32_max_aff_cell_2025 <- 0.005


for (bl in blV) {
  bd <- 0
  pa <- "BH"
  if (bl == 0) {
    bd <- 1
    pa <- "none"
  }

  cfg$gms$c44_bii_decrease <- bd
  cfg$gms$s44_bii_lower_bound <- bl
  cfg$gms$c22_protect_scenario <- pa

  for (mp in mpV) {
    cfg$gms$s15_rumdairy_scp_substitution <- mp / 100

    preflag <- paste0("MP", str_pad(mp, 2, pad = "0"),
      "BI", str_pad(bl * 100, 2, pad = "0")
    )
    cfg$results_folder <- paste(
      "output", identifierFlag, preflag, ":title:", sep = "/"
    )
    cfg$info$flag2 <- preflag

    for (be in beV) {

      be <- paste0("E", str_pad(be, 2, pad = "0"))
      cfg$gms$c60_2ndgen_biodem <- paste0(preflag, be)

      for (g in gV){

        g <- paste0("G", str_pad(g, 4, pad = "0"))

        cfg$gms$c56_pollutant_prices <- paste0(g, "exp2110")

        ##############################################
        runflag <- "demand"

        cfg$title <- paste0(preflag, be, g, runflag)

        start_run(cfg, codeCheck = FALSE)

      } # GHG
    } # BE
  } # MP replacement
} # BII lower bound
