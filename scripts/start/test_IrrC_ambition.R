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

runID <- "v1"

cfg$qos <- "priority"

cfg$force_download <- FALSE

# sticky
cfg$gms$factor_costs <- "sticky_feb18"

# crop realisation
cfg$gms$crop <- "endo_apr21"
cfg$gms$c30_marginal_land <- "q33_marginal"

ambition <- c(
  "none", "IrrC_30pc", "IrrC_40pc", "IrrC_50pc", "IrrC_60pc",
  "IrrC_70pc", "IrrC_80pc", "IrrC_90pc", "IrrC_100pc"
)

for (ic in ambition) {
  cfg$gms$c22_protect_scenario <- ic

  cfg$title <- paste0(runID, "_IrrC_ambition_test_", gsub("IrrC_", "", ic))

  start_run(cfg, codeCheck = FALSE)
}
