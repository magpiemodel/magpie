# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


# ----------------------------------------------------------
# description: runs for peatland paper (might be useful as draft for other papers/projects)
# ----------------------------------------------------------

library(gms)
library(magclass)
library(gdx2)
library(luscale)
library(magpie4)

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

cfg$gms$peatland  <- "on"
cfg$gms$c60_biodem_level <- 0
cfg$gms$s56_c_price_induced_aff <- 0
cfg$gms$s80_optfile <- 1

cfg$output <- c("rds_report")
download_and_update(cfg)

#T141 full set final SSPDB bugfix + highres
prefix <- "T143"

for (ssp in c("SSP1","SSP2","SSP3","SSP4","SSP5")) {
#for (ssp in c("SSP2")) {
  pcost <- "default"
  #reset restor costs to default values
  cfg$gms$s58_rewet_cost_onetime  <- 7000
  cfg$gms$s58_rewet_cost_recur  <- 200

  #Ref
  cfg$title <- paste(prefix,ssp,"Ref",pcost,sep="_")
  cfg <- setScenario(cfg,c(ssp,"NPI"))
  #getInput("/p/projects/remind/runs/magpie4-2019-04-02-develop/output/r8473-trunk-C_NPi-mag-4/fulldata.gdx")
  cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-Ref-REMIND-MAGPIE"
  cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-Ref-REMIND-MAGPIE"
  cfg$gms$s15_elastic_demand <- 1
  cfg$gms$c12_interest_rate <- "gdp_dependent"              # def = "gdp_dependent"

  cfg$gms$s56_peatland_policy <- 0
  cfg$gms$s58_rewetting_switch  <- 0
  start_run(cfg,codeCheck=FALSE)

  #Pol
  #getInput("/p/projects/remind/runs/magpie4-2019-04-02-develop/output/r8473-trunk-C_Budg600-mag-4/fulldata.gdx")
  cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-26-REMIND-MAGPIE"
  cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-26-REMIND-MAGPIE"
  cfg <- setScenario(cfg,c(ssp,"NDC"))
  cfg$gms$s15_elastic_demand <- 1
  cfg$gms$c12_interest_rate <- "gdp_dependent"              # def = "gdp_dependent"

  cfg$title <- paste(prefix,ssp,"RCP2p6",pcost,sep="_")
  cfg$gms$s56_peatland_policy <- 0
  cfg$gms$s58_rewetting_switch  <- 0
  start_run(cfg,codeCheck=FALSE)

  cfg$title <- paste(prefix,ssp,"RCP2p6+PeatProt",pcost,sep="_")
  cfg$gms$s56_peatland_policy <- 1
  cfg$gms$s58_rewetting_switch  <- 0
  start_run(cfg,codeCheck=FALSE)

  cfg$title <- paste(prefix,ssp,"RCP2p6+PeatRestor",pcost,sep="_")
  cfg$gms$s56_peatland_policy <- 1
  cfg$gms$s58_rewetting_switch  <- Inf
  start_run(cfg,codeCheck=FALSE)

  for (pcost in c("low","medium","high")) {
    if (pcost == "low") {
      cfg$gms$s58_rewet_cost_onetime  <- 875
      cfg$gms$s58_rewet_cost_recur  <- 25
    } else if (pcost == "medium") {
      cfg$gms$s58_rewet_cost_onetime  <- 7000
      cfg$gms$s58_rewet_cost_recur  <- 200
    } else if (pcost == "high") {
      cfg$gms$s58_rewet_cost_onetime  <- 14000
      cfg$gms$s58_rewet_cost_recur  <- 400
    }
    cfg$title <- paste(prefix,ssp,"RCP2p6+PeatRestor",pcost,sep="_")
    cfg$gms$s56_peatland_policy <- 1
    cfg$gms$s58_rewetting_switch  <- Inf
    start_run(cfg,codeCheck=FALSE)
  }
}
