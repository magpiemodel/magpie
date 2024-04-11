# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: test routine for duallayer implementation 
# ----------------------------------------------------------


## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

# choose a meaningful Pull Request (PR) flag. 
# example for high risk modification requiring runs from the current develop and the feature branch to be merged: PR276_develop, PR276_TAUhistfree
pr_flag <- "PR282test"

# Grab user name
user <- Sys.info()[["user"]]

cfg$results_folder <- "output/:title:"

## Create a set of runs based on default.cfg

for(tc in c("endo_jun18","exo")) { 
    for (trade in c("exo","free_apr16","selfsuff_reduced","off")) {
      #cfg <- setScenario(cfg,c(ssp,"NPI"))
      cfg$gms$tc <- tc
      cfg$gms$trade <- trade
        
      cfg$title <- paste0(pr_flag,"_",user,"_",tc,"-",trade) #Create easily distinguishable run title
      
      cfg$output <- c("rds_report") # Only run rds_report after model run
      
      start_run(cfg,codeCheck=TRUE) # Start MAgPIE run
      #cat(cfg$title)
    }
}
