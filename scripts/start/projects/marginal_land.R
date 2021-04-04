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

source("scripts/start_functions.R")
source("scripts/performance_test.R")
source("config/default.cfg")

cfg$qos <- "priority"


# marginal land scenarios
marginalLandScen <- c("all_marginal", "half_marginal", "no_marginal" )

# Test different price levels

  for (marg in marginalLandScen) {

    # basic scenario setting
    cfg <- setScenario(cfg, c("SSP2", "NPI"))
    cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
    cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"

    #marginal land scenario
    cfg$gms$c30_marginal_land <- marg

    # Updating the title
    cfg$title = paste0("SSP2_NPI_",marg)

    # Start run
    start_run(cfg=cfg,codeCheck=TRUE)

  }



