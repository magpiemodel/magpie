# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(gms)
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
	## Brazil run with 500 clusters and extra weight to region BRA
    cellcode <- "n500_BRA18_LAM26_ROW01"
    regionscode <- "d49a7a8baaab0edc754ebfc09462be0a"
  } else if(reg=="H12") {
	## 12 region run with 200 clusters
    cellcode <- "h200"
    regionscode <- "690d3718e151be1b450b394c1064b1c5"
  } else {
    stop("Unknown region setting!")
  }

  ## Test for artificial NPI policy for Japan.
  ## forest_pro is forest protection in JPN
  ## forest_nopro is no NPI in JPN with older version of additional_data_rev3.43

  forest_pro <- c(paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-noco2_rev33_",cellcode,"_",regionscode,".tgz"),
                         paste0("rev3.35_",regionscode,"_magpie.tgz"),
                         paste0("rev3.35_",regionscode,"_validation.tgz"),
                         "additional_data_rev3.44.tgz")
  forest_nopro   <- c(paste0("isimip_rcp-IPSL_CM5A_LR-rcp2p6-noco2_rev33_",cellcode,"_",regionscode,".tgz"),
                         paste0("rev3.35_",regionscode,"_magpie.tgz"),
                         paste0("rev3.35_",regionscode,"_validation.tgz"),
                         "additional_data_rev3.43.tgz")

  ## Three SSP scenarios to analyse
  for (ssp in c("SSP2","SSP1","SSP5")) {
  ## reference and mitigation runs (without co2 fertilization)
    for (rcp in c("ref","26")){
     #if(rcp=="26" && ssp %in% c("SSP3","SSP4")) next

	 ## lg is livestock gridded implementation by Kristine. ptc15 is pasture transport cost of 0.15 by Geanderson
      for(tc in c("lg","ptc15")) {

	  ## JPNfp is forest protection in JPN related to forest_pro
	  ## JPNdf is no forest protection in JPN related to forest_nopro
        for(jpn in c("JPNfp","JPNdf")){

		## Two realization for Tau implementation.
          for(tau in c("endo_JUN16","endo_jun18")){

            cfg$title <- paste(reg,tc,jpn,tau,ssp,rcp,sep="_")

            cfg <- setScenario(cfg,c(ssp,if(rcp=="ref") "NPI" else "NDC"))

            if(rcp=="Ref"){spa="SPA0"}else{spa=paste0("SPA",substring(ssp,4,5))}
            if(ssp%in%c("SSP1","SSP2","SSP5")){
              model="REMIND-MAgPIE"
            } else if (ssp=="SSP3"){
              model="AIM-CGE"
            } else {
              model="GCAM4"
            }
            cfg$gms$c56_pollutant_prices <- paste("SSPDB",ssp,rcp,model,sep="-")
            cfg$gms$c60_2ndgen_biodem <- paste("SSPDB",ssp,rcp,model,sep="-")

            cfg$gms$tc <- tau

            if(jpn=="JPNdf"){
              cfg$input <- forest_nopro
            } else if(jpn=="JPNfp"){
              cfg$input <- forest_pro
            } else stop("Unknown transport cost setting!")

            if(tc=="ptc15") {
              cfg$gms$s40_pasture_transport_costs <- 0.15 #ptc15
              cfg$damping_factor <- 0.7
              cfg$gms$disagg_lvst <- "off"
            } else if(tc=="lg") {
              cfg$gms$s40_pasture_transport_costs <- 0
              cfg$damping_factor <- 0.98
              cfg$gms$disagg_lvst <- "simple_oct17"
            } else stop("Unknown transport cost setting!")

			## Submit the runs
            start_run(cfg,codeCheck=FALSE)
          }
        }
      }
    }
  }
}
