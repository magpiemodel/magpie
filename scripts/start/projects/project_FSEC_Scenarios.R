# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
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
  "a_Population", "a_EconDevelop", "a_EnergyTrans",
  "a_NoUnderweight", "a_HalfOverweight", "a_DietVegFruitsNutsSeeds", "a_DietLegumes",
  "a_DietMonogastrics", "a_DietRuminants", "a_DietEmptyCals", "a_LessFoodWaste",
  "a_ManureMngmt", "a_LivestockMngmt", "a_BiodivSparing",
  "a_NitrogenEff", "a_RiceMit", "a_CropeffTax",
  "a_CapitalSubst", "a_MinWage", "a_Bioplastics", "a_LandscapeElements",
  "a_LiberalizedTrade", "a_TimberCities", "a_REDDaff", "a_REDD", "a_CropRotations",
  "a_LandSparing", "a_WaterSparing", "a_PeatlandSparing", "a_AirPollution", "a_SoilCarbon",
  # Scenario combination runs
  "c_BAU", "d_SSP1bau", "d_SSP1PLUSbau", "d_SSP2bau", "d_SSP3bau", "d_SSP4bau", "d_SSP5bau",
  "d_SSP1fsdp", "d_SSP2fsdp", "d_SSP3fsdp", "d_SSP4fsdp", "d_SSP5fsdp",
  "e_FSDP",
  "b_Diet", "b_Livelihoods", "b_NatureSparing", "b_AgroMngmt", "b_ExternalPressures"
  # "b_WaterSoil", "b_REDDaffRuminants", "b_DietRotations", "b_MonogastricsRotations",
  # "b_TradeRotations", "b_TradeREDDaff", "b_TradeSoil",
  # "b_TradeMonogastrics", "b_TradeRuminants", "b_TradeVeggies",
  # "b_SoilMonogastric", "b_SoilMonogastricRuminants", "b_SoilRotations",
  # "b_MonogastricsVeggies", "b_LivestockManureMngmt", "b_LivestockNUEMngmt",
  # "b_AllNitrogen", "b_AllClimate", "b_FullBiodiv",
  # "b_AllEnvironment", "b_AllHealth", "b_Protection", "b_Efficiency",
  # "b_AllInclusion", "b_LivelihoodsExt", "b_Bioeconomy",
)) {

    # Start runs
    cfg <- fsecScenario(scenario = scenarioName)
    start_run(cfg = cfg, codeCheck = codeCheck)
}
