# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

flag_run <- "NatVeg_management"

library(lucode)
source("scripts/start_functions.R")
source("config/default.cfg")

cfg$developer_mode <- TRUE

#cfg$input <- c("magpie4.0_default_sep18.tgz","additional_data_rev3.65.tgz","isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev35_c200_690d3718e151be1b450b394c1064b1c5.tgz","private_forestry_dec18_20190216.tgz")
#cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,"/p/projects/landuse/users/mishra/additional_data_private_forestry"=NULL), getOption("magpie_repos"))

cfg$input <- c("magpie4.0_default_sep18.tgz","additional_data_rev3.65.tgz","isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev35_c200_690d3718e151be1b450b394c1064b1c5.tgz","rev4.1666_690d3718e151be1b450b394c1064b1c5_validation.tgz","private_forestry_dec18_20190820.tgz")
cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,"/p/projects/landuse/users/mishra/additional_data_private_forestry"=NULL,"/p/projects/rd3mod/inputdata/output"=NULL), getOption("magpie_repos"))

cfg$output <- c("rds_report","interpolation")

#set defaults
codeCheck <- TRUE

### Single runs ###
#general settings
cfg$gms$c_timesteps <- "5year"
cfg$results_folder <- "output/:title:"
cfg <- setScenario(cfg,c("SSP2","NPI"))

## Module settings
cfg$gms$demand <- "sector_dec18"
cfg$gms$trade <- "selfsuff_reduced_ff"
cfg$gms$forestry  <- "dynamic_dec18"
cfg$gms$natveg  <- "dynamic_dec18"
cfg$gms$optimization <- "nlp_apr17"

#ALERT:  At the moment this script cannot download new data in case the input files are changed. Has to be set to true.
cfg$force_download <- FALSE
rl_all<-c("rlGTM")
#rl_all<-c("rlFAO_min","rlGTM","rlFAO_max")
#rl_all<-c("rlGTM","rlFAO_max")
#rl_all<-c("rlFAO_max")

co2_price_scenarios <- c("SSP2-Ref-SPA0")
#co2_price_scenarios <- c("SSP2-Ref-SPA0","SSP2-26-SPA2")

for(biodem in co2_price_scenarios){

	cfg$gms$c56_pollutant_prices <- paste0(biodem,"-V15-REMIND-MAGPIE")      	# def = "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
	cfg$gms$c60_2ndgen_biodem <- biodem     									# def = "SSP2-Ref-SPA0"

	for (sl_set in c(0.05,1.00)) {
		if(sl_set == 0.05) sl_name = "SelLog"
#		if(sl_set == 0.10) sl_name = "Sl10pc"
#		if(sl_set == 0.50) sl_name = "Sl50pc"
		if(sl_set == 1.00) sl_name = "ClearCut"

		cfg$gms$s35_selective_logging_flag = sl_set

  for (rl in rl_all) {
  	if(rl=="rlFAO_min"){
  		print(paste("Rotation length:",rl,"-----"))
  		t <- gsub(".*_", "", rl)
  		t <- gsub("rl","",t)
  		cfg$gms$c32_rot_length <- rl
  		for(rl_estb in c("rlFAO_min","rlGTM")){
  		cfg$gms$c32_rot_length_estb <- rl_estb
  		t_estb <- gsub(".*_", "", rl_estb)
      	t_estb <- gsub("rl","",t_estb)
  		if(cfg$gms$c56_pollutant_prices == "SSP2-26-SPA2-V15-REMIND-MAGPIE" ) {
  			cfg$title<- paste0(t,"Harv","-",t_estb,"Estb","-",format(Sys.time(), format="%m%d"),"_",format(Sys.time(), format="%H%M"),"_CO2prices")
      		} else {
      		cfg$title<- paste0(t,"Harv","-",t_estb,"Estb","-",format(Sys.time(), format="%m%d"),"_",format(Sys.time(), format="%H%M"))
      		}
      	start_run(cfg=cfg,codeCheck=codeCheck)
  		}
  	} else if(rl=="rlGTM"){
  		print(paste("Rotation length:",rl,"-----"))
  		t <- gsub(".*_", "", rl)
  		t <- gsub("rl","",t)
  		cfg$gms$c32_rot_length <- rl
  		for(rl_estb in c("rlGTM")){
  		cfg$gms$c32_rot_length_estb <- rl_estb
  		t_estb <- gsub(".*_", "", rl_estb)
      	t_estb <- gsub("rl","",t_estb)
  		if(cfg$gms$c56_pollutant_prices == "SSP2-26-SPA2-V15-REMIND-MAGPIE" ) {
  			cfg$title<- paste0(flag_run,"_",sl_name,"_"format(Sys.time(), format="%m%d"),"_",format(Sys.time(), format="%H%M"),"_CO2prices")
      		} else {
      		#cfg$title<- paste0(t,"Harv","-",t_estb,"Estb","-",format(Sys.time(), format="%m%d"),"_",format(Sys.time(), format="%H%M"))
					cfg$title<- paste0(flag_run,"_",sl_name,"_"format(Sys.time(), format="%m%d"),"_",format(Sys.time(), format="%H%M"))
      		}
      	start_run(cfg=cfg,codeCheck=codeCheck)
  		}
  	} else if(rl=="rlFAO_max"){
  		print(paste("Rotation length:",rl,"-----"))
  		t <- gsub(".*_", "", rl)
  		t <- gsub("rl","",t)
  		cfg$gms$c32_rot_length <- rl
  		for(rl_estb in c("rlGTM")){
  		cfg$gms$c32_rot_length_estb <- rl_estb
  		t_estb <- gsub(".*_", "", rl_estb)
      	t_estb <- gsub("rl","",t_estb)
  		if(cfg$gms$c56_pollutant_prices == "SSP2-26-SPA2-V15-REMIND-MAGPIE" ) {
  			cfg$title<- paste0(t,"Harv","-",t_estb,"Estb","-",format(Sys.time(), format="%m%d"),"_",format(Sys.time(), format="%H%M"),"_CO2prices")
      		} else {
      		cfg$title<- paste0(t,"Harv","-",t_estb,"Estb","-",format(Sys.time(), format="%m%d"),"_",format(Sys.time(), format="%H%M"))
      		}
      	start_run(cfg=cfg,codeCheck=codeCheck)
  		}
    }
  }
 }
}
