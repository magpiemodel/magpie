# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


# ------------------------------------------------
# description: India tests with input data and water scenarios
# ------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################

##Runs with new india input data and 3 scenarios for factor costs
source("scripts/start_functions.R")
source("config/default.cfg")

# short description of the actual run
#cfg$title <- "0203_newinputdata01"

#New input data as of 8th October used
cfg$input <- c(cellular = "rev4.67_0203_indiaYields01__h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
         regional = "rev4.67_0203_indiaYields01__h12_magpie.tgz",
         validation = "rev4.67_0203_indiaYields01__h12_validation.tgz",
         calibration = "calibration_H12_mixed_feb17_18Jan22.tgz",
         additional = "additional_data_rev4.08.tgz")

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL),
                                    getOption("magpie_repos"))

# Should input data be downloaded from source even if cfg$input did not change?
  cfg$force_download <- TRUE

  #Using mixed regional scenario for factor costs
  cfg$gms$factor_costs <- "mixed_reg_feb17"


#Iterations of factor costs in ssp2 food demand setting
for(i in seq(1, 2, by = 0.5)) {
  cfg$gms$s38_factor <- i
  cfg$title <- paste0("0603","_","factor","_",i,"_","indiaYields01")
  cfg$results_folder = "output/:title:"
  start_run(cfg)
}

####Test run with new input data 30% yield setting
#
#source("scripts/start_functions.R")
#source("config/default.cfg")

# short description of the actual run
#cfg$title <- "2402_newinputdata03"

#New input data as of 8th October used
#cfg$input <- c(cellular = "rev4.67_2402_indiaYields03__h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
#         regional = "rev4.67_2402_indiaYields03__h12_magpie.tgz",
#         validation = "rev4.67_2402_indiaYields03__h12_validation.tgz",
#         calibration = "calibration_H12_mixed_feb17_18Jan22.tgz",
#         additional = "additional_data_rev4.08.tgz")

#cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL),
      #                              getOption("magpie_repos"))

#  cfg$force_download <- TRUE

#start_run(cfg, codeCheck=F)


####Test run with new input data 02

#source("scripts/start_functions.R")
#ource("config/default.cfg")

# short description of the actual run
#cfg$title <- "2402_newinputdata02"

#New input data as of 8th October used
#cfg$input <- c(cellular = "rev4.67_2402_indiaYields02__h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
#         regional = "rev4.67_2402_indiaYields02__h12_magpie.tgz",
#         validation = "rev4.67_2402_indiaYields02__h12_validation.tgz",
#         calibration = "calibration_H12_mixed_feb17_18Jan22.tgz",
#         additional = "additional_data_rev4.08.tgz")

#cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL),
  #                                  getOption("magpie_repos"))

# Should input data be downloaded from source even if cfg$input did not change?
#  cfg$force_download <- TRUE

#start_run(cfg, codeCheck=F)

##Default run with default input data with agr_sector_aug13 water demand setting
#source("scripts/start_functions.R")
#source("config/default.cfg")

# short description of the actual run
#cfg$title <- "2402_defaultinputdata_agr"

#New input data as of 8th October used
#cfg$input <- c(cellular = "rev4.67_2402_default__h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
#         regional = "rev4.67_2402_default__h12_magpie.tgz",
#         validation = "rev4.67_2402_default__h12_validation.tgz",
#         calibration = "calibration_H12_mixed_feb17_18Jan22.tgz",
#         additional = "additional_data_rev4.08.tgz")

#cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL),
#                                    getOption("magpie_repos"))

# Should input data be downloaded from source even if cfg$input did not change?
#  cfg$force_download <- TRUE

#    cfg$gms$water_demand<- "agr_sector_aug13" # def = all_sectors_aug13
#    cfg$gms$c42_watdem_scenario  <- "nocc"   # def = "cc"


#start_run(cfg, codeCheck=F)


##30% yield setting with agr_sector_aug13 setting for water demand realization
#source("scripts/start_functions.R")
#source("config/default.cfg")

# short description of the actual run
#cfg$title <- "2402_newinputdata03_agr"

#New input data as of 8th October used
#cfg$input <- c(cellular = "rev4.67_2402_indiaYields03__h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
#         regional = "rev4.67_2402_indiaYields03__h12_magpie.tgz",
#         validation = "rev4.67_2402_indiaYields03__h12_validation.tgz",
#         calibration = "calibration_H12_mixed_feb17_18Jan22.tgz",
#         additional = "additional_data_rev4.08.tgz")

#cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL),
#                                    getOption("magpie_repos"))

# Should input data be downloaded from source even if cfg$input did not change?
#  cfg$force_download <- TRUE


#  cfg$gms$water_demand<- "agr_sector_aug13" # def = all_sectors_aug13
#  cfg$gms$c42_watdem_scenario  <- "nocc"   # def = "cc"


#start_run(cfg, codeCheck=F)

##Test run with India settings for water and yields reduction of 30%
#source("scripts/start_functions.R")
#source("config/default.cfg")

# short description of the actual run
#cfg$title <- "2402_newinputdata03_agrindia"

#New input data as of 8th October used
#cfg$input <- c(cellular = "rev4.67_2402_indiaYields03__h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
#         regional = "rev4.67_2402_indiaYields03__h12_magpie.tgz",
#         validation = "rev4.67_2402_indiaYields03__h12_validation.tgz",
#         calibration = "calibration_H12_mixed_feb17_18Jan22.tgz",
#         additional = "additional_data_rev4.08.tgz")

#cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL),
  #                                  getOption("magpie_repos"))

# Should input data be downloaded from source even if cfg$input did not change?
#  cfg$force_download <- TRUE

#  cfg$gms$water_demand<- "agr_sector_aug13" # def = all_sectors_aug13
#  cfg$gms$c42_watdem_scenario  <- "nocc"   # def = "cc"
#  cfg$gms$c42_rf_policy <- "mixed"             # def = "off"
#  cfg$gms$s42_shock_year <- 2020                #def = 1995
#  cfg$gms$s42_shock_scalar<- 0.4                #def = 0.4

#start_run(cfg, codeCheck=F)
