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

#source default config
source("config/default.cfg")

cfg$force_download <- TRUE #re-download the inputdata

cfg$results_folder <- "output/:title:" #where you want to store the output

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,
                                "./patch_inputdata"=NULL),
                           getOption("magpie_repos"))

cfg$input <- c("magpie4.1_default_apr19.tgz","additional_data_rev3.68.tgz",
               "isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev38_c200_690d3718e151be1b450b394c1064b1c5.tgz", 
               "patch_gdp20.tgz")


cfg$title <- paste0("dc_SSE_20k")



#start run
start_run(cfg=cfg)

