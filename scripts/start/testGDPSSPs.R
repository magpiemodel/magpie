# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test rountine for standardized test runs
# position: 5
# ----------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

# start a run with default settings
start_run(cfg, codeCheck = TRUE)

ssps <- c("SSP1", "SSP2","SSP3","SSP4","SSP5")

# create a set of runs based on default.cfg
for(ssp in ssps) {        # Add SSP* here for testing other SSPs.
                               # Basic test should be for at least two SSPs to
                               #check if results until 2020 are identical

  cfg$title <- paste0("GDPtest_old_", ssp)
  cfg <- setScenario(cfg,c(ssp))
  start_run(cfg, codeCheck = TRUE)

}



# create a set of runs based on default.cfg
for(ssp in ssps) {        # Add SSP* here for testing other SSPs.
  # Basic test should be for at least two SSPs to
  #check if results until 2020 are identical

  #FILL IN CALIBRATION
  cfg$input <- c(cellular    = "rev4.64+DCTest_h12_12ceb32a_cellularmagpie_debug_c200_MRI-ESM2-0-ssp370_lpjml-066f36d1.tgz",
                 regional    = "rev4.64+DCTest_h12_magpie_debug.tgz",
                 validation  = "rev4.64+DCTest_h12_validation_debug.tgz",
                 additional  = cfg$input[grep("additional_data", cfg$input)])

  cfg$title <- paste0("GDPtest_new_", ssp)
  # Set NPI scenario
  cfg <- setScenario(cfg,c(ssp))
  start_run(cfg, codeCheck = TRUE)

}
