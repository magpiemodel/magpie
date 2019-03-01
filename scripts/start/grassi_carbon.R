# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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
cfg$results_folder <- "output/:title:"
cfg$recalibrate <- FALSE

getInput <- function(gdx) {
  a <- readGDX(gdx,"f56_pollutant_prices_coupling")
  write.magpie(a,"modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3")
  a <- readGDX(gdx,"f60_bioenergy_dem_coupling")
  write.magpie(a,"modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv")
}

cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"

#SSP2 Ref noCC
cfg$title <- "SSP2_Ref_noCC_05"
cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp6p0-co2_rev34_c200_690d3718e151be1b450b394c1064b1c5.tgz",
               "rev4.14_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
               "rev4.14_690d3718e151be1b450b394c1064b1c5_validation.tgz",
               "additional_data_rev3.65.tgz",
               "calibration_H12_c200_12Sep18.tgz")
cfg$gms$land <- "dec18"
cfg <- setScenario(cfg,c("SSP2","NPI"))
getInput("/p/projects/remind/runs/magpie_40-develop-2019-02-25-macfix/output/r8375-C_Base-mag-10/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)

#SSP2 Ref CC
cfg$title <- "SSP2_Ref_CC_05"
cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp6p0-co2_rev34_c200_690d3718e151be1b450b394c1064b1c5.tgz",
               "rev4.14_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
               "rev4.14_690d3718e151be1b450b394c1064b1c5_validation.tgz",
               "additional_data_rev3.65.tgz",
               "calibration_H12_c200_12Sep18.tgz")
cfg$gms$land <- "dec18"
cfg <- setScenario(cfg,c("SSP2","NPI"))
getInput("/p/projects/remind/runs/magpie_40-develop-2019-02-25-macfix/output/r8375-C_Budg600-mag-10/fulldata.gdx")
cfg$gms$c14_yields_scenario  <- "cc"
cfg$gms$c42_watdem_scenario  <- "cc"
cfg$gms$c52_carbon_scenario  <- "cc"
cfg$gms$c59_som_scenario  <- "cc"
start_run(cfg,codeCheck=FALSE)

##SSP2 26 CC
cfg$title <- "SSP2_26_CC_05"
cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev34_c200_690d3718e151be1b450b394c1064b1c5.tgz",
               "rev4.14_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
               "rev4.14_690d3718e151be1b450b394c1064b1c5_validation.tgz",
               "additional_data_rev3.65.tgz",
               "calibration_H12_c200_12Sep18.tgz")
cfg$gms$land <- "dec18"
cfg <- setScenario(cfg,c("SSP2","NDC"))
getInput("/p/projects/remind/runs/magpie_40-develop-2019-02-25-macfix/output/r8375-C_Budg600-mag-10/fulldata.gdx")
cfg$gms$c14_yields_scenario  <- "cc"
cfg$gms$c42_watdem_scenario  <- "cc"
cfg$gms$c52_carbon_scenario  <- "cc"
cfg$gms$c59_som_scenario  <- "cc"
start_run(cfg,codeCheck=FALSE)
