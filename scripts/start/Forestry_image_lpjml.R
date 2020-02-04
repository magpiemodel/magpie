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

## Define repositories
cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,"/p/projects/landuse/users/mishra/additional_data_private_forestry"=NULL), getOption("magpie_repos"))

## Code check toggle
codeCheck <- FALSE

## Title settings
cfg$results_folder <- "output/:title:"

## Which outputs to create during post processing
cfg$output <- c("rds_report")

## If manual solver settings from module be used (0=No, 1=Yes)
cfg$gms$s80_optfile <- 1

## Set time step length
cfg$gms$c_timesteps = "5year"

## Emis policy
cfg$gms$c56_emis_policy <- "ssp_nosoil"

## Reward for -ve emis
cfg$gms$s56_reward_neg_emis <- -Inf

## Which land realization to use
#cfg$gms$land <- "feb15" ---- Changed inside loop. Check once.

#########################################
############ Setting up runs ############
#########################################

for(bef in c("ipccBEF")){
	cfg$gms$c32_bef <- bef
	flag_run <- paste0("R007--RTMAXV--",bef,"--")
	for(interest_rate in c("medium")) {

		cfg$gms$s32_recurring_cost_multiplier <- 10

		## Set rotation length at harvest according to interest rate
		if(interest_rate == "1pc"){
			cfg$gms$c32_rotation_harvest = "bio"
			rot_flag = "Biological"
		} else if(interest_rate == "low"){
			cfg$gms$c32_rotation_harvest = "high"
			rot_flag = "Extended"
		} else if(interest_rate == "medium"){
			cfg$gms$c32_rotation_harvest = "def"
			rot_flag = "Normal"
		} else if(interest_rate == "high"){
			cfg$gms$c32_rotation_harvest = "low"
			rot_flag = "Reduced"
		} else if(interest_rate == "15pc"){
			cfg$gms$c32_rotation_harvest = "min"
			rot_flag = "Very Short"
		}

		## Overwrite SSP2 interest rate
		cfg$gms$c12_interest_rate <- interest_rate

		## Rotation length for establishment
		cfg$gms$c32_rotation_estb <- "def"

		## Loop over climate impacts
		for(climate_impacts in c("nocc")) {

			cfg <- setScenario(cfg, climate_impacts)

			for (sl_set in c(1.00)) {
			if(sl_set == 0.01) logging = "Restrict1pc"
			if(sl_set == 0.05) logging = "Restrict5pc"
			if(sl_set == 1.00) logging = "ClearCut"

			cfg$gms$s35_selective_logging_flag = sl_set

			for(protection_scen in c("BASE","NPI")){
					cfg <- setScenario(cfg,c("SSP2",protection_scen))
					cfg$gms$demand <- "sector_dec18"
					cfg$gms$trade <- "selfsuff_reduced_ff"
					cfg$gms$forestry  <- "dynamic_nov19"
					cfg$gms$natveg  <- "dynamic_nov19"
					cfg$gms$optimization <- "nlp_apr17"
					cfg$gms$land <- "landmatrix_dec18"
					cfg$title<- paste0(flag_run,"-",paste0(rot_flag," rotation"),"-",protection_scen)

				## Declare input data array
				magpie_default_data <- "magpie4.1_default_apr19.tgz"
				additional_magpie_data <- "additional_data_rev3.68.tgz"
	#			isimip_data <- paste0("isimip_rcp-IPSL_CM5A_LR-",rcp_scen,"-co2_rev38_c200_690d3718e151be1b450b394c1064b1c5.tgz")
				isimip_data <- paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev38_c200_690d3718e151be1b450b394c1064b1c5.tgz")
				forestry_data <- "private_forestry_dec18_20200203.tgz"

				## Update input data array
				cfg$input <- c(magpie_default_data,additional_magpie_data,isimip_data,forestry_data)

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
}
