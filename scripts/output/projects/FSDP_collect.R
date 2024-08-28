# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Collect reg, iso and grid level data from multiple FSDP runs (requires LR or HR runs)
# comparison script: TRUE
# ---------------------------------------------------------------

# Version 1.0, Florian Humpenoeder

library(lucode2)
library(magclass)
library(gms)
library(magpiesets)
library(data.table)
library(gdx2)
library(quitte)
library(m4fsdp)
library(stringr)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- file.path("output/", list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  lucode2::readArgs("outputdir")
}
###############################################################################

# For case of sub-folder structure write to the respective folder
title     <- basename(outputdir)

# Select runs to be displayed
x         <- unlist(lapply(strsplit(basename(outputdir), "_"), function(x) x[2]))
outputdir <- outputdir[which(x %in% c("FSECa", "FSECb", "FSECc", "FSECd", "FSECe"))]

# Get revision number
x <- unlist(lapply(strsplit(basename(outputdir), "_"), function(x) x[1]))
if (length(unique(x)) == 1) rev <- unique(x) else stop("version prefix is not identical. Check your selection of runs")

##########
# Append health impacts reports
hi_datasets_path <- "/p/projects/magpie/data/FSEC_healthImpactsDatasets_raw"
if (dir.exists(hi_datasets_path)) {

  hi_datasets      <- list.files(hi_datasets_path)
  hi_versionToUse  <- grep(rev, hi_datasets, value = TRUE)

  if (length(hi_versionToUse) == 0) {

    message("No corresponding version ID was found within the health impacts datasets. Using the latest available.")

    highestVersionNr <- max(as.numeric(str_extract(hi_datasets, "(?<=v)(.*?)(?=_)")))
    hi_versionToUse <- grep(paste0("v", highestVersionNr), hi_datasets, value = TRUE)

  } else if (length(hi_versionToUse) >= 2) {
    stop("Duplicated version IDs were found in the health impacts datasets, only one is expected.")
  }

  hi_versionToUse_path <- file.path(hi_datasets_path, hi_versionToUse)
  hi_gdx <- suppressWarnings(readGDX(hi_versionToUse_path))

  .appendHealthImpacts <- function(.x) {
    cfg <- gms::loadConfig(file.path(.x, "config.yml"))
    title <- cfg$title

    message("Appending health impact report: ", title)
    tryCatch(
      expr = {
        appendReportHealthImpacts(healthImpacts_gdx = hi_gdx, scenario = title, dir = .x)
      }, error = function(e) {
        message("Unable to append health impacts for scenario: ", title, ". Likely it is non-dietary.")
      }
    )
  }
  lapply(X = outputdir, FUN = .appendHealthImpacts)

} else {
  message("The directory storing health impacts datasets wasn't found. Skipping health impacts.")
}

magicc7_datasets_path <- "/p/projects/magpie/data/FSEC_magicc7Datasets_raw"
if (dir.exists(magicc7_datasets_path)) {

  magicc7_datasets <- list.files(magicc7_datasets_path)
  magicc7_versionToUse  <- grep(rev, magicc7_datasets, value = TRUE)

  if (length(magicc7_versionToUse) == 0) {

    message("No corresponding version ID was found within the MAGICC7 datasets. Using the latest available.")

    highestVersionNr <- max(as.numeric(str_extract(magicc7_datasets, "(?<=v)(.*?)(?=_)")))
    magicc7_versionToUse <- grep(paste0("v", highestVersionNr), magicc7_datasets, value = TRUE)

  } else if (length(magicc7_versionToUse) >= 2) {
    stop("Duplicated version IDs were found in the MAGICC7 datasets, only one is expected.")
  }

  magicc7_versionToUse_path <- file.path(magicc7_datasets_path, magicc7_versionToUse)

  .appendMAGICC7 <- function(.x) {
    cfg <- gms::loadConfig(file.path(.x, "config.yml"))
    title <- cfg$title

    tryCatch(
      expr = {
        appendReportMAGICC7(resultsPath = magicc7_versionToUse_path, scenario = title, dir = .x)
      }, error = function(e) {
        message("Unable to append MAGICC7 dataset for scenario: ", title)
      }
    )
  }
  lapply(X = outputdir, FUN = .appendMAGICC7)

} else {
  message("The directory storing MAGICC7 datasets wasn't found. Skipping AR6 global warming calculations.")
}


##########
# Generate output files
cat("\nStarting output generation\n")

reg     <- NULL
iso     <- NULL
grid    <- NULL
missing <- NULL

saveRDS(outputdir,"outputdir.rds")

