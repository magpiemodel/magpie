######################################################################################
#### Script to start a MAgPIE run using different factor_costs realizations ##########
######################################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Sources the default configuration file
source("config/default.cfg")


#Factor cost realizations
realization<-c("sticky_feb18","mixed_feb17")

#inputs
cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev44_c200_690d3718e151be1b450b394c1064b1c5.tgz",
			   "rev4.44_h12_magpie.tgz",
			   "rev4.44_h12_validation.tgz",
			   "calibration_H12_c200_26Feb20.tgz",
			   "additional_data_rev3.79.tgz")

for(j in 1:length(realization)){

#Change the results folder name
cfg$title<-paste0("PullRequest_",realization)

#Output shouldnt include validation
cfg$output <- c("interpolation","rds_report","disaggregation")


#Factor costs realization
cfg$gms$factor_costs <- realization[j]

start_run(cfg=cfg)
}
