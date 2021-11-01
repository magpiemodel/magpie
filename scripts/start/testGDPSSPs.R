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

#add johannes repo
cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,
 "/p/tmp/jokoch/test_mrdrivers/output/"=NULL),
                           getOption("magpie_repos"))

ssps <- c("SSP1", "SSP2","SSP3","SSP4","SSP5")

# create a set of runs based on default.cfg
for(ssp in ssps) {        # Add SSP* here for testing other SSPs.
                               # Basic test should be for at least two SSPs to
                               #check if results until 2020 are identical

  cfg$title <- paste0("GDPtest2_old_", ssp)
  cfg <- setScenario(cfg,c(ssp))
  start_run(cfg, codeCheck = TRUE)

}



# create a set of runs based on new files
cfg$input <- c(cellular    = "rev333_h12_477f2095_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-4b917a03.tgz",
               regional    = "rev333_h12_magpie.tgz",
               validation  = "rev333_h12_validation.tgz",
               additional  = cfg$input[grep("additional_data", cfg$input)])

for(ssp in ssps) {

  cfg$title <- paste0("GDPtest2_new_", ssp)
  cfg <- setScenario(cfg,c(ssp))
  start_run(cfg, codeCheck = TRUE)

}
