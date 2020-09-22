######################################################################################
#### Script to start a MAgPIE run using different factor_costs realizations ##########
######################################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Sources the default configuration file
source("config/default.cfg")

#List of clusterin types
clustering<-c("n200")

#Factor cost realizations
realization<-c("mixed_feb17")
climate<-c("cc")


for (k in 1:length(clustering)){
  for (i in 1:length(climate)){
    for(j in 1:length(realization)){


        #Inputs
        if(clustering[k]=="c200"){

          cfg$input <- c("rev4.47+mrmagpie6_h12_magpie.tgz",
                 "rev4.47+mrmagpie7_h12_238dd4e69b15586dde74376b6b84cdec_cellularmagpie_debug.tgz",
                 "rev4.47+mrmagpie6_h12_validation.tgz",
                 "additional_data_rev3.85.tgz",
                 paste0("calibration_H12_",realization[j],"_21Sep20.tgz")
                )

        }else if(clustering[k]=="n200"){

          cfg$input <- c("rev4.47+mrmagpie6_h12_magpie.tgz",
                 "rev4.47+mrmagpie7_h12_4ade54491b634b981be2d6c4a0d17706_cellularmagpie_debug.tgz",
                 "rev4.47+mrmagpie6_h12_validation.tgz",
                 "additional_data_rev3.85.tgz",
                paste0("calibration_H12_",realization[j],"_21Sep20.tgz")
              )
        }


        #Change the results folder name
        cfg$title<-paste0("LPj_T_",realization[j],"_",clustering[k],"_HadGEM2_ES","_","rcp2p6","_CO2_",climate[i])


        #recalibrate
        cfg$recalibrate <- FALSE

        #recalc_npi_ndc
        #cfg$recalc_npi_ndc <- TRUE

        #forestry
        cfg$gms$forestry  <- "static_sep16"


        #Factor costs realization
        cfg$gms$factor_costs <- realization[j]

        #Climate impact or not
        cfg$gms$c14_yields_scenario  <- climate[i]
        cfg$gms$c42_watdem_scenario  <- climate[i]
        cfg$gms$c52_carbon_scenario  <- climate[i]
        cfg$gms$c43_watavail_scenario<- climate[i]
        cfg$gms$c59_som_scenario  <- climate[i]

        start_run(cfg=cfg)
        }
      }
    }
