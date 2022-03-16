# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ------------------------------------------------
# description: Runs for Pasture mangagement paper
# ------------------------------------------------
library(gms)
# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run

scenarios <- list(c("SSP1","rcp2p6"), c("SSP2","rcp4p5"), c("SSP3","rcp7p0"), c("SSP4","rcp6p0"), c("SSP5", "rcp8p5"))

for (ssp_setting in scenarios) {
  cfg="default.cfg"
  cfg <- setScenario(cfg,ssp_setting)
  if("SSP1" %in% ssp_setting) {
    cfg$recalibrate <- TRUE
    cfg$recalibrate_landconversion_cost <- TRUE
  } else {
    cfg$recalibrate <- FALSE
    cfg$recalibrate_landconversion_cost <- FALSE
  }
  cfg$gms$past <- "grasslands_mar22"
  cfg$title <- paste0("PR-",ssp_setting,"_", substr(Sys.time(), 6,10),"-",gsub(":", "_", substr(Sys.time(), 12,16)))
  start_run(cfg)
}
