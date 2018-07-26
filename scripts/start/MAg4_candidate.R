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
#withMetadata(TRUE) ## Doesn't work.

###############################################################################################################
## Following script is with H12 regions, All SSPs (ref and rcp2.6), on a livestock gridded configuration,    ##
## with forest protection policy in Japan and new tau implementation jun18. Includes correct GDP calculation ##
## and also includes other land protetction in Japan.														 ##
###############################################################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

cfg$results_folder <- "output/:title:"

#specify the title flag for all the scenarios
#flag <- ""

#SSPs
for(reg in c("H12")) {
  ## 200 clusters
  cellcode <- "h200"
  regionscode <- "690d3718e151be1b450b394c1064b1c5"
    
  forest_pro <- c(paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev33_",cellcode,"_",regionscode,".tgz"),
                         paste0("rev3.36_",regionscode,"_magpie.tgz"),
                         paste0("rev3.36_",regionscode,"_validation.tgz"),
                         "additional_data_rev3.45.tgz")
  
  for (ssp in c("SSP1","SSP2","SSP3","SSP4","SSP5")) {
    for (rcp in c("ref","26")){
     #if(rcp=="26" && ssp %in% c("SSP3","SSP4")) next
      for(tc in c("lg")) {
        for(jpn in c("JPNfp")){
          for(tau in c("endo_jun18")){
            
            cfg$title <- paste(ssp,rcp,sep="_")
            
            cfg <- setScenario(cfg,c(ssp,if(rcp=="ref") "NPI" else "NDC"))
            cfg$gms$c56_pollutant_prices <- paste(if(ssp %in% c("SSP3","SSP4")) "SSP2" else ssp,rcp,"SPA0",sep="-")
            cfg$gms$c60_2ndgen_biodem <- paste(if(ssp %in% c("SSP3","SSP4")) "SSP2" else ssp,rcp,"SPA0",sep="-")
            
            cfg$gms$tc <- tau
            
            cfg$input <- forest_pro
                        
            cfg$gms$s40_pasture_transport_costs <- 0
            cfg$damping_factor <- 0.98
            cfg$gms$disagg_lvst <- "simple_oct17" 
                       
            start_run(cfg,codeCheck=FALSE)
			
          }  
        }
      }
    }
  }
}
