# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
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

#start MAgPIE run
source("config/default.cfg")

#cfg$force_download <- FALSE

cfg$results_folder <- "output/:title:"

#06 bug pasture production
#07 bugfix pasture production
#08 Update from Edna
#09 bugfix aff
#10 recalc npi
#13 final test

prefix <- "C14_"

for (ssp in c("SDP","SSP1","SSP2","SSP5")) {

  getInput(paste0("/p/projects/piam/runs/coupled-magpie/output-20200129/C_",ssp,"-Base-mag-4/fulldata.gdx"))
  cfg <- setScenario(cfg,c(ssp,"NPI"))
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$gms$c60_2ndgen_biodem <- "coupling"
  cfg$title <- paste0(prefix,ssp,"_NPI")
  start_run(cfg,codeCheck=FALSE)
  
  getInput(paste0("/p/projects/piam/runs/coupled-magpie/output-20200129/C_",ssp,"-PkBudg900-mag-4/fulldata.gdx"))
  cfg <- setScenario(cfg,c(ssp,"NDC"))
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$gms$c60_2ndgen_biodem <- "coupling"
  cfg$title <- paste0(prefix,ssp,"_PkBudg900_plantations")
  start_run(cfg,codeCheck=FALSE)
}

