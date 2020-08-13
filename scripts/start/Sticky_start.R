######################################################################################
#### Script to start a MAgPIE run using different factor_costs realizations ##########
######################################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Sources the default configuration file
source("config/default.cfg")


#Factor cost realizations
realization<-c("sticky_feb18")

#Change the results folder name
cfg$title<-paste0("PullRequest_",realization)

#Output shouldnt include validation
cfg$output <- c("interpolation","rds_report","disaggregation")


#Factor costs realization
cfg$gms$factor_costs <- realization[j]

start_run(cfg=cfg)
