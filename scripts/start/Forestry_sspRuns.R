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
cfg$output <- c("rds_report")

## If manual solver settings from module be used (0=No, 1=Yes)
cfg$gms$s80_optfile <- 1

## Set time step length
cfg$gms$c_timesteps = "5year"

## Emis policy
cfg$gms$c56_emis_policy <- "ssp_nosoil"

## Reward for -ve emis
cfg$gms$s56_reward_neg_emis <- -Inf

#######################################
########## Setting up runs ############
#######################################


flag_run <- paste0("FutureDemandFix-LauriEtAl-R033")

cfg$gms$s32_recurring_cost_multiplier <- 10

## Set rotation length at harvest according to interest rate
cfg$gms$c32_rotation_harvest = "def"

## Rotation length for establishment
cfg$gms$c32_rotation_estb <- cfg$gms$c32_rotation_harvest

rot_flag = "Normal"

## Loop over climate impacts

cfg <- setScenario(cfg, "nocc")

cfg$gms$s35_selective_logging_flag = 1.00 ## Clear cut is 1.0

for(ssp in c("SSP1","SSP2","SSP3","SSP4","SSP5")){
	cfg <- setScenario(cfg,c(ssp,"NPI"))

	cfg$title<- paste0(ssp,"-",paste0(rot_flag," rotation"),"-",flag_run)

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
