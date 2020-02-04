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

prefix <- "C01_"

for (ssp in c("SSP1","SSP2","SSP5")) {
  
  cfg <- setScenario(cfg,c(ssp,"NDC"))
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$gms$c60_2ndgen_biodem <- "coupling"
  # cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-PkBudg900"
  # cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-PkBudg900"
  #  cfg$gms$s15_elastic_demand <- 0
#  cfg$gms$land <- "landmatrix_dec18"
  # cfg$gms$s80_maxiter <- 20
  #  cfg$gms$land <- "feb15"
  #  cfg$gms$s80_optfile <- 0
  
  getInput(paste0("/p/projects/piam/runs/coupled-magpie/output-20200129/C_",ssp,"-PkBudg900-mag-4/fulldata.gdx"))
  
  # cfg$title <- paste0(prefix,ssp,"_PkBudg900_natveg_old_BioTrade")
  # cfg$gms$c52_growth_par  <- "natveg_old"
  # start_run(cfg,codeCheck=FALSE)
  # 
  # cfg$title <- paste0(prefix,ssp,"_PkBudg900_natveg_new_BioTrade")
  # cfg$gms$c52_growth_par  <- "natveg"
  # start_run(cfg,codeCheck=FALSE)
  
  cfg$title <- paste0(prefix,ssp,"_PkBudg900_natveg_old_BioNoTrade")
  cfg$gms$c52_growth_par  <- "natveg_old"
  start_run(cfg,codeCheck=FALSE)

  cfg$title <- paste0(prefix,ssp,"_PkBudg900_natveg_new_BioNoTrade")
  cfg$gms$c52_growth_par  <- "natveg"
  start_run(cfg,codeCheck=FALSE)
}

