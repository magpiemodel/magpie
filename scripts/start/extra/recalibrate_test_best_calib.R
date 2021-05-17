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

#start MAgPIE run
source("config/default.cfg")

realization<-c("mixed_feb17","sticky_feb18")

for (best in c(FALSE,TRUE)){
for (i in realization)
cfg$input <- c("additional_data_rev4.02.tgz",
               "rev4.59newparam+proxyYieldFix_h12_magpie_debug.tgz",
               "rev4.59newparam+proxyYieldFix_h12_c5cdbf33_cellularmagpie_debug.tgz",
               "rev4.59newparam_h12_validation_debug.tgz")

cfg$results_folder <- "output/:title:"
cfg$recalibrate <- TRUE
cfg$title <- paste0("calib_run_",best,"-",i,"_")
cfg$gms$c_timesteps <- 1
cfg$output <- c("rds_report")
cfg$sequential <- TRUE
cfg$best_calib <- best
cfg$crop_calib_max<- 1.5
cfg$gms$factor_costs <- i
cfg$gms$c38_sticky_mode <- "dynamic"


start_run(cfg,codeCheck=FALSE)
magpie4::submitCalibration("H12_best_calib_",best,"_",i,"_")
}
}
