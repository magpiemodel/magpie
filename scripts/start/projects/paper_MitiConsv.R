# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -------------------------------------------------------------
# description: Land-based mitigation and habitat conservation
# -------------------------------------------------------------

rev <- "rev19"

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

# cc is new default
cfg <- setScenario(cfg, c("SSP2", "nocc_hist", "NPI", "ForestryExo"))
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
  "SSP2-PB650-NPi", "SSP2-PB650-NDC",
  "SSP2-PB650-NPi-30by30", "SSP2-PB650-NDC-30by30",
  "SSP2-PB650-AR200", "SSP2-PB650-AR200-30by30",
  "SSP2-PB650-AR350", "SSP2-PB650-AR350-30by30",
  "SSP2-PB650-AR500", "SSP2-PB650-AR500-30by30",
  "SSP2-REF"
)


for (scen in scenarios) {
  scen <- unlist(strsplit(scen, "-"))
  ssp <- scen[grepl("SSP", scen)]

  source("config/default.cfg")

  cfg$qos <- "short_highMem"

  cfg$results_folder <- "output/:title::date:"

  cfg$output <- c(
    "output_check", "extra/disaggregation", "rds_report", "extra/runSEALSallocation"
  )

  # Climate change switched off for these runs
  cfg <- setScenario(cfg, c(ssp, "nocc_hist", "NPI", "ForestryExo"))
  cfg <- setScenario(cfg, "MitiConsv", scenario_config = "config/projects/scenario_config_miti_consv.csv")

  # Calibration settings
  cfg$input["calibration"] <- calib_tgz

  # sticky
  cfg$gms$factor_costs <- "sticky_feb18"

  # SNV habitat defintion
  cfg$gms$land_snv <- "secdforest, other"

  # Set path to coupled output
  pathToCoupledOutput <- "/p/projects/magpie/users/vjeetze/magpie/projects/MitiConsv/C_MitiConsv_May25/remind/output/C_rev9_MitiConsv_SSP2-NPi-rem-7/REMIND_generic_C_rev9_MitiConsv_SSP2-NPi-rem-7.mif"

  # No ghg price in NPI run
  cfg$gms$c56_mute_ghgprices_until <- "y2100"

  if (any(c("NPi", "NDC") %in% scen)) {
    cfg <- setScenario(cfg, "NDC")
    # Update path to coupled output
    pathToCoupledOutput <- "/p/projects/magpie/users/vjeetze/magpie/projects/MitiConsv/C_MitiConsv_May25/remind/output/C_rev9_MitiConsv_SSP2-PB650-NDC-rem-7/REMIND_generic_C_rev9_MitiConsv_SSP2-PB650-NDC-rem-7.mif"
    if ("30by30" %in% scen) {
      pathToCoupledOutput <- "/p/projects/magpie/users/vjeetze/magpie/projects/MitiConsv/C_MitiConsv_May25/remind/output/C_rev9_MitiConsv_SSP2-PB650-NDC-30by30-rem-7/REMIND_generic_C_rev9_MitiConsv_SSP2-PB650-NDC-30by30-rem-7.mif"
    }
    if ("NPi" %in% scen) {
      cfg <- setScenario(cfg, "NPI")
      pathToCoupledOutput <- "/p/projects/magpie/users/vjeetze/magpie/projects/MitiConsv/C_MitiConsv_May25/remind/output/C_rev9_MitiConsv_SSP2-PB650-NPi-rem-7/REMIND_generic_C_rev9_MitiConsv_SSP2-PB650-NPi-rem-7.mif"
      if ("30by30" %in% scen) {
        pathToCoupledOutput <- "/p/projects/magpie/users/vjeetze/magpie/projects/MitiConsv/C_MitiConsv_May25/remind/output/C_rev9_MitiConsv_SSP2-PB650-NPi-30by30-rem-7/REMIND_generic_C_rev9_MitiConsv_SSP2-PB650-NPi-30by30-rem-7.mif"
      }
    }
    cfg$gms$c56_mute_ghgprices_until <- "y2030"
    cfg <- setScenario(cfg, "AR0", scenario_config = "config/projects/scenario_config_miti_consv.csv")
  }

  if ("AR200" %in% scen) {
    pathToCoupledOutput <- "/p/projects/magpie/users/vjeetze/magpie/projects/MitiConsv/C_MitiConsv_May25/remind/output/C_rev9_MitiConsv_SSP2-PB650-AR200-rem-7/REMIND_generic_C_rev9_MitiConsv_SSP2-PB650-AR200-rem-7.mif"
    if ("30by30" %in% scen) {
      pathToCoupledOutput <- "/p/projects/magpie/users/vjeetze/magpie/projects/MitiConsv/C_MitiConsv_May25/remind/output/C_rev9_MitiConsv_SSP2-PB650-AR200-30by30-rem-7/REMIND_generic_C_rev9_MitiConsv_SSP2-PB650-AR200-30by30-rem-7.mif"
    }
    cfg$gms$c56_mute_ghgprices_until <- "y2030"
    cfg <- setScenario(cfg, "AR200", scenario_config = "config/projects/scenario_config_miti_consv.csv")
  }

  if ("AR350" %in% scen) {
    pathToCoupledOutput <- "/p/projects/magpie/users/vjeetze/magpie/projects/MitiConsv/C_MitiConsv_May25/remind/output/C_rev9_MitiConsv_SSP2-PB650-AR350-rem-7/REMIND_generic_C_rev9_MitiConsv_SSP2-PB650-AR350-rem-7.mif"
    if ("30by30" %in% scen) {
      pathToCoupledOutput <- "/p/projects/magpie/users/vjeetze/magpie/projects/MitiConsv/C_MitiConsv_May25/remind/output/C_rev9_MitiConsv_SSP2-PB650-AR350-30by30-rem-7/REMIND_generic_C_rev9_MitiConsv_SSP2-PB650-AR350-30by30-rem-7.mif"
    }
    cfg$gms$c56_mute_ghgprices_until <- "y2030"
    cfg <- setScenario(cfg, "AR350", scenario_config = "config/projects/scenario_config_miti_consv.csv")
  }

  if ("AR500" %in% scen) {
    pathToCoupledOutput <- "/p/projects/magpie/users/vjeetze/magpie/projects/MitiConsv/C_MitiConsv_May25/remind/output/C_rev9_MitiConsv_SSP2-PB650-AR500-rem-7/REMIND_generic_C_rev9_MitiConsv_SSP2-PB650-AR500-rem-7.mif"
    if ("30by30" %in% scen) {
      pathToCoupledOutput <- "/p/projects/magpie/users/vjeetze/magpie/projects/MitiConsv/C_MitiConsv_May25/remind/output/C_rev9_MitiConsv_SSP2-PB650-AR500-30by30-rem-7/REMIND_generic_C_rev9_MitiConsv_SSP2-PB650-AR500-30by30-rem-7.mif"
    }
    cfg$gms$c56_mute_ghgprices_until <- "y2030"
    cfg <- setScenario(cfg, "AR500", scenario_config = "config/projects/scenario_config_miti_consv.csv")
  }

  if ("30by30" %in% scen) {
    cfg <- setScenario(cfg, "30by30", scenario_config = "config/projects/scenario_config_miti_consv.csv")
  }

  # Settings taken from coupled runs
  cfg$gms$c56_pollutant_prices <- "coupling"
  cfg$gms$c60_2ndgen_biodem <- "coupling"
  cfg$path_to_report_ghgprices <- pathToCoupledOutput
  cfg$path_to_report_bioenergy <- pathToCoupledOutput

  cfg$title <- paste0(prefix, "_", paste(scen, collapse = "-"))
  start_run(cfg = cfg, codeCheck = FALSE)
}
