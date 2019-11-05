######################################################################################
#### Script to start a MAgPIE run using the Good Practice scenario configurations ####
######################################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Sources the default configuration file
source("config/default.cfg")

#Change the results folder name
cfg$title<-"Good_Practice_DEFAULT"

# INPUT FILES
cfg$input <- c("magpie4.1_default_apr19.tgz","additional_data_rev3.68.tgz","isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev38_c200_690d3718e151be1b450b394c1064b1c5.tgz","rev4.32_690d3718e151be1b450b394c1064b1c5_magpie.tgz","rev4.32_690d3718e151be1b450b394c1064b1c5_validation.tgz")

#NITROGEN UPTAKE SCENARIO DEFAULT 60_60. GoodPractice 85_85
#cfg$gms$c50_scen_neff <- "neff85_85_starty2010"
cfg$gms$c50_scen_neff <- "neff60_60_starty2010"

#Manure share used in an anaerobic digester. 0.15 in 2015, 0.30 in 2030, 0.5 in 2050 and 0.7 in 2100
#cfg$gms$c55_scen_conf<-"GoodPractice"
cfg$gms$c55_scen_conf<-"SSP2"

#start MAgPIE run
start_run(cfg=cfg)
