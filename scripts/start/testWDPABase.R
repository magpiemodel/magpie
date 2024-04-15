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

cres <- "c200"

######################################
#### Script to start a MAgPIE run ####
######################################

library(gms)
library(lucode2)
library(magclass)

# Load start functions
source("scripts/start_functions.R")

# ====================
# Scenario runs
# ====================

prefix <- paste(rev, "PR662", cres, sep = "_")


scenarios <- c("default",
               "WDPA_I-II-III",
               "WDPA_IV-V-VI",
               "none")


  for (scen in scenarios) {

    source("config/default.cfg")

    cfg$results_folder <- "output/:title::date:"

    cfg$output <- c(
      "output_check", "extra/disaggregation", "rds_report",
      "extra/reportMAgPIE2SEALS", "projects/FSEC_cropDiversityGrid"
    )

    cfg$force_download <- FALSE

    if ("default" == scen) {
     cfg$gms$c22_base_protect <- "WDPA"
    } else {
     cfg$gms$c22_base_protect <- scen
    }

    cfg$title <- paste0(prefix, "_", paste(scen, collapse = "-"))
    start_run(cfg = cfg, codeCheck = FALSE)
  }
