# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: calculate and store new calibration for different factor costs, AEI and clustering
# --------------------------------------------------------

library(gms)
library(magpie4)
library(magclass)
options(warn=-1)
# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")


#realization<-c("sticky_feb18")
#sticky_modes<-c("dynamic")
realization<-c("mixed_feb17")
sticky_modes<-c("")

combo<-c(#"rcp7p0_EPIC_GFDL","rcp7p0_CYGMA_GFDL","rcp8p5_CYGMA_GFDL",
        #"rcp8p5_pDSSAT_GFDL","rcp8p5_EPIC_GFDL","rcp8p5_CYGMA_UKESM",
        "rcp8p5_pDSSAT_UKESM","rcp8p5_EPIC_UKESM",
        "rcp7p0_CYGMA_UKESM","rcp7p0_EPIC_UKESM"
        )

hashes_combos<-c(#"669b91c3","c6f10324","d972a1ce",
                 #"5b2b868c","82675b72","e61ed473",
                 "256c3ab7","c0547439",
                 "41ad9618","6bd5239a")


input<-c("additional_data_rev4.02.tgz",
         "rev4.59SmashingPumpkins+StickyFiles_h12_magpie_debug.tgz",
         "rev4.59SmashingPumpkins+ISIMIPyields_h12_validation_debug.tgz")

aux<-1

### Normal
for (i in realization){
  for (com in combo){
    for (so in sticky_modes) {

          #configurations
          cfg$title <- paste0("calib_",com,"_",i,"_",so)
          cfg$force_download <- TRUE
          cfg$crop_calib_max <- 2
          cfg$recalibrate <- TRUE
          cfg$results_folder <- "output/:title::date:"
          cfg$input <- c(input,
                         paste0("rev4.59SmashingPumpkins+ISIMIPyields_h12_",hashes_combos[aux],"_cellularmagpie_debug.tgz"))
          cfg$gms$c_timesteps <- 1
          cfg$output <- c("rds_report")
          cfg$sequential <- TRUE

          #Special modules
          cfg$gms$factor_costs <- i
          if(i == "sticky_feb18"){
          cfg$gms$c38_sticky_mode  <- so
           }
          cfg$gms$yields  <- "managementcalib_aug19"

         start_run(cfg,codeCheck=FALSE)

         magpie4::submitCalibration(paste0("H12_",com,"_",i,"_",so))

         aux<-aux+1
       }
     }
   }
