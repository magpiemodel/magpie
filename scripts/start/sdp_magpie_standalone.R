# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
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
library(magpie4)
library(gdx)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE runs
source("config/default.cfg")

cfg$force_download <- TRUE

#cfg$results_folder <- "output/:title:"
cfg$results_folder <- "output/:title::date:"




###################################################################################
#### Policy runs with bioenergy and CO2 prices from REMIND-MAgPIE coupled SDP-runs:

#For activating input files with data from coupled runs, the following switches have to be activated:
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"


# The following function generates the files 
# "f56_pollutant_prices_coupling.cs3" and
# "reg.2ndgen_bioenergy_demand.csv"
# that are required if switches "c56_pollutant_prices" and "c60_2ndgen_biodem"
# are se to "coupling":

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




##### last REMIND iteration: with new SDP standard setting "feb" and new default solver settings w.r.t. tolerances

cfg$title <- "SDP-PkBudg900-mag-3_solv_feb15"
cfg <- setScenario(cfg,c("SDP","NDC"))
getInput("/p/projects/piam/runs/magpie-isabelle/output/REMIND_SDP-PkBudg900-mag-3/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SDP-PkBudg1100-mag-2_solv_feb15"
cfg <- setScenario(cfg,c("SDP","NDC"))
getInput("/p/projects/piam/runs/magpie-isabelle/output/REMIND_SDP-PkBudg1100-mag-2/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)


cfg$title <- "SDP-PkBudg1300-mag-2_solv_feb15"
cfg <- setScenario(cfg,c("SDP","NDC"))
getInput("/p/projects/piam/runs/magpie-isabelle/output/REMIND_SDP-PkBudg1300-mag-2/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)


### SSP2 with policy with new SDP standard setting "feb" and new default solver settings w.r.t. tolerance

cfg$title <- "SSP2_26_SSP2DB_RM_solv_feb15"
cfg <- setScenario(cfg,c("SSP2","noSDP","NDC"))
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)







#reset:
# SSP2 with NPI policy is default:
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"



