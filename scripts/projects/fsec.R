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

  # FSEC input data
  input <- c(regional    = "rev4.73FSECmodeling_e2bdb6cd_magpie.tgz",
             cellular    = "rev4.73FSECmodeling_e2bdb6cd_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
             validation  = "rev4.73FSECmodeling_e2bdb6cd_validation.tgz",
             additional  = "additional_data_rev4.26.tgz",
             calibration = "calibration_FSEC_18Jun22.tgz")
  # version number
  v <- "vTEST"

  x <- list(bau            = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = "FSEC"),
            ssp1           = list(standard = c("cc", "rcp1p9", "SSP1", "NDC", "ForestryEndo"),
                                  fsec = "FSEC"),
            ssp3           = list(standard = c("cc", "rcp7p0", "SSP3", "NDC", "ForestryEndo"),
                                  fsec = "FSEC"),
            ssp4           = list(standard = c("cc", "rcp6p0", "SSP4", "NDC", "ForestryEndo"),
                                  fsec = "FSEC"),
            ssp5           = list(standard = c("cc", "rcp8p5", "SSP5", "NDC", "ForestryEndo"),
                                  fsec = "FSEC"),
            # Individual transformation clusters:
            population     = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "population")),
            institutions   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "institutions")),
            energy         = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "energy")),
            diet           = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "diet")),
            meat           = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "meat")),
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
            REDDaff       = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "REDDaff")),
            REDD          = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "REDD")),
            landSparing   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "landSparing")),
            waterSparing   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "waterSparing")),
            peatland       = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "peatland")),
            airPollution   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "airPollution")),
            soil   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "soil")),
            # FSDP (all transformations active)
            fsdp = list(standard = c("cc", "rcp7p0", "SSP1", "NDC", "ForestryEndo"),
                        fsec = c("FSEC", "population", "institutions", "energy", "diet", "meat", "waste", "awms", "livestock", "cropefficiency", "biodiversity", "fairTrade", "timberCities", "REDDaff", "REDD", "landSparing", "waterSparing", "peatland",
                        #"airPollution", ## ready yet?
                        "soil"))
            # Scenarios (combinations of transformation clusters)
            #Water + Soil
            externalPressures   = list(standard = c("cc", "rcp7p0", "SSP2", "NDC", "ForestryEndo"),
                                  fsec = c("FSEC", "population", "institutions", "energy")),
            #Low ruminants + afforestation
            #Diet_change + crop_rotations
            #Soil + livst_monogastric
            #All climate + nitrogen
            #Biodiv+crop rotations
            #All environment
            #All health (Planetary Health diets; all diet switches without waste)
            #All inclusion (pop, gdp+inst, timber, fair trade)
            #Bioeconomy + energy + timber
            #Efficiency (NUE, livestock, awms, waste, fairtrade)
            #Sufficiency (diet)
            #Protection (water, land sparing, peatland)
            )
  # Assign selected scenario to cfg
  cfg <- setScenario(cfg, x[[scenario]]$standard)
  cfg <- setScenario(cfg, x[[scenario]]$fsec, scenario_config = "config/scenario_fsec.csv")

  # overwrite cellular input (was overwritten by RCP from standard scenario_config)
  cfg$input['cellular'] <- input['cellular']

  # general
  cfg$info$flag   <- v
  cfg$input       <- input
  cfg$title       <- paste(cfg$info$flag, scenario, sep = "_")
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
