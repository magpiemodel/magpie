# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(lucode)
source("scripts/start_functions.R")
source("config/default.cfg")

cfg$developer_mode <- TRUE

## Location of input data
cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,"/p/projects/landuse/users/mishra/additional_data_private_forestry"=NULL), getOption("magpie_repos"))

#set defaults
codeCheck <- FALSE

#general settings
cfg$results_folder <- "output/:title:"

#cfg <- setScenario(cfg,c("SSP2","BASE"))
## Load SSP2
cfg <- setScenario(cfg,c("SSP2","NPI"))
## Module settings
#cfg$gms$demand <- "sector_dec18"
#cfg$gms$trade <- "selfsuff_reduced_ff"
#cfg$gms$forestry  <- "dynamic_nov19"
cfg$gms$s32_recurring_cost_multiplier <- 100
#cfg$gms$natveg  <- "dynamic_nov19"
#cfg$gms$optimization <- "nlp_apr17"
#cfg$gms$c80_nlp_solver <- "conopt4"

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

#################################
####### CHANGING THE FLAG #######
#################################
flag_run <- "R028--"
#################################
#for(rl_scen in c("low","medium","high")) {
for(rl_scen in c("low","medium","high")) {
	if(rl_scen == "1pc") cfg$gms$c32_rotation_harvest <- "bio"
	if(rl_scen == "low") cfg$gms$c32_rotation_harvest = "high"
	if(rl_scen == "medium") cfg$gms$c32_rotation_harvest = "def"
	if(rl_scen == "high") cfg$gms$c32_rotation_harvest = "low"
	if(rl_scen == "15pc") cfg$gms$c32_rotation_harvest = "min"


	## Overwrite SSP2 interest rate
	cfg$gms$c12_interest_rate <- rl_scen

	cfg$gms$c32_rotation_estb <- cfg$gms$c32_rotation_harvest

	## Loop over climate impacts
	#for(climate_impacts in c("nocc","cc")) {
	for(climate_impacts in c("nocc","cc")) {
		cfg <- setScenario(cfg, climate_impacts)

		## Loop over mitigation-co2 prices
		#for(co2_price_scenarios in c("R2M41-SSP2-NPi","R2M41-SSP2-Budg1300")) {
		for(co2_price_scenarios in c("R2M41-SSP2-NPi","R2M41-SSP2-Budg1300")) {
			if(co2_price_scenarios=="R2M41-SSP2-NPi") rcp_scen <- "rcp6p0"
			if(co2_price_scenarios=="R2M41-SSP2-Budg1300") rcp_scen <- "rcp2p6"

			## Update input file from isimip
			isimip_data <- paste0("isimip_rcp-IPSL_CM5A_LR-",rcp_scen,"-co2_rev38_c200_690d3718e151be1b450b394c1064b1c5.tgz")
			cfg$input <- c("magpie4.1_default_apr19.tgz","additional_data_rev3.68.tgz",isimip_data,"private_forestry_dec18_20191114.tgz")

			## Set 2nd gen bioenergy demand and pollutant prices
			cfg$gms$c56_pollutant_prices <- co2_price_scenarios
			cfg$gms$c60_2ndgen_biodem <- co2_price_scenarios		# same as co2 price scenario from mag4.1

			## Set time step length
			cfg$gms$c_timesteps = "5year"

			## Set clear cutting or selective logging flag
			#for (sl_set in c(0.01,0.05,1.00)) {
			for (sl_set in c(1.00,0.05,0.01)) {
				if(sl_set == 0.01) logging = "Sel1pc"
				if(sl_set == 0.05) logging = "Sel5pc"
				if(sl_set == 1.00) logging = "ClrCut"
				cfg$gms$s35_selective_logging_flag = sl_set

				if(cfg$gms$c56_pollutant_prices == "R2M41-SSP2-Budg1300") {
					#cfg$title<- paste0(flag_run,"-",ssp_scen,"-",forestry_tc,"_",logging,"_",climate_impacts,"_",rcp_scen,"_","Mitig-pCO2")
					cfg$gms$c56_emis_policy <- "all_nosoil"
					cfg$gms$s56_reward_neg_emis <- -Inf
					cfg$gms$c32_price_flag_forestry <- 1
					cfg$title<- paste0(flag_run,"-",paste0(cfg$gms$c32_rotation_harvest,"RL"),"_",logging,"_",climate_impacts,"_","Mitig-pCO2")
				} else {
					#cfg$title<- paste0(flag_run,"-",ssp_scen,"-",forestry_tc,"_",logging,"_",climate_impacts,"_",rcp_scen)
					cfg$title<- paste0(flag_run,"-",paste0(cfg$gms$c32_rotation_harvest,"RL"),"_",logging,"_",climate_impacts)
				}
				start_run(cfg=cfg,codeCheck=codeCheck)
			}
		}

	}
}
