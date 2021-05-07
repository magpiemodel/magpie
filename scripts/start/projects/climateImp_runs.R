######################################################################################
#### Script to start a MAgPIE run using different factor_costs realizations ##########
######################################################################################

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
realization<-c("mixed_feb17","sticky_feb18")
sticky_modes<-c("","dynamic")

combo<-c("rcp7p0_EPIC_GFDL")#,"rcp7p0_CYGMA_GFDL","rcp8p5_CYGMA_GFDL",
#        "rcp8p5_pDSSAT_GFDL","rcp8p5_EPIC_GFDL",
#        "rcp8p5_EPIC_UKESM","rcp8p5_CYGMA_UKESM","rcp8p5_pDSSAT_UKESM",
#        "rcp7p0_EPIC_UKESM","rcp7p0_CYGMA_UKESM"
#        )

hashes_combos<-c("669b91c3")#,"c6f10324","d972a1ce",
#                 "5b2b868c","82675b72",
#                 "c0547439","e61ed473","256c3ab7",
#                 "6bd5239a","41ad9618")
climate<-c("cc","nocc")

input<-c("additional_data_rev4.02.tgz",
         "rev4.59SmashingPumpkins+StickyFiles_h12_magpie_debug.tgz",
         "rev4.59SmashingPumpkins+ISIMIPyields_h12_validation_debug.tgz")

calibration<-("calibration_H12_rcp7p0_EPIC_GFDL_mixed_feb17__07May21.tgz",
              "calibration_H12_rcp7p0_EPIC_GFDL_sticky_feb18_dynamic_07May21.tgz")


### Normal
for (i in realization){
  for (com in combo){
    for (so in sticky_modes) {
      for (c in climate){

          # Set cc
          cfg<-gms::setScenario(cfg,c)
          #configurations
          cfg$title<-paste0("NewBranch_",com,"_",i,"_",so,"_",c,"_")
          cfg$input <- c(input,
                         paste0("rev4.59SmashingPumpkins+ISIMIPyields_h12_",hashes_combos[1],"_cellularmagpie_debug.tgz"),
                         paste0("calibration_H12_rcp7p0_EPIC_GFDL_",i,"__07May21.tgz") )

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
