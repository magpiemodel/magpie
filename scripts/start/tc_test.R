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
library(gdx)
library(luscale)

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

exp <- read.magpie("modules/13_tc/input/f13_tc_exponent.cs3")
exp[,getYears(exp,as.integer = T)<=2020,] <- setYears(exp[,1995,],NULL)
exp[,2050,] <- setYears(exp[,2100,],NULL)
exp <- time_interpolate(exp[,seq(2025,2045,by=5),,invert=T],interpolated_year = seq(2020,2050,by=5),integrate_interpolated_years = TRUE)
write.magpie(round(exp,2),"modules/13_tc/input/f13_tc_exponent.cs3")

fac <- read.magpie("modules/13_tc/input/f13_tc_factor.cs3")
fac[,getYears(fac,as.integer = T)<=2020,] <- setYears(fac[,1995,],NULL)
fac[,2050,] <- setYears(fac[,2100,],NULL)
fac <- time_interpolate(fac[,seq(2025,2045,by=5),,invert=T],interpolated_year = seq(2020,2050,by=5),integrate_interpolated_years = TRUE)
write.magpie(round(fac),"modules/13_tc/input/f13_tc_factor.cs3")

# cfg$title <- "TC3_SDP"
# cfg <- setScenario(cfg,c("SDP","NPI"))
# cfg$gms$c56_pollutant_prices <- "coupling"
# cfg$gms$c60_2ndgen_biodem <- "coupling"
# getInput("/p/projects/piam/runs/coupled-magpie/output/C_SDP-NPi-mag-4/fulldata.gdx")
# cfg$gms$c13_tccost <- "medium"
# start_run(cfg,codeCheck=FALSE)

cfg$title <- "TC3_SDP_lowCost_2050"
cfg <- setScenario(cfg,c("SDP","NPI"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/runs/coupled-magpie/output/C_SDP-NPi-mag-4/fulldata.gdx")
cfg$gms$c13_tccost <- "low"
start_run(cfg,codeCheck=FALSE)

# cfg$title <- "TC3_SSP1"
# cfg <- setScenario(cfg,c("SSP1","NPI"))
# cfg$gms$c56_pollutant_prices <- "coupling"
# cfg$gms$c60_2ndgen_biodem <- "coupling"
# getInput("/p/projects/piam/runs/coupled-magpie/output/C_SSP1-NPi-mag-4/fulldata.gdx")
# cfg$gms$c13_tccost <- "medium"
# start_run(cfg,codeCheck=FALSE)

cfg$title <- "TC3_SSP1_lowCost_2050"
cfg <- setScenario(cfg,c("SSP1","NPI"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/runs/coupled-magpie/output/C_SSP1-NPi-mag-4/fulldata.gdx")
cfg$gms$c13_tccost <- "low"
start_run(cfg,codeCheck=FALSE)

# cfg$title <- "TC3_SSP2-NPI"
# cfg <- setScenario(cfg,c("SSP2","NPI"))
# cfg$gms$c56_pollutant_prices <- "coupling"
# cfg$gms$c60_2ndgen_biodem <- "coupling"
# getInput("/p/projects/piam/runs/coupled-magpie/output/C_SSP2-NPi-mag-4/fulldata.gdx")
# cfg$gms$c13_tccost <- "medium"
# start_run(cfg,codeCheck=FALSE)

# cfg$title <- "TC3_SSP2-NPI_moreTrade"
# cfg <- setScenario(cfg,c("SSP2","NPI"))
# cfg$gms$c56_pollutant_prices <- "coupling"
# cfg$gms$c60_2ndgen_biodem <- "coupling"
# getInput("/p/projects/piam/runs/coupled-magpie/output/C_SSP2-NPi-mag-4/fulldata.gdx")
# cfg$gms$c13_tccost <- "medium"
# cfg$gms$c21_trade_liberalization  <- "l908080r807070"
# start_run(cfg,codeCheck=FALSE)

# cfg$title <- "TC3_SSP5"
# cfg <- setScenario(cfg,c("SSP5","NPI"))
# cfg$gms$c56_pollutant_prices <- "coupling"
# cfg$gms$c60_2ndgen_biodem <- "coupling"
# getInput("/p/projects/piam/runs/coupled-magpie/output/C_SSP5-NPi-mag-4/fulldata.gdx")
# cfg$gms$c13_tccost <- "medium"
# start_run(cfg,codeCheck=FALSE)

cfg$title <- "TC3_SSP5_lowCost_2050"
cfg <- setScenario(cfg,c("SSP5","NPI"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
getInput("/p/projects/piam/runs/coupled-magpie/output/C_SSP5-NPi-mag-4/fulldata.gdx")
cfg$gms$c13_tccost <- "low"
start_run(cfg,codeCheck=FALSE)
