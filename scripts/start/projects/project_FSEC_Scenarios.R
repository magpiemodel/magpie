# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Scenarios for FSEC
# ----------------------------------------------------------

library(gms)
source("scripts/start_functions.R")
source("scripts/projects/fsec.R")
source("config/default.cfg")

codeCheck <- FALSE

for (scenarioName in c(
  # Single transformation runs
  "population", "instituions", "energy",
  "noUnderweight", "noOverweight", "fruitsNutsVegSeeds", "pulses", "monogastics", "ruminants", "processed", "fish", "waste",
  "awms", "livestock", "cropefficiency", "biodiversity",
  # still missing: Bioeconomy
  "fairTrade", "timberCities", "REDDaff", "REDD"
  "landSparing", "waterSparing", "peatland", "airPollution", "soil",
  # Scenario combination runs
  "bau", "ssp1", "ssp3", "ssp4", "ssp5", "fsdp",
  "externalPressures", "waterSoil", "meatForest", "dietRotations", "soilMonogastrics",
  "allClimate", "fullBiodiv", "allEnvironment", "allHealth", "allInclusion",
  # still missing: Bioeconomy + energy + timber
  "Efficiency", "Sufficiency", "Protection")) {

    # Start runs
    cfg <- fsecScenario(scenario = scenarioName)
    start_run(cfg = cfg, codeCheck = codeCheck)

  }
