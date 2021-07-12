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

cfg$input <- c(cellular    = "rev4.62_h12_1b31a144_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-ab83aee4.tgz",
               regional    = "rev4.62_h12_magpie.tgz",
               validation  = "rev4.62_h12_validation.tgz",
               calibration = "calibration_H12_newlpjml_bestcalib_fc-sticky-free_crop-endoApr21_20May21.tgz",
               additional  = cfg$input[grep("additional_data", cfg$input)])
# see /p/projects/magpie/data/input/calibration for more available calibration factors

cfg$title                            <- "default_lpjml5"

# in case of recalibration, following settings should be applied
### cfg$recalibrate    <- TRUE
### cfg$force_download <- TRUE
cfg$crop_calib_max                   <- 1.5
cfg$best_calib                       <- TRUE


# preliminary test settings for new default 
# (including new yield, crop, factor cost realizations)
cfg$gms$yields                       <- "managementcalib_aug19"
cfg$gms$s14_yld_past_switch          <- 0.25
cfg$gms$processing                   <- "substitution_may21"
cfg$gms$crop                         <- "endo_apr21"
cfg$gms$factor_costs                 <- "sticky_feb18"
cfg$gms$c38_sticky_mode              <- "free" 
cfg$gms$landconversion               <- "devstate"
cfg$gms$c41_initial_irrigation_area  <- "LUH2v2"
cfg$gms$s80_optfile                  <- 1
cfg                                  <- setScenario(cfg,"cc")

