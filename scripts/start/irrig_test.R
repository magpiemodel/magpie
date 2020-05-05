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
library(magclass)
library(gdx)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"

getInput <- function(gdx,ghg_price=TRUE,biodem=TRUE) {
  if(ghg_price) {
    a <- readGDX(gdx,"f56_pollutant_prices_coupling")
    write.magpie(a,"modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3")
  }
  if(biodem) {
    a <- readGDX(gdx,"f60_bioenergy_dem_coupling")
    write.magpie(a,"modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv")
  }
}

cfg$title <- "IR1_SDP-NPI_GDP"
cfg <- setScenario(cfg,c("SDP","NPI"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/runs/coupled-magpie/output/C_SDP-NPi-mag-4/fulldata.gdx")
cfg$gms$s42_irrig_eff_scenario <- 3
start_run(cfg,codeCheck=FALSE)

cfg$title <- "IR1_SSP1-NPI_GDP"
cfg <- setScenario(cfg,c("SSP1","NPI"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/runs/coupled-magpie/output/C_SSP1-NPi-mag-4/fulldata.gdx")
cfg$gms$s42_irrig_eff_scenario <- 2
start_run(cfg,codeCheck=FALSE)

cfg$title <- "IR1_SSP2-NPI_GDP"
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/runs/coupled-magpie/output/C_SSP2-NPi-mag-4/fulldata.gdx")
cfg$gms$s42_irrig_eff_scenario <- 2
start_run(cfg,codeCheck=FALSE)

cfg$title <- "IR1_SSP5-NPI_GDP"
cfg <- setScenario(cfg,c("SSP5","NPI"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/runs/coupled-magpie/output/C_SSP5-NPi-mag-4/fulldata.gdx")
cfg$gms$s42_irrig_eff_scenario <- 2
start_run(cfg,codeCheck=FALSE)
