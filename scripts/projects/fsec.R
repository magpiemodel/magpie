# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

################################################################################
# Define internal functions
################################################################################

fsecScenario <- function(scenario) {

  source("config/default.cfg")

  # version number
  v <- "v16_FSEC"

  x <- list(c_BAU            = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = "FSEC"),
            d_SSP1           = list(standard = c("cc", "rcp1p9", "SSP1", "NDC", "ForestryEndo"),
                                  fsec = "FSEC", "SSP1"),
            d_SSP3           = list(standard = c("cc", "rcp7p0", "SSP3", "NDC", "ForestryEndo"),
                                  fsec = "FSEC", "SSP3"),
            d_SSP4           = list(standard = c("cc", "rcp6p0", "SSP4", "NDC", "ForestryEndo"),
                                  fsec = "FSEC", "SSP4"),
            d_SSP5           = list(standard = c("cc", "rcp8p5", "SSP5", "NDC", "ForestryEndo"),
                                  fsec = "FSEC", "SSP5"),
            # Individual transformation clusters:
            a_Population         = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "population")),
            a_SocioEconDevelop   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "institutions")),
            a_EnergyTrans        = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "energy")),
            a_NoUnderweight      = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "noUnderweight")),
            a_NoOverweight       = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "noOverweight")),
            a_DietVegFruitsNutsSeeds  = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "fruitsNutsVegSeeds")),
            a_DietMonogastrics   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "monogastrics")),
            a_DietRuminants      = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "ruminants")),
            a_DietLegumes        = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "pulses")),
            a_DietEmptyCals      = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "processed")),
            a_DietFish           = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "fish")),
            a_LessFoodWaste      = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "waste")),
            a_AnimalWasteMngmt   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "awms")),
            a_LivestockMngmt     = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "livestock")),
            a_NitrogenUptakeEff  = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "cropefficiency")),
            a_LandUseDiversity   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "biodiversity")),
            a_FairTrade          = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "fairTrade")),
            a_TimberCities       = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "timberCities")),
            a_REDDaff            = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "REDDaff")),
            a_REDD               = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "REDD")),
            a_CropRotations      = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "landSharing")),
            a_LandSparing        = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "landSparing")),
            a_WaterSparing       = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "waterSparing")),
            a_PeatlandSparing    = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "peatland")),
            a_AirPollution       = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "airPollution")),
            a_SoilCarbon         = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                        fsec = c("FSEC", "soil")),
            # FSDP (all transformations active)
            e_FSDP = list(standard = c("cc", "rcp7p0", "SSP1", "NDC", "ForestryEndo"),
                        fsec = c("FSEC", "population", "institutions", "energy",
                        "awms", "livestock", "cropefficiency", "biodiversity", "fairTrade", "timberCities",
                        "REDDaff", "REDD", "landSharing", "landSparing", "waterSparing", "peatland",
                        "airPollution", "soil", "allDietAndWaste", "allEmisPrice")),
            # Scenarios (combinations of transformation clusters)
            b_ExternalPressures  = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "population", "institutions", "energy")),
            b_WaterSoil          = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "waterSparing", "soil")),
            b_REDDaffDietRuminants = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "ruminants", "REDDaff")),
            b_DietRotations      = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "landSharing", "allDiet")),
            b_SoilMonogastric    = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "monogastrics", "soil")),
            b_SoilRotations      = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "landSharing", "soil")),
            b_AllClimate         = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "cropefficiency", "awms", "allEmisPrice")),
            b_FullBiodiv         = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                fsec = c("FSEC", "biodiversity", "landSharing")),
            b_AllEnvironment     = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "biodiversity", "REDDaff", "landSparing", "waterSparing", "peatland", "soil", "airPollution")),
            b_AllHealth          = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "allDiet")),
            b_AllInclusion       = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "population", "institutions", "timberCities", "fairTrade")),
            #Bioeconomy + energy + timber # we do not have bioeconomy yet
            b_Efficiency          = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "cropefficiency", "awms", "waste", "fairTrade")),
            b_Sufficiency         = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "allDietAndWaste")),
            b_Protection          = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "waterSparing", "landSparing", "peatland"))
            )
  # Assign selected scenario to cfg
  cfg <- setScenario(cfg, x[[scenario]]$standard)
  cfg <- setScenario(cfg, x[[scenario]]$fsec, scenario_config = "config/scenario_fsec.csv")

  # Download gridded population data
  gms::download_unpack(input = "FSEC_populationScenarios_v2_22-08-22.tgz",
                       targetdir = "./input",
                       repositories = cfg$repositories)

  # general
  cfg$title       <- paste(v, scenario, sep = "")
  cfg$recalibrate <- FALSE
  cfg$qos         <- "priority_maxMem"
  cfg$output      <- c(cfg$output,
                       "rds_report_iso",
                       "extra/disaggregation_BII",
                       "projects/FSEC_dietaryIndicators",
                       "projects/FSEC_costs.R",
                       "projects/FSEC_nitrogenPollution.R",
                       "projects/FSEC_StevenLord.R",
                       "runBlackmagicc.R"
                       )
  cfg$force_download    <- TRUE

  return(cfg)
}
