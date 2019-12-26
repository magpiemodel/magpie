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

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"

for (ssp in c("SSP1","SSP2","SSP5")) {
  
  # cfg$title <- paste0("f_affore_",ssp,"_Budg600_jan19")
  # cfg <- setScenario(cfg,c(ssp,"NDC"))
  # cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
  # cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"
  # cfg$gms$ghg_policy  <- "price_jan19"
  # start_run(cfg,codeCheck=FALSE)
  
  cfg$title <- paste0("f_affore_",ssp,"_Budg600_ghgPol_jan20_land_feb15")
  cfg <- setScenario(cfg,c(ssp,"NDC"))
  cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
  cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"
  cfg$gms$ghg_policy  <- "price_jan20"
#  cfg$gms$s15_elastic_demand <- 0
#  cfg$gms$land <- "landmatrix_jan20"
  cfg$gms$land <- "feb15"
#  cfg$gms$s80_optfile <- 0
  
  start_run(cfg,codeCheck=FALSE)
}

