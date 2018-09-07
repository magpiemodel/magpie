# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
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

cfg$recalibrate <- TRUE
test <- c("foragebased_aug18","foragebased_sep18","simple_oct17")

for(i in (1:3)){
  cfg$title <- paste0("SSP2_REF_",test[i])
  cfg$gms$disagg_lvst <- test[i]
  cfg <- setScenario(cfg,c("SSP2","NPI"))
  cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
  cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
  start_run(cfg=cfg,codeCheck=FALSE)
}



