# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

library(gms)
library(lucode2)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")


# # ====================
# # Calibration
# # ====================
# #
# source("config/default.cfg")

# cfg$input <- c(
#   regional = "rev4.81FSEC_e2bdb6cd_magpie.tgz",
#   cellular = "rev4.81FSEC_e2bdb6cd_6819938d_cellularmagpie_c200_MRI-ESM2-0-ssp126_lpjml-8e6c5eb1.tgz",
#   validation = "rev4.81FSEC_e2bdb6cd_validation.tgz",
#   additional = "additional_data_rev4.38.tgz",
#   calibration = "calibration_FSEC_14Feb23.tgz",
#   patch = "consv_prio_fsec_c200.tgz"
# )
# cfg$repositories <- append(
#   list(
#     "https://rse.pik-potsdam.de/data/magpie/public" = NULL,
#     "../patch_inputdata" = NULL
#   ),
#   getOption("magpie_repos")
# )

# cfg$force_download <- TRUE

# cfg$title <- "calib_run"
# cfg$force_replace <- TRUE

# cfg$recalibrate <- TRUE
# cfg$recalibrate_landconversion_cost <- TRUE

# # sticky
# cfg$gms$factor_costs <- "sticky_feb18"

# # crop realisation
# cfg$gms$crop <- "endo_apr21"
# cfg$gms$c30_marginal_land <- "q33_marginal"

# cfg$gms$past <- "grasslands_apr22"

# start_run(cfg = cfg)
# calib_grass_tgz <- magpie4::submitCalibration("IrrC_test_v4_grass")


# =====================================
# Test runs
# =====================================

runID <- "v4"

# load config
source("config/default.cfg")

cfg$force_download <- TRUE

# sticky
cfg$gms$factor_costs <- "sticky_feb18"

# crop realisation
cfg$gms$crop <- "endo_apr21"
cfg$gms$c30_marginal_land <- "q33_marginal"

ambition <- c(
  "none", "IrrC_50pc", "IrrC_75pc",
  "IrrC_95pc", "IrrC_99pc", "IrrC_75pc_30by30",
  "IrrC_95pc_30by30", "IrrC_99pc_30by30"
)
# ambition <- "30by30"

# grass <- c("endo_jun13", "grasslands_apr22")
grass <- c("grasslands_apr22")

# cprice <- c("", "+Ctax")
cprice <- c("+Ctax")

for (g in grass) {
  if (g == "endo_jun13") {
    cfg$input <- c(
      regional = "rev4.81FSEC_e2bdb6cd_magpie.tgz",
      cellular = "rev4.81FSEC_e2bdb6cd_6819938d_cellularmagpie_c200_MRI-ESM2-0-ssp126_lpjml-8e6c5eb1.tgz",
      validation = "rev4.81FSEC_e2bdb6cd_validation.tgz",
      additional = "additional_data_rev4.38.tgz",
      calibration = "calibration_FSEC_14Feb23.tgz",
      patch = "consv_prio_fsec_c200.tgz"
    )
    cfg$repositories <- append(
      list(
        "https://rse.pik-potsdam.de/data/magpie/public" = NULL,
        "../patch_inputdata" = NULL
      ),
      getOption("magpie_repos")
    )
  } else {
    cfg$input <- c(
      regional = "rev4.81FSEC_e2bdb6cd_magpie.tgz",
      cellular = "rev4.81FSEC_e2bdb6cd_6819938d_cellularmagpie_c200_MRI-ESM2-0-ssp126_lpjml-8e6c5eb1.tgz",
      validation = "rev4.81FSEC_e2bdb6cd_validation.tgz",
      additional = "additional_data_rev4.38.tgz",
      calibration = "calibration_IrrC_test_v4_grass_23Feb23.tgz",
      patch = "consv_prio_fsec_c200.tgz"
    )
    cfg$repositories <- append(
      list(
        "https://rse.pik-potsdam.de/data/magpie/public" = NULL,
        "../patch_inputdata" = NULL
      ),
      getOption("magpie_repos")
    )
  }

  cfg$gms$past <- g

  for (ic in ambition) {
    cfg$gms$c22_protect_scenario <- ic

    for (i in 1:length(cprice)){

      if (cprice[i] == "+Ctax"){
        cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
      } else {
       cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"
      }


      if (g == "endo_jun13") {
        cfg$title <- paste0(runID, "_IrrC_ambition_test_", gsub("IrrC", "_", ic,"_",cprice[i]), "_oldPast")
      } else {
        cfg$title <- paste0(runID, "_IrrC_ambition_test_", gsub("IrrC", "_", ic,"_",cprice[i]), "_newGrass")
      }

    start_run(cfg, codeCheck = FALSE)
  }
  }
}
