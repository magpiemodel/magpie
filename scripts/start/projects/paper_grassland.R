# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ------------------------------------------------
# description:
# ------------------------------------------------
library(gms)
# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run

for(reali in c("grasslands_mar22", "grasslands_feb22")){
  cfg="default.cfg"
  cfg$recalibrate <- TRUE
  cfg$recalibrate_landconversion_cost <- TRUE
  cfg$gms$past <- reali
  for(ssp_setting in c("SSP1","SSP2","SSP3","SSP4","SSP5")){
    if(ssp_setting != "SSP1") {
      cfg$recalibrate <- FALSE
      cfg$recalibrate_landconversion_cost <- FALSE
    }
    cfg <- setScenario(cfg,ssp_setting)
    cfg$title <- paste0("PR-",ssp_setting,"_",reali, substr(Sys.time(), 6,10),"-",gsub(":", "_", substr(Sys.time(), 12,16)))
    if(ssp_setting == "SSP1") {cfg$gms$c31_past_suit_scen  <- "ssp126"}
    if(ssp_setting == "SSP2") {cfg$gms$c31_past_suit_scen  <- "ssp126"}
    if(ssp_setting == "SSP3") {cfg$gms$c31_past_suit_scen  <- "ssp370"}
    if(ssp_setting == "SSP4") {cfg$gms$c31_past_suit_scen  <- "ssp585"}
    if(ssp_setting == "SSP5") {cfg$gms$c31_past_suit_scen  <- "ssp585"}
    start_run(cfg)
  }
}
