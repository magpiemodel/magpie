# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

flag_run <- "NPI"

library(lucode)
source("scripts/start_functions.R")
source("config/default.cfg")

cfg$developer_mode <- TRUE

## Fine names of input data
cfg$input <- c("magpie4.1_default_apr19.tgz","additional_data_rev3.68.tgz","isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev38_c200_690d3718e151be1b450b394c1064b1c5.tgz","private_forestry_dec18_20190827.tgz")

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
cfg$gms$trade <- "selfsuff_reduced_ff"
cfg$gms$forestry  <- "dynamic_dec18"
cfg$gms$natveg  <- "dynamic_dec18"
cfg$gms$optimization <- "nlp_apr17"

#ALERT:  At the moment this script cannot download new data in case the input files are changed. Has to be set to true.
cfg$force_download <- FALSE

## No interpolation later
cfg$output <- c("rds_report")

## CO2 price runs
co2_price_scenarios <- c("R2M41-SSP2-NPi")

## What outputs to generate
cfg$output <- c("rds_report")

## Food model covnvergence
cfg$gms$s15_convergence <- 0.005

for(climate_impacts in c(FALSE)){

	if(climate_impacts){
		cfg <- setScenario(cfg, "cc")
		cc_flag = "CC"
	} else {cc_flag = "nCC"}

	cfg$gms$c56_pollutant_prices <- co2_price_scenarios	# def = "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
	cfg$gms$c60_2ndgen_biodem <- co2_price_scenarios		# same as co2 price scenario from mag4.1

	for(ts_test in c("5year")){
		cfg$gms$c_timesteps = ts_test
		for (sl_set in c(0.05)) {
			if(sl_set == 0.05) sl_name = "SL"
			if(sl_set == 1.00) sl_name = "ClC"
			cfg$gms$s35_selective_logging_flag = sl_set

			if(cfg$gms$c56_pollutant_prices == "SSP2-26-SPA2-V15-REMIND-MAGPIE" ) {
				cfg$title<- paste0(cfg$gms$c_timesteps,"_",sl_name,"_","_CO2prices","_",cc_flag,"_",flag_run)
			} else {
				cfg$title<- paste0(cfg$gms$c_timesteps,"_",sl_name,"_",cc_flag,"_",flag_run)
			}
			start_run(cfg=cfg,codeCheck=codeCheck)
	 }
 }
}
