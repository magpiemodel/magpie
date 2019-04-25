# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see CITATION.cff file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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

cfg$results_folder <- "output/:title:"

cfg$title <- "R2M41_SSP2_NPi"
setScenario(cfg,"SSP2","NPI")
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "R2M41_SSP2_Budg600"
setScenario(cfg,"SSP2","NDC")
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSPDB_SSP2_26"
setScenario(cfg,"SSP2","NDC")
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)
