# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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


##Input data files to be used for India-specific analysis
cfg$input <- c(cellular = "rev4.732706_indiaYields_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
        regional = "rev4.732706_indiaYields_h12_magpie.tgz",
        validation = "rev4.732706_indiaYields_h12_validation.tgz",
        calibration = "calibration_Indiacalibration_473_27Jun22.tgz",
        additional = "additional_data_rev4.26.tgz")

##Please always use the updated `calibration` and `additional` files from the main default.cfg file

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL),
                                           getOption("magpie_repos"))

#Download input data
cfg$force_download <- TRUE

#Setting pumping to 1
cfg$gms$s42_pumping <- 1
#Setting year from which pumping costs will be implemented
 cfg$gms$s42_multiplier_startyear <- 1995
##Pumping cost value to  default value for India
cfg$gms$s42_multiplier <- 1

cfg$recalibrate <- TRUE
