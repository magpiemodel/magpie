# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de


##########################################################
#### Script to start a MAgPIE run ####
##########################################################

library(lucode)

#Here the function start_run(cfg) is loaded which is needed to start MAgPIE runs
#The function needs information about the configuration of the run. This can be either supplied as a list of settings or as a file name of a config file
source("scripts/start_functions.R")

#set defaults
config <- "default.cfg"
scenario <- "SSP2"
codeCheck <- TRUE

#defaults are overwritten if specified as argument
readArgs("config","scenario","codeCheck")

#start MAgPIE run
start_run(cfg=config,scenario=scenario,codeCheck=codeCheck)
