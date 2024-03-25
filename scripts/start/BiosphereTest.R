# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: SNV test runs
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
# Scenario runs
# ====================

prefix <- paste(rev, "BiosphereTest_CurrentDev", sep = "_")

scenarios <- c(
  "SSP2-REF", "SSP2-SNV20",
  "SSP2-GSN", "SSP2-GSN-SNV20",
  "SSP2-30by30", "SSP2-30by30-SNV20"
)

  for (scen in scenarios) {
    actions <- unlist(strsplit(scen, "-"))

    source("config/default.cfg")

    cfg$results_folder <- "output/:title::date:"

    cfg$output <- c(
      "output_check", "extra/disaggregation", "rds_report",
      "extra/reportMAgPIE2SEALS", "projects/FSEC_cropDiversityGrid"
    )

    # sticky
    cfg$gms$factor_costs <- "sticky_feb18"

    # crop realisation
    cfg$gms$crop <- "endo_apr21"
    cfg$gms$c30_marginal_land <- "q33_marginal"

    # SNV habitat defintion
    cfg$gms$land_snv <- "secdforest, other"

    if (any(actions %in% c("SNV20"))) {
      cfg$gms$s30_snv_shr <- 0.2
      cfg$gms$s30_snv_scenario_target <- 2050
    }

    if (any(actions %in% c("GSN"))) {
      cfg$gms$c22_protect_scenario <- "GSN_HalfEarth"
      cfg$gms$s22_conservation_target <- 2050
    }

    if (any(actions %in% c("30by30"))) {
      cfg$gms$c22_protect_scenario <- "30by30"
      cfg$gms$s22_conservation_target <- 2030
    }


    cfg$title <- paste0(prefix, "_", scen)
    start_run(cfg = cfg, codeCheck = FALSE)
  }

