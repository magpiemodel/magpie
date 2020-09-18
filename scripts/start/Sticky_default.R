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
realization<-c("mixed_feb17","sticky_feb18")
climate<-"nocc"


for (i in 1:length(resolutions)){
for(j in 1:length(realization)){

#Change the results folder name
cfg$title<-paste0("LPjmL_Tests_",realization[j],"_HadGEM2_ES","_","rcp6p0","_CO2_nocc")


#recalibrate
cfg$recalibrate <- TRUE

#recalc_npi_ndc
cfg$recalc_npi_ndc <- TRUE

#forestry
cfg$gms$forestry  <- "static_sep16"


#Factor costs realization
cfg$gms$factor_costs <- realization[j]

#Climate impact or not
  cfg$gms$c14_yields_scenario  <- climate
  cfg$gms$c42_watdem_scenario  <- climate
  cfg$gms$c43_watavail_scenario<- climate
  cfg$gms$c52_carbon_scenario  <- climate
  cfg$gms$c59_som_scenario  <- climate

start_run(cfg=cfg)
}}
