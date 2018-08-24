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

cfg$gms$trade <- "selfsuff_reduced"


for(i in c(
  "free2000","regionalized","globalized","fragmented",
  "a909090","a908080","a909595","a808080","a807070","a809090",
  "l909090r808080","l908080r807070","l909595r809090")){
  cfg$title <- paste0("tradetest_",i)
  cfg$gms$c21_trade_liberalization = i
  start_run(cfg=cfg)
  
}

source("config/default.cfg")


cfg$title <- "default"
#start MAgPIE run
start_run(cfg=cfg)
