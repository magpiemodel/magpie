# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
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

cfg$force_download <- FALSE

cfg$results_folder <- "output/:title:"
cfg$force_replace <- TRUE
#cfg$results_folder <- "output/:title::date:"

cfg$output <- c("rds_report","projects/agmip_report","validation","extra/disaggregation")

prefix <- "V1"

#################################################################
# 1 Baseline SSP1-3 simulations "_NoMt_NoCC"                    #
#################################################################


cfg$title <- paste(prefix,"SSP2_RCPREF_C0000_REFDIET",sep = "_")
cfg <- gms::setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$s56_gwpstar <- 0
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2_RCPREF_C0000_LSPCUT")
cfg <- gms::setScenario(cfg,c("SSP2","NPI"))
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c15_livescen_target <- "lin_zero_20_70"
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$s56_gwpstar <- 0
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2_RCPREF_C0150_REFDIET")
cfg <- gms::setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$s56_gwpstar <- 0
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2_RCPREF_C0150_GWPSTAR_REFDIET")
cfg <- gms::setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$s56_gwpstar <- 1
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2_RCPREF_C0150_LSPCUT")
cfg <- gms::setScenario(cfg,c("SSP2","NPI"))
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c15_livescen_target <- "lin_zero_20_70"
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$s56_gwpstar <- 0
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"SSP2_RCPREF_C0150_GWPSTAR_LSPCUT")
cfg <- gms::setScenario(cfg,c("SSP2","NPI"))
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c15_livescen_target <- "lin_zero_20_70"
cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$s56_gwpstar <- 1
start_run(cfg,codeCheck=FALSE)