indicators_main <- getVariables()
names(indicators_main) <- NULL
var_reg <- c(indicators_main,
             ### Validation
             "Biodiversity|Agricultural landscape intactness",
             "Biodiversity|Biodiversity hotspot intactness",
             "Biodiversity|BII in areas outside Biodiversity Hotspots, Intact Forest & Cropland Landscapes",
             "Biodiversity|Biodiversity Hotspot and Intact Forest Landscapes BII",
             "Biodiversity|Biodiversity Hotspot BII",
             "Biodiversity|BII in 30x30 Landscapes",
             "Biodiversity|Cropland Landscapes BII",
             "Biodiversity|Key Biodiversity Area BII",
             "Biodiversity|Inverted Simpson crop area diversity index",
             "Population",
             "Income",
             "Nutrition|Calorie Supply|+|Crops",
             "Nutrition|Calorie Supply|+|Livestock products",
             "Demand|++|Crops",
             "Demand|Food|+|Crops",
             "Demand|Feed|+|Crops",
             "Demand|Feed|+|Pasture",
             "Demand|Feed|+|Secondary products",
             "Demand|Feed|+|Crop residues",
             "Demand|Seed|+|Crops",
             "Demand|Material|+|Crops",
             "Demand|Processing|+|Crops",
             "Demand|++|Livestock products",
             "Production|+|Crops",
             "Production|Crops|+|Cereals",
             "Production|Crops|+|Oil crops",
             "Production|Crops|+|Sugar crops",
             "Production|Crops|Other crops|+|Fruits Vegetables Nuts",
             "Production|+|Livestock products",
             "Production|+|Secondary products",
             "Production|+|Pasture",
             "Production|+|Bioenergy crops",
             "Timber|Volumetric|Production|Roundwood",
             "Resources|Land Cover",
             "Resources|Land Cover|+|Cropland",
             "Resources|Land Cover|+|Pastures and Rangelands",
             "Resources|Land Cover|+|Forest",
             "Resources|Land Cover|Forest|+|Managed Forest",
             "Resources|Land Cover|Forest|Natural Forest|+|Primary Forest",
             "Resources|Land Cover|Forest|Natural Forest|+|Secondary Forest",
             "Resources|Land Cover|+|Other Land",
             "Resources|Land Cover|+|Urban Area",
             "Resources|Land Cover|Cropland|+|Croparea",
             "Resources|Land Cover|Cropland|+|Fallow Cropland",
             "Resources|Land Cover|Cropland|Croparea|Crops|+|Cereals",
             "Resources|Land Cover|Cropland|Croparea|Crops|Cereals|+|Maize",
             "Resources|Land Cover|Cropland|Croparea|Crops|Cereals|+|Rice",
             "Resources|Land Cover|Cropland|Croparea|Crops|Cereals|+|Temperate cereals",
             "Resources|Land Cover|Cropland|Croparea|Crops|Cereals|+|Tropical cereals",
             "Resources|Land Cover|Cropland|Croparea|Crops|+|Oil crops",
             "Resources|Land Cover|Cropland|Croparea|Crops|Oil crops|+|Cotton seed",
             "Resources|Land Cover|Cropland|Croparea|Crops|Oil crops|+|Groundnuts",
             "Resources|Land Cover|Cropland|Croparea|Crops|Oil crops|+|Oilpalms",
             "Resources|Land Cover|Cropland|Croparea|Crops|Oil crops|+|Other oil crops incl rapeseed",
             "Resources|Land Cover|Cropland|Croparea|Crops|Oil crops|+|Soybean",
             "Resources|Land Cover|Cropland|Croparea|Crops|Oil crops|+|Sunflower",
             "Resources|Land Cover|Cropland|Croparea|Crops|+|Sugar crops",
             "Resources|Land Cover|Cropland|Croparea|Crops|Sugar crops|+|Sugar beet",
             "Resources|Land Cover|Cropland|Croparea|Crops|Sugar crops|+|Sugar cane",
             "Resources|Land Cover|Cropland|Croparea|Crops|Other crops|+|Fruits Vegetables Nuts",
             "Resources|Land Cover|Cropland|Croparea|Crops|Other crops|+|Potatoes",
             "Resources|Land Cover|Cropland|Croparea|Crops|Other crops|+|Pulses",
             "Resources|Land Cover|Cropland|Croparea|Crops|Other crops|+|Tropical roots",
             "Resources|Land Cover|Cropland|Croparea|+|Bioenergy crops",
             "Productivity|Landuse Intensity Indicator Tau",
             "Productivity|Feed conversion",
             "Productivity|Feed conversion|Ruminant meat and dairy",
             "Productivity|Feed conversion|Poultry meat and eggs",
             "Productivity|Feed conversion|Monogastric meat",
             "Productivity|Feed conversion|+|Cereal Intensity",
             "Productivity|Feed conversion|+|Oilcrop intensity",
             "Productivity|Feed conversion|+|Pasture intensity",
             "Productivity|Roughage share|Ruminant meat and dairy",
             "Productivity|Pasture share|Ruminant meat and dairy",
             "Productivity|Yield by physical area|Crops",
             "Productivity|Yield by physical area|Crops|Cereals",
             "Productivity|Yield by physical area|Crops|Oil crops",
             "Productivity|Yield by physical area|Crops|Sugar crops",
             "Productivity|Yield by physical area|Crops|Other crops",
             "Productivity|Yield by physical area|Crops|Other crops|Fruits Vegetables Nuts",
             "Productivity|Yield by physical area|Pasture",
             "Productivity|Yield by physical area|Bioenergy crops",
             "Productivity|Yield by physical area|Forage",
             "Resources|Nitrogen|Cropland Budget|Inputs",
             "Resources|Nitrogen|Cropland Budget|Inputs|+|Fertilizer",
             "Resources|Nitrogen|Cropland Budget|Inputs|+|Biological Fixation Symbiotic Crops",
             "Resources|Nitrogen|Cropland Budget|Inputs|+|Manure Recycled from Confinements",
             "Resources|Nitrogen|Cropland Budget|Inputs|+|Recycled Aboveground Crop Residues",
             "Resources|Nitrogen|Cropland Budget|Withdrawals|+|Harvested Crops",
             "Resources|Nitrogen|Cropland Budget|Withdrawals|+|Aboveground Crop Residues",
             "Resources|Nitrogen|Cropland Budget|Balance|+|Nutrient Surplus",
             "Resources|Nitrogen|Cropland Budget|Balance|+|Soil Organic Matter",
             "Resources|Nitrogen|Pollution|Surplus|+|Cropland",
             "Resources|Nitrogen|Pollution|Surplus|+|Pasture",
             "Resources|Nitrogen|Pollution|Surplus|+|Animal Waste Management",
             "Resources|Nitrogen|Pollution|Surplus|+|Non-agricultural land",
             "Resources|Water|Withdrawal|Agriculture",
             "Resources|Land Cover|Cropland|Area equipped for irrigation",
             "Value|Bioeconomy Demand",
             "Production|Bioenergy|2nd generation|++|Bioenergy crops",
             ### Maps
             "Costs",
             "Population",
             "Labor|Employment|Share of working age population employed in agriculture",
             "Labor|Wages|Hourly labor costs",
             ### Suppl plots
             "Population",
             "Prices|Index2020|Agriculture|Food products",
             "Prices|Index2020|Agriculture|Food products|Livestock",
             "Prices|Index2020|Agriculture|Food products|Plant-based",
             "SDG|SDG02|Investment in AgR&D",
             "Household Expenditure|Food|Expenditure|Crops",
             "Household Expenditure|Food|Expenditure|Crops|Cereals",
             "Household Expenditure|Food|Expenditure|Crops|Oil crops",
             "Household Expenditure|Food|Expenditure|Crops|Other crops",
             "Household Expenditure|Food|Expenditure|Crops|Sugar crops",
             "Household Expenditure|Food|Expenditure|Fish",
             "Household Expenditure|Food|Expenditure|Livestock products",
             "Household Expenditure|Food|Expenditure|Secondary products",
             "Household Expenditure|Food|Food Expenditure Share",
             "SDG|SDG02|Food expenditure share",
             "Value|Agriculture GDP",
             "Costs|TC",
             "Agricultural Research Intensity",
             "Nutrition|Calorie Intake",
             "Nutrition|Calorie Intake|+|Crops",
             "Nutrition|Calorie Intake|+|Fish",
             "Nutrition|Calorie Intake|+|Livestock products",
             "Nutrition|Calorie Intake|+|Secondary products",
             "Nutrition|Calorie Intake|Crops|+|Cereals",
             "Nutrition|Calorie Intake|Crops|+|Oil crops",
             "Nutrition|Calorie Intake|Crops|+|Other crops",
             "Nutrition|Calorie Intake|Crops|+|Sugar crops",
             "Nutrition|Calorie Intake|Crops|Cereals|+|Maize",
             "Nutrition|Calorie Intake|Crops|Cereals|+|Rice",
             "Nutrition|Calorie Intake|Crops|Cereals|+|Temperate cereals",
             "Nutrition|Calorie Intake|Crops|Cereals|+|Tropical cereals",
             "Nutrition|Calorie Intake|Crops|Oil crops|+|Groundnuts",
             "Nutrition|Calorie Intake|Crops|Oil crops|+|Other oil crops incl rapeseed",
             "Nutrition|Calorie Intake|Crops|Oil crops|+|Soybean",
             "Nutrition|Calorie Intake|Crops|Oil crops|+|Sunflower",
             "Nutrition|Calorie Intake|Crops|Other crops|+|Fruits Vegetables Nuts",
             "Nutrition|Calorie Intake|Crops|Other crops|+|Potatoes",
             "Nutrition|Calorie Intake|Crops|Other crops|+|Pulses",
             "Nutrition|Calorie Intake|Crops|Other crops|+|Tropical roots",
             "Nutrition|Calorie Intake|Crops|Sugar crops|+|Sugar beet",
             "Nutrition|Calorie Intake|Crops|Sugar crops|+|Sugar cane",
             "Nutrition|Calorie Intake|Livestock products|+|Dairy",
             "Nutrition|Calorie Intake|Livestock products|+|Eggs",
             "Nutrition|Calorie Intake|Livestock products|+|Monogastric meat",
             "Nutrition|Calorie Intake|Livestock products|+|Poultry meat",
             "Nutrition|Calorie Intake|Livestock products|+|Ruminant meat",
             "Nutrition|Calorie Intake|Secondary products|+|Alcoholic beverages",
             "Nutrition|Calorie Intake|Secondary products|+|Brans",
             "Nutrition|Calorie Intake|Secondary products|+|Molasses",
             "Nutrition|Calorie Intake|Secondary products|+|Oils",
             "Nutrition|Calorie Intake|Secondary products|+|Sugar",
             "Nutrition|Calorie Supply",
             "Nutrition|Calorie Supply|+|Crops",
             "Nutrition|Calorie Supply|+|Fish",
             "Nutrition|Calorie Supply|+|Livestock products",
             "Nutrition|Calorie Supply|+|Secondary products",
             "Nutrition|Calorie Supply|Crops|+|Cereals",
             "Nutrition|Calorie Supply|Crops|+|Oil crops",
             "Nutrition|Calorie Supply|Crops|+|Other crops",
             "Nutrition|Calorie Supply|Crops|+|Sugar crops",
             "Nutrition|Calorie Supply|Crops|Cereals|+|Maize",
             "Nutrition|Calorie Supply|Crops|Cereals|+|Rice",
             "Nutrition|Calorie Supply|Crops|Cereals|+|Temperate cereals",
             "Nutrition|Calorie Supply|Crops|Cereals|+|Tropical cereals",
             "Nutrition|Calorie Supply|Crops|Oil crops|+|Groundnuts",
             "Nutrition|Calorie Supply|Crops|Oil crops|+|Other oil crops incl rapeseed",
             "Nutrition|Calorie Supply|Crops|Oil crops|+|Soybean",
             "Nutrition|Calorie Supply|Crops|Oil crops|+|Sunflower",
             "Nutrition|Calorie Supply|Crops|Other crops|+|Fruits Vegetables Nuts",
             "Nutrition|Calorie Supply|Crops|Other crops|+|Potatoes",
             "Nutrition|Calorie Supply|Crops|Other crops|+|Pulses",
             "Nutrition|Calorie Supply|Crops|Other crops|+|Tropical roots",
             "Nutrition|Calorie Supply|Crops|Sugar crops|+|Sugar beet",
             "Nutrition|Calorie Supply|Crops|Sugar crops|+|Sugar cane",
             "Nutrition|Calorie Supply|Livestock products|+|Dairy",
             "Nutrition|Calorie Supply|Livestock products|+|Eggs",
             "Nutrition|Calorie Supply|Livestock products|+|Monogastric meat",
             "Nutrition|Calorie Supply|Livestock products|+|Poultry meat",
             "Nutrition|Calorie Supply|Livestock products|+|Ruminant meat",
             "Nutrition|Calorie Supply|Secondary products|+|Alcoholic beverages",
             "Nutrition|Calorie Supply|Secondary products|+|Brans",
             "Nutrition|Calorie Supply|Secondary products|+|Molasses",
             "Nutrition|Calorie Supply|Secondary products|+|Oils",
             "Nutrition|Calorie Supply|Secondary products|+|Sugar",
             "Demand|+|Agricultural Supply Chain Loss",
             "Demand|+|Bioenergy",
             "Demand|+|Feed",
             "Demand|+|Food",
             "Demand|+|Material",
             "Demand|+|Processing",
             "Demand|+|Seed",
             "Demand|+|Roundwood",
             "Demand|+|Domestic Balanceflow",
             "Trade|+|Net-Trade",
             "Trade|Net-Trade|+|Crops",
             "Trade|Net-Trade|+|Fish",
             "Trade|Net-Trade|+|Forest products",
             "Trade|Net-Trade|+|Livestock products",
             "Trade|Net-Trade|+|Secondary products",
             "Trade|Net-Trade|Crops|+|Cereals",
             "Trade|Net-Trade|Crops|+|Oil crops",
             "Trade|Net-Trade|Crops|+|Other crops",
             "Trade|Net-Trade|Crops|+|Sugar crops",
             "Trade|Net-Trade|Crops|Cereals|+|Maize",
             "Trade|Net-Trade|Crops|Cereals|+|Rice",
             "Trade|Net-Trade|Crops|Cereals|+|Temperate cereals",
             "Trade|Net-Trade|Crops|Cereals|+|Tropical cereals",
             "Trade|Net-Trade|Crops|Oil crops|+|Cotton seed",
             "Trade|Net-Trade|Crops|Oil crops|+|Groundnuts",
             "Trade|Net-Trade|Crops|Oil crops|+|Other oil crops incl rapeseed",
             "Trade|Net-Trade|Crops|Oil crops|+|Soybean",
             "Trade|Net-Trade|Crops|Oil crops|+|Sunflower",
             "Trade|Net-Trade|Crops|Other crops|+|Fruits Vegetables Nuts",
             "Trade|Net-Trade|Crops|Other crops|+|Potatoes",
             "Trade|Net-Trade|Crops|Other crops|+|Pulses",
             "Trade|Net-Trade|Crops|Other crops|+|Tropical roots",
             "Trade|Net-Trade|Crops|Sugar crops|+|Sugar beet",
             "Trade|Net-Trade|Crops|Sugar crops|+|Sugar cane",
             "Trade|Net-Trade|Forest products|+|Industrial roundwood",
             "Trade|Net-Trade|Forest products|+|Wood fuel",
             "Trade|Net-Trade|Livestock products|+|Dairy",
             "Trade|Net-Trade|Livestock products|+|Eggs",
             "Trade|Net-Trade|Livestock products|+|Monogastric meat",
             "Trade|Net-Trade|Livestock products|+|Poultry meat",
             "Trade|Net-Trade|Livestock products|+|Ruminant meat",
             "Trade|Net-Trade|Secondary products|+|Sugar",
             "Trade|Self-sufficiency|Crops|Cereals",
             "Trade|Self-sufficiency|Crops|Cereals|Maize",
             "Trade|Self-sufficiency|Crops|Cereals|Rice",
             "Trade|Self-sufficiency|Crops|Cereals|Temperate cereals",
             "Trade|Self-sufficiency|Crops|Cereals|Tropical cereals",
             "Trade|Self-sufficiency|Crops|Other crops",
             "Trade|Self-sufficiency|Crops|Other crops|Fruits Vegetables Nuts",
             "Trade|Self-sufficiency|Crops|Other crops|Potatoes",
             "Trade|Self-sufficiency|Crops|Other crops|Pulses",
             "Trade|Self-sufficiency|Crops|Other crops|Tropical roots",
             "Trade|Self-sufficiency|Crops|Sugar crops|Sugar cane",
             "Trade|Self-sufficiency|Fish",
             "Trade|Self-sufficiency|Livestock products",
             "Trade|Self-sufficiency|Livestock products|Dairy",
             "Trade|Self-sufficiency|Livestock products|Eggs",
             "Trade|Self-sufficiency|Livestock products|Monogastric meat",
             "Trade|Self-sufficiency|Livestock products|Poultry meat",
             "Trade|Self-sufficiency|Livestock products|Ruminant meat",
             "Trade|Self-sufficiency|Secondary products",
             "Trade|Self-sufficiency|Secondary products|Alcoholic beverages",
             "Trade|Self-sufficiency|Secondary products|Brans",
             "Trade|Self-sufficiency|Secondary products|Cotton lint",
             "Trade|Self-sufficiency|Secondary products|Distillers grains",
             "Trade|Self-sufficiency|Secondary products|Ethanol",
             "Trade|Self-sufficiency|Secondary products|Microbial protein",
             "Trade|Self-sufficiency|Secondary products|Molasses",
             "Trade|Self-sufficiency|Secondary products|Oilcakes",
             "Trade|Self-sufficiency|Secondary products|Oils",
             "Trade|Self-sufficiency|Secondary products|Sugar",
             "Emissions|CO2|Land|+|Land-use Change",
             "Emissions|CH4|Land|+|Agriculture",
             "Emissions|N2O|Land|+|Agriculture",
             "Resources|Land Cover|+|Cropland",
             "Resources|Land Cover|+|Pastures and Rangelands",
             "Resources|Land Cover|Forest|Natural Forest|+|Primary Forest",
             "Resources|Land Cover|Forest|Natural Forest|+|Secondary Forest",
             "Resources|Land Cover|Forest|Managed Forest|+|Plantations",
             "Resources|Land Cover|Forest|Managed Forest|+|NPI/NDC",
             "Resources|Land Cover|Forest|Managed Forest|+|Afforestation",
             "Resources|Land Cover|Cropland|+|Bioenergy crops",
             "Resources|Land Cover|+|Other Land",
             "Resources|Land Cover|+|Urban Area",
             "Resources|Land Cover|Cropland|Crops|Cereals|+|Maize",
             "Resources|Land Cover|Cropland|Crops|Cereals|+|Rice",
             "Resources|Land Cover|Cropland|Crops|Cereals|+|Temperate cereals",
             "Resources|Land Cover|Cropland|Crops|Cereals|+|Tropical cereals",
             "Resources|Land Cover|Cropland|Crops|Oil crops|+|Cotton seed",
             "Resources|Land Cover|Cropland|Crops|Oil crops|+|Groundnuts",
             "Resources|Land Cover|Cropland|Crops|Oil crops|+|Oilpalms",
             "Resources|Land Cover|Cropland|Crops|Oil crops|+|Other oil crops incl rapeseed",
             "Resources|Land Cover|Cropland|Crops|Oil crops|+|Soybean",
             "Resources|Land Cover|Cropland|Crops|Oil crops|+|Sunflower",
             "Resources|Land Cover|Cropland|Crops|Sugar crops|+|Sugar beet",
             "Resources|Land Cover|Cropland|Crops|Sugar crops|+|Sugar cane",
             "Resources|Land Cover|Cropland|Crops|Other crops|+|Fruits Vegetables Nuts",
             "Resources|Land Cover|Cropland|Crops|Other crops|+|Potatoes",
             "Resources|Land Cover|Cropland|Crops|Other crops|+|Pulses",
             "Resources|Land Cover|Cropland|Crops|Other crops|+|Tropical roots",
             "Resources|Land Cover|Cropland|Crops|Cereals|irrigated",
             "Resources|Land Cover|Cropland|Crops|Cereals|Maize|irrigated",
             "Resources|Land Cover|Cropland|Crops|Cereals|Maize|rainfed",
             "Resources|Land Cover|Cropland|Crops|Cereals|rainfed",
             "Resources|Land Cover|Cropland|Crops|Cereals|Rice|irrigated",
             "Resources|Land Cover|Cropland|Crops|Cereals|Rice|rainfed",
             "Resources|Land Cover|Cropland|Crops|Cereals|Temperate cereals|irrigated",
             "Resources|Land Cover|Cropland|Crops|Cereals|Temperate cereals|rainfed",
             "Resources|Land Cover|Cropland|Crops|Cereals|Tropical cereals|irrigated",
             "Resources|Land Cover|Cropland|Crops|Cereals|Tropical cereals|rainfed",
             "Resources|Land Cover|Cropland|Crops|irrigated",
             "Resources|Land Cover|Cropland|Crops|Oil crops|Groundnuts|irrigated",
             "Resources|Land Cover|Cropland|Crops|Oil crops|Groundnuts|rainfed",
             "Resources|Land Cover|Cropland|Crops|Oil crops|irrigated",
             "Resources|Land Cover|Cropland|Crops|Oil crops|Other oil crops incl rapeseed|irrigated",
             "Resources|Land Cover|Cropland|Crops|Oil crops|Other oil crops incl rapeseed|rainfed",
             "Resources|Land Cover|Cropland|Crops|Oil crops|rainfed",
             "Resources|Land Cover|Cropland|Crops|Other crops|Fruits Vegetables Nuts|irrigated",
             "Resources|Land Cover|Cropland|Crops|Other crops|Fruits Vegetables Nuts|rainfed",
             "Resources|Land Cover|Cropland|Crops|Other crops|irrigated",
             "Resources|Land Cover|Cropland|Crops|Other crops|Potatoes|irrigated",
             "Resources|Land Cover|Cropland|Crops|Other crops|Potatoes|rainfed",
             "Resources|Land Cover|Cropland|Crops|Other crops|Pulses|irrigated",
             "Resources|Land Cover|Cropland|Crops|Other crops|Pulses|rainfed",
             "Resources|Land Cover|Cropland|Crops|Other crops|rainfed",
             "Resources|Land Cover|Cropland|Crops|Other crops|Tropical roots|irrigated",
             "Resources|Land Cover|Cropland|Crops|Other crops|Tropical roots|rainfed",
             "Resources|Land Cover|Cropland|Crops|rainfed",
             "Resources|Land Cover|Cropland|Crops|Sugar crops|irrigated",
             "Resources|Land Cover|Cropland|Crops|Sugar crops|rainfed",
             "Resources|Land Cover|Cropland|Crops|Sugar crops|Sugar beet|irrigated",
             "Resources|Land Cover|Cropland|Crops|Sugar crops|Sugar beet|rainfed",
             "Resources|Land Cover|Cropland|Crops|Sugar crops|Sugar cane|irrigated",
             "Resources|Land Cover|Cropland|Crops|Sugar crops|Sugar cane|rainfed",
             "Resources|Land Cover|Cropland|Forage|irrigated",
             "Resources|Land Cover|Cropland|Forage|rainfed",
             "Resources|Land Cover|Cropland|+|Bioenergy crops",
             "Resources|Land Cover|Cropland|+|Fallow Cropland",

             "SDG|SDG15|Biological nitrogen fixation on cropland",
             "SDG|SDG15|Non-agricultural land share",
             "SDG|SDG15|Other natural land share",

             "Resources|Nitrogen|Pollution|Surplus|+|Cropland",
             "Resources|Nitrogen|Pollution|Surplus|+|Pasture",
             "Resources|Nitrogen|Pollution|Surplus|+|Animal Waste Management",
             "Resources|Nitrogen|Pollution|Surplus|+|Non-agricultural land",
             "Resources|Water|Withdrawal|Agriculture",

             "Resources|Nitrogen|Cropland Budget|Soil Nitrogen Uptake Efficiency",

             "Emissions|CH4_GWP*AR6|Land",
             "Emissions|CH4_GWP*AR6|Land|+|Agriculture",
             "Emissions|CH4_GWP*AR6|Land|+|Biomass Burning",
             "Emissions|CH4_GWP*AR6|Land|+|Peatland",
             "Emissions|CH4_GWP*AR6|Land|Agriculture|+|Animal waste management",
             "Emissions|CH4_GWP*AR6|Land|Agriculture|+|Enteric fermentation",
             "Emissions|CH4_GWP*AR6|Land|Agriculture|+|Rice",
             "Emissions|CH4_GWP*AR6|Land|Biomass Burning|+|Burning of Crop Residues",
             "Emissions|CH4_GWP*AR6|Land|Peatland|+|Managed",
             "Emissions|CH4_GWP100AR6|Land",
             "Emissions|CH4_GWP100AR6|Land|+|Agriculture",
             "Emissions|CH4_GWP100AR6|Land|+|Biomass Burning",
             "Emissions|CH4_GWP100AR6|Land|+|Peatland",
             "Emissions|CH4_GWP100AR6|Land|Agriculture|+|Animal waste management",
             "Emissions|CH4_GWP100AR6|Land|Agriculture|+|Enteric fermentation",
             "Emissions|CH4_GWP100AR6|Land|Agriculture|+|Rice",
             "Emissions|CH4_GWP100AR6|Land|Biomass Burning|+|Burning of Crop Residues",
             "Emissions|CH4_GWP100AR6|Land|Peatland|+|Managed",
             "Emissions|CH4|Land",
             "Emissions|CH4|Land|+|Agriculture",
             "Emissions|CH4|Land|+|Biomass Burning",
             "Emissions|CH4|Land|+|Peatland",
             "Emissions|CH4|Land|Agriculture|+|Animal waste management",
             "Emissions|CH4|Land|Agriculture|+|Enteric fermentation",
             "Emissions|CH4|Land|Agriculture|+|Rice",
             "Emissions|CH4|Land|Biomass Burning|+|Burning of Crop Residues",
             "Emissions|CH4|Land|Peatland|+|Managed",
             "Emissions|CO2|Land",
             "Emissions|CO2|Land RAW",
             "Emissions|CO2|Land RAW|+|Indirect RAW",
             "Emissions|CO2|Land RAW|+|Land-use Change RAW",
             "Emissions|CO2|Land|+|Indirect",
             "Emissions|CO2|Land|+|Land-use Change",
             "Emissions|CO2|Land|Cumulative",
             "Emissions|CO2|Land|Cumulative|+|Indirect",
             "Emissions|CO2|Land|Cumulative|+|Land-use Change",
             "Emissions|CO2|Land|Cumulative|Land-use Change|+|Gross LUC",
             "Emissions|CO2|Land|Cumulative|Land-use Change|+|Peatland",
             "Emissions|CO2|Land|Cumulative|Land-use Change|+|Regrowth",
             "Emissions|CO2|Land|Cumulative|Land-use Change|Gross LUC|+|Forest Degradation",
             "Emissions|CO2|Land|Cumulative|Land-use Change|Regrowth|CO2-price AR",
             "Emissions|CO2|Land|Cumulative|Land-use Change|Regrowth|NPI_NDC AR",
             "Emissions|CO2|Land|Cumulative|Land-use Change|Regrowth|Other Land",
             "Emissions|CO2|Land|Cumulative|Land-use Change|Regrowth|Secondary Forest",
             "Emissions|CO2|Land|Cumulative|Land-use Change|Regrowth|Timber Plantations",
             "Emissions|CO2|Land|Land-use Change|++|Above Ground Carbon",
             "Emissions|CO2|Land|Land-use Change|++|Below Ground Carbon",
             "Emissions|CO2|Land|Land-use Change|+|Gross LUC",
             "Emissions|CO2|Land|Land-use Change|+|Peatland",
             "Emissions|CO2|Land|Land-use Change|+|Regrowth",
             "Emissions|CO2|Land|Land-use Change|Gross LUC|+|Forest Degradation",
             "Emissions|CO2|Land|Land-use Change|Regrowth|CO2-price AR",
             "Emissions|CO2|Land|Land-use Change|Regrowth|NPI_NDC AR",
             "Emissions|CO2|Land|Land-use Change|Regrowth|Other Land",
             "Emissions|CO2|Land|Land-use Change|Regrowth|Secondary Forest",
             "Emissions|CO2|Land|Land-use Change|Regrowth|Timber Plantations",
             "Emissions|GWP100AR6|Land",
             "Emissions|GWP100AR6|Land|Cumulative",
             "Emissions|N2O_GWP100AR6|Land",
             "Emissions|N2O_GWP100AR6|Land|+|Agriculture",
             "Emissions|N2O_GWP100AR6|Land|+|Biomass Burning",
             "Emissions|N2O_GWP100AR6|Land|+|Peatland",
             "Emissions|N2O_GWP100AR6|Land|Agriculture|+|Agricultural Soils",
             "Emissions|N2O_GWP100AR6|Land|Agriculture|+|Animal Waste Management",
             "Emissions|N2O_GWP100AR6|Land|Agriculture|Agricultural Soils|+|Decay of Crop Residues",
             "Emissions|N2O_GWP100AR6|Land|Agriculture|Agricultural Soils|+|Inorganic Fertilizers",
             "Emissions|N2O_GWP100AR6|Land|Agriculture|Agricultural Soils|+|Manure applied to Croplands",
             "Emissions|N2O_GWP100AR6|Land|Agriculture|Agricultural Soils|+|Pasture",
             "Emissions|N2O_GWP100AR6|Land|Agriculture|Agricultural Soils|+|Soil Organic Matter Loss",
             "Emissions|N2O_GWP100AR6|Land|Agriculture|Agricultural Soils|Inorganic Fertilizers|+|Cropland",
             "Emissions|N2O_GWP100AR6|Land|Agriculture|Agricultural Soils|Inorganic Fertilizers|+|Pasture",
             "Emissions|N2O_GWP100AR6|Land|Biomass Burning|+|Burning of Crop Residues",
             "Emissions|N2O_GWP100AR6|Land|Peatland|+|Managed",
             "Emissions|N2O|Direct|Land",
             "Emissions|N2O|Direct|Land|+|Agriculture",
             "Emissions|N2O|Direct|Land|+|Biomass Burning",
             "Emissions|N2O|Direct|Land|Agriculture|+|Agricultural Soils",
             "Emissions|N2O|Direct|Land|Agriculture|+|Animal Waste Management",
             "Emissions|N2O|Direct|Land|Agriculture|Agricultural Soils|+|Decay of Crop Residues",
             "Emissions|N2O|Direct|Land|Agriculture|Agricultural Soils|+|Inorganic Fertilizers",
             "Emissions|N2O|Direct|Land|Agriculture|Agricultural Soils|+|Manure applied to Croplands",
             "Emissions|N2O|Direct|Land|Agriculture|Agricultural Soils|+|Pasture",
             "Emissions|N2O|Direct|Land|Agriculture|Agricultural Soils|+|Soil Organic Matter Loss",
             "Emissions|N2O|Direct|Land|Agriculture|Agricultural Soils|Inorganic Fertilizers|+|Cropland",
             "Emissions|N2O|Direct|Land|Agriculture|Agricultural Soils|Inorganic Fertilizers|+|Pasture",
             "Emissions|N2O|Direct|Land|Biomass Burning|+|Burning of Crop Residues",
             "Emissions|N2O|Indirect|Land",
             "Emissions|N2O|Indirect|Land|+|Agriculture",
             "Emissions|N2O|Indirect|Land|+|Biomass Burning",
             "Emissions|N2O|Indirect|Land|Agriculture|+|Agricultural Soils",
             "Emissions|N2O|Indirect|Land|Agriculture|+|Animal Waste Management",
             "Emissions|N2O|Indirect|Land|Agriculture|Agricultural Soils|+|Decay of Crop Residues",
             "Emissions|N2O|Indirect|Land|Agriculture|Agricultural Soils|+|Inorganic Fertilizers",
             "Emissions|N2O|Indirect|Land|Agriculture|Agricultural Soils|+|Manure applied to Croplands",
             "Emissions|N2O|Indirect|Land|Agriculture|Agricultural Soils|+|Pasture",
             "Emissions|N2O|Indirect|Land|Agriculture|Agricultural Soils|+|Soil Organic Matter Loss",
             "Emissions|N2O|Indirect|Land|Agriculture|Agricultural Soils|Inorganic Fertilizers|+|Cropland",
             "Emissions|N2O|Indirect|Land|Agriculture|Agricultural Soils|Inorganic Fertilizers|+|Pasture",
             "Emissions|N2O|Indirect|Land|Biomass Burning|+|Burning of Crop Residues",
             "Emissions|N2O|Land",
             "Emissions|N2O|Land|+|Agriculture",
             "Emissions|N2O|Land|+|Biomass Burning",
             "Emissions|N2O|Land|+|Peatland",
             "Emissions|N2O|Land|Agriculture|+|Agricultural Soils",
             "Emissions|N2O|Land|Agriculture|+|Animal Waste Management",
             "Emissions|N2O|Land|Agriculture|Agricultural Soils|+|Decay of Crop Residues",
             "Emissions|N2O|Land|Agriculture|Agricultural Soils|+|Inorganic Fertilizers",
             "Emissions|N2O|Land|Agriculture|Agricultural Soils|+|Manure applied to Croplands",
             "Emissions|N2O|Land|Agriculture|Agricultural Soils|+|Pasture",
             "Emissions|N2O|Land|Agriculture|Agricultural Soils|+|Soil Organic Matter Loss",
             "Emissions|N2O|Land|Agriculture|Agricultural Soils|Inorganic Fertilizers|+|Cropland",
             "Emissions|N2O|Land|Agriculture|Agricultural Soils|Inorganic Fertilizers|+|Pasture",
             "Emissions|N2O|Land|Biomass Burning|+|Burning of Crop Residues",
             "Emissions|N2O|Land|Peatland|+|Managed",
             "Emissions|NH3|Land",
             "Emissions|NH3|Land|+|Agriculture",
             "Emissions|NH3|Land|+|Biomass Burning",
             "Emissions|NH3|Land|Agriculture|+|Agricultural Soils",
             "Emissions|NH3|Land|Agriculture|+|Animal Waste Management",
             "Emissions|NH3|Land|Agriculture|Agricultural Soils|+|Decay of Crop Residues",
             "Emissions|NH3|Land|Agriculture|Agricultural Soils|+|Inorganic Fertilizers",
             "Emissions|NH3|Land|Agriculture|Agricultural Soils|+|Manure applied to Croplands",
             "Emissions|NH3|Land|Agriculture|Agricultural Soils|+|Pasture",
             "Emissions|NH3|Land|Agriculture|Agricultural Soils|+|Soil Organic Matter Loss",
             "Emissions|NH3|Land|Agriculture|Agricultural Soils|Inorganic Fertilizers|+|Cropland",
             "Emissions|NH3|Land|Agriculture|Agricultural Soils|Inorganic Fertilizers|+|Pasture",
             "Emissions|NH3|Land|Biomass Burning|+|Burning of Crop Residues",
             "Emissions|NO2|Land",
             "Emissions|NO2|Land|+|Agriculture",
             "Emissions|NO2|Land|+|Biomass Burning",
             "Emissions|NO2|Land|Agriculture|+|Agricultural Soils",
             "Emissions|NO2|Land|Agriculture|+|Animal Waste Management",
             "Emissions|NO2|Land|Agriculture|Agricultural Soils|+|Decay of Crop Residues",
             "Emissions|NO2|Land|Agriculture|Agricultural Soils|+|Inorganic Fertilizers",
             "Emissions|NO2|Land|Agriculture|Agricultural Soils|+|Manure applied to Croplands",
             "Emissions|NO2|Land|Agriculture|Agricultural Soils|+|Pasture",
             "Emissions|NO2|Land|Agriculture|Agricultural Soils|+|Soil Organic Matter Loss",
             "Emissions|NO2|Land|Agriculture|Agricultural Soils|Inorganic Fertilizers|+|Cropland",
             "Emissions|NO2|Land|Agriculture|Agricultural Soils|Inorganic Fertilizers|+|Pasture",
             "Emissions|NO2|Land|Biomass Burning|+|Burning of Crop Residues",
             "Emissions|NO3-|Land",
             "Emissions|NO3-|Land|+|Agriculture",
             "Emissions|NO3-|Land|+|Biomass Burning",
             "Emissions|NO3-|Land|Agriculture|+|Agricultural Soils",
             "Emissions|NO3-|Land|Agriculture|+|Animal Waste Management",
             "Emissions|NO3-|Land|Agriculture|Agricultural Soils|+|Decay of Crop Residues",
             "Emissions|NO3-|Land|Agriculture|Agricultural Soils|+|Inorganic Fertilizers",
             "Emissions|NO3-|Land|Agriculture|Agricultural Soils|+|Manure applied to Croplands",
             "Emissions|NO3-|Land|Agriculture|Agricultural Soils|+|Pasture",
             "Emissions|NO3-|Land|Agriculture|Agricultural Soils|+|Soil Organic Matter Loss",
             "Emissions|NO3-|Land|Agriculture|Agricultural Soils|Inorganic Fertilizers|+|Cropland",
             "Emissions|NO3-|Land|Agriculture|Agricultural Soils|Inorganic Fertilizers|+|Pasture",
             "Emissions|NO3-|Land|Biomass Burning|+|Burning of Crop Residues",

             "SDG|SDG15|Afforestation",


             "Nutrition|Anthropometrics|People normalweight",
             "Nutrition|Anthropometrics|People obese",
             "Nutrition|Anthropometrics|People overweight",
             "Nutrition|Anthropometrics|People underweight",
             "Labor|Employment|Agricultural employment",
             "Labor|Employment|Agricultural employment|+|Crop products",
             "Labor|Employment|Agricultural employment|+|Livestock products",
             "Labor|Employment|Agricultural employment|+|MACCS",
             "Labor|Wages|Hourly labor costs",
             "Labor|Total Hours Worked",
             "Income|Gini Coefficient",
             "Income|Average Income of Lower 40% of Population",
             "Income|Fraction of Population below half of Median Income",
             "Income|Number of People Below 1p90 USDppp11/day",
             "Income|Number of People Below 3p20 USDppp11/day",
             "Income|Number of People Below 5p50 USDppp11/day",
             "Health|Years of life lost|Disease",
             "Health|Years of life lost|Disease|+|Congenital Heart Disease",
             "Health|Years of life lost|Disease|+|Stroke",
             "Health|Years of life lost|Disease|+|Cancer",
             "Health|Years of life lost|Disease|+|Type-2 Diabetes",
             "Health|Years of life lost|Disease|+|Respiratory Disease",
             "Health|Attributable deaths|Disease"
)
var_reg <- unique(var_reg)

