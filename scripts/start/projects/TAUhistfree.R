# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: TAUhistfree
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

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"
cfg$output <- c("rds_report")

prefix <- "THF02"
cfg$qos <- "priority"

cfg$gms$s80_optfile <- 1
cfg$gms$s80_maxiter <- 30

# cfg$gms$s32_planing_horizon <- 100
# cfg$gms$c35_protect_scenario <- "WDPA"
# cfg$gms$c56_emis_policy <- "redd+_nosoil"

#ref
for (scen in c("REF","POL")) {
  if (scen == "REF") {
    cfg <- setScenario(cfg,c("SSP2","NPI"))
    cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
    cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"
  } else if (scen == "POL") {
    cfg <- setScenario(cfg,c("SSP2","NDC"))
    cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
    cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"
  }
  for (sec in c("Ag","AgF","AgFsecdini0")) {
    if (sec == "Ag") {
      cfg <- setScenario(cfg,c("ForestryOff"))
    } else if (sec == "AgF") {
      cfg <- setScenario(cfg,c("ForestryEndo"))
    } else if (sec == "AgFsecdini0") {
      cfg <- setScenario(cfg,c("ForestryEndo"))
      cfg$gms$s35_secdf_distribution <- 0
    }
    for (TC in c("TCfix","TCfree")) {
      if (TC == "TCfix") {
        cfg$gms$s13_tau_hist_lower_bound <- 1
      } else if (TC == "TCfree") {
        cfg$gms$s13_tau_hist_lower_bound <- 0
      }
      for (LC in c("LC888","LC881")) {
        if (LC == "LC888") {
          cfg$gms$s39_cost_establish_crop <- 8000
          cfg$gms$s39_cost_establish_past <- 8000
          cfg$gms$s39_cost_establish_forestry <- 8000
        } else if (LC == "LC881") {
          cfg$gms$s39_cost_establish_crop <- 8000
          cfg$gms$s39_cost_establish_past <- 8000
          cfg$gms$s39_cost_establish_forestry <- 1000
        }
        cfg$title <- paste(prefix,"SSP2",scen,sec,TC,LC,sep="_")
        start_run(cfg,codeCheck=FALSE)
      }
    }
  }
}
