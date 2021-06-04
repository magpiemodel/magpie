# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


# ----------------------------------------------------------
# description: peatland dev
# ----------------------------------------------------------

library(gms)
library(magclass)
library(gdx)
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
cfg$gms$s58_rewetting_switch  <- Inf
cfg$gms$s80_optfile <- 1
cfg$gms$s80_maxiter <- 30
cfg$output <- c("rds_report")
#download_and_update(cfg)

prefix <- "PT37"

cfg$title <- paste(prefix,"SSP2","REF","PeatPolOffDefault",sep="_")
cfg <- setScenario(cfg,c("SSP2","NPI","ForestryEndo"))
cfg$gms$peatland  <- "on"
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"
cfg$gms$s56_peatland_policy <- 0
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2","1p5deg","PeatPolOnDefault",sep="_")
cfg <- setScenario(cfg,c("SSP2","NDC","ForestryEndo"))
cfg$gms$peatland  <- "on"
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"
cfg$gms$s56_peatland_policy <- 1
start_run(cfg,codeCheck=FALSE)


source("scripts/start/extra/lpjml_addon.R")

cfg$results_folder <- "output/:title:"
cfg$gms$s58_rewetting_switch  <- Inf
cfg$gms$s80_optfile <- 1
cfg$gms$s80_maxiter <- 30
cfg$output <- c("rds_report")
#download_and_update(cfg)

# cfg$title <- paste(prefix,"SSP2","REF","PeatOn2000",sep="_")
# cfg <- setScenario(cfg,c("SSP2","NPI","ForestryEndo"))
# cfg$gms$peatland  <- "on"
# cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"
# cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"
# cfg$gms$s56_peatland_policy <- 0
# cfg$gms$s58_cost_rewet_onetime <- 0
# cfg$gms$sm_fix_SSP2 <- 1995
# start_run(cfg,codeCheck=FALSE)
# cfg$gms$sm_fix_SSP2 <- 2020

#SSP2 REF

cfg$title <- paste(prefix,"SSP2","REF","PeatOnOld",sep="_")
cfg <- setScenario(cfg,c("SSP2","NPI","ForestryEndo"))
cfg$gms$peatland  <- "on_old"
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"
cfg$gms$s56_peatland_policy <- 0
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2","REF","PeatOnProtect",sep="_")
cfg <- setScenario(cfg,c("SSP2","NPI","ForestryEndo"))
cfg$gms$peatland  <- "on"
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"
cfg$gms$s56_peatland_policy <- 0
cfg$gms$s58_cost_degrad_onetime <- 10000
start_run(cfg,codeCheck=FALSE)


cfg$title <- paste(prefix,"SSP2","REF","PeatOnReward",sep="_")
cfg <- setScenario(cfg,c("SSP2","NPI","ForestryEndo"))
cfg$gms$peatland  <- "on"
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"
cfg$gms$s56_peatland_policy <- 0
cfg$gms$s58_cost_rewet_onetime <- -20000
cfg$gms$s58_cost_degrad_onetime <- 20000
start_run(cfg,codeCheck=FALSE)
cfg$gms$s58_cost_rewet_onetime <- 7000
cfg$gms$s58_cost_degrad_onetime <- 0

cfg$title <- paste(prefix,"SSP2","REF","PeatOn",sep="_")
cfg <- setScenario(cfg,c("SSP2","NPI","ForestryEndo"))
cfg$gms$peatland  <- "on"
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"
cfg$gms$s56_peatland_policy <- 0
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2","REF","PeatOff",sep="_")
cfg <- setScenario(cfg,c("SSP2","NPI","ForestryEndo"))
cfg$gms$peatland  <- "off"
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"
cfg$gms$s56_peatland_policy <- 0
start_run(cfg,codeCheck=FALSE)


#SSP2 POL
cfg$title <- paste(prefix,"SSP2","1p5deg","PeatPolOn",sep="_")
cfg <- setScenario(cfg,c("SSP2","NDC","ForestryEndo"))
cfg$gms$peatland  <- "on"
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"
cfg$gms$s56_peatland_policy <- 1
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2","1p5deg","PeatPolOff",sep="_")
cfg <- setScenario(cfg,c("SSP2","NDC","ForestryEndo"))
cfg$gms$peatland  <- "on"
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"
cfg$gms$s56_peatland_policy <- 0
start_run(cfg,codeCheck=FALSE)


#SDP POL
cfg$title <- paste(prefix,"SDP","1p5deg","PeatPolOn",sep="_")
cfg <- setScenario(cfg,c("SDP","NDC","ForestryEndo"))
cfg$gms$peatland  <- "on"
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"
cfg$gms$s56_peatland_policy <- 1
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SDP","1p5deg","PeatPolOff",sep="_")
cfg <- setScenario(cfg,c("SDP","NDC","ForestryEndo"))
cfg$gms$peatland  <- "on"
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"
cfg$gms$s56_peatland_policy <- 0
start_run(cfg,codeCheck=FALSE)

### SSP3
cfg$title <- paste(prefix,"SSP3","1p5deg","PeatPolOn",sep="_")
cfg <- setScenario(cfg,c("SSP3","NDC","ForestryEndo"))
cfg$gms$peatland  <- "on"
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"
cfg$gms$s56_peatland_policy <- 1
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP3","1p5deg","PeatPolOff",sep="_")
cfg <- setScenario(cfg,c("SSP3","NDC","ForestryEndo"))
cfg$gms$peatland  <- "on"
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"
cfg$gms$s56_peatland_policy <- 0
start_run(cfg,codeCheck=FALSE)
