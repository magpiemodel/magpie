# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -------------------------------------------------------------
# description: Land-based mitigation and habitat conservation
# -------------------------------------------------------------

rev <- "rev16"

cres <- "c200"

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

cfg$title <- paste0(rev, "_calib_MitiConsv")
cfg$output <- c("rds_report", "validation_short")
cfg$force_replace <- TRUE

# land conversion cost calibration settings
cfg$recalibrate_landconversion_cost <- TRUE
cfg$restart_landconversion_cost <- FALSE
cfg$best_calib_landconversion_cost <- FALSE

cfg$calib_accuracy_landconversion_cost <- 0.01
cfg$lowpass_filter_landconversion_cost <- 1

# cc is new default
cfg <- setScenario(cfg, c("SSP2EU", "nocc_hist", "NPI", "ForestryExo"))
cfg <- setScenario(cfg, c("MitiConsv"), scenario_config = "config/projects/scenario_config_miti_consv.csv")

# sticky
cfg$gms$factor_costs <- "sticky_feb18"

# SNV habitat defintion
cfg$gms$land_snv <- "secdforest, other"

# marginal land scenario
cfg$gms$c29_marginal_land <- "q33_marginal"

start_run(cfg = cfg)
calib_tgz <- magpie4::submitCalibration(paste(rev, "MitiConsv", sep = "_"))

# ====================
# Scenario runs
# ====================

prefix <- paste(rev, "MitiConsv", cres, sep = "_")

scenarios <- c(
  "SSP2-REF", "SSP2-PB650-AR", "SSP2-PB650-AvC",
  "SSP2-PB1000-AR", "SSP2-PB1000-AvC",
  "SSP2-PB650-AR-BH", "SSP2-PB650-AvC-BH",
  "SSP2-PB1000-AR-BH", "SSP2-PB1000-AvC-BH",
  "SSP2-PB650-AR-KBA", "SSP2-PB650-AvC-KBA",
  "SSP2-PB1000-AR-KBA", "SSP2-PB1000-AvC-KBA"
)

for (scen in scenarios) {
  scen <- unlist(strsplit(scen, "-"))
  ssp <- scen[grepl("SSP", scen)]

  if (length(ssp) == 0 || ssp == "SSP2") {
    ssp <- "SSP2EU"
  }

  source("config/default.cfg")

  cfg$qos <- "short_highMem"

  cfg$results_folder <- "output/:title::date:"

  cfg$output <- c(
    "output_check", "extra/disaggregation", "rds_report", "extra/runSEALSallocation"
  )

  # Climate change switched off for these runs
  cfg <- setScenario(cfg, c(ssp, "nocc_hist", "NPI", "ForestryExo"))
  cfg <- setScenario(cfg, c("MitiConsv"), scenario_config = "config/projects/scenario_config_miti_consv.csv")

  # Calibration settings
  cfg$input["calibration"] <- calib_tgz

  # sticky
  cfg$gms$factor_costs <- "sticky_feb18"

  # SNV habitat defintion
  cfg$gms$land_snv <- "secdforest, other"

  # Set path to coupled output
  pathToCoupledOutput <- "/p/projects/magpie/users/vjeetze/magpie/projects/MitiConsv/C_MitiConsv_Jan25/remind/output/C_rev6_MitiConsv_SSP2-NPi-rem-12/REMIND_generic_C_rev6_MitiConsv_SSP2-NPi-rem-12.mif"

  # No ghg price in NPI run
  cfg$gms$c56_mute_ghgprices_until <- "y2100"

  if ("PB650" %in% scen) {
    cfg <- setScenario(cfg, "NDC")
    # Update path to coupled output
    pathToCoupledOutput <- "/p/projects/magpie/users/vjeetze/magpie/projects/MitiConsv/C_MitiConsv_Jan25/remind/output/C_rev6_MitiConsv_SSP2-PkBudg650-rem-12/REMIND_generic_C_rev6_MitiConsv_SSP2-PkBudg650-rem-12.mif"
    cfg$gms$c56_mute_ghgprices_until <- "y2030"
  }

  if ("PB1000" %in% scen) {
    cfg <- setScenario(cfg, "NDC")
    # Update path to coupled output
    pathToCoupledOutput <- "/p/projects/magpie/users/vjeetze/magpie/projects/MitiConsv/C_MitiConsv_Jan25/remind/output/C_rev6_MitiConsv_SSP2-PkBudg1000-rem-12/REMIND_generic_C_rev6_MitiConsv_SSP2-PkBudg1000-rem-12.mif"
    cfg$gms$c56_mute_ghgprices_until <- "y2030"
  }

  if ("AR" %in% scen) {
    cfg$gms$c56_emis_policy <- "redd+natveg_nosoil"
  }

  if ("AvC" %in% scen) {
    cfg$gms$c56_emis_policy <- "redd+natveg_nosoil"
    cfg$gms$s56_c_price_induced_aff <- 0
  }

  if ("KBA" %in% scen) {
    cfg$gms$c22_protect_scenario <- "KBA"
  }

  if ("BH" %in% scen) {
    cfg$gms$c22_protect_scenario <- "BH"
  }

  # Settings taken from coupled runs
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$gms$c60_2ndgen_biodem <- "coupling"
  cfg$path_to_report_ghgprices <- pathToCoupledOutput
  cfg$path_to_report_bioenergy <- pathToCoupledOutput

  cfg$title <- paste0(prefix, "_", paste(scen, collapse = "-"))
  start_run(cfg = cfg, codeCheck = FALSE)
}
