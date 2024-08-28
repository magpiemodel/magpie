# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


# ----------------------------------------------------------
# description: uses bioenergy demand and GHG prices from REMIND as input for a run
# ----------------------------------------------------------

library(gms)
library(magclass)
library(gdx2)

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

prefix <- "RM01_"

cfg$title <- paste0(prefix,"SSP2_NPI")
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/SDP_runs/SDP_round1/magpie_SDP/output/C_SSP2-NPi-mag-4/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste0(prefix,"SSP2_PkBudg900")
cfg <- setScenario(cfg,c("SSP2","NDC"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/SDP_runs/SDP_round1/magpie_SDP/output/C_SSP2-PkBudg900-mag-4/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)
