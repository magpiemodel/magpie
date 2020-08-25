######################################################################################
#### Script to start a MAgPIE run using different factor_costs realizations ##########
######################################################################################

library(lucode2)
library(magclass)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Sources the default configuration file
source("config/default.cfg")


for(cc in c("nocc","cc")){

    # Set cc
    cfg<-gms::setScenario(cfg,cc)

    # Set factor costs
    cfg$gms$factor_costs = "sticky_feb18"

    #recalibrate
    cfg$recalibrate <- TRUE

    #Change the results folder name
    cfg$title<-paste0("Sticky_",cc)

    # Start run
    start_run(cfg=cfg)
}
