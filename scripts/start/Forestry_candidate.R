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
cfg$output <- c("rds_report","disaggregation","interpolation")



## Recalculate NPIs
cfg$recalc_npi_ndc <- TRUE

#######################################
########## Setting up runs ############
#######################################

flag_run <- paste0("R072-CodeFix-")

cfg$gms$land <- "feb15"

for(conopt_setting in c(0,1)){
	## If manual solver settings from module be used (0=No, 1=Yes)
	cfg$gms$s80_optfile <- conopt_setting
	if(conopt_setting == 1) solver_flag = "ConoptManual"
	if(conopt_setting == 0) solver_flag = "ConoptDefault"

	for(timber_demand in c(1)){

		cfg$gms$s73_timber_demand <- timber_demand

		if(timber_demand == 1) dem_flag = "TimberON"
		if(timber_demand == 0) dem_flag = "TimberOFF"

		for(c32_rotation_extension in c(0)){
			for(pollutant_prices in c("R2M41-SSP2-NPi")){

				if(pollutant_prices == "R2M41-SSP2-NPi") {
					co2_flag = "Ref"
				} else if(pollutant_prices == "R2M41-SSP2-Budg1300"){
					co2_flag = "CO2price"
					cfg$gms$c56_pollutant_prices <- pollutant_prices
					cfg$gms$c60_2ndgen_biodem <- pollutant_prices
				}

				cfg$gms$c32_rotation_extension = c32_rotation_extension;

				if(c32_rotation_extension == 0) rot_flag = "NormalRotation"
				if(c32_rotation_extension == 1) rot_flag = "ExtendedRotation5y"
				if(c32_rotation_extension == 2) rot_flag = "ExtendedRotation10y"

				for(ssp in c("SSP2")){
					cfg <- setScenario(cfg,c(ssp,"NPI"))

					## Declare input data array
					#magpie_default_data <- "magpie4.1_default_apr19.tgz"
					#additional_magpie_data <- "additional_data_rev3.68.tgz"
					#isimip_data <- paste0("isimip_rcp-IPSL_CM5A_LR-",rcp_scen,"-co2_rev38_c200_690d3718e151be1b450b394c1064b1c5.tgz")
					#isimip_data <- paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev38_c200_690d3718e151be1b450b394c1064b1c5.tgz")
					#forestry_data <- "private_forestry_dec18_20200203.tgz"

					## Update input data array
					#cfg$input <- c(magpie_default_data,additional_magpie_data,isimip_data,forestry_data)

					## Should recalibration be made
					cfg$recalibrate <- "ifneeded"

					#cfg$title<- paste0(ssp,"-",rot_flag,"-",co2_flag,"-",dem_flag,"-",flag_run)
					cfg$title<- paste0(flag_run,"-",ssp,"-",rot_flag,"-",dem_flag,"-",co2_flag,"-",cfg$gms$land,"-",solver_flag)

					## Start the run
					start_run(cfg=cfg,codeCheck=codeCheck)
				}
			}
		}
	}
}
