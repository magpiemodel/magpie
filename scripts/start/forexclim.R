# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de


###########################################
############ Standard Settings ############
###########################################

## Load necessary libraries in R environment
library(lucode)

## Source the start functions
source("scripts/start_functions.R")

## Source the default config
source("config/default.cfg")

## Toggle for developer mode
cfg$developer_mode <- TRUE

## Code check toggle
codeCheck <- FALSE

## Title settings
cfg$results_folder <- "output/:title:"

## Which outputs to create during post processing
cfg$output <- c("rds_report","interpolation")

## If manual solver settings from module be used (0=No, 1=Yes)
cfg$gms$s80_optfile <- 1

## Set time step length
cfg$gms$c_timesteps = "coup2100"

## Emis policy
cfg$gms$c56_emis_policy <- "ssp_nosoil"

## Reward for -ve emis
cfg$gms$s56_reward_neg_emis <- -Inf

#######################################
########## Setting up runs ############
#######################################

flag_run <- paste0("R056-")

cfg$gms$s32_recurring_cost_multiplier <- 10

for(timber_demand in c(1)){

	cfg$gms$s73_timber_demand <- timber_demand

	if(timber_demand == 1) dem_flag = "-"
	if(timber_demand == 0) dem_flag = "TimberOFF"

	for(c32_rotation_extension in c(0)){
		for(co2_price_scenarios in c("R2M41-SSP2-NPi")){

			if(co2_price_scenarios == "R2M41-SSP2-NPi") co2_flag = "Ref"
			if(co2_price_scenarios == "R2M41-SSP2-Budg1300") co2_flag = "CO2price"

			## Set rotation length at harvest according to interest rate
			cfg$gms$c32_rotation_harvest = "def"

			cfg$gms$c32_rotation_extension = c32_rotation_extension;

			if(c32_rotation_extension == 0) rot_flag = "NormalRotation"
			if(c32_rotation_extension == 1) rot_flag = "ExtendedRotation5y"
			if(c32_rotation_extension == 2) rot_flag = "ExtendedRotation10y"

			## Rotation length for establishment
			cfg$gms$c32_rotation_estb <- cfg$gms$c32_rotation_harvest

			## Loop over climate impacts

			cfg <- setScenario(cfg, "nocc")

			cfg$gms$s35_selective_logging_flag = 1.00 ## Clear cut is 1.0

			for(ssp in c("SSP2")){
				cfg <- setScenario(cfg,c(ssp,"NPI"))

				cfg$gms$c56_pollutant_prices <- co2_price_scenarios
				cfg$gms$c60_2ndgen_biodem <- co2_price_scenarios

				#cfg$title<- paste0(ssp,"-",rot_flag,"-",co2_flag,"-",dem_flag,"-",flag_run)
				cfg$title<- paste0(flag_run,"-",ssp,"-",rot_flag,"-",co2_flag)

				## Declare input data array
				#magpie_default_data <- "magpie4.1_default_apr19.tgz"
				#additional_magpie_data <- "additional_data_rev3.68.tgz"
				#isimip_data <- paste0("isimip_rcp-IPSL_CM5A_LR-",rcp_scen,"-co2_rev38_c200_690d3718e151be1b450b394c1064b1c5.tgz")
				#isimip_data <- paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev38_c200_690d3718e151be1b450b394c1064b1c5.tgz")
				#forestry_data <- "private_forestry_dec18_20200203.tgz"

				## Update input data array
				#cfg$input <- c(magpie_default_data,additional_magpie_data,isimip_data,forestry_data)

				## If the model be forced to download data
				cfg$force_download <- FALSE

				## Should recalibration be made
				cfg$recalibrate <- "ifneeded"

				## Start the run
				start_run(cfg=cfg,codeCheck=codeCheck)
			}
		}
	}
}
