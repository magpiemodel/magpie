# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: FSEC Social Welfare Function indicators start script
# ----------------------------------------------------------

library(gms)
source("scripts/start_functions.R")
source("scripts/performance_test.R")
source("config/default.cfg")

# Set defaults
codeCheck <- TRUE

input <- c(regional    = "rev4.67_h12_magpie.tgz",
           cellular    = "rev4.67_h12_1998ea10_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
           validation  = "rev4.67_h12_validation.tgz",
           additional  = "additional_data_rev4.08.tgz",
           calibration = "calibration_H12_sticky_feb18_free_18Jan22.tgz")

# General settings
general_settings <- function(title) {
  source("config/default.cfg")
  cfg$input <- input
  cfg <- lucode::setScenario(cfg, "nocc")
  cfg$recalibrate <- FALSE
  return(cfg)
}


# -----------------------------------------------------------------------------------------------------------------
# Scenario runs

### Business-as-usual
cfg <- general_settings(title = "FSEC_SSP2")
cfg <- lucode::setScenario(cfg, "SSP2")

start_run(cfg = cfg, codeCheck = codeCheck)


### SSP1
cfg <- general_settings(title = "FSEC_SSP1")
cfg <- lucode::setScenario(cfg, "SSP1")

start_run(cfg = cfg, codeCheck = codeCheck)


# -----------------------------------------------------------------------------------------------------------------
# Output generation

cfg$output <- c(cfg$output, "disaggregation_BII", "FSEC_dietaryIndicators", "FSEC_environmentalPollution_grid")
