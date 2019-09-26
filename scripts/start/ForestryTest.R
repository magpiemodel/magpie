# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

flag_run <- "noHeaven"

library(lucode)
source("scripts/start_functions.R")
source("config/default.cfg")

cfg$developer_mode <- TRUE

## Fine names of input data
cfg$input <- c("magpie4.1_default_apr19.tgz","additional_data_rev3.68.tgz","isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev38_c200_690d3718e151be1b450b394c1064b1c5.tgz","private_forestry_dec18_20190923_local.tgz")

## Location of input data
cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,"/p/projects/landuse/users/mishra/additional_data_private_forestry"=NULL), getOption("magpie_repos"))

#set defaults
codeCheck <- FALSE

#general settings
cfg$results_folder <- "output/:title:"
cfg <- setScenario(cfg,c("SSP2","NPI"))
#cfg <- setScenario(cfg,c("SSP2"))

## Module settings
cfg$gms$demand <- "sector_dec18"
cfg$gms$trade <- "selfsuff_reduced"
cfg$gms$forestry  <- "dynamic_oct19"
cfg$gms$natveg  <- "dynamic_dec18"
cfg$gms$optimization <- "nlp_apr17"
cfg$gms$land <- "feb15"
cfg$gms$c80_nlp_solver <- "conopt4"

#ALERT:  At the moment this script cannot download new data in case the input files are changed. Has to be set to true.
cfg$force_download <- FALSE

## No interpolation later
cfg$output <- c("rds_report")

## Using optfile
cfg$gms$s80_optfile <- 1

## What outputs to generate
cfg$output <- c("rds_report")

## Food model covnvergence
cfg$gms$s15_convergence <- 0.005

## Should recalibration be made
cfg$recalibrate <- "ifneeded"

## Setting up runs

## Loop over mitigation-co2 prices
#for(co2_price_scenarios in c("R2M41-SSP2-NPi","R2M41-SSP2-Budg1300" )){
for(co2_price_scenarios in c("R2M41-SSP2-NPi")){

	## Loop over climate impacts
	for(climate_impacts in c(FALSE)){
		if(climate_impacts){
			cfg <- setScenario(cfg, "cc")
			cc_flag = "CC"
		} else {cc_flag = "noCC"}

		## Set 2nd gen bioenergy demand and pollutant prices
		cfg$gms$c56_pollutant_prices <- co2_price_scenarios
		cfg$gms$c60_2ndgen_biodem <- co2_price_scenarios		# same as co2 price scenario from mag4.1

		## Set time step length
		cfg$gms$c_timesteps = "5year"

		## Set clear cutting or selective logging flag
		#for (sl_set in c(0.05,1.00)) {
		#	if(sl_set == 0.05) logging = "SelectiveLog"
		#	if(sl_set == 1.00) logging = "ClearCut"
		#	cfg$gms$s35_selective_logging_flag = sl_set

			if(cfg$gms$c56_pollutant_prices == "R2M41-SSP2-Budg1300" ) {
#				cfg$title<- paste0(cfg$gms$c_timesteps,"_",logging,"_","_CO2prices","_",cc_flag,"_",flag_run)
				cfg$title<- paste0("Mitig-CO2prices","_",cc_flag,"-",flag_run)
			} else {
#				cfg$title<- paste0(cfg$gms$c_timesteps,"_",logging,"_",cc_flag,"_",flag_run)
				cfg$title<- paste0(flag_run,"-",cfg$gms$c80_nlp_solver)
			}
			start_run(cfg=cfg,codeCheck=codeCheck)
	 #}
	}
}
