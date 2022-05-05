# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test new rotational constraint scenarios
# ----------------------------------------------------------


######################################
#### Script to start a MAgPIE run ####
######################################

library(gms)
library(lucode2)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

cfg$results_folder <- "output/:title:"
#cfg$output <- c("rds_report","extra/disaggregation")#"extra/highres"

prefix <- "rotationtests05uncalib"
#cfg$qos <- "priority"

cfg$title <- paste(prefix,"olddefault",sep="_")
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"newdefault",sep="_")
cfg$gms$crop    <- "rotation_apr22"
cfg$gms$c30_rotation_scenario = "min_20div"
start_run(cfg,codeCheck=FALSE)

for (scenario in c("min","good","good_20div","setaside","legumes","agroforestry","sixfoldrotation","agroecology")){
  for (byyear in c("by2030","by2050")){
	  cfg$gms$c30_rotation_scenario = scenario
	  cfg$gms$c30_rotation_scenario_speed = byyear
	  cfg$title <- paste(prefix,scenario,byyear,sep="_")
	  start_run(cfg,codeCheck=FALSE)
  }

}
