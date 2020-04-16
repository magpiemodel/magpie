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

cfg$output <- c("rds_report")

cfg$gms$sm_fix_SSP2 <- 2020

cfg$title <- "val24_SDP_NPI"
cfg <- setScenario(cfg,c("SDP","NPI"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/runs/coupled-magpie/output/C_SDP-NPi-mag-4/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)

cfg$title <- "val24_SSP1_NPI"
cfg <- setScenario(cfg,c("SSP1","NPI"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/runs/coupled-magpie/output/C_SSP1-NPi-mag-4/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)

cfg$title <- "val24_SSP2_NPI"
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/runs/coupled-magpie/output/C_SSP2-NPi-mag-4/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)

cfg$title <- "val24_SSP5_NPI"
cfg <- setScenario(cfg,c("SSP5","NPI"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/runs/coupled-magpie/output/C_SSP5-NPi-mag-4/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)



cfg$title <- "val24_SDP_PkBudg1000"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/runs/coupled-magpie/output/C_SDP-PkBudg1000-mag-4/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)

cfg$title <- "val24_SSP1_PkBudg900"
cfg <- setScenario(cfg,c("SSP1","NDC"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/runs/coupled-magpie/output/C_SSP1-PkBudg900-mag-4/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)

cfg$title <- "val24_SSP2_PkBudg900"
cfg <- setScenario(cfg,c("SSP2","NDC"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/runs/coupled-magpie/output/C_SSP2-PkBudg900-mag-4/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)

cfg$title <- "val24_SSP5_PkBudg900"
cfg <- setScenario(cfg,c("SSP5","NDC"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/runs/coupled-magpie/output/C_SSP5-PkBudg900-mag-4/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)


