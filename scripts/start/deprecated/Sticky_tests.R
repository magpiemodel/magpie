######################################################################################
#### Script to start a MAgPIE run using different factor_costs realizations ##########
######################################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Sources the default configuration file
source("config/default.cfg")

#List of resolutions forruns
resolutions<-c("200")
#Factor cost realizations
realization<-c("mixed_feb17","sticky_feb1")
# Trade realization
title<-c("default","Sticky_test_run")

for (i in 1:length(resolutions)){
for(j in 1:length(realization)){
#for(k in 1:length(trade)){
#Change the results folder name
#cfg$title<-paste0("Develop_",realization[j],"_c",resolutions[i],"_UP")
cfg$title<-title[j]

#Factor costs realization
cfg$gms$factor_costs <- realization[j]

start_run(cfg=cfg)
}}
#}
