# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: BEST project bioenergy runs
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################

version <- "V13"

library(lucode2)
library(magclass)
library(gdx2)
library(magpie4)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

### define functions

calc_bioen <- function(x) {
  #B0
  B0 <- new.magpie("GLO",seq(1995,2150,by=5),NULL,fill = 0)

  #B50
  #50 EJ in 2050 globally, linear interpolation
  B50 <- new.magpie("GLO",c(seq(1995,2020,by=5),2050,2100,2150),NULL,fill = 0)
  B50[,"y2050",] <- 50*1000
  B50[,"y2100",] <- 50/30*80*1000
  B50[,"y2150",] <- 50/30*80*1000#50/40*90
  B50 <- time_interpolate(B50,seq(2020,2050,by=5),TRUE)
  B50 <- time_interpolate(B50,seq(2050,2100,by=5),TRUE)
  B50 <- time_interpolate(B50,seq(2100,2150,by=5),TRUE)
  
  #B100
  #100 EJ in 2050 globally, linear interpolation
  B100 <- B50*2

  if (x == "B0") {
    return(B0)
  } else if (x == "B50") {
    return(B50)
  } else if (x == "B100") {
    return(B100)
  } else stop("Not defined")
}
calc_ghgprice <- function(x) {
  T0 <- read.magpie("modules/56_ghg_policy/input/f56_pollutant_prices.cs3")
  T0 <- collapseNames(T0[,,getNames(T0,dim=2)[1]])
  T0[,,] <- 0
  
  #T200 200 USD/tCO2 in 2050
  T200 <- new.magpie(getRegions(T0),c(seq(1995,2025,by=5),2050,2100,2150),getNames(T0),fill = 0)
  T200[,"y2025","co2_c"] <- 25
  T200[,"y2050","co2_c"] <- 200
  T200[,"y2100","co2_c"] <- 525
  T200[,"y2150","co2_c"] <- 525
  T200 <- time_interpolate(T200,seq(2015,2100,by=5),TRUE)
  T200 <- time_interpolate(T200,seq(2100,2150,by=5),TRUE)
  T200[,,"ch4"] <- T200[,,"co2_c"]*28
  T200[,,"n2o_n_direct"] <- T200[,,"co2_c"]*265*44/28
  T200[,,"n2o_n_indirect"] <- T200[,,"co2_c"]*265*44/28
  T200[,,"co2_c"] <- T200[,,"co2_c"]*44/12
  
  T40 <- T200*0.2
  
  if (x == "T0") {
    return(T0)
  } else if (x == "T40") {
    return(T40)
  } else if (x == "T200") {
    return(T200)
  } else stop("Not defined")
}

### source config
source("config/default.cfg")

# overall setup
cfg$force_replace <- TRUE
cfg$results_folder <- "output/:title:"
cfg$gms$c60_biodem_level <- 0.01
cfg$gms$c60_2ndgen_biodem <- "emulator"
cfg$gms$c56_pollutant_prices <- "emulator"


# define ssp scenarios
rcps <- c("rcp2p6","rcp6p0")
ssps <- c("SSP1","SSP2","SSP5")

# define setup for TAU Reference run
biodem <- "B0"
ghgprice <- "T0"
bioen_type <- "all"
bioen_water <- "all"
tau_scen <- paste(biodem,ghgprice,paste0("Type",toupper(bioen_type)),paste0("Water",toupper(bioen_water)),sep="-")

### start model runs with endogenous TAU
for (rcp in rcps) {
  for (ssp in ssps) {
    cfg$title <- paste("TAU",ssp,rcp,tau_scen,sep="-")
    cfg <- setScenario(cfg,c(ssp,"NPI",rcp))
    cfg$gms$s32_max_aff_area <- 0
    cfg$gms$s56_c_price_induced_aff <- 0
    cfg$gms$c30_bioen_type <- bioen_type
    cfg$gms$c30_bioen_water <- bioen_water
    cfg$gms$tc <- "endo_jan22"
    x <- try(modelstat(file.path("output",cfg$title,"fulldata.gdx")),silent = TRUE)
    if(any(!x %in% c(2,7))) {
      download_and_update(cfg)
      write.magpie(calc_bioen(biodem),"modules/60_bioenergy/input/glo.2ndgen_bioenergy_demand.csv")
      write.magpie(calc_ghgprice(ghgprice),"modules/56_ghg_policy/input/f56_pollutant_prices_emulator.cs3")
      start_run(cfg,codeCheck=FALSE)
      message(paste0("TAU run started: ",cfg$title))
    }
  }
}


### wait until model runs with endogenous TAU are finished, check is performed every 10 minutes
success <- FALSE
while (!success) {
  z <- NULL
  for (rcp in rcps) {
    for (ssp in ssps) {
      x <- try(modelstat(file.path("output",paste("TAU",ssp,rcp,tau_scen,sep="-"),"fulldata.gdx")),silent = TRUE)
      if (is(x, "try-error")) x <- NULL else if (is.magpie(x) & all(x %in% c(2,7))) x <- add_dimension(collapseNames(x),dim = 3.1,add = "scen",nm = paste0(ssp,rcp))
      z <- mbind(z,x)
    }
  }
  print(str(z))
  print(dim(z))
  if (is.null(z)) {
    message("Not any model run with endogenous TAU finished. Sleeping for 10 minutes.")
    Sys.sleep(60*10)
  } else if (dim(z)[3] < length(ssps) * length(rcps)) {
    message("At least on model run with endogenous TAU not yet finished. Sleeping for 10 minutes.")
    Sys.sleep(60*10)
  } else if (dim(z)[3] == length(ssps) * length(rcps)) {
    if (all(z %in% c(2,7))) success <- TRUE else stop("Modelstat different from 2 or 7 detected")
  }
}

### start model runs with exogenous TAU
message("Starting model runs with exogenous TAU")
for (rcp in rcps) {
  for (ssp in ssps) {
    for (biodem in c("B0","B50","B100")) {
      for (ghgprice in c("T0","T40","T200")) {
        for (bioen_type in c("all","begr","betr")) {
          for (bioen_water in c("all","rainfed")) {
            cfg <- setScenario(cfg,c(ssp,"NPI",rcp))
            cfg$title <- paste(version,ssp,rcp,biodem,ghgprice,paste0("Type",toupper(bioen_type)),paste0("Water",toupper(bioen_water)),sep="-")
            cfg$gms$s32_max_aff_area <- 0
            cfg$gms$s56_c_price_induced_aff <- 0
            cfg$gms$tc <- "exo"
            cfg$gms$c30_bioen_type <- bioen_type
            cfg$gms$c30_bioen_water <- bioen_water
            download_and_update(cfg)
            write.magpie(readGDX(file.path("output",paste("TAU",ssp,rcp,tau_scen,sep="-"),"fulldata.gdx"), "ov_tau", select=list(type="level")),"modules/13_tc/input/f13_tau_scenario.csv")
            write.magpie(calc_bioen(biodem),"modules/60_bioenergy/input/glo.2ndgen_bioenergy_demand.csv")
            write.magpie(calc_ghgprice(ghgprice),"modules/56_ghg_policy/input/f56_pollutant_prices_emulator.cs3")
            start_run(cfg,codeCheck=FALSE)
          }
        }
      }
    }
  }
}
