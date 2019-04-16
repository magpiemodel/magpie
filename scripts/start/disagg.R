# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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
  cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
  cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
  start_run(cfg=cfg,codeCheck=FALSE)
  cfg$recalibrate <- TRUE
}



