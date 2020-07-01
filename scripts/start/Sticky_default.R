######################################################################################
#### Script to start a MAgPIE run using different factor_costs realizations ##########
######################################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Sources the default configuration file
source("config/default.cfg")

#Climate scenario
clima<-"cc"
#List of resolutions forruns
resolutions<-c("200")
#Factor cost realizations
realization<-c("sticky_feb18","mixed_feb17")
# Trade realization
title<-c("Last_Sticky_scaling","Last_develop")

for (i in 1:length(resolutions)){
for(j in 1:length(realization)){
#for(k in 1:length(trade)){
#Change the results folder name
#cfg$title<-paste0("Develop_",realization[j],"_c",resolutions[i],"_UP")
cfg$title<-title[j]

#max year ssp2
#cfg$gms$sm_fix_SSP2 <- 1990

#recalibrate
cfg$recalibrate <- TRUE


#Factor costs realization
cfg$gms$factor_costs <- realization[j]

#Climate impact or not
#cfg$gms$c14_yields_scenario  <- clima
#cfg$gms$c42_watdem_scenario  <- clima
#cfg$gms$c43_watavail_scenario<- clima
#cfg$gms$c52_carbon_scenario  <- clima
#cfg$gms$c59_som_scenario  <- clima


start_run(cfg=cfg)
}}
#}
