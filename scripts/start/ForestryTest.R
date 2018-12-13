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

cfg$input <- c("magpie4.0_default_sep18.tgz","isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev35_c200_690d3718e151be1b450b394c1064b1c5.tgz","private_forestry_dec18_20181213v2.tgz")
cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,"/p/projects/landuse/users/mishra/additional_data_private_forestry"=NULL),
                           getOption("magpie_repos"))

cfg$output <- c("rds_report","interpolation")

## Module settings
#cfg$policyregions <- "iso"
cfg$gms$demand <- "sector_dec18"
cfg$gms$trade <- "selfsuff_reduced_ff"
cfg$gms$forestry  <- "dynamic_dec18"
cfg$gms$c32_aff_policy <- "none"
cfg$gms$natveg  <- "dynamic_dec18"
cfg$gms$c35_ad_policy <- "none"

#set defaults
codeCheck <- TRUE

### Single runs ###
#general settings
cfg$gms$c_timesteps <- "5year"
cfg$results_folder <- "output/:title:"
cfg<-lucode::setScenario(cfg,"SSP2")

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
	cfg$title<- paste0(t,"_",format(Sys.time(), format="%Y%m%d"),"_",format(Sys.time(), format="%H%M"))
	start_run(cfg=cfg,codeCheck=codeCheck)
}
