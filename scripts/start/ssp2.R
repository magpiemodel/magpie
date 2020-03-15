# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"

run_flag <- "F28_FH_"

cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"
cfg$gms$forestry  <- "dynamic_mar20"
cfg$gms$natveg  <- "dynamic_nov19"

# cfg$title <- "F12_devfull_timberOff"
# cfg$gms$timber <- "off"
# start_run(cfg,codeCheck=FALSE)
#
# cfg$title <- "F12_devfull_timberOn"
# cfg$gms$timber <- "biomass_feb20"
# start_run(cfg,codeCheck=FALSE)

#simple
cfg$gms$land <- "feb15"
cfg$gms$processing <- "off"
cfg$gms$disagg_lvst <- "off"
cfg$gms$maccs  <- "off_jul16"
cfg$gms$residues <- "off"
cfg$gms$s15_elastic_demand <- 0
#cfg$gms$c32_aff_policy <- "none"
cfg$gms$trade <- "selfsuff_forestry"
cfg$gms$c80_nlp_solver <- "conopt4"

# cfg$title <- "F12_simple_timberOff"
# cfg$gms$timber <- "off"
# start_run(cfg,codeCheck=FALSE)

cfg <- setScenario(cfg,c("SSP5","NPI"))
cfg$title <- paste0(run_flag,"TradeTest_SSP5_timberOn")
cfg$gms$timber <- "biomass_feb20"
cfg$gms$s15_elastic_demand <- 0
start_run(cfg,codeCheck=FALSE)

cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$title <- paste0(run_flag,"TradeTest_SSP2_timberOn")
cfg$gms$timber <- "biomass_feb20"
cfg$gms$s15_elastic_demand <- 0
start_run(cfg,codeCheck=FALSE)

# cfg <- setScenario(cfg,c("SSP2","NPI"))
# cfg$title <- paste0(run_flag,"simple_SSP2_timberOn_freeTrade")
# cfg$gms$timber <- "biomass_feb20"
# cfg$gms$trade <- "free_apr16"
# start_run(cfg,codeCheck=FALSE)
# 
# cfg <- setScenario(cfg,c("SSP5","NPI"))
# cfg$title <- paste0(run_flag,"simple_SSP5_timberOn_freeTrade")
# cfg$gms$timber <- "biomass_feb20"
# cfg$gms$trade <- "free_apr16"
# start_run(cfg,codeCheck=FALSE)