var_iso <- c("Population",
             "Health|Years of life lost|Disease",
             "Labor|Employment|Agricultural employment",
             "Nutrition|Anthropometrics|People underweight",
             "Nutrition|Anthropometrics|People obese",
             "Household Expenditure|Food|Expenditure",
             "Income|Number of People Below 3p20 USDppp11/day",
             "Income|Gini Coefficient")
var_iso <- unique(var_iso)

for (i in 1:length(outputdir)) {
  print(paste("Processing",outputdir[i]))
  cfg <- gms::loadConfig(file.path(outputdir[i], "config.yml"))

  ### regional level outputs
  rep <- file.path(outputdir[i], "report.rds")
  if(file.exists(rep)) {
    a <- as.data.table(readRDS(rep))
    a <- a[variable %in% var_reg,]
    a <- droplevels(a)
    reg <- rbind(reg, a)
  } else missing <- c(missing,rep)

  ### ISO and Grid level outputs
  ## only for BAU and SDP in 2020 and 2050 to save time and storage
  years <- c(2020, 2050)
  scen <- c("BAU", "FSDP", "SSP2fsdp")
  thisScen <- unlist(strsplit(cfg$title, "_"))[3]
  if (thisScen %in% scen) {

    ### ISO level outputs
    rep <- file.path(outputdir[i], "report_iso.rds")
    if(file.exists(rep)) {
      a <- as.data.table(readRDS(rep))
      a <- a[variable %in% var_iso & period %in% years,]
      a <- droplevels(a)
      iso <- rbind(iso, a)
    } else missing <- c(missing,rep)
  }

  scen <- c("BAU", "FSDP", "SSP2fsdp")
  #scen <- c("ERROR")
  thisScen <- unlist(strsplit(cfg$title, "_"))[3]
  if (thisScen %in% scen) {
    ###Grid level outputs
    y     <- NULL

    ## BII
    nc_file <- file.path(outputdir[i], "cell.bii_0.5.mz") #Note the "_" instead of "-"
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      getNames(a) <- "BII (index)"
      getSets(a,fulldim = F)[3] <- "variable"
      y <- mbind(y,a)
    } else missing <- c(missing,nc_file)

    ## Gridded temperature data from ISIMIP archive for relevant SSP/RCP
    rcp <- switch(thisScen,
                  "BAU"      = "ssp460",
                  "FSDP"     = "ssp119",
                  "SSP2fsdp" = "ssp245",
                  "Invalid case")


    nc_file <- "./input/FSEC_GlobalSurfaceTempPerRCP_v4_19-03-24/FSEC_GlobalSurfaceTempPerRCP_v4_19-03-24.mz"

    if (file.exists(nc_file)) {
      a <- read.magpie(nc_file)[, years, rcp]
      getNames(a) <- "Global Surface Temperature (C)"
      getSets(a, fulldim = FALSE)[3] <- "variable"
      y <- mbind(y, a)
    } else missing <- c(missing, nc_file)

    ## Crop diversity
    nc_file <- file.path(outputdir[i], paste0(cfg$title, "-CropDiversityGridded.mz"))
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years, "ShannonCropDiversity"]
      getNames(a) <- "Shannon crop diversity (index)"
      getSets(a,fulldim = F)[3] <- "variable"
      y <- mbind(y,a)
    } else missing <- c(missing,nc_file)

    ## land patterns Mha
    nc_file <- file.path(outputdir[i], "cell.land_0.5.mz")
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      getNames(a) <- paste0(getNames(a)," (Mha)")
      getSets(a,fulldim = F)[3] <- "variable"
      y <- mbind(y,a)
    } else missing <- c(missing,nc_file)

    ## land patterns share
    nc_file <- file.path(outputdir[i], "cell.land_0.5_share.mz")
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      land_hr_shr <- a #needed for croparea shares
      getNames(a) <- paste0(getNames(a)," (area share)")
      getSets(a,fulldim = F)[3] <- "variable"
      y <- mbind(y,a)
    } else missing <- c(missing,nc_file)

    ## croparea shares
    nc_file <- file.path(outputdir[i], "cell.croparea_0.5_share.mz")
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      a <- dimSums(a,dim = "w")
      getNames(a) <- reportingnames(getNames(a))
      a <- mbind(a, setNames(collapseNames(land_hr_shr[,,"crop"]) - dimSums(a, dim = 3), "Fallow"))
      a[a < 0] <- 0
      getNames(a) <- paste0("Cropland|",getNames(a)," (area share)")
      getSets(a,fulldim = F)[3] <- "variable"
      y <- mbind(y,a)
    } else missing <- c(missing,nc_file)

    ## Nitrogen
    nc_file <- file.path(outputdir[i], paste(cfg$title, "nutrientSurplus_intensity.mz", sep = "-"))
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      getNames(a) <- "nutrientSurplus (kg N per ha)"
      getSets(a,fulldim = F)[3] <- "variable"
      y <- mbind(y,a)
    } else missing <- c(missing, nc_file)

    ## Water
    nc_file <- file.path(outputdir[i], "watStressViolations.mz")
    if (file.exists(nc_file)) {
      a <- read.magpie(nc_file)[, years, ]
      getNames(a) <- "water stress and violations"
      getSets(a, fulldim = FALSE)[3] <- "variable"
      y <- mbind(y, a)
    } else missing <- c(missing, nc_file)

    nc_file <- file.path(outputdir[i], "efvVolume.mz")
    if (file.exists(nc_file)) {
      a <- read.magpie(nc_file)[, years, ]
      getNames(a) <- "water environmental flow violations volume (km3)"
      getSets(a, fulldim = FALSE)[3] <- "variable"
      y <- mbind(y, a)
    } else missing <- c(missing, nc_file)

    nc_file <- file.path(outputdir[i], "efvVolume_ha.mz")
    if (file.exists(nc_file)) {
      a <- read.magpie(nc_file)[, years, ]
      getNames(a) <- "water environmental flow violations volume (m3/ha)"
      getSets(a, fulldim = FALSE)[3] <- "variable"
      y <- mbind(y, a)
    } else missing <- c(missing, nc_file)

    #add dimensions

    if (is.null(y)) {
      message("Scenario: ", cfg$title, " contained none of the cellular output data.")
    } else {
      y <- add_dimension(y, dim = 3.1, add = "scenario", nm = gsub(".", "_", cfg$title, fixed = TRUE))
      y <- add_dimension(y, dim = 3.1, add = "model", nm = "MAgPIE")
      getSets(y, fulldim = FALSE)[2] <- "period"

      #save as data.frame with xy coordinates
      y <- as.data.table(as.data.frame(y, rev = 3))

      #bind together
      grid <- rbind(grid, y)
    }
  }
}

