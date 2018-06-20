# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
cfg$results_folder <- "output/:title:"

#SSPs
for (ssp in c("SSP1","SSP2","SSP3","SSP4","SSP5")) {
  for (rcp in c("Ref","26")) {
    cfg <- setScenario(cfg,ssp)
    cfg$gms$c56_pollutant_prices <- paste(if(ssp %in% c("SSP3","SSP4")) "SSP2" else ssp,rcp,"SPA0",sep="-")
    cfg$gms$c60_2ndgen_biodem <- paste(if(ssp %in% c("SSP3","SSP4")) "SSP2" else ssp,rcp,"SPA0",sep="-")
    cfg$title <- paste(ssp,rcp,sep="_")
    start_run(cfg,codeCheck=FALSE)
  }
}
