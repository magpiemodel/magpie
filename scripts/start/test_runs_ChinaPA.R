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

prefix <- paste(rev, "ChinaPA", sep = "_")


source("config/default.cfg")

cfg$input <- c(
  regional = "rev4.128ChinaPA_h12_magpie.tgz",
  cellular = "rev4.128ChinaPA_h12_1b5c3817_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1.tgz",
  validation = "rev4.128ChinaPA_h12_92e02314_validation.tgz",
  additional = "additional_data_rev4.63.tgz",
  calibration = "calibration_H12_FAO_18Sep25.tgz"
)

cfg$title <- paste0(prefix, "_", "default")
start_run(cfg = cfg, codeCheck = FALSE)
