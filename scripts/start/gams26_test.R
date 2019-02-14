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

cfg$title <- "SSP2_Base_GAMS26"
cfg <- setScenario(cfg,c("SSP2","NPI"))
getInput("/p/projects/remind/runs/magpie_40-develop/output/r8332_coupled_Base-mag-5/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP2_NDC_GAMS26"
cfg <- setScenario(cfg,c("SSP2","NDC"))
getInput("/p/projects/remind/runs/magpie_40-develop-2019-02-08/output/r8332_coupled_NDC-mag-5/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP2_budg600_GAMS26"
cfg <- setScenario(cfg,c("SSP2","NDC"))
getInput("/p/projects/remind/runs/magpie_40-develop-2019-02-08/output/r8332_coupled_Budg600-mag-5/fulldata.gdx")
start_run(cfg,codeCheck=FALSE)

