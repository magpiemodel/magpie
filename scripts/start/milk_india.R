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

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"

prefix <- "03_"

for (ssp in c("SSP1","SSP2","SSP5")) {
  
  cfg <- setScenario(cfg,c(ssp,"NPI"))
  # cfg$gms$c56_pollutant_prices <- paste0("R2M41-",ssp,"-NPi")
  # cfg$gms$c60_2ndgen_biodem <- paste0("R2M41-",ssp,"-NPi")

  #getInput(paste0("/p/projects/piam/runs/coupled-magpie/output/coupled-remind_",ssp,"-PkBudg900-mag-4/fulldata.gdx"))
  
  cfg$title <- paste0(prefix,ssp,"_NPI_milkInd50")
  cfg$gms$c15_milk_share_india <- "halving2050"
  start_run(cfg,codeCheck=FALSE)
  
  cfg$title <- paste0(prefix,ssp,"_NPI_milkInd100")
  cfg$gms$c15_milk_share_india <- "constant"
  start_run(cfg,codeCheck=FALSE)
  
}

