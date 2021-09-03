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

cfg$title   = paste0("GDPupdate_old")

start_run(cfg=cfg)

cfg$force_download <- TRUE
cfg$input <- c(cellular = "rev333_h12_80bd3d6f_cellularmagpie_c200_IPSL-CM6A-LR-ssp126_lpjml-066f36d1.tgz",
         regional = "rev333_h12_magpie_debug.tgz",
         validation = "rev4.58_h12_validation.tgz",
         calibration = "calibration_H12_c200_23Feb21.tgz",
         additional = "additional_data_rev4.04.tgz",
         patch = "patch_land_iso.tgz",
         patch2 = "gmd-2021-76_patch.tgz")


cfg$title   = paste0("GDPupdate_new")

start_run(cfg=cfg)
