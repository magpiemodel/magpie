# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ------------------------------------------------
# description: start run with Forestry (Endogenous)
# position: 6
# ------------------------------------------------


library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
#cfg$results_folder <- "output/:title:"

cfg <- setScenario(cfg,c("SSP2","NPI","ForestryEndo"))

run_flag <- "AFF01"

xx <- c()

for(c56_pollutant_prices in c("R2M41-SSP2-NPi","SSPDB-SSP2-26-REMIND-MAGPIE")){
  # Enable CO2 Pricing
  cfg$gms$c56_pollutant_prices <- c56_pollutant_prices
  cfg$gms$c60_2ndgen_biodem <- cfg$gms$c56_pollutant_prices

  for(s32_aff_plantation in c(0,1)){
    # Enable afforestation via plantation growth curve
    cfg$gms$s32_aff_plantation <- s32_aff_plantation

    #cfg <- setScenario(cfg,c("SSP2","NPI","ForestryExo"))
    #cfg <- setScenario(cfg,c("SSP2","NPI","ForestryOff"))

    if(cfg$gms$s32_aff_plantation == 1) aff_flag <- "AffPlant"
    if(cfg$gms$s32_aff_plantation == 0) aff_flag <- "AffNatVeg"

    if(cfg$gms$c56_pollutant_prices == "SSPDB-SSP2-26-REMIND-MAGPIE") {
      co2_flag = "CO2p"
      cfg <- setScenario(cfg,"NDC")
    }
    if(cfg$gms$c56_pollutant_prices == "R2M41-SSP2-NPi") {
      co2_flag = "Baseline"
      cfg <- setScenario(cfg,"NPI")
    }

    cfg$title <- paste0(run_flag,"_","ForestryEndo","_",co2_flag,"_",aff_flag)
    xx = c(xx,cfg$title)
    cfg$results_folder = "output/:title:"
    start_run(cfg,codeCheck=FALSE)
  }
}
