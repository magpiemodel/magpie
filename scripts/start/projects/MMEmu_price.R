# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: MESSAGE-MAgPIE Emulator Debug Setup
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
source("config/default.cfg") #nolinter

cfg$qos <- "standby"

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public" = NULL,
                               "./patch_input" = NULL),
                           getOption("magpie_repos"))
cfg$input <- append(cfg$input, c(patch = "patch.tgz"))

cfg$output <- c("output_check", "rds_report")
cfg$force_replace <- TRUE

ssp <-  "SSP2"
cfg <- setScenario(cfg, c(ssp)) #load config presets

### Identifier and folder
###############################################
identifierFlag <- "Emulator_23-02-14_set-71"
###############################################
cfg$info$flag <- identifierFlag
cfg$results_folder <- paste0("output/", identifierFlag, "/:title:")

### BE 
cfg$gms$bioenergy <- "MMEmu_feb23"
# non-default BE demands
cfg$gms$c60_1stgen_biodem <- "phaseout2020"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-Npi-PhaseOut20"
cfg$gms$s60_2ndgen_bioenergy_dem_min_post_fix <- 0

# Subsidies / Prices
cfg$gms$c60_bioenergy_subsidy_fix_SSP2 <- 300
cfg$gms$c60_bioenergy_subsidy <- 0

beV <- c(0, 6, 8, 10, 12, 15, 25)

### GHG
cfg$gms$ghg_policy  <- "MMEmu_feb23"
cfg$gms$s56_ghgprice_startprice <- 0
cfg$gms$s56_ghgprice_endprice <- 0


### Tau / Yield
cfg$gms$c14_yields_scenario <- "nocc_hist"
cfg$gms$tc <- "exo"

### Biodiv
cfg$gms$c44_bii_decrease <- 0


### Cropland
cfg$gms$s30_annual_max_growth <- 0.02


us00_05 <- 1.1197 #src: https://data.worldbank.org/indicator/NY.GDP.DEFL.ZS?end=2005&locations=US&start=2000


for (be in beV){
    cfg$gms$s60_bioenergy_gj_price_1st <- be * us00_05
    cfg$gms$s60_bioenergy_price_2nd <- be * us00_05

    ##############################################
    runflag <- "price"
    cfg$title <- paste0(str_pad(be, 2, pad = "0"), "G0000", runflag)

    start_run(cfg, codeCheck = FALSE)


} #GHG
