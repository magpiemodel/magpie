# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

library(gms)
library(lucode2)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# load config
source("config/default.cfg")

runID <- "v2"

# cfg$sequential <- TRUE
# cfg$qos <- "priority"

cfg$force_download <- FALSE

# sticky
cfg$gms$factor_costs <- "sticky_feb18"

# crop realisation
cfg$gms$crop <- "endo_apr21"
cfg$gms$c30_marginal_land <- "q33_marginal"

consv_prio <- c(
    "none", "KBA", "GSN_DSA", "GSN_RarePhen", "GSN_AreaIntct", "GSN_ClimTier1", "GSN_ClimTier2", "BH", "IFL", "BH_IFL","CCA", "GSN_HalfEarth", "PBL_HalfEarth"
)

# consv_prio <- "30by30"

for (cp in consv_prio) {
  cfg$gms$c22_protect_scenario <- cp

  cfg$title <- paste0(runID, "_consv_prio_test_", cp)

  start_run(cfg, codeCheck = FALSE)
}
