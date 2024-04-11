# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test Biodiversity Prices
# ----------------------------------------------------------


######################################
#### Script to start a MAgPIE run ####
######################################

library(gms)
library(lucode2)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

cfg$results_folder <- "output/:title:"
cfg$output <- c("rds_report","extra/disaggregation")#"extra/highres"

prefix <- "BII07"

cfg$qos <- "priority"

ssp <- "SSP2"

for (price in c(0,100,1000,2000,3000)) {
  for (pol in c("Ref","Nature")) {
    if (pol == "Ref") {
      cfg <- setScenario(cfg,c(ssp,"NDC","rcp7p0"))
      cfg$gms$s44_target_price <- price
      cfg$gms$c35_protect_scenario <- "WDPA"
      cfg$gms$c30_snv_target <- "by2030"
      cfg$gms$s30_snv_shr <- 0
    } else if (pol == "Nature") {
      cfg <- setScenario(cfg,c(ssp,"NDC","rcp7p0"))
      cfg$gms$s44_target_price <- price
      cfg$gms$c35_protect_scenario <- "BH_IFL"
      cfg$gms$c30_snv_target <- "by2030"
      cfg$gms$s30_snv_shr <- 0.2
    }
    cfg$title <- paste(prefix,paste0(pol,"-BV",price),sep="_")
    start_run(cfg,codeCheck=FALSE)
  }
}
