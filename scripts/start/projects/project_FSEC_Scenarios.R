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

codeCheck <- FALSE

for (scenarioName in c(
  # Single transformation runs
  "a_Population", "a_SocioEconDevelop", "a_EnergyTrans",
  "a_NoUnderweight", "a_NoOverweight", "a_DietVegFruitsNutsSeeds", "a_DietLegumes", "a_DietMonogastrics", "a_DietRuminants", "a_DietEmptyCals", "a_DietFish", "a_LessFoodWaste",
  "a_AnimalWasteMngmt", "a_LivestockMngmt", "a_NitrogenUptakeEff", "a_LandUseDiversity",
  # still missing: Bioeconomy
  "a_FairTrade", "a_TimberCities", "a_REDDaff", "a_REDD", "a_CropRotations",
  "a_LandSparing", "a_WaterSparing", "a_PeatlandSparing", "a_AirPollution", "a_SoilCarbon",
  # Scenario combination runs
  "c_BAU", "d_SSP1", "d_SSP3", "d_SSP4", "d_SSP5",
  "e_FSDP",
  "b_ExternalPressures", "b_WaterSoil", "b_REDDaffDietRuminants", "b_DietRotations",
  "b_SoilMonogastric", "b_SoilRotations",
  "b_AllClimate", "b_FullBiodiv", "b_AllEnvironment", "b_AllHealth", "b_AllInclusion",
  # still missing: Bioeconomy + energy + timber
  "b_Efficiency", "b_Sufficiency", "b_Protection")) {

    # Start runs
    cfg <- fsecScenario(scenario = scenarioName)
    start_run(cfg = cfg, codeCheck = codeCheck)

  }
