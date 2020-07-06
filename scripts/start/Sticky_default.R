######################################################################################
#### Script to start a MAgPIE run using different factor_costs realizations ####
######################################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Sources the default configuration file
source("config/default.cfg")


cfg$title<-"Sticky_test"

cfg$gms$factor_costs <-"sticky_feb18"

start_run(cfg=cfg)
