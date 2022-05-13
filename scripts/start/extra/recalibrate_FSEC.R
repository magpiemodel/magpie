# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: calculate and store new calibration factors for yields AND land conversion costs for FSEC regional setup (time consuming; up to 40 model runs with 1 or 5 time steps)
# --------------------------------------------------------

library(magpie4)
library(magclass)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

input <- c(regional    = "rev4.68FSECmodeling_e2bdb6cd_magpie.tgz",
           cellular    = "rev4.68FSECmodeling_e2bdb6cd_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
           validation  = "rev4.68FSECmodeling_e2bdb6cd_validation.tgz",
           additional  = "additional_data_rev4.14.tgz",
           calibration = "calibration_FSEC_29Apr22.tgz")

# General settings of FSEC global runs:
general_settings <- function(title) {

  source("config/default.cfg")

  cfg$input       <- input
  cfg$title       <- paste0("v3_", title)
  cfg$recalibrate <- FALSE
  cfg$qos         <- "priority_maxMem"
  cfg$output      <- c(cfg$output ,
                       "extra/disaggregation_BII", "projects/FSEC_dietaryIndicators",
                       "projects/FSEC_environmentalPollution_grid"
                      )

  # Climate change impacts activated, SSP2 default settings, NDC activated, endogenous forestry activated
  cfg <- gms::setScenario(cfg, c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"))
  cfg$input['cellular'] <- "rev4.68FSECmodeling_e2bdb6cd_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz"

  # Nitrogen module with IPCC emissions factors rescaled with efficiency
  cfg$gms$nitrogen                <- "rescaled_jan21"
  # emission policy not including any GHG sources
  cfg$gms$c56_emis_policy         <- "none"
  # ghg price setting (only relevant when activated by c56_emis_policy)
  cfg$gms$c56_pollutant_prices    <- "R21M42-SDP-PkBudg1000"
  # no peatland GHG emission pricing
  cfg$gms$s56_peatland_policy     <- "0"
  # residue on field burning is set to "constant"
  cfg$gms$c18_burn_scen           <- "constant"
  # C price driven afforestation is off by default
  cfg$gms$s56_c_price_induced_aff <- "0"
  # Soil organic carbon dynamics activated
  cfg$gms$som                     <- "cellpool_aug16"
  # Cost module: sticky - dynamic mode
  cfg$gms$factor_costs            <- "sticky_feb18"
  cfg$gms$c38_sticky_mode         <- "dynamic"
  # Necessary to be feasible
  cfg$gms$s13_max_gdp_shr <- 1

  return(cfg)
}

# -----------------------------------------------------------------------------------------------------------------
# Calibration run
cfg <- general_settings(title = "calibration_FSEC_sticky_feb18_free")
cfg$results_folder                  <- "output/:title:"
cfg$recalibrate                     <- TRUE
cfg$recalibrate_landconversion_cost <- TRUE
cfg$output                          <- c("rds_report", "validation_short")
cfg$force_replace                   <- TRUE
start_run(cfg, codeCheck = FALSE)
magpie4::submitCalibration("FSEC")
