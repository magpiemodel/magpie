# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(gms)
library(magpie4)

source("scripts/start_functions.R")
source("scripts/performance_test.R")
source("config/default.cfg")


#set defaults
codeCheck <- FALSE


#### MAgPIE deafult SSPs ######################################


##SSP1
cfg$title <- "SSP1"
cfg<-gms::setScenario(cfg,"SSP1")
start_run(cfg=cfg,codeCheck=codeCheck)

##SSP2
cfg$title <- "SSP2"
cfg<-gms::setScenario(cfg,"SSP2")
start_run(cfg=cfg,codeCheck=codeCheck)


##SSP3
cfg$title <- "SSP3"
cfg<-gms::setScenario(cfg,"SSP3")
start_run(cfg=cfg,codeCheck=codeCheck)


##SSP4
cfg$title <- "SSP4"
cfg<-gms::setScenario(cfg,"SSP4")
start_run(cfg=cfg,codeCheck=codeCheck)


##SSP5
cfg$title <- "SSP5"
cfg<-gms::setScenario(cfg,"SSP5")
start_run(cfg=cfg,codeCheck=codeCheck)
