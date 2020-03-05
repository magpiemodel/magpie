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

cfg$results_folder <- "output/:title:"

prefix <- "RMC01"

for (ssp in c("SDP","SSP1","SSP2","SSP5")) {
 for (pol in c("NPi","PkBudg900","PkBudg1100","PkBudg1300")) {
   if(ssp=="SDP" & pol=="PkBudg900") pol <- "PkBudg1000"
   getInput(paste0("/p/projects/piam/runs/coupled-magpie/output/C_",ssp,"-",pol,"-mag-4/fulldata.gdx"))
   cfg$title <- paste(prefix,ssp,pol,sep="-")
   cfg <- setScenario(cfg,c(ssp,if(pol=="NPi") "NPI" else "NDC"))
   cfg$gms$c56_pollutant_prices <- "coupling"
   cfg$gms$c60_2ndgen_biodem <- "coupling"
   start_run(cfg,codeCheck=FALSE)
 }
}

