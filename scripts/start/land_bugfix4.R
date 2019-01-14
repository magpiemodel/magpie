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
library(gdx)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
cfg$results_folder <- "output/:title:"
cfg$recalibrate <- FALSE

getInput <- function(gdx) {
  a <- readGDX(gdx,"f56_pollutant_prices_coupling")
  write.magpie(a,"modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3")
  a <- readGDX(gdx,"f60_bioenergy_dem_coupling")
  write.magpie(a,"modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv")
}

cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"

for (ssp in c("SSP1","SSP2","SSP3","SSP4","SSP5")) {
  cfg$title <- paste(ssp,"Base",sep="_")
  cfg <- setScenario(cfg,c(ssp,"NPI"))
  getInput("/p/projects/remind/runs/magpie_40-develop/output/r8239_coupled_Base-mag-9/fulldata.gdx")
  start_run(cfg,codeCheck=FALSE)
  
  cfg$title <- paste(ssp,"budg600",sep="_")
  cfg <- setScenario(cfg,c(ssp,"NDC"))
  getInput("/p/projects/remind/runs/magpie_40-develop/output/r8239_coupled_Budg600-mag-9/fulldata.gdx")
  start_run(cfg,codeCheck=FALSE)
  
  cfg$title <- paste(ssp,"budg950",sep="_")
  cfg <- setScenario(cfg,c(ssp,"NDC"))
  getInput("/p/projects/remind/runs/magpie_40-develop/output/r8239_coupled_Budg950-mag-9/fulldata.gdx")
  start_run(cfg,codeCheck=FALSE)
}

