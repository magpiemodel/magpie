######################################################################################
#### Script to start a MAgPIE run using different factor_costs realizations ##########
######################################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Sources the default configuration file
source("config/default.cfg")

#List of clusterin types
#clustering<-c("n200","c200")
clustering<-c("c200")

#Factor cost realizations
realization<-c("mixed_feb17","sticky_feb18")
climate<-c("cc","nocc")
#AEI<-c("LUH2v2","Siebert")
AEI<-c("LUH2v2")

for (k in 1:length(climate)){
  for (i in 1:length(AEI)){
    for(j in 1:length(realization)){

        #Change the results folder name
        #NBC STANDS FOR NEW BEST CALIBRATION
        cfg$title<-paste0("LPj_T_NBC_",realization[j],"_",clustering[k],"_","rcp2p6","_CO2_",climate[1])


        #recalibrate
        cfg$recalibrate <- TRUE

        #recalc_npi_ndc
        #cfg$recalc_npi_ndc <- TRUE

        #forestry
        cfg$gms$forestry  <- "static_sep16"

        #AEI
        cfg$gms$c41_initial_irrigation_area  <- AEI[i]

        #Factor costs realization
        cfg$gms$factor_costs <- realization[j]

        #Climate impact or not
        cfg$gms$c14_yields_scenario  <- climate[k]
        cfg$gms$c42_watdem_scenario  <- climate[k]
        cfg$gms$c52_carbon_scenario  <- climate[k]
        cfg$gms$c43_watavail_scenario<- climate[k]
        cfg$gms$c59_som_scenario  <- climate[k]

        start_run(cfg=cfg)
        }
      }
    }

    #
    #      if(clustering[k]=="m200_Land"){
    #
    #        cfg$input <- c("rev4.51+mrmagpie8_h12_magpie.tgz",
    #               "rev4.51+mrmagpie8_h12_93ba9cce36beb9a8e242a1fc6b1776cd_cellularmagpie.tgz",
    #               "rev4.51+mrmagpie8_h12_validation.tgz",
    #               "additional_data_rev3.85.tgz"
    #              )
    #
    #      }else if(clustering[k]=="sticky_feb18"){
    #
    #        cfg$input <- c("rev4.51+mrmagpie8_h12_magpie.tgz",
    #               "rev4.51+mrmagpie8_h12_4d77b3919c13daf7d986d7b542a45282_cellularmagpie.tgz",
    #               "rev4.51+mrmagpie8_h12_validation.tgz",
    #               "additional_data_rev3.85.tgz"
    #            )
    #      }

            #Inputs
    #        if(clustering[k]=="c200"){
    #
    #          cfg$input <- c("rev4.51+mrmagpie8_h12_magpie_debug.tgz",
    #                 "rev4.51+mrmagpie8_h12_cfc9a5551f05ca4efc6cbc7016516432_cellularmagpie_debug.tgz",
    #                 "rev4.51+mrmagpie8_h12_validation_debug.tgz",
    #                 "additional_data_rev3.85.tgz"
    #                )
    #
    #        }else if(clustering[k]=="m200"){
    #
    #          cfg$input <- c("rev4.51+mrmagpie8_h12_magpie_debug.tgz",
    #                 "rev4.51+mrmagpie8_h12_0fd3d50f15b9a42b430a6039e951d873_cellularmagpie_debug.tgz",
    #                 "rev4.51+mrmagpie8_h12_validation_debug.tgz",
    #                 "additional_data_rev3.85.tgz"
    #              )
    #        }

    #        cfg$input <- c("rev4.51+mrmagpie8_h12_magpie.tgz",
    #               "rev4.51+mrmagpie8_h12_ecbf5173fe4051486f34f8764d9fc8e7_cellularmagpie.tgz",
    #               "rev4.51+mrmagpie8_h12_validation.tgz",
    #               "additional_data_rev3.85.tgz"
    #              )
