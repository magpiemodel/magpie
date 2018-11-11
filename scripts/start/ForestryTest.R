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

#set defaults
codeCheck <- FALSE

### Single runs ###
#general settings
cfg$gms$c_timesteps <- "5year"
cfg$results_folder <- "output/:title:"
cfg<-lucode::setScenario(cfg,"SSP2")

## GHG TEST ##

cfg$gms$ghg_policy  <- "price_sep16"                     # def = price_sep16

# * pollutant price scenario
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"         # def = "SSP2-Ref-SPA0"
# *   options:  SSP1-Ref-SPA0, SSP2-Ref-SPA0, SSP5-Ref-SPA0,
# *             SSP1-26-SPA0, SSP1-37-SPA0, SSP1-45-SPA0,
# *             SSP2-26-SPA0, SSP2-37-SPA0, SSP2-45-SPA0, SSP2-60-SPA0,
# *             SSP5-26-SPA0, SSP5-37-SPA0, SSP5-45-SPA0, SSP5-60-SPA0,
# *             SSP1-26-SPA1, SSP1-37-SPA1, SSP1-45-SPA1,
# *             SSP2-26-SPA2, SSP2-37-SPA2, SSP2-45-SPA2, SSP2-60-SPA2,
# *             SSP5-26-SPA5, SSP5-37-SPA5, SSP5-45-SPA5, SSP5-60-SPA5,
# *             coupling

#priceScen <- c("SSP2-26-SPA0","SSP2-Ref-SPA0")
priceScen <- c("SSP2-Ref-SPA0")

for(PoluPriceScen in priceScen){
	cfg$gms$c56_pollutant_prices <- PoluPriceScen
	if(cfg$gms$c56_pollutant_prices=="SSP2-Ref-SPA0"){
		ghgscen <- "NoGHG"} else {ghgscen <- "GHG"}
	## Emission policy switch
	#policyScen <- c("ssp","ssp_AMFH") # def = ssp
	policyScen <- c("ssp_AMFH") # def = ssp
	# * emission policies
	# * options: none, all, ssp, ssp_AMFH
	# * ssp: CO2 emis from LUC in natveg; all CH4 and N2O emissions
	for(EmisPol in policyScen){
		cfg$gms$c56_emis_policy <- EmisPol
		#ALERT:  At the moment this script cannot download new data in case the input files are changed. Has to be set to true.
		cfg$force_download <- FALSE
		rl_all<-c("rlGTM")
		#rl_all<-c("rlGTM","rlFAO_max")
		#rl_all<-c("hybrid")
		for (rl in rl_all) {
			print(paste("Rotation length:",rl,"-----"))
			 t <- gsub(".*_", "", rl)
			 t <- gsub("rl","",t)
			 cfg$gms$c32_rot_length <- rl
			 #cfg$title<- paste0(t,"_",ghgscen,"_x",CostComparison) #Use the above naming when using two policyScen or using RecCost switch
			 #cfg$title<- paste0(t,"_factor",ups_factor_name,"_FixDem_OnlyPlantationMetDem") #Use the above naming when using two policyScen or using RecCost switch
			 cfg$title<- paste0(t,"_newCALIB") #Use the above naming when using two policyScen or using RecCost switch
			 start_run(cfg=cfg,codeCheck=codeCheck)
    }
  }
 }
