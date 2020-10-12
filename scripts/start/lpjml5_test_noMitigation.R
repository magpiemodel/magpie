######################################################################################
#### Script to start a MAgPIE run using different factor_costs realizations ##########
######################################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Sources the default configuration file
source("config/default.cfg")

#List of clusterin types
#clustering<-c("n200","c200")
clustering<-c("c200","m200")

#Factor cost realizations
realization<-c("mixed_feb17","sticky_feb18")
climate<-c("cc")
#AEI<-c("LUH2v2","Siebert")
AEI<-c("LUH2v2")

for (k in 1:length(clustering)){
  for (i in 1:length(AEI)){
    for(j in 1:length(realization)){


        #Inputs
        if(clustering[k]=="c200"){

          cfg$input <- c("rev4.51+mrmagpie8_h12_magpie_debug.tgz",
                 "rev4.51+mrmagpie8_h12_cfc9a5551f05ca4efc6cbc7016516432_cellularmagpie_debug.tgz",
                 "rev4.51+mrmagpie8_h12_validation_debug.tgz",
                 "additional_data_rev3.85.tgz"
                )

        }else if(clustering[k]=="m200"){

          cfg$input <- c("rev4.51+mrmagpie8_h12_magpie_debug.tgz",
                 "rev4.51+mrmagpie8_h12_0fd3d50f15b9a42b430a6039e951d873_cellularmagpie_debug.tgz",
                 "rev4.51+mrmagpie8_h12_validation_debug.tgz",
                 "additional_data_rev3.85.tgz"
              )
        }


        #Change the results folder name
        cfg$title<-paste0("LPj_T_BC_",realization[j],"_",clustering[k],"_",AEI[i],"_","rcp2p6","_CO2_",climate[1])


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
        cfg$gms$c14_yields_scenario  <- climate[1]
        cfg$gms$c42_watdem_scenario  <- climate[1]
        cfg$gms$c52_carbon_scenario  <- climate[1]
        cfg$gms$c43_watavail_scenario<- climate[1]
        cfg$gms$c59_som_scenario  <- climate[1]

        start_run(cfg=cfg)
        }
      }
    }
