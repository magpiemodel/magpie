# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: calculate and store new yield calib factors for realizations of factor costs (land conversion cost calibration factors are only calculated if needed)
# --------------------------------------------------------

library(magpie4)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

realizations<-c("sticky_feb18","perTonFAO") #"sticky_labor" is very similar to sticky_feb18. No extra calibration needed.
type<-NULL
# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: calculate and store new yield calib factors for realizations of factor costs (land conversion cost calibration factors are only calculated if needed)
# --------------------------------------------------------

library(magpie4)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

realizations<-c("sticky_feb18","perTonFAO") #"sticky_labor" is very similar to sticky_feb18. No extra calibration needed.
type<-NULL

cfg$input <- c(regional    = "rev4.69_h12_magpie.tgz",
               cellular    = "rev4.69_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
               validation  = "rev4.69_h12_validation.tgz",
               additional  = "additional_data_rev4.10.tgz")

for(r in realizations){

      cfg$results_folder <- "output/:title:"
      cfg$recalibrate <- TRUE
      cfg$recalibrate_landconversion_cost <- "ifneeded"

      cfg$title <-  paste("calib_run",r,sep="_")

      cfg$output <- c("rds_report","validation_short")
      cfg$force_replace <- TRUE

      cfg$gms$factor_costs     <-   r


      start_run(cfg)
      magpie4::submitCalibration(paste("H12",r,t,sep="_"))
    }
