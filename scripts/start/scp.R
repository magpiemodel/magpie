# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(gms)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"

cfg <- setScenario(cfg,c("SSP2","NPI"))

cfg$gms$c20_scp_type <- "hydrogen"
cfg$gms$s15_elastic_demand <- 0

cfg$title <- "SCP05_hydrogen_scpFeedOff"
cfg$gms$s70_scp_feed <- 0
cfg$gms$s15_scp_food <- 0
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SCP05_hydrogen_scpFeedOn"
cfg$gms$s70_scp_feed <- 1
cfg$gms$s15_scp_food <- 0
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SCP05_hydrogen_scpKapOn"
cfg$gms$s70_scp_feed <- 1
cfg$gms$s15_scp_food <- 1
start_run(cfg,codeCheck=FALSE)
