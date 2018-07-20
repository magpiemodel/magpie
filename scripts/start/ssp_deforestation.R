# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

cfg$results_folder <- "output/:title:"
cfg$recalibrate <- TRUE
cfg$force_download <- TRUE

#specify the title flag for all the scenarios
#flag <- ""

#SSPs
for(reg in c("BRA","H12")) {
  if(reg=="BRA"){
    cellcode <- "n500_BRA18_LAM26_ROW01"
    regionscode <- "d49a7a8baaab0edc754ebfc09462be0a"
  } else if(reg=="H12") {
    cellcode <- "h200"
    regionscode <- "690d3718e151be1b450b394c1064b1c5"
  } else {
    stop("Unknown region setting!")
  }
  cfg$input <- c(paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-noco2_rev33_",cellcode,"_",regionscode,".tgz"),
                 paste0("rev3.35_",regionscode,"_magpie.tgz"),
                 paste0("rev3.35_",regionscode,"_validation.tgz"),
                 "additional_data_rev3.44.tgz")
  
  for (ssp in c("SSP2")) {
    for (rcp in c("ref","26")){
     #if(rcp=="26" && ssp %in% c("SSP3","SSP4")) next
      for(tc in c("ptc15","lg","no")) {
        cfg$title <- paste(reg,tc,ssp,rcp,sep="_")
        
        cfg <- setScenario(cfg,c(ssp,if(rcp=="Ref") "NPI" else "NDC"))
        cfg$gms$c56_pollutant_prices <- paste(if(ssp %in% c("SSP3","SSP4")) "SSP2" else ssp,rcp,"SPA0",sep="-")
        cfg$gms$c60_2ndgen_biodem <- paste(if(ssp %in% c("SSP3","SSP4")) "SSP2" else ssp,rcp,"SPA0",sep="-")

        if(tc=="ptc15") {
          cfg$gms$s40_pasture_transport_costs <- 0.15 #ptc15
          cfg$gms$disagg_lvst <- "off" 
        } else if(tc=="lg") {
          cfg$gms$s40_pasture_transport_costs <- 0
          cfg$gms$disagg_lvst <- "simple_oct17" 
        } else if(tc=="no"){
		 cfg$gms$s40_pasture_transport_costs <- 0
          cfg$gms$disagg_lvst <- "off" 
		} else stop("Unknown transport cost setting!")
        
		start_run(cfg,codeCheck=FALSE)
      }
    }
  }
}
