# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -------------------------------------------------------------
# description: test new gdp
# ------------------------------------------------------------

library(gms)
source("scripts/start_functions.R")
source("config/default.cfg")

cfg$title   = paste0("GDPupdate3_old")

start_run(cfg=cfg)

cfg$force_download <- TRUE
cfg$input <- c(cellular = "rev333_h12_80bd3d6f_cellularmagpie_c200_IPSL-CM6A-LR-ssp126_lpjml-066f36d1.tgz",
         regional = "rev333_h12_magpie_debug.tgz",
         validation  = "rev4.63_h12_validation.tgz",
         additional  = "additional_data_rev4.04.tgz",
         calibration = "calibration_H12_sticky_feb18_free_31Aug21.tgz")


cfg$recalibrate = TRUE
cfg$title   = paste0("GDPupdate3_new")

start_run(cfg=cfg)
