# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

source("config/default.cfg")


cfg$title <- "default"
#start MAgPIE run
start_run(cfg=cfg)


cfg$gms$trade <- "selfsuff_reduced"

for(i in c(   "free2000",
              "regionalized",
              "globalized",
              "fragmented",
              "lib_70_70_70",
              "lib80_80_80",
              "lib80_60_60",
              "lib80_90_90")){
  cfg$title <- paste0("tradetest_",i)
  
  start_run(cfg=cfg)
  
}
