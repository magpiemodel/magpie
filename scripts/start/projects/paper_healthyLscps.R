# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Healthy Landscapes Paper
# ----------------------------------------------------------

rev <- "rev9"

# Note: rev4 used MAgPIE 4.6.9
# Note: rev6 used MAgPIE 4.6.10
# Note: rev7 used MAgPIE 4.6.11
# Note: rev8 used MAgPIE dev 16 Sep 2024
# Note: rev9 used MAgPIE 4.8.2

######################################
#### Script to start a MAgPIE run ####
######################################

library(gms)
library(lucode2)
library(magclass)
library(gdx2)

# Load start functions
source("scripts/start_functions.R")

# ====================
# Calibration
# ====================

source("config/default.cfg")

cfg$title <- "calib_run"
cfg$output <- c("rds_report", "validation_short")
cfg$force_replace <- TRUE

cfg$recalibrate <- TRUE
cfg$recalibrate_landconversion_cost <- TRUE

cfg$best_calib <- TRUE
cfg$best_calib_landconversion_cost <- FALSE

# cc is new default
cfg <- setScenario(cfg, "nocc_hist")

# New iso food realisation
cfg$gms$food <- "anthro_iso_jun22"

cfg$gms$s14_use_yield_calib <- 1

# sticky
cfg$gms$factor_costs <- "sticky_feb18"

# marginal land scenario
cfg$gms$c30_marginal_land <- "q33_marginal"

start_run(cfg = cfg)
calib_tgz <- magpie4::submitCalibration(paste(rev, "healthyLscps", sep = "_"))

# ====================
# Scenario runs
# ====================

prefix <- paste(rev, "healthyLscps", sep = "_")

SSPs <- c("SSP2", "SSP1", "SSP3")

scenarios <- c(
  "REF", "DIET100", "DIET50",
  "BIOS", "DIET100-BIOS", "DIET50-BIOS",
  "landConservation", "DIET100-landConservation", "DIET50-landConservation",
  "noNatureLoss2030", "DIET100-noNatureLoss2030", "DIET50-noNatureLoss2030",
  "SNV20", "DIET100-SNV20", "DIET50-SNV20"
)

for (ssp in SSPs) {
  for (scen in scenarios) {
    actions <- unlist(strsplit(scen, "-"))

    source("config/default.cfg")

    cfg$qos <- "short_highMem"

    cfg$results_folder <- "output/:title::date:"

    cfg$output <- c(
      "output_check", "extra/disaggregation", "rds_report", "extra/runSEALSallocation"
    )

    cfg$input["calibration"] <- calib_tgz

    # Climate change switched off for these runs
    cfg <- setScenario(cfg, "nocc_hist")

    # New iso food realisation
    cfg$gms$food <- "anthro_iso_jun22"

    cfg$gms$s14_use_yield_calib <- 1

    # sticky
    cfg$gms$factor_costs <- "sticky_feb18"

    # SNV habitat defintion
    cfg$gms$land_snv <- "secdforest, other"

    cfg <- setScenario(cfg, c(ssp, "NPI"))
    cfg$gms$c15_food_scenario <- ssp

    cfg$seals_years <- c(2020, 2050)

    # --- Dietary transitions ---

    # 50 % convergence towards EAT lancet diet
    if ("DIET50" %in% actions) {
      cfg <- setScenario(cfg, "eat_lancet_diet_v1")
      cfg$gms$s15_exo_foodscen_start <- 2020
      cfg$gms$s15_exo_foodscen_target <- 2050
      cfg$gms$s15_exo_foodscen_convergence <- 0.5
      cfg$gms$s15_exo_waste <- 1
    }

    # 100% convergence towards EAT lancet diet
    if ("DIET100" %in% actions) {
      cfg <- setScenario(cfg, "eat_lancet_diet_v1")
      cfg$gms$s15_exo_foodscen_start <- 2020
      cfg$gms$s15_exo_foodscen_target <- 2050
      cfg$gms$s15_exo_foodscen_convergence <- 1
      cfg$gms$s15_exo_waste <- 1
    }

    # --- Ecosystem stewarship actions ---

    # 30by30 land conservation
    if (any(actions %in% c("BIOS", "landConservation"))) {
      cfg$gms$c22_protect_scenario <- "30by30"
      cfg$gms$s22_conservation_start <- 2020
      cfg$gms$s22_conservation_target <- 2030
    }

    # no net nature loss
    if (any(actions %in% c("BIOS", "noNatureLoss2030"))) {
      cfg$gms$c44_bii_decrease <- 0
      cfg$gms$s44_start_year <- 2030
    }

    # permanent habitats in agricultural landscapes
    if (any(actions %in% c("BIOS", "SNV20"))) {
      cfg$gms$s29_snv_shr <- 0.2
      cfg$gms$s29_snv_scenario_start <- 2020
      cfg$gms$s29_snv_scenario_target <- 2030
    }

    # parameters are fixed to SSP2 values until 2020
    cfg <- setScenario(cfg, "fix_2020", scenario_config = "config/projects/scenario_config_year_fix.csv")

    cfg$title <- paste0(prefix, "_", ssp, "-", scen)
    start_run(cfg = cfg, codeCheck = FALSE)
  }
}
