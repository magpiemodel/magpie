# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: AgMIP GWPstar runs
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

pollutant_prices <- function(price_ref=0, CH4_factor=1) {
  
  GWP100_CH4 <- 25
  GWP100_N2O <- 265
  CO2_C <- 44/12
  N2O_N <- 44/28
  growth_rate <- 0.05
  year_start <- 2015
  year_end <- 2100
  year_ref <- 2070
  #  price_ref <- 150
  
  a<-read.magpie("modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3")
  a[,,] <- 0
  
  for (y in seq(year_start,2150,by=5)) {
    if (y <= year_end) {
      a[,y,"ch4"] <- price_ref*(1+growth_rate)^-(year_ref-y)*GWP100_CH4*CH4_factor
      a[,y,c("n2o_n_direct","n2o_n_indirect")] <- price_ref*(1+growth_rate)^-(year_ref-y)*N2O_N*GWP100_N2O
    } else {
      a[,y,"ch4"] <- setYears(a[,year_end,"ch4"],y)
      a[,y,c("n2o_n_direct","n2o_n_indirect")] <- setYears(a[,year_end,c("n2o_n_direct","n2o_n_indirect")],y)
    }
  }
  write.magpie(a,"modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3")
}

cfg$force_download <- FALSE

cfg$results_folder <- "output/:title:"
cfg$force_replace <- TRUE
#cfg$results_folder <- "output/:title::date:"

cfg$output <- c("rds_report","projects/agmip_report","validation","extra/disaggregation")

prefix <- "V15"

cfg$gms$c_timesteps <- "5year2070"

cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c57_macc_version  <- "PBL_2019"   # def = PBL_2007
cfg$gms$s56_limit_ch4_n2o_price <- 4000   # def = 1000
cfg$gms$c56_pollutant_prices <- "coupling"

cfg$gms$s15_livescen_target_subst <- 0

cfg$title <- paste(prefix,"SSP2_RCPREF_CP0000_REFDIET",sep = "_")
cfg$gms$c15_livescen_target <- "constant"
pollutant_prices(price_ref = 0,CH4_factor = 1)
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2_RCPREF_CP0150_REFDIET",sep = "_")
cfg$gms$c15_livescen_target <- "constant"
pollutant_prices(price_ref = 150,CH4_factor = 1)
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2_RCPREF_CP0150STARF_REFDIET",sep = "_")
cfg$gms$c15_livescen_target <- "constant"
pollutant_prices(price_ref = 150,CH4_factor = 0.25)
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2_RCPREF_CP0150STARM_REFDIET",sep = "_")
cfg$gms$c15_livescen_target <- "constant"
pollutant_prices(price_ref = 150,CH4_factor = 4)
start_run(cfg,codeCheck=FALSE)


cfg$title <- paste(prefix,"SSP2_RCPREF_CP0500_REFDIET",sep = "_")
cfg$gms$c15_livescen_target <- "constant"
pollutant_prices(price_ref = 500,CH4_factor = 1)
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2_RCPREF_CP0500STARF_REFDIET",sep = "_")
cfg$gms$c15_livescen_target <- "constant"
pollutant_prices(price_ref = 500,CH4_factor = 0.25)
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2_RCPREF_CP0500STARM_REFDIET",sep = "_")
cfg$gms$c15_livescen_target <- "constant"
pollutant_prices(price_ref = 500,CH4_factor = 4)
start_run(cfg,codeCheck=FALSE)


cfg$title <- paste(prefix,"SSP2_RCPREF_CP0000_LSPCUT",sep = "_")
cfg$gms$c15_livescen_target <- "lin_zero_20_70"
pollutant_prices(price_ref = 0,CH4_factor = 1)
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2_RCPREF_CP0150_LSPCUT",sep = "_")
cfg$gms$c15_livescen_target <- "lin_zero_20_70"
pollutant_prices(price_ref = 150,CH4_factor = 1)
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2_RCPREF_CP0150STARF_LSPCUT",sep = "_")
cfg$gms$c15_livescen_target <- "lin_zero_20_70"
pollutant_prices(price_ref = 150,CH4_factor = 0.25)
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2_RCPREF_CP0150STARM_LSPCUT",sep = "_")
cfg$gms$c15_livescen_target <- "lin_zero_20_70"
pollutant_prices(price_ref = 150,CH4_factor = 4)
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2_RCPREF_CP0500_LSPCUT",sep = "_")
cfg$gms$c15_livescen_target <- "lin_zero_20_70"
pollutant_prices(price_ref = 500,CH4_factor = 1)
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2_RCPREF_CP0500STARF_LSPCUT",sep = "_")
cfg$gms$c15_livescen_target <- "lin_zero_20_70"
pollutant_prices(price_ref = 500,CH4_factor = 0.25)
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2_RCPREF_CP0500STARM_LSPCUT",sep = "_")
cfg$gms$c15_livescen_target <- "lin_zero_20_70"
pollutant_prices(price_ref = 500,CH4_factor = 4)
start_run(cfg,codeCheck=FALSE)
