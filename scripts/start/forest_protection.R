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

cfg$title <- "WDPA"
cfg$gms$c35_protect_scenario <- "WDPA"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "full"
cfg$gms$c35_protect_scenario <- "full"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "forest"
cfg$gms$c35_protect_scenario <- "forest"
start_run(cfg,codeCheck=FALSE)
