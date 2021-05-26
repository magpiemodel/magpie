# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  a, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ------------------------------------------------------------
# description: test runs for new yield realization and data
# ------------------------------------------------------------

library(gms)
source("scripts/start_functions.R")
source("config/default.cfg")
source("scripts/start/extra/lpjml_addon.R")


cfg$title               <- "PRtest_default_lpjml5_mixed"
cfg$force_download      <- TRUE
cfg$recalibrate         <- TRUE 
start_run(cfg=cfg)
magpie4::submitCalibration("H12_newlpjml_bestcalib_fc-mixed_crop-endoJun13")

cfg$title               <- "PRtest_default_lpjml5_sticky_dynamic"
cfg$gms$factor_costs    <- "sticky_feb18"
cfg$gms$c38_sticky_mode <- "dynamic"
cfg$crop_calib_max      <- 2
start_run(cfg=cfg)
magpie4::submitCalibration("H12_newlpjml_bestcalib_fc-sticky-dynamic_crop-endoJun13")


cfg$title               <- "PRtest_default_lpjml5_sticky_free"
cfg$gms$factor_costs    <- "sticky_feb18"
cfg$gms$c38_sticky_mode <- "free"
cfg$crop_calib_max      <- 2
start_run(cfg=cfg)
magpie4::submitCalibration("H12_newlpjml_bestcalib_fc-sticky-free_crop-endoJun13")

