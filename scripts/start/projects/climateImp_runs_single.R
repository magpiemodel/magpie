library(gms)
library(magpie4)
library(magclass)
options(warn=-1)
# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")


realization<-c("mixed_feb17","sticky_feb18")
combo<-c("rcp7p0_LPJML_GFDL_newParam"
        )

#hashes_combos<-c("")


input<-c("additional_data_rev4.02.tgz",
         "rev4.59SmashingPumpkins+StickyFiles_h12_magpie_debug.tgz",
         "rev4.59SmashingPumpkins+ISIMIPyields_h12_validation_debug.tgz")
calib<-list()
calib[["mixed_feb17"]]<-"calibration_H12_rcp7p0_LPJML_GFDL_newParam_mixed_feb17__07May21.tgz"
calib[["sticky_feb18"]]<-"calibration_H12_rcp7p0_LPJML_GFDL_newParam_sticky_feb18_dynamic_07May21.tgz"

#aux<-1

### Normal
for (i in realization){
  for (com in combo){

    if(i == "sticky_feb18"){
    sticky_modes<-c("dynamic")
  }else{
    sticky_modes<-c("")
  }

    for (so in sticky_modes) {

          #configurations
          cfg$title<-paste0("NewBranch_",com,"_",i,"_",so,"_",c,"_")
          cfg$input <- c(input,
                         paste0("rev4.59newparam_h12_c5cdbf33_cellularmagpie_debug.tgz"),
                         calib[[i]])


          cfg$output <- c("rds_report")


          #Special modules
          cfg$gms$factor_costs <- i
          if(i == "sticky_feb18"){
          cfg$gms$c38_sticky_mode  <- so
           }
          cfg$gms$yields  <- "managementcalib_aug19"

         start_run(cfg,codeCheck=FALSE)


       }
     }
   }
