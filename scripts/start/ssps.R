# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(lucode)
library(magpie4)

source("scripts/start_functions.R")
source("scripts/performance_test.R")
source("config/default.cfg")


#set defaults
codeCheck <- FALSE


#### MAgPIE deafult SSPs ######################################


##SSP1
cfg$title <- "SSP1"
cfg<-lucode::setScenario(cfg,"SSP1")
start_run(cfg=cfg,codeCheck=codeCheck)

##SSP2
cfg$title <- "SSP2"
cfg<-lucode::setScenario(cfg,"SSP2")
start_run(cfg=cfg,codeCheck=codeCheck)


##SSP3
cfg$title <- "SSP3"
cfg<-lucode::setScenario(cfg,"SSP3")
start_run(cfg=cfg,codeCheck=codeCheck)


##SSP4
cfg$title <- "SSP4"
cfg<-lucode::setScenario(cfg,"SSP4")
start_run(cfg=cfg,codeCheck=codeCheck)


##SSP5
cfg$title <- "SSP5"
cfg<-lucode::setScenario(cfg,"SSP5")
start_run(cfg=cfg,codeCheck=codeCheck)





