library(gms)
library(magpie4)
library(magclass)
options(warn=-1)
# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")


realization<-c("sticky_feb18")
sticky_modes<-c("dynamic")
#realization<-c("mixed_feb17")
#sticky_modes<-c("")

combo<-c("rcp7p0_CYGMA_GFDL","rcp8p5_CYGMA_GFDL",
        "rcp8p5_pDSSAT_GFDL","rcp8p5_CYGMA_UKESM","rcp8p5_pDSSAT_UKESM","rcp7p0_CYGMA_UKESM",
        "rcp8p5_EPIC_GFDL",
        "rcp8p5_EPIC_UKESM",
        "rcp7p0_EPIC_UKESM",
        "rcp7p0_EPIC_GFDL"
        )

hashes_combos<-c("c6f10324","d972a1ce",
                "5b2b868c","e61ed473","256c3ab7","41ad9618",
                 "82675b72",
                 "c0547439",
                 "6bd5239a",
                 "669b91c3"
)

climate<-c("cc","nocc")
input<-c("additional_data_rev4.02.tgz",
         "rev4.59SmashingPumpkins+StickyFiles_h12_magpie_debug.tgz",
         "rev4.59SmashingPumpkins+ISIMIPyields_h12_validation_debug.tgz")

calib<-list()
calib[["rcp7p0_CYGMA_GFDL"]][["mixed_feb17"]]<-"calibration_H12_rcp7p0_CYGMA_GFDL_mixed_feb17__08May21.tgz"
calib[["rcp8p5_CYGMA_GFDL"]][["mixed_feb17"]]<-"calibration_H12_rcp8p5_CYGMA_GFDL_mixed_feb17__08May21.tgz"
calib[["rcp8p5_pDSSAT_GFDL"]][["mixed_feb17"]]<-"calibration_H12_rcp8p5_pDSSAT_GFDL_mixed_feb17__09May21.tgz"
calib[["rcp8p5_CYGMA_UKESM"]][["mixed_feb17"]]<-"calibration_H12_rcp8p5_CYGMA_UKESM_mixed_feb17__09May21.tgz"
calib[["rcp8p5_pDSSAT_UKESM"]][["mixed_feb17"]]<-"calibration_H12_rcp8p5_pDSSAT_UKESM_mixed_feb17__09May21.tgz"
calib[["rcp7p0_CYGMA_UKESM"]][["mixed_feb17"]]<-"calibration_H12_rcp7p0_CYGMA_UKESM_mixed_feb17__09May21.tgz"
calib[["rcp8p5_EPIC_GFDL"]][["mixed_feb17"]]<-"calibration_H12_rcp8p5_EPIC_GFDL_mixed_feb17__07May21.tgz"
calib[["rcp8p5_EPIC_UKESM"]][["mixed_feb17"]]<-"calibration_H12_rcp8p5_EPIC_UKESM_mixed_feb17__07May21.tgz"
calib[["rcp7p0_EPIC_UKESM"]][["mixed_feb17"]]<-"calibration_H12_rcp7p0_EPIC_UKESM_mixed_feb17__07May21.tgz"
calib[["rcp7p0_EPIC_GFDL"]][["mixed_feb17"]]<-"calibration_H12_rcp7p0_EPIC_GFDL_mixed_feb17__07May21.tgz"

calib[["rcp7p0_CYGMA_GFDL"]][["sticky_feb18"]]<-"calibration_H12_rcp7p0_CYGMA_GFDL_sticky_feb18_dynamic_08May21.tgz"
calib[["rcp8p5_CYGMA_GFDL"]][["sticky_feb18"]]<-"calibration_H12_rcp8p5_CYGMA_GFDL_sticky_feb18_dynamic_08May21.tgz"
calib[["rcp8p5_pDSSAT_GFDL"]][["sticky_feb18"]]<-"calibration_H12_rcp8p5_pDSSAT_GFDL_sticky_feb18_dynamic_09May21.tgz"
calib[["rcp8p5_CYGMA_UKESM"]][["sticky_feb18"]]<-"calibration_H12_rcp8p5_CYGMA_UKESM_sticky_feb18_dynamic_09May21.tgz"
calib[["rcp8p5_pDSSAT_UKESM"]][["sticky_feb18"]]<-"calibration_H12_rcp8p5_pDSSAT_UKESM_sticky_feb18_dynamic_09May21.tgz"
calib[["rcp7p0_CYGMA_UKESM"]][["sticky_feb18"]]<-"calibration_H12_rcp7p0_CYGMA_UKESM_sticky_feb18_dynamic_09May21.tgz"
calib[["rcp8p5_EPIC_GFDL"]][["sticky_feb18"]]<-"calibration_H12_rcp8p5_EPIC_GFDL_sticky_feb18_dynamic_07May21.tgz"
calib[["rcp8p5_EPIC_UKESM"]][["sticky_feb18"]]<-"calibration_H12_rcp8p5_EPIC_UKESM_sticky_feb18_dynamic_07May21.tgz"
calib[["rcp7p0_EPIC_UKESM"]][["sticky_feb18"]]<-"calibration_H12_rcp7p0_EPIC_UKESM_sticky_feb18_dynamic_07May21.tgz"
calib[["rcp7p0_EPIC_GFDL"]][["sticky_feb18"]]<-"calibration_H12_rcp7p0_EPIC_GFDL_sticky_feb18_dynamic_07May21.tgz"

aux<-1

### Normal
for (i in realization){
  for (com in combo){
    for (so in sticky_modes){
        for (c in climate){

          cfg<-gms::setScenario(cfg,c)
          #configurations
          cfg$title<-paste0("NewBranch_F_",com,"_",i,"_",so,"_",c,"_")
          cfg$recalibrate <- FALSE

          cfg$input <- c(input,
                         paste0("rev4.59SmashingPumpkins+ISIMIPyields_h12_",hashes_combos[aux],"_cellularmagpie_debug.tgz"),
                         calib[[com]][[i]])
          cfg$output <- c("rds_report")


          #Special modules
          cfg$gms$factor_costs <- i
          if(i == "sticky_feb18"){
          cfg$gms$c38_sticky_mode  <- so
           }
          cfg$gms$yields  <- "managementcalib_aug19"

         start_run(cfg,codeCheck=FALSE)

         aux<-aux+1
       }
     }
   }
}

combo<-c("rcp7p0_LPJML_GFDL_newParam"
        )
climate<-c("cc","nocc")

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
      for (c in climate){

          #configurations
          cfg$title<-paste0("NewBranch_F_",com,"_",i,"_",so,"_",c,"_")
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
}
