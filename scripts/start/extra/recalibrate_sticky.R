# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: calculate and store new calibration factors
# --------------------------------------------------------

library(magpie4)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")
source("scripts/start/extra/lpjml_addon.R")

realization<- c("sticky_feb18","sticky_feb18","fixed_per_ton_mar18","mixed_feb17")
mode<-c("free","dynamic","","")

#start MAgPIE run

for(s in mode){
for (r in realization){

  cfg$input <- c(cellular    = "rev4.63_h12_a3fb0fc7_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-066f36d1.tgz",
                 regional    = "rev4.63_h12_magpie.tgz",
                 validation  = "rev4.63_h12_validation.tgz",
                 additional  = cfg$input[grep("additional_data", cfg$input)])

      cfg$results_folder <- "output/:title:"
      cfg$recalibrate <- TRUE
      cfg$title <- paste0("cal_NewDefaults_",r,"_",s,"_")
      cfg$gms$factor_costs<- r
      cfg$gms$c38_sticky_mode<- s

      cfg$gms$c_timesteps <- 1
      cfg$output <- c("rds_report")
      cfg$sequential <- TRUE
      cfg$force_download <- TRUE

      start_run(cfg,codeCheck=FALSE)
      magpie4::submitCalibration(paste0("H12_",r,"_",s))
}}
