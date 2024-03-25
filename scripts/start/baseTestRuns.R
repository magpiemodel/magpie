# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Base test runs
# ----------------------------------------------------------

rev <- "rev1"

######################################
#### Script to start a MAgPIE run ####
######################################

library(gms)
library(lucode2)
library(magclass)

# Load start functions
source("scripts/start_functions.R")

# ====================
# Calibration
# ====================

# source("config/default.cfg")

# cfg$title <- "calib_run"
# cfg$output <- c("rds_report", "validation_short")

# cfg$recalibrate <- FALSE
# cfg$recalibrate_landconversion_cost <- TRUE

# # cc is new default
# cfg <- setScenario(cfg, "nocc_hist")

# # crop penalty realisation
# cfg$gms$crop <- "endo_apr21"

# # sticky
# cfg$gms$factor_costs <- "sticky_feb18"

# # marginal land scenario
# cfg$gms$c30_marginal_land <- "q33_marginal"

# start_run(cfg = cfg)
# calib_tgz <- magpie4::submitCalibration(paste(rev, "testRuns", sep = "_"))

# ====================
# Scenario runs
# ====================

prefix <- paste(rev, "3rdPaperTests", sep = "_")

# scenarios <- c("SSP1", "SSP2", "SSP3", "SSP4", "SSP5",
#                "SSP2-PB650-R", "SSP2-PB1050-R",
#                "SSP2-PB650-P", "SSP2-PB1050-P")

# scenarios <- c("SSP2-PB650-R", "SSP2-PB1050-R",
#                "SSP2-PB650-P", "SSP2-PB1050-P")

scenarios <- c("SSP2-PB650-Pmax-30by30", "SSP2-PB650-R-30by30",
               "SSP2-PB650-Pmax-KBA", "SSP2-PB650-R-KBA",
               "SSP2-PB650-Pmax-GSN_DSA", "SSP2-PB650-R-GSN_DSA",
               "SSP2-PB650-Pmax-GSN_RarePhen", "SSP2-PB650-R-GSN_RarePhen",
               "SSP2-PB650-Pmax-CCA", "SSP2-PB650-R-CCA",
               "SSP2-PB650-Pmax-BH", "SSP2-PB650-R-BH")

  for (scen in scenarios) {

    scen <- unlist(strsplit(scen, "-"))
    ssp <- scen[grepl("SSP", scen)]

    if(length(ssp) == 0){
      ssp <- "SSP2"
    }

    source("config/default.cfg")

    cfg$results_folder <- "output/:title::date:"

    cfg$output <- c(
      "output_check", "extra/disaggregation", "rds_report",
      "extra/reportMAgPIE2SEALS", "projects/FSEC_cropDiversityGrid"
    )

    cfg$input <- c(regional = "rev4.96_h12_magpie.tgz",
               cellular    = "rev4.96_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
               validation  = "rev4.96_h12_validation.tgz",
               additional  = "additional_data_rev4.47.tgz",
              #  calibration = calib_tgz
               calibration = "calibration_rev1_testRuns_10Jan24.tgz"
    )

    # Climate change switched off for these runs
    cfg <- setScenario(cfg, "nocc_hist")

    # sticky
    cfg$gms$factor_costs <- "sticky_feb18"

    # crop realisation
    cfg$gms$crop <- "endo_apr21"
    cfg$gms$c30_marginal_land <- "q33_marginal"

    # SNV habitat defintion
    cfg$gms$land_snv <- "secdforest, other"

    cfg <- setScenario(cfg, c(ssp, "NPI"))

    if ("PB650" %in% scen) {
      cfg <- setScenario(cfg, c(ssp, "NDC"))
      cfg$gms$c56_pollutant_prices <- "R32M46-SSP2EU-PkBudg650"
      cfg$gms$c56_emis_policy <- "redd+natveg_nosoil"
      cfg$gms$c60_2ndgen_biodem <- "R32M46-SSP2EU-PkBudg650"
    }

    if ("PB1050" %in% scen) {
      cfg <- setScenario(cfg, c(ssp, "NDC"))
      cfg$gms$c56_pollutant_prices <- "R32M46-SSP2EU-PkBudg1050"
      cfg$gms$c56_emis_policy <- "redd+natveg_nosoil"
      cfg$gms$c60_2ndgen_biodem <- "R32M46-SSP2EU-PkBudg1050"
    }

    if ("P" %in% scen) {
      cfg$gms$s32_aff_plantation <- 1
      cfg$gms$s32_aff_bii_coeff <- 1
    }

    if (all(c("PB1050", "Pmax") %in% scen)) {
      cfg$gms$s32_aff_plantation <- 1
      cfg$gms$s32_aff_bii_coeff <- 1
      cfg$gms$s32_max_aff_area <- 300
    }

    if (all(c("PB650", "Pmax") %in% scen)) {
      cfg$gms$s32_aff_plantation <- 1
      cfg$gms$s32_aff_bii_coeff <- 1
      cfg$gms$s32_max_aff_area <- 350
    }

    if ("30by30" %in% scen) {
     cfg$gms$c22_protect_scenario <- "30by30"
    }

    if ("KBA" %in% scen) {
     cfg$gms$c22_protect_scenario <- "KBA"
    }

    if ("GSN_RarePhen" %in% scen) {
     cfg$gms$c22_protect_scenario <- "GSN_DSA"
    }

    if ("30by30" %in% scen) {
     cfg$gms$c22_protect_scenario <- "GSN_RarePhen"
    }

    if ("CCA" %in% scen) {
     cfg$gms$c22_protect_scenario <- "CCA"
    }

    if ("BH" %in% scen) {
     cfg$gms$c22_protect_scenario <- "BH"
    }

    cfg$title <- paste0(prefix, "_", paste(scen, collapse = "-"))
    start_run(cfg = cfg, codeCheck = FALSE)
  }
