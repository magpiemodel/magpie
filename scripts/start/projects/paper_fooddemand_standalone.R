# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


# ----------------------------------------------------------
# description: Food Demand Paper simulations (overweight, underweight, food demand)
# ----------------------------------------------------------

#setwd("C:/Users/bodirsky/Desktop/articles/demand model/manuscript_from_starved_to_stuffed/magpie")

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# download supplementary data, if not yet available
if(!dir.exists("crossvalidation")) {
  dir.create("crossvalidation")
  download.file("http://rse.pik-potsdam.de/data/magpie/public/crossvalidation_trade_paper.tgz","crossvalidation/data.tgz")
  setwd("crossvalidation")
  untar("data.tgz")
  unlink("data.tgz")
  setwd("..")
}

#start MAgPIE run
source("config/default.cfg")
cfg$model                   <- "standalone/demand_model.gms"  
cfg$recalibrate             <- FALSE
cfg$gms$c_timesteps         <- "pastandfuture"
cfg$gms$s15_calibrate       <- 1
cfg$gms$s15_elastic_demand  <- 0

from  <- "crossvalidation/k_default/"
to    <- "modules/15_food/input/"

files <- list.files(from, pattern="*.*")
file.copy(from=paste0(from,files),to=to, overwrite=TRUE)

cfg$title <- "demand_ssp1"
cfg$gms$c09_pop_scenario  <- "SSP1"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP1"    # def = SSP2
start_run(cfg=cfg)

cfg$title <- "demand_ssp2"
cfg$gms$c09_pop_scenario  <- "SSP2"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP2"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)

cfg$title <- "demand_ssp3"
cfg$gms$c09_pop_scenario  <- "SSP3"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP3"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)

cfg$title <- "demand_ssp4"
cfg$gms$c09_pop_scenario  <- "SSP4"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP4"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)

cfg$title <- "demand_ssp5"
cfg$gms$c09_pop_scenario  <- "SSP5"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP5"    # def = SSP2
start_run(cfg=cfg,codeCheck = FALSE)

### k-fold cross validation for historical period

crossvalid <- c("k1","k2","k3","k4","k5","k_default")

### calib till 1975

cfg$gms$c_past <- "till_1975"
cfg$gms$c09_pop_scenario  <- "SSP2"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP2"    # def = SSP2

for (i in crossvalid){
  cfg$title <- paste0("demand_ssp2_calib1975_",i)
  from      <- paste0("crossvalidation/",i,"/")
  to        <- "modules/15_food/input/"
  files     <- list.files(from, pattern="*.*")
  file.copy(from=paste0(from,files),to = to, overwrite = TRUE)
  cat(paste0(from,files))
  start_run(cfg=cfg,codeCheck = FALSE)
}
### no calib

cfg$gms$s15_calibrate = 0

cfg$title <- "demand_ssp2_nocalib"
cfg$gms$c09_pop_scenario  <- "SSP2"    # def = SSP2
cfg$gms$c09_gdp_scenario  <- "SSP2"    # def = SSP2

for (i in crossvalid){
  cfg$title <- paste0("demand_ssp2_nocalib_",i)
  from <- paste0("crossvalidation/",i,"/")
  to <- "modules/15_food/input/"
  files <- list.files(from, pattern="*.*")
  file.copy(from=paste0(from,files),to = to, overwrite = TRUE)
  start_run(cfg=cfg,codeCheck = FALSE)
}

cfg$gms$s15_calibrate <- 1

cfg$gms$c_past <- "till_2010"
