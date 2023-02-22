# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Collect reg, iso and grid level data from multiple FSDP runs
# comparison script: TRUE
# ---------------------------------------------------------------

# Version 1.0, Florian Humpenoeder

library(lucode2)
library(magclass)
library(gms)
library(magpiesets)
library(data.table)
library(gdx)
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
subfolder <- unlist(lapply(strsplit(x = outputdir, split = "/"), FUN = "[", 3))
title     <- basename(outputdir)

if (all(subfolder == title)) {
  subfolder <- ""
} else {
  subfolder <- subfolder[1]
}

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

##########
# Append nutrient surplus reports
.appendNutrientSurplus <- function(.x) {
    cfg <- gms::loadConfig(file.path(.x, "config.yml"))
    title <- cfg$title

    tryCatch(
        expr = {
            appendReportNutrientSurplus(scenario = title, dir = .x)
        }, error = function(e) {
            message("Unable to append the nutrient surplus dataset!\n", e)
        }
    )
}
lapply(X = outputdir, FUN = .appendNutrientSurplus)

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
             "Biodiversity|Biodiversity hotspot intactness (unitless)",
             "Population",
             "Income",
             "Nutrition|Calorie Supply|+|Crops",
             "Nutrition|Calorie Supply|+|Livestock products",
             "Demand|++|Crops",
             "Demand|++|Livestock products",
             "Resources|Land Cover|+|Cropland",
             "Resources|Land Cover|+|Pastures and Rangelands",
             "Resources|Land Cover|+|Forest",
             "Resources|Land Cover|Forest|+|Managed Forest",
             "Resources|Land Cover|Forest|Natural Forest|+|Primary Forest",
             "Resources|Land Cover|Forest|Natural Forest|+|Secondary Forest",
             "Resources|Land Cover|+|Other Land",
             "Resources|Land Cover|+|Urban Area",
             "Productivity|Landuse Intensity Indicator Tau",
             "Resources|Nitrogen|Cropland Budget|Inputs|+|Fertilizer",
             "Resources|Water|Withdrawal|Agriculture",
             ### Maps
             "Costs",
             "Population",
             "Labor|Employment|Share of working age population employed in agriculture",
             "Labor|Wages|Hourly labor costs",
             ### Suppl plots
             "Population",
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
             "Resources|Land Cover|Cropland|+|Bioenergy crops",
             "Resources|Land Cover|Cropland|+|Fallow Cropland",
             "Resources|Nitrogen|Cropland Budget|Balance|+|Nutrient Surplus",
             "Resources|Nitrogen|Pasture Budget|Balance|+|Nutrient Surplus",
             "Resources|Water|Withdrawal|Agriculture",
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
             "Income|Number of People Below 5p50 USDppp11/day"
             )
var_reg <- unique(var_reg)

