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
  v <- "v10"

  x <- list(bau            = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = "SSP1"),
            ssp1           = list(standard = c("cc", "rcp1p9", "SSP1", "NDC", "ForestryEndo"),
                                  fsec = "FSEC", "SSP1"),
            ssp3           = list(standard = c("cc", "rcp7p0", "SSP3", "NDC", "ForestryEndo"),
                                  fsec = "FSEC", "SSP3"),
            ssp4           = list(standard = c("cc", "rcp6p0", "SSP4", "NDC", "ForestryEndo"),
                                  fsec = "FSEC", "SSP4"),
            ssp5           = list(standard = c("cc", "rcp8p5", "SSP5", "NDC", "ForestryEndo"),
                                  fsec = "FSEC", "SSP5"),
            # Individual transformation clusters:
            population     = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "population")),
            institutions   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "institutions")),
            energy         = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "energy")),
            noUnderweight  = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "noUnderweight")),
            noOverweight   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "noOverweight")),
            fruitsNutsVegSeeds  = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "fruitsNutsVegSeeds")),
            monogastrics   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "monogastrics")),
            ruminants      = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "ruminants")),
            pulses         = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "pulses")),
            processed      = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "processed")),
            fish           = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "fish")),
            waste          = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "waste")),
            awms           = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "awms")),
            livestock      = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "livestock")),
            cropefficiency = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "cropefficiency")),
            biodiversity   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "biodiversity")),
            fairTrade      = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "fairTrade")),
            timberCities   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "timberCities")),
            REDDaff        = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "REDDaff")),
            REDD           = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "REDD")),
            landSharing    = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "landSharing")),
            landSparing    = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "landSparing")),
            waterSparing   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "waterSparing")),
            peatland       = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "peatland")),
            airPollution   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "airPollution")),
            soil           = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "soil")),
            # FSDP (all transformations active)
            fsdp = list(standard = c("cc", "rcp7p0", "SSP1", "NDC", "ForestryEndo"),
                        fsec = c("FSEC", "population", "institutions", "energy", "diet", "meat", "waste", "awms", "livestock", "cropefficiency", "biodiversity", "fairTrade", "timberCities", "REDDaff", "REDD", "landSparing", "waterSparing", "peatland", "allEmisPrice",
                        #"airPollution", ## ready yet?
                        "soil")),
            # Scenarios (combinations of transformation clusters)
            externalPressures   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "population", "institutions", "energy")),
            waterSoil           = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "waterSparing", "soil")),
            meatForest          = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "ruminants", "REDDaff")),
            dietRotations       = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "noOverweight", "noUnderweight", "fruitsNutsVegSeeds", "monogastrics", "ruminants", "pulses", "processed", "fish", "landSharing")),
            soilMonogastrics    = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "monogastics", "soil")),
            allClimate          = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "cropefficiency", "awms", "allEmisPrice")),
            fullBiodiv          = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                fsec = c("FSEC", "biodiversity", "landSharing")),
            allEnvironment      = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "biodiversity", "REDDaff", "landSparing", "waterSparing", "peatland", "soil")), #airPollution?
            allHealth           = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "noOverweight", "noUnderweight", "fruitsNutsVegSeeds", "monogastrics", "ruminants", "pulses", "processed", "fish")),
            allInclusion        = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "population", "institutions", "timber", "fairTrade")),
            #Bioeconomy + energy + timber # we do not have bioeconomy yet
            Efficiency          = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "cropefficiency", "awms", "waste", "fairTrade")),
            Sufficiency         = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "noOverweight", "noUnderweight", "fruitsNutsVegSeeds", "monogastrics", "ruminants", "pulses", "processed", "fish", "waste")),
            Protection          = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "waterSparing", "landSparing", "peatland"))
            )
  # Assign selected scenario to cfg
  cfg <- setScenario(cfg, x[[scenario]]$standard)
  cfg <- setScenario(cfg, x[[scenario]]$fsec, scenario_config = "config/scenario_fsec.csv")

  # general
  cfg$title       <- paste(v, scenario, sep = "_")
  #cfg$results_folder <- "output/:title:"
  cfg$recalibrate <- FALSE
  cfg$qos         <- "priority_maxMem"
  cfg$output      <- c(cfg$output,
                         "rds_report_iso",
                         "extra/disaggregation_BII"#,
                         #"projects/FSEC_dietaryIndicators",
                         #"projects/FSEC_costs.R",
                         #"projects/FSEC_nitrogenPollution.R",
                         #"projects/FSEC_StevenLord.R"
                       )
  cfg$force_download    <- TRUE

  return(cfg)
}
