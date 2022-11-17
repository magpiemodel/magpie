# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -------------------------------------------------------------
# description: default run with new yield realization and data
# ------------------------------------------------------------

library(gms)
library(lucode2)

source("scripts/start_functions.R")
source("config/default.cfg")


cfg$title   <- paste0("BilatPR_OFF")
cfg$gms$trade <- "selfsuff_reduced"             # def = selfsuff_reduced

#start_run(cfg=cfg)

cfg$title   <- paste0("BilatPR_ON")
cfg$gms$trade <- "selfsuff_reduced_bilateral22"             # def = selfsuff_reduced

cfg$recalibrate = "ifneeded"
cfg$recalibrate_landconversion_cost <- "ifneeded"  #def "ifneeded"
cfg$force_download = TRUE

start_run(cfg=cfg)

