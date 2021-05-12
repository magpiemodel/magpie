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


realization<-c("sticky_feb18","mixed_feb17")

#"rcp7p0_EPIC_GFDL","rcp7p0_CYGMA_GFDL","rcp8p5_EPIC_UKESM",
combo<-c("rcp8p5_pDSSAT_UKESM","rcp8p5_CYGMA_UKESM","rcp8p5_EPIC_GFDL","rcp7p0_EPIC_UKESM","rcp8p5_CYGMA_GFDL","rcp8p5_pDSSAT_GFDL","rcp7p0_CYGMA_UKESM")
#"669b91c3","c6f10324","c0547439",
hashes_combos<-c("256c3ab7","e61ed473","82675b72","6bd5239a","d972a1ce","5b2b868c","41ad9618")

climate<-c("cc","nocc")
input<-c("additional_data_rev4.02.tgz",
         "rev4.59SmashingPumpkins+StickyFiles_h12_magpie_debug.tgz",
         "rev4.59SmashingPumpkins+ISIMIPyields_h12_validation_debug.tgz")

calib1<-list()
calib1[["rcp7p0_CYGMA_GFDL"]][["mixed_feb17"]][[""]]<-"calibration_H12_fix_rcp7p0_CYGMA_GFDL_mixed_feb17__11May21.tgz"
calib1[["rcp8p5_CYGMA_GFDL"]][["mixed_feb17"]][[""]]<-"calibration_H12_fix_rcp8p5_CYGMA_GFDL_mixed_feb17__11May21.tgz"
calib1[["rcp8p5_pDSSAT_GFDL"]][["mixed_feb17"]][[""]]<-"calibration_H12_fix_rcp8p5_pDSSAT_GFDL_mixed_feb17__11May21.tgz"
calib1[["rcp8p5_CYGMA_UKESM"]][["mixed_feb17"]][[""]]<-"calibration_H12_fix_rcp8p5_CYGMA_UKESM_mixed_feb17__11May21.tgz"
calib1[["rcp8p5_pDSSAT_UKESM"]][["mixed_feb17"]][[""]]<-"calibration_H12_fix_rcp8p5_pDSSAT_UKESM_mixed_feb17__11May21.tgz"
calib1[["rcp7p0_CYGMA_UKESM"]][["mixed_feb17"]][[""]]<-"calibration_H12_fix_rcp7p0_CYGMA_UKESM_mixed_feb17__12May21.tgz"
calib1[["rcp8p5_EPIC_GFDL"]][["mixed_feb17"]][[""]]<-"calibration_H12_fix_rcp8p5_EPIC_GFDL_mixed_feb17__12May21.tgz"
calib1[["rcp8p5_EPIC_UKESM"]][["mixed_feb17"]][[""]]<-"calibration_H12_fix_rcp8p5_EPIC_UKESM_mixed_feb17__12May21.tgz"
calib1[["rcp7p0_EPIC_UKESM"]][["mixed_feb17"]][[""]]<-"calibration_H12_fix_rcp7p0_EPIC_UKESM_mixed_feb17__12May21.tgz"
calib1[["rcp7p0_EPIC_GFDL"]][["mixed_feb17"]][[""]]<-"calibration_H12_fix_rcp7p0_EPIC_GFDL_mixed_feb17__12May21.tgz"