var_iso <- c("Population",
             "Health|Years of life lost|Risk|Diet and anthropometrics",
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
  scen <- c("BAU", "FSDP")
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

    ###Grid level outputs
    y     <- NULL

    ## BII
    nc_file <- file.path(outputdir[i], paste(cfg$title, "cell.bii_0.5.mz", sep = "_"))#Note the "_" instead of "-"
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      getNames(a) <- "BII (index)"
      getSets(a,fulldim = F)[3] <- "variable"
      a <- addLocation(a)
      y <- mbind(y,a)
    } else missing <- c(missing,nc_file)

    ## Gridded temperature data from ISIMIP archive for relevant SSP/RCP
    rcp     <- if (thisScen == "BAU") "ssp245" else "ssp119"
    nc_file <- "./input/FSEC_GlobalSurfaceTempPerRCP_v2_16-01-23/FSEC_GlobalSurfaceTempPerRCP_v2_16-01-23.mz"
    if (file.exists(nc_file)) {
      a <- read.magpie(nc_file)[, years, rcp]
      getNames(a) <- "Global Surface Temperature (C)"
      getSets(a, fulldim = FALSE)[3] <- "variable"
      a <- addLocation(a)
      y <- mbind(y, a)
    } else missing <- c(missing, nc_file)

    ## Crop diversity
    nc_file <- file.path(outputdir[i], paste0(cfg$title, "-CropDiversityGridded.mz"))
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years, "ShannonCropDiversity"]
      getNames(a) <- "Shannon crop diversity (index)"
      getSets(a,fulldim = F)[3] <- "variable"
      a <- addLocation(a)
      y <- mbind(y,a)
    } else missing <- c(missing,nc_file)

    ## land patterns Mha
    nc_file <- file.path(outputdir[i], "cell.land_0.5.mz")
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      getNames(a) <- paste0(getNames(a)," (Mha)")
      getSets(a,fulldim = F)[3] <- "variable"
      a <- addLocation(a)
      y <- mbind(y,a)
    } else missing <- c(missing,nc_file)

    ## land patterns share
    nc_file <- file.path(outputdir[i], "cell.land_0.5_share.mz")
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      land_hr_shr <- a #needed for croparea shares
      getNames(a) <- paste0(getNames(a)," (area share)")
      getSets(a,fulldim = F)[3] <- "variable"
      a <- addLocation(a)
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
      a <- addLocation(a)
      y <- mbind(y,a)
    } else missing <- c(missing,nc_file)

    ## Nitrogen
    nc_file <- file.path(outputdir[i], paste(cfg$title, "nutrientSurplus_intensity.mz", sep = "-"))
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      getNames(a) <- "nutrientSurplus (kg N per ha)"
      getSets(a,fulldim = F)[3] <- "variable"
      a <- addLocation(a)
      y <- mbind(y,a)
    } else missing <- c(missing,nc_file)

    ## Water
    nc_file <- file.path(outputdir[i], "watStressViolations.mz")
    if (file.exists(nc_file)) {
      a <- read.magpie(nc_file)[, years, ]
      getNames(a) <- "water stress and violations"
      getSets(a,  fulldim = FALSE)[3] <- "variable"
      a <- addLocation(a)
      y <- mbind(y, a)
    } else missing <- c(missing,nc_file)

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

reg  <- renameScenario(reg)
iso  <- renameScenario(iso)
grid <- renameScenario(grid)

message("Saving rds files ...")

saveRDS(reg,  file = file.path(unique("output", subfolder), paste0(rev, "_FSDP_reg.rds")), version = 2, compress = "xz")
saveRDS(iso,  file = file.path(unique("output", subfolder), paste0(rev, "_FSDP_iso.rds")), version = 2, compress = "xz")
saveRDS(grid, file = file.path(unique("output", subfolder), paste0(rev, "_FSDP_grid.rds")), version = 2, compress = "xz")

# save i_to_iso mapping
gdx     <- file.path(outputdir[1], "fulldata.gdx")
reg2iso <- readGDX(gdx, "i_to_iso")
names(reg2iso) <- c("region", "iso_a3")
write.csv(reg2iso, file.path(unique("output", subfolder), "reg2iso.csv"))
saveRDS(reg2iso, file = file.path(unique("output", subfolder), "reg2iso.rds"), version = 2, compress = "xz")

# save validation file
val <- file.path(unique(outputdir[1], subfolder), "validation.mif")
val <- as.data.table(read.quitte(val))
saveRDS(val, file = file.path(unique("output", subfolder), paste0(rev, "_FSDP_validation.rds")), version = 2, compress = "xz")

message("Plotting figures ...")
#Add new plots here:
#https://github.com/pik-piam/m4fsdp/blob/master/R/plotFSDP.R
plotFSDP(outputfolder = file.path("output", unique(subfolder)),
         reg = reg,
         iso = iso,
         grid = grid,
         val = val,
         reg2iso = reg2iso,
         rev = rev)
