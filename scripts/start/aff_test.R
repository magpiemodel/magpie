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

for (ssp in c("SSP1","SSP2","SSP5")) {
  
  cfg <- setScenario(cfg,c(ssp,"NDC"))
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$gms$c60_2ndgen_biodem <- "coupling"
  # cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-PkBudg900"
  # cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-PkBudg900"
  #  cfg$gms$s15_elastic_demand <- 0
  cfg$gms$land <- "landmatrix_dec18"
  # cfg$gms$s80_maxiter <- 20
  #  cfg$gms$land <- "feb15"
  #  cfg$gms$s80_optfile <- 0
  
  getInput(paste0("/p/projects/piam/runs/coupled-magpie/output/coupled-remind_",ssp,"-PkBudg900-mag-4"))
  
  cfg$title <- paste0("aff5_",ssp,"_PkBudg900_cpricefuture_50%")
  cfg$gms$ghg_policy  <- "price_jan20"
  cfg$gms$s56_c_price_aff_future <- 1
  cfg$gms$s56_cprice_red_factor <- 0.5
  start_run(cfg,codeCheck=FALSE)
  
  cfg$title <- paste0("aff5_",ssp,"_PkBudg900_cpricepresent_50%")
  cfg$gms$ghg_policy  <- "price_jan20"
  cfg$gms$s56_c_price_aff_future <- 0
  cfg$gms$s56_cprice_red_factor <- 0.5
  start_run(cfg,codeCheck=FALSE)

  cfg$title <- paste0("aff5_",ssp,"_PkBudg900_cpricepresent_100%")
  cfg$gms$ghg_policy  <- "price_jan20"
  cfg$gms$s56_c_price_aff_future <- 0
  cfg$gms$s56_cprice_red_factor <- 1
  start_run(cfg,codeCheck=FALSE)
  
  cfg$title <- paste0("aff5_",ssp,"_PkBudg900_cpricepresent_100%_interest_7%")
  cfg$gms$ghg_policy  <- "price_jan20"
  cfg$gms$s56_c_price_aff_future <- 0
  cfg$gms$s56_cprice_red_factor <- 1
  cfg$gms$interest_rate <- "glo_jan16"  
  cfg$gms$c12_interest_rate <- "medium"
  start_run(cfg,codeCheck=FALSE)
  
  cfg$title <- paste0("aff5_",ssp,"_PkBudg900_cpricepresent_100%_interest_5%")
  cfg$gms$ghg_policy  <- "price_jan20"
  cfg$gms$s56_c_price_aff_future <- 0
  cfg$gms$s56_cprice_red_factor <- 1
  cfg$gms$interest_rate <- "glo_jan16"  
  cfg$gms$c12_interest_rate <- "coupling"
  start_run(cfg,codeCheck=FALSE)
  
  # cfg$title <- paste0("aff4_",ssp,"_PkBudg900_ghgPol_jan20growthrate_cpricepresent")
  # cfg$gms$ghg_policy  <- "price_jan20_growthrate"
  # cfg$gms$s56_c_price_aff_future <- 0
  # start_run(cfg,codeCheck=FALSE)

  
  # cfg$title <- paste0("aff4_",ssp,"_PkBudg900_ghgPol_jan20growthrate_cpricefuture")
  # cfg$gms$ghg_policy  <- "price_jan20_growthrate"
  # cfg$gms$s56_c_price_aff_future <- 1
  # start_run(cfg,codeCheck=FALSE)
  
  # cfg$title <- paste0("aff4_",ssp,"_PkBudg900_ghgPol_jan19")
  # cfg$gms$ghg_policy  <- "price_jan19"
  # start_run(cfg,codeCheck=FALSE)
  
}

