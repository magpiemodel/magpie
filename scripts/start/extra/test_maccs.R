# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test marginal abatement costs
# ----------------------------------------------------------


######################################
#### Script to start a MAgPIE run ####
######################################

library(gms)
library(lucode2)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

prefix <- "maccs_test_v6"

source("config/default.cfg")
cfg$title <- paste(prefix,"newsetup_baseline",sep="_")
cfg$gms$peatland  <- "on_aug22"
cfg$gms$nr_soil_budget  <- "macceff_aug22"
cfg$gms$nitrogen <- "rescaled_aug22"
cfg$gms$carbon <- "normal_aug22"
cfg$gms$methane <- "ipcc2006_aug22"
cfg$gms$ghg_policy <- "price_aug22"
cfg$gms$maccs <- "on_aug22"
cfg$gms$peatland <-"on_aug22"
start_run(cfg,codeCheck=FALSE)

source("config/default.cfg")
cfg$title <- paste(prefix,"newsetup_mitigation",sep="_")
cfg$gms$peatland  <- "on_aug22"
cfg$gms$nr_soil_budget  <- "macceff_aug22"
cfg$gms$nitrogen <- "rescaled_aug22"
cfg$gms$carbon <- "normal_aug22"
cfg$gms$methane <- "ipcc2006_aug22"
cfg$gms$ghg_policy <- "price_aug22"
cfg$gms$maccs <- "on_aug22"
cfg$gms$peatland <-"on_aug22"
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"     # def = R21M42-SSP2-NPi
cfg$gms$c56_pollutant_prices_noselect <- "R21M42-SSP2-PkBudg900"     # def = R21M42-SSP2-NPi
start_run(cfg,codeCheck=FALSE)

source("config/default.cfg")
cfg$title <- paste(prefix,"newsetup_maxmaccs",sep="_")
cfg$gms$peatland  <- "on_aug22"
cfg$gms$nr_soil_budget  <- "macceff_aug22"
cfg$gms$nitrogen <- "rescaled_aug22"
cfg$gms$carbon <- "normal_aug22"
cfg$gms$methane <- "ipcc2006_aug22"
cfg$gms$ghg_policy <- "price_aug22"
cfg$gms$maccs <- "on_aug22"
cfg$gms$peatland <-"on_aug22"
cfg$gms$s57_maxmac_n_soil  <- 1   # def = 0
cfg$gms$s57_maxmac_n_awms  <- 1   # def = 0
cfg$gms$s57_maxmac_ch4_rice   <- 1   # def = 0
cfg$gms$s57_maxmac_ch4_entferm <- 1   # def = 0
cfg$gms$s57_maxmac_ch4_awms  <- 1   # def = 0
start_run(cfg,codeCheck=FALSE)

source("config/default.cfg")
cfg$title <- paste(prefix,"olddefault",sep="_")
start_run(cfg,codeCheck=FALSE)

source("config/default.cfg")
cfg$title <- paste(prefix,"olddefault_mitigation",sep="_")
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"     # def = R21M42-SSP2-NPi
cfg$gms$c56_pollutant_prices_noselect <- "R21M42-SSP2-PkBudg900"     # def = R21M42-SSP2-NPi
start_run(cfg,codeCheck=FALSE)
