# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Food demand test
# ----------------------------------------------------------


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode2)
library(magclass)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE runs
source("config/default.cfg")

pollutant_prices <- function(price_ref=200, CH4_factor=1) {
  
  GWP100_CH4 <- 28
  GWP100_N2O <- 265
  CO2_C <- 44/12
  N2O_N <- 44/28
  growth_rate <- 0.05
  year_start <- 2020
  year_end <- 2100
  year_ref <- 2030
  #  price_ref <- 150
  
  a<-read.magpie("modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3")
  a[,,] <- 0
  
  for (y in seq(year_start,2150,by=5)) {
    if (y <= year_end) {
      a[,y,"co2_c"] <- price_ref*(1+growth_rate)^-(year_ref-y)*CO2_C
      a[,y,"ch4"] <- price_ref*(1+growth_rate)^-(year_ref-y)*GWP100_CH4*CH4_factor
      a[,y,c("n2o_n_direct","n2o_n_indirect")] <- price_ref*(1+growth_rate)^-(year_ref-y)*N2O_N*GWP100_N2O
    } else {
      a[,y,"ch4"] <- setYears(a[,year_end,"ch4"],y)
      a[,y,c("n2o_n_direct","n2o_n_indirect")] <- setYears(a[,year_end,c("n2o_n_direct","n2o_n_indirect")],y)
    }
  }
  write.magpie(a,"modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3")
}
pollutant_prices()
cfg$force_download <- FALSE

cfg$results_folder <- "output/:title:"
cfg$force_replace <- TRUE

cfg$output <- c("rds_report")

prefix <- "FT4"

cfg <- setScenario(cfg,c("SSP2","NDC"))
cfg$gms$s15_elastic_demand <- 1
#cfg$gms$c57_macc_version  <- "PBL_2019"   # def = PBL_2007

#cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"

cfg$title <- paste(prefix,"SSP2-PkBudg900_CH4N2Olim1000",sep = "_")
cfg$gms$s56_limit_ch4_n2o_price <- 1000   # def = 1000
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2-PkBudg900_CH4N2Onolim",sep = "_")
cfg$gms$s56_limit_ch4_n2o_price <- 90000000000000   # def = 1000
start_run(cfg,codeCheck=FALSE)
