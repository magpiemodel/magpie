# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
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


# biodiversity scenarios
#bvPriceScen <- c("p0","p1_p10","p10_p100","p10_p10000")
bvPriceScen <- c("p0", "p10_p10000")

# Test different price levels

  for (pricelevel in bvPriceScen) {
     
    # basic scenario setting
    cfg <- setScenario(cfg, c("SSP2", "NPI"))
    cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
    cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"

    # biodiversity price
    cfg$gms$c44_price_bv_loss <- pricelevel

    # Updating the title
    cfg$title = paste0("SSP2_NPI_bv_",pricelevel)

    # Start run
    start_run(cfg=cfg,codeCheck=TRUE)

  }
}


