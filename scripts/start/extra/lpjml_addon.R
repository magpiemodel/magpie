# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------------
# description: Addon settings for new yield realization and data
# ---------------------------------------------------------------

library(gms)
source("scripts/start_functions.R")
source("config/default.cfg")



cfg$input <- c(cfg$input[grep("additional_data", cfg$input)],
               "rev4.59_h12_magpie.tgz",
               "rev4.59_h12_c5cdbf33_cellularmagpie_c200_GFDL-ESM4-ssp370_lpjml-47a77da3.tgz",
               "rev4.59_h12_validation.tgz")

cfg$title                            <- "default_lpjml5"
cfg$crop_calib_max                   <- 1.5
cfg$best_calib                       <- TRUE
cfg$gms$yields                       <- "managementcalib_aug19"
cfg$gms$s14_yld_past_switch          <- 0.25
cfg$gms$processing                   <- "substitution_may21"
cfg$gms$crop                         <- "endo_apr21"
cfg$gms$factor_cost                  <- "sticky_feb18"
cfg$gms$c41_initial_irrigation_area  <- "LUH2v2"
cfg                                  <- setScenario(cfg,"cc")

