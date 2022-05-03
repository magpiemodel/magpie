
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


####################################################################333
##EFP 30%

source("scripts/start_functions.R")
source("config/default.cfg")

# short description of the actual run
cfg$title <- "2604_yield50_efp_30percent"

cfg$gms$c42_env_flow_policy <- "mixed"             # def = "off"
cfg$gms$EFP_countries <- "IND" # def = all_iso_countries
cfg$gms$s42_env_flow_scenario <- 1            # def = 2
cfg$gms$s42_env_flow_fraction <- 0.3           # def = 0.2


cfg$input <- c(cellular = "rev4.67_2204_indiaYields_05_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
        regional = "rev4.67_2204_indiaYields_05_h12_magpie.tgz",
        validation = "rev4.67_2204_indiaYields_05_h12_validation.tgz",
        calibration = "calibration_H12_mixed_feb17_18Jan22.tgz",
        additional = "additional_data_rev4.08.tgz")

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL),
                                           getOption("magpie_repos"))

start_run(cfg, codeCheck=FALSE)

####################################################################333
##EFP 40%

source("scripts/start_functions.R")
source("config/default.cfg")

# short description of the actual run
cfg$title <- "2604_yield50_efp_40percent"

cfg$gms$c42_env_flow_policy <- "mixed"             # def = "off"
cfg$gms$EFP_countries <- "IND" # def = all_iso_countries
cfg$gms$s42_env_flow_scenario <- 1            # def = 2
cfg$gms$s42_env_flow_fraction <- 0.4           # def = 0.2


cfg$input <- c(cellular = "rev4.67_2204_indiaYields_05_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
        regional = "rev4.67_2204_indiaYields_05_h12_magpie.tgz",
        validation = "rev4.67_2204_indiaYields_05_h12_validation.tgz",
        calibration = "calibration_H12_mixed_feb17_18Jan22.tgz",
        additional = "additional_data_rev4.08.tgz")

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL),
                                           getOption("magpie_repos"))

start_run(cfg, codeCheck=FALSE)
