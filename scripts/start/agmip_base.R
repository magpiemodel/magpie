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

cfg$force_download <- FALSE

#cfg$results_folder <- "output/:title:"
cfg$results_folder <- "output/:title::date:"





#################################################################
# No climate change                                             #
#################################################################


### SSPs w/o mitigation ################
cfg$title <- "SSP1_NoMt_NoCC"
cfg <- setScenario(cfg,c("SSP1","NPI"))
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP2_NoMt_NoCC"
cfg <- setScenario(cfg,c("SSP2","NPI"))
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP3_NoMt_NoCC"
cfg <- setScenario(cfg,c("SSP3","NPI"))
start_run(cfg,codeCheck=FALSE)




#reset:
cfg <- setScenario(cfg,c("SSP2","NPI"))