if (!is.null(missing)) {
  cat("\nList of folders with missing report files\n")
  print(missing)
}

renameScenario <- function(rep) {
  rep <- rep[!get("scenario") %like% "calibration_FSEC", ]
  rep[, c("version", "scenset", "scenario") := tstrsplit(scenario, "_", fixed = TRUE)]
  return(rep)
}

message("Saving rds files ...")

reg  <- renameScenario(reg)
saveRDS(reg,  file = file.path("output", paste0(rev, "_FSDP_reg.rds")), version = 2, compress = "xz")
iso  <- renameScenario(iso)
saveRDS(iso,  file = file.path("output", paste0(rev, "_FSDP_iso.rds")), version = 2, compress = "xz")
if(!is.null(grid)){
  grid <- renameScenario(grid)
  saveRDS(grid, file = file.path("output", paste0(rev, "_FSDP_grid.rds")), version = 2, compress = "xz")
}

# save i_to_iso mapping
gdx     <- file.path(outputdir[1], "fulldata.gdx")
reg2iso <- readGDX(gdx, "i_to_iso")
names(reg2iso) <- c("region", "iso_a3")
write.csv(reg2iso, file.path("output", "reg2iso.csv"))
saveRDS(reg2iso, file = file.path("output", "reg2iso.rds"), version = 2, compress = "xz")

# save validation file
val <- file.path("input", "validation.mif")
val <- as.data.table(read.quitte(val))
saveRDS(val, file = file.path("output", paste0(rev, "_FSDP_validation.rds")), version = 2, compress = "xz")

message("Plotting figures ...")
#Add new plots here:
#https://github.com/pik-piam/m4fsdp/blob/master/R/plotFSDP.R
plotFSDP(outputfolder = "output",
         reg = reg,
         iso = iso,
         grid = grid,
         val = val,
         reg2iso = reg2iso,
         rev = rev)
