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

cfg$title <- "SSP2_Base_price_jan19"
cfg <- setScenario(cfg,c("SSP2","NPI"))
getInput("/p/projects/remind/runs/magpie_40-develop/output/r8239_coupled_Base-mag-9/fulldata.gdx")
cfg$gms$ghg_policy  <- "price_jan19"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP2_budg600_price_jan19"
cfg <- setScenario(cfg,c("SSP2","NDC"))
getInput("/p/projects/remind/runs/magpie_40-develop/output/r8239_coupled_Budg600-mag-9/fulldata.gdx")
cfg$gms$ghg_policy  <- "price_jan19"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP2_budg600_price_sep16"
cfg <- setScenario(cfg,c("SSP2","NDC"))
getInput("/p/projects/remind/runs/magpie_40-develop/output/r8239_coupled_Budg600-mag-9/fulldata.gdx")
cfg$gms$ghg_policy  <- "price_sep16"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP2_budg950_price_jan19"
cfg <- setScenario(cfg,c("SSP2","NDC"))
getInput("/p/projects/remind/runs/magpie_40-develop/output/r8239_coupled_Budg950-mag-9/fulldata.gdx")
cfg$gms$ghg_policy  <- "price_jan19"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP2_budg950_price_sep16"
cfg <- setScenario(cfg,c("SSP2","NDC"))
getInput("/p/projects/remind/runs/magpie_40-develop/output/r8239_coupled_Budg950-mag-9/fulldata.gdx")
cfg$gms$ghg_policy  <- "price_sep16"
start_run(cfg,codeCheck=FALSE)


# cfg$title <- "SSP2_budg600_price_dec18_dev25"
# cfg <- setScenario(cfg,c("SSP2","NDC"))
# getInput("/p/projects/remind/runs/magpie_40-develop/output/r8239_coupled_Budg600-mag-9/fulldata.gdx")
# cfg$gms$ghg_policy  <- "price_dec18"
# cfg$gms$s56_emis_pricing_dev_threshold <- 0.25
# start_run(cfg,codeCheck=FALSE)


# cfg$title <- "SSP1_budg600_devMultiPhaseIn5"
# cfg <- setScenario(cfg,c("SSP1","NDC"))
# getInput("/p/projects/remind/runs/magpie_40-develop/output/r8239_coupled_Budg600-mag-9/fulldata.gdx")
# cfg$gms$ghg_policy  <- "price_dec18"
# start_run(cfg,codeCheck=FALSE)
# 
# cfg$title <- "SSP2_budg600_devMultiPhaseIn5"
# cfg <- setScenario(cfg,c("SSP2","NDC"))
# getInput("/p/projects/remind/runs/magpie_40-develop/output/r8239_coupled_Budg600-mag-9/fulldata.gdx")
# cfg$gms$ghg_policy  <- "price_dec18"
# start_run(cfg,codeCheck=FALSE)
# 
# cfg$title <- "SSP3_budg600_devMultiPhaseIn5"
# cfg <- setScenario(cfg,c("SSP3","NDC"))
# getInput("/p/projects/remind/runs/magpie_40-develop/output/r8239_coupled_Budg600-mag-9/fulldata.gdx")
# cfg$gms$ghg_policy  <- "price_dec18"
# start_run(cfg,codeCheck=FALSE)
# 
# cfg$title <- "SSP4_budg600_devMultiPhaseIn5"
# cfg <- setScenario(cfg,c("SSP4","NDC"))
# getInput("/p/projects/remind/runs/magpie_40-develop/output/r8239_coupled_Budg600-mag-9/fulldata.gdx")
# cfg$gms$ghg_policy  <- "price_dec18"
# start_run(cfg,codeCheck=FALSE)
# 
# cfg$title <- "SSP5_budg600_devMultiPhaseIn5"
# cfg <- setScenario(cfg,c("SSP5","NDC"))
# getInput("/p/projects/remind/runs/magpie_40-develop/output/r8239_coupled_Budg600-mag-9/fulldata.gdx")
# cfg$gms$ghg_policy  <- "price_dec18"
# start_run(cfg,codeCheck=FALSE)
