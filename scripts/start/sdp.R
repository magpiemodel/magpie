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

#start MAgPIE runs
source("config/default.cfg")

cfg$force_download <- TRUE

#cfg$results_folder <- "output/:title:"
cfg$results_folder <- "output/:title::date:"


cfg$title <- "R2M41_SDP"
cfg <- setScenario(cfg,c("SDP"))
start_run(cfg,codeCheck=FALSE)


cfg$title <- "R2M41_SDP_NPi"
cfg <- setScenario(cfg,c("SDP","NPI"))
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "R2M41_SDP_NDC"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NDC"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NDC"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "R2M41_SDP_Budg600"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSPDB_SDP_26"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)
