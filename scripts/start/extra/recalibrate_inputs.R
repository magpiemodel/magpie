# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: calculate and store new calibration for different factor costs, AEI and clustering
# --------------------------------------------------------


library(magpie4)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

cfg$results_folder <- "output/:title:"
cfg$recalibrate <- TRUE

#realization<-c("mixed_feb17","sticky_feb18")
realization<-c("mixed_feb17")
#clustering<-c("n200","c200")
clustering<-c("n200")
#AEI<-c("LUH2v2","Siebert")
AEI<-c("LUH2v2")
#preloopCalib<-c("managementcalib_aug19","dynamic_aug18")
preloopCalib<-c("managementcalib_aug19")

for (i in realization){
  for (k in clustering){
    for (av in AEI){
      for (p in preloopCalib){
#removes previous calibration factors
remove <- dir(pattern=c(".cs3"))
file.remove(remove,recursive=FALSE)

cfg$force_download <- TRUE

cfg$gms$yields <- p

cfg$title <- paste0("calib_run_",i,"_",k,"_",av,"_",p)

#Selects factor costs realization
cfg$gms$factor_costs <- i

cfg$gms$c_timesteps <- 1
cfg$output <- c("report")
cfg$sequential <- TRUE

#Selects inputs based on clustering
if(k=="c200"){

  cfg$input <- c("rev4.47+mrmagpie7_h12_magpie_debug.tgz",
         "rev4.47+mrmagpie7_h12_238dd4e69b15586dde74376b6b84cdec_cellularmagpie_debug.tgz",
         "rev4.47+mrmagpie7_h12_validation_debug.tgz",
         "additional_data_rev3.85.tgz"
        )

}else if(k=="n200"){

  cfg$input <- c("rev4.47+mrmagpie7_h12_magpie_debug.tgz",
         "rev4.47+mrmagpie7_h12_4ade54491b634b981be2d6c4a0d17706_cellularmagpie_debug.tgz",
         "rev4.47+mrmagpie7_h12_validation_debug.tgz",
         "additional_data_rev3.85.tgz"
      )
}

# AEI switch

cfg$gms$c41_initial_irrigation_area  <- av


start_run(cfg,codeCheck=FALSE)
magpie4::submitCalibration(paste0("H12_",i,"_",k,"_",av,"_",p))
}
}}
}
