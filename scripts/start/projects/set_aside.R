# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode2)
library(magclass)
library(magpie4)
library(gms)
library(stringr)

source("scripts/start_functions.R")
source("scripts/performance_test.R")
source("config/default.cfg")

cfg$qos <- "priority"


# set-aside scenarios
setAsideScen <- c(0, 0.1, 0.2, 0.3)
setAsideNames <- c("0per", "10per", "20per", "30per")
targetYear <- c("by2030", "by2050")

# Test different price levels
for (by in targetYear){
  for (s in 1:length(setAsideScen)) {

    # basic scenario setting
    cfg <- setScenario(cfg, c("SSP2", "NPI"))
    cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
    cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"

    # set aside share
    cfg$gms$s30_set_aside_shr <- setAsideScen[s]
    # target year
    cfg$gms$c30_set_aside_target <- by

    # Updating the title
    cfg$title = paste0("SSP2_NPI_set_aside_",setAsideNames[s],str_to_title(by))

    # Start run
    start_run(cfg=cfg,codeCheck=TRUE)

  }
}
