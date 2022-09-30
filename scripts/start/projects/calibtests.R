# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


# ------------------------------------------------
# description: Default script for all India-specific runs
# ------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################


source("scripts/start_functions.R")
source("config/default.cfg")

cfg$title <- "2909_nocalib"

cfg$input <- c(regional    = "rev4.77_h12_magpie.tgz",
               cellular    = "rev4.77_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
               validation  = "rev4.77_h12_validation.tgz",
               additional  = "additional_data_rev4.30.tgz")

#Download input data
cfg$force_download <- TRUE
cfg$recalibrate <- TRUE


#setting aquastat calibration to 1
cfg$gms$s14_calib_ir2rf <- 0       # def = 1
#start MAgPIE run
start_run(cfg)

######################################


source("scripts/start_functions.R")
source("config/default.cfg")

cfg$title <- "2909_yescalib"

cfg$input <- c(regional    = "rev4.75ir2rfRatio_h12_magpie.tgz",
               cellular    = "rev4.75ir2rfRatio_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
               validation  = "rev4.75ir2rfRatio_h12_validation.tgz",
               additional  = "additional_data_rev4.30.tgz")
  #             calibration = "calibration_H12_per_ton_fao_may22+NOir2rfCalib_01Sep22.tgz")

#Download input data
cfg$force_download <- TRUE
cfg$recalibrate <- TRUE


#setting aquastat calibration to 1
cfg$gms$s14_calib_ir2rf <- 1       # def = 1
#start MAgPIE run
start_run(cfg)

######################################

source("scripts/start_functions.R")
source("config/default.cfg")

cfg$title <- "2909_India"

##Input data files to be used for India-specific analysis
cfg$input <- c(cellular = "rev4.77_2609_indiaYields__h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
        regional = "rev4.77_2609_indiaYields__h12_magpie.tgz",
        validation = "rev4.77_2609_indiaYields__h12_validation.tgz",
#        calibration = "calibration_Indiacalibration_473_27Jun22.tgz",
        additional = "additional_data_rev4.30.tgz")

##Please always use the updated `calibration` and `additional` files from the main default.cfg file

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL),
                                           getOption("magpie_repos"))

#Download input data
cfg$force_download <- TRUE
cfg$recalibrate <- TRUE

#start MAgPIE run
start_run(cfg)
