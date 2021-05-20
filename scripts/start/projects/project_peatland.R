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

cfg$gms$peatland  <- "on_target"
cfg$gms$s58_rewetting_switch  <- Inf
cfg$gms$s80_optfile <- 1
cfg$gms$s80_maxiter <- 30
cfg$gms$s56_peatland_policy <- 0
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"
cfg <- setScenario(cfg,c("SSP2","NPI","ForestryEndo"))

cfg$output <- c("rds_report")
#download_and_update(cfg)

prefix <- "PT15"

#Ref
cfg$title <- paste(prefix,"SSP2","Ref",sep="_")
cfg$gms$s58_rewet_reward <- 0
start_run(cfg,codeCheck=FALSE)

#PeatRestor
cfg$title <- paste(prefix,"SSP2","Ref","PeatRestor",sep="_")
cfg$gms$s58_rewet_reward <- 30000
start_run(cfg,codeCheck=FALSE)