calib2<-list()
calib2[["rcp7p0_CYGMA_GFDL"]][["sticky_feb18"]][["dynamic"]]<-"calibration_H12_fix_rcp7p0_CYGMA_GFDL_sticky_feb18_dynamic_11May21.tgz"
calib2[["rcp8p5_CYGMA_GFDL"]][["sticky_feb18"]][["dynamic"]]<-"calibration_H12_fix_rcp8p5_CYGMA_GFDL_sticky_feb18_dynamic_11May21.tgz"
calib2[["rcp8p5_pDSSAT_GFDL"]][["sticky_feb18"]][["dynamic"]]<-"calibration_H12_fix_rcp8p5_pDSSAT_GFDL_sticky_feb18_dynamic_11May21.tgz"
calib2[["rcp8p5_CYGMA_UKESM"]][["sticky_feb18"]][["dynamic"]]<-"calibration_H12_fix_rcp8p5_CYGMA_UKESM_sticky_feb18_dynamic_11May21.tgz"
calib2[["rcp8p5_pDSSAT_UKESM"]][["sticky_feb18"]][["dynamic"]]<-"calibration_H12_fix_rcp8p5_pDSSAT_UKESM_sticky_feb18_dynamic_11May21.tgz"
calib2[["rcp7p0_CYGMA_UKESM"]][["sticky_feb18"]][["dynamic"]]<-"calibration_H12_fix_rcp7p0_CYGMA_UKESM_sticky_feb18_dynamic_11May21.tgz"
calib2[["rcp8p5_EPIC_GFDL"]][["sticky_feb18"]][["dynamic"]]<-"calibration_H12_fix_rcp8p5_EPIC_GFDL_sticky_feb18_dynamic_11May21.tgz"
calib2[["rcp8p5_EPIC_UKESM"]][["sticky_feb18"]][["dynamic"]]<-"calibration_H12_fix_rcp8p5_EPIC_UKESM_sticky_feb18_dynamic_12May21.tgz"
calib2[["rcp7p0_EPIC_UKESM"]][["sticky_feb18"]][["dynamic"]]<-"calibration_H12_fix_rcp7p0_EPIC_UKESM_sticky_feb18_dynamic_12May21.tgz"
calib2[["rcp7p0_EPIC_GFDL"]][["sticky_feb18"]][["dynamic"]]<-"calibration_H12_fix_rcp7p0_EPIC_GFDL_sticky_feb18_dynamic_12May21.tgz"

calib3<-list()
calib3[["rcp7p0_CYGMA_GFDL"]][["sticky_feb18"]][["free"]]<-"calibration_H12_fix_rcp7p0_CYGMA_GFDL_sticky_feb18_free_11May21.tgz"
calib3[["rcp8p5_CYGMA_GFDL"]][["sticky_feb18"]][["free"]]<-"calibration_H12_fix_rcp8p5_CYGMA_GFDL_sticky_feb18_free_11May21.tgz"
calib3[["rcp8p5_pDSSAT_GFDL"]][["sticky_feb18"]][["free"]]<-"calibration_H12_fix_rcp8p5_pDSSAT_GFDL_sticky_feb18_free_11May21.tgz"
calib3[["rcp8p5_CYGMA_UKESM"]][["sticky_feb18"]][["free"]]<-"calibration_H12_fix_rcp8p5_CYGMA_UKESM_sticky_feb18_free_11May21.tgz"
calib3[["rcp8p5_pDSSAT_UKESM"]][["sticky_feb18"]][["free"]]<-"calibration_H12_fix_rcp8p5_pDSSAT_UKESM_sticky_feb18_free_11May21.tgz"
calib3[["rcp7p0_CYGMA_UKESM"]][["sticky_feb18"]][["free"]]<-"calibration_H12_fix_rcp7p0_CYGMA_UKESM_sticky_feb18_free_11May21.tgz"
calib3[["rcp8p5_EPIC_GFDL"]][["sticky_feb18"]][["free"]]<-"calibration_H12_fix_rcp8p5_EPIC_GFDL_sticky_feb18_free_11May21.tgz"
calib3[["rcp8p5_EPIC_UKESM"]][["sticky_feb18"]][["free"]]<-"calibration_H12_fix_rcp8p5_EPIC_UKESM_sticky_feb18_free_11May21.tgz"
calib3[["rcp7p0_EPIC_UKESM"]][["sticky_feb18"]][["free"]]<-"calibration_H12_fix_rcp7p0_EPIC_UKESM_sticky_feb18_free_12May21.tgz"
calib3[["rcp7p0_EPIC_GFDL"]][["sticky_feb18"]][["free"]]<-"calibration_H12_fix_rcp7p0_EPIC_GFDL_sticky_feb18_free_12May21.tgz"



