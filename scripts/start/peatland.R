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

#cfg$force_download <- TRUE

# cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp8p5-co2_rev34_c200_690d3718e151be1b450b394c1064b1c5.tgz",
#                "rev4.14_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
#                "rev4.14_690d3718e151be1b450b394c1064b1c5_validation.tgz",
#                "additional_data_rev3.68_FH.tgz",
#                "calibration_H12_c200_12Sep18.tgz",
#                "peatland_input_v1.tgz")
# cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,"/p/projects/landuse/users/florianh/data"=NULL),
#                            getOption("magpie_repos"))

cfg$gms$peatland  <- "on"
cfg$gms$c60_biodem_level <- 0
cfg$gms$s56_c_price_induced_aff <- 0
cfg$gms$s80_optfile <- 1
cfg$gms$c12_interest_rate <- "gdp_dependent"              # def = "gdp_dependent"
cfg$gms$c12_interest_rate_noselect <- "gdp_dependent"     # def = "gdp_dependent"

cfg$output <- c("rds_report","interpolation")

#prefix <- "T118"
#128 default
#129 lowcost
#130 old input files
#131 new input files with old spam file
#132 current input files low cost degrad
#133 current input files low cost degrad + no unused
#134 current input files low cost degrad + no unused + forestry
#135 current input files low cost degrad + no unused + GWP change
#T136 full set
#T137 full set no degrad cost
#T138 full set no transition costs

prefix <- "T138"

for (ssp in c("SSP1","SSP2","SSP3","SSP4","SSP5")) {
#for (ssp in c("SSP2")) {
  # cfg$gms$s58_degrad_cost_onetime  <- 0
  # cfg$gms$s58_degrad_cost_recur  <- 0
  pcost <- "default"
  #reset restor costs to default values
  cfg$gms$s58_rewet_cost_onetime  <- 7000
  cfg$gms$s58_rewet_cost_recur  <- 200
  
  #cfg$gms$tc <- "endo_jun18"
  #Ref
  cfg$title <- paste(prefix,ssp,"Ref",pcost,sep="_")
  cfg <- setScenario(cfg,c(ssp,"NPI"))
  #getInput("/p/projects/remind/runs/magpie4-2019-04-02-develop/output/r8473-trunk-C_NPi-mag-4/fulldata.gdx")
  cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-Ref-REMIND-MAGPIE"
  cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-Ref-REMIND-MAGPIE"
  cfg$gms$s15_elastic_demand <- 0
  cfg$gms$c12_interest_rate <- "gdp_dependent"              # def = "gdp_dependent"
  cfg$gms$c12_interest_rate_noselect <- "gdp_dependent"     # def = "gdp_dependent"
  
  cfg$gms$s56_peatland_policy <- 0
  cfg$gms$s58_rewetting_switch  <- 0
  start_run(cfg,codeCheck=FALSE)

  #Pol
  #getInput("/p/projects/remind/runs/magpie4-2019-04-02-develop/output/r8473-trunk-C_Budg600-mag-4/fulldata.gdx")
  cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-26-REMIND-MAGPIE"
  cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-26-REMIND-MAGPIE"
  cfg <- setScenario(cfg,c(ssp,"NDC"))
  cfg$gms$s15_elastic_demand <- 0
  cfg$gms$c12_interest_rate <- "gdp_dependent"              # def = "gdp_dependent"
  cfg$gms$c12_interest_rate_noselect <- "gdp_dependent"     # def = "gdp_dependent"
  
  cfg$title <- paste(prefix,ssp,"RCP2p6",pcost,sep="_")
  cfg$gms$s56_peatland_policy <- 0
  cfg$gms$s58_rewetting_switch  <- 0
  start_run(cfg,codeCheck=FALSE)

  # cfg$gms$tc <- "exo"
  # tau(paste0("output/",paste(prefix,ssp,"RCP2p6",pcost,sep="_"),"/fulldata.gdx"),"modules/13_tc/input/f13_tau_scenario.csv")
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
