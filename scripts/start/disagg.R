# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
source("scripts/start_functions.R")
source("config/default.cfg")


test <- c("foragebased_aug18","simple_oct17","foragebased_sep18_nocalib","foragebased_sep18")

for(i in (1:4)){
  cfg$title <- paste0("SSP2_REF_",test[i])
  if(i==3) cfg$gms$disagg_lvst <- "foragebased_sep18"
  if(i==3) cfg$recalibrate <- FALSE
  cfg <- setScenario(cfg,c("SSP2","NPI"))
  cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-Ref-REMIND-MAGPIE"
  cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-Ref-REMIND-MAGPIE"
  start_run(cfg=cfg,codeCheck=FALSE)
  cfg$recalibrate <- TRUE
}