aux<-1

### Normal

  for (com in combo){
    for (i in realization){
        for (so in sticky_modes){
          if(com == "rcp8p5_CYGMA_UKESM" & i == "sticky_feb18" & so == "dynamic"){
            climate<-c("nocc")
          }else{
            climate<-c("cc","nocc")
          }
              for (c in climate){

          calib<-list()
          cfg<-gms::setScenario(cfg,c)
          #configurations
          cfg$title<-paste0("ClIm_",com,"_",i,"_",so,"_",c,"_")
          cfg$recalibrate <- FALSE

          if(so == ""){
            calib <- calib1
          }else if (so == "dynamic"){
            calib <- calib2
          }else if (so == "free"){
            calib <- calib3
          }

          cfg$input <- c(input,
                         paste0("rev4.59SmashingPumpkins+ISIMIPyields_h12_",hashes_combos[aux],"_cellularmagpie_debug.tgz"),
                         calib[[com]][[i]]
                         )
          cfg$output <- c("rds_report")


          #Special modules
          cfg$gms$factor_costs <- i
          if(i == "sticky_feb18"){
          cfg$gms$c38_sticky_mode  <- so
           }
          cfg$gms$yields  <- "managementcalib_aug19"
          cfg$gms$s14_yld_past_switch          <- 0.25
          cfg$gms$c41_initial_irrigation_area  <- "LUH2v2"


         start_run(cfg,codeCheck=FALSE)

         aux<-aux+1
       }
     }
   }
}


#  combo<-c("rcp7p0_LPJML_GFDL_bugFix")
#  climate<-c("cc","nocc")
#  realization<-c("mixed_feb17")
# #
# # #hashes_combos<-c("")
# #
# #
#  input<-c("additional_data_rev4.02.tgz",
#           "rev4.59SmashingPumpkins+StickyFiles_h12_magpie_debug.tgz",
#           "rev4.59SmashingPumpkins+ISIMIPyields_h12_validation_debug.tgz")
#
#  calib<-list()
#  calib[["mixed_feb17"]]<-"calibration_H12_rcp7p0_LPJML_GFDL_newParam_mixed_feb17__11May21.tgz"
# # calib[["sticky_feb18"]][["dynamic"]]<-"calibration_H12_rcp7p0_LPJML_GFDL_newParam_sticky_feb18_dynamic_11May21.tgz"
# # calib[["sticky_feb18"]][["free"]]<-"calibration_H12_rcp7p0_LPJML_GFDL_newParam_sticky_feb18_free_11May21.tgz"
#
# #aux<-1
#
### Normal
# for (i in realization){
#   for (com in combo){
#
#     if(i == "sticky_feb18"){
#     sticky_modes<-c("dynamic","free")
#   }else{
#     sticky_modes<-c("")
#   }
#
#     for (so in sticky_modes) {
#       for (c in climate){
#
#           cfg<-gms::setScenario(cfg,c)
#           #configurations
#           cfg$title<-paste0("ClIm_",com,"_",i,"_",so,"_",c,"_")
#           cfg$input <- c(input,
#                          paste0("rev4.59newparam+proxyYieldFix_h12_c5cdbf33_cellularmagpie_debug.tgz"),
#                          calib[[i]])
#
#
#           cfg$output <- c("rds_report")
#           cfg$gms$s14_yld_past_switch          <- 0.25
#           cfg$gms$c41_initial_irrigation_area  <- "LUH2v2"
#
#           #Special modules
#           cfg$gms$factor_costs <- i
#           if(i == "sticky_feb18"){
#           cfg$gms$c38_sticky_mode  <- so
#            }
#           cfg$gms$yields  <- "managementcalib_aug19"
#
#          start_run(cfg,codeCheck=FALSE)
#
#
#        }
#      }
#    }
# }
