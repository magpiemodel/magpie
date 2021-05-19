library(magclass)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Sources the default configuration file
source("config/default.cfg")

#recalibrate
cfg$recalibrate <- FALSE


for(cc in c("nocc_hist","nocc")){

    # Set cc
    cfg<-gms::setScenario(cfg,cc)

    #Change the results folder name
    cfg$title<-paste0("Mixed_dollar_hist_flex2",cc)

    # Start run
    start_run(cfg=cfg)
}
