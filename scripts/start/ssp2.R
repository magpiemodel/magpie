# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
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

cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"

cfg$title <- "R2M41_SSP2_NPi_v5"
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c56_pollutant_prices_select <- "R2M41-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem_select <- "R2M41-SSP2-NPi"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "R2M41_SSP2_NDC_v5"
cfg <- setScenario(cfg,c("SSP2","NDC"))
cfg$gms$c56_pollutant_prices_select <- "R2M41-SSP2-NDC"
cfg$gms$c60_2ndgen_biodem_select <- "R2M41-SSP2-NDC"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "R2M41_SSP2_Budg600_v5"
cfg <- setScenario(cfg,c("SSP2","NDC"))
cfg$gms$c56_pollutant_prices_select <- "R2M41-SSP2-Budg600"
cfg$gms$c60_2ndgen_biodem_select <- "R2M41-SSP2-Budg600"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSPDB_SSP2_26_v5"
cfg <- setScenario(cfg,c("SSP2","NDC"))
cfg$gms$c56_pollutant_prices_select <- "SSPDB-SSP2-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem_select <- "SSPDB-SSP2-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)
