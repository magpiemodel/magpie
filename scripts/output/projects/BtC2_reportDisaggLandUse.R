# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -------------------------------------------------------------------------------------------------
# description: Creates a NetCDF file with disaggregated land use pools for Bending the Curve 2.0
# comparison script: FALSE
# -------------------------------------------------------------------------------------------------

# Version 1.00 - Patrick v. Jeetze
# 1.00: first working version

library(lucode2)
library(magpie4)
library(madrat)
library(gms)
library(gdx2)
library(mstools)
library(ncdf4)
library(tidyr)
library(dplyr)

############################# BASIC CONFIGURATION #############################
if (!exists("source_include")) {
  outputdir <- NULL
  # Define arguments that can be read from command line
  readArgs("outputdir")
}
###############################################################################

suffix <- ""

projectName <- "BtC2v04"

mapFile <- Sys.glob(file.path(outputdir, "clustermap_*.rds"))
gdx <- file.path(outputdir, "fulldata.gdx")
landHrFile <- file.path(outputdir, "cell.land_0.5.mz")
landSplitHrFile <- file.path(outputdir, "cell.land_split_0.5.mz")
transitionsHrFile <- file.path(outputdir, "cell.land_transitions_0.5.mz")
cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))

# -----------------------------------------
#  Helper functions
# -----------------------------------------

.printSuffix <- function(suffix) {
  suffix <- ifelse(suffix == "", "", paste0("_", suffix))
  return(suffix)
}

.printProjectName <- function(projectName, title) {
  if (grepl(tolower(projectName), tolower(title))) {
    projectName <- ""
  } else {
    projectName <- paste0(projectName, "_")
  }
  return(projectName)
}

# Area of a report class: the sum of the land split items of the class (classOf: class by item).
.classArea <- function(landSplit, classOf, class) {
  return(setNames(dimSums(landSplit[, , names(which(classOf == class))], dim = 3), class))
}

# Other land of one origin (from toolGriddedLandOrigin) as report class; zero where no area has that origin.
.originArea <- function(otherOrigin, origin, class) {
  item <- paste("other", origin, sep = ".")
  if (item %in% getItems(otherOrigin, dim = 3)) {
    return(setNames(otherOrigin[, , item], class))
  } else {
    return(setNames(otherOrigin[, , 1] * 0, class))
  }
}


# ----------------------
# Read input data
# ----------------------

# Read disaggregated MAgPIE outputs
landHr <- read.magpie(landHrFile)[, 1985, , invert = TRUE]
landSplitHr <- read.magpie(landSplitHrFile)[, 1985, , invert = TRUE]
# gross grid cell transitions between the land types by stage, with managed forest (timber plantations
# and other planted forest) as a type of its own
transitionsHr <- read.magpie(transitionsHrFile)
fromLabel <- getItems(transitionsHr, "from", full = TRUE)
fromLabel[getItems(transitionsHr, "fromType", full = TRUE) %in% c("plant", "other_planted")] <- "timber"
transitionLabel <- paste(getItems(transitionsHr, "stage", full = TRUE), fromLabel,
                         getItems(transitionsHr, "to", full = TRUE), sep = ".")
transitionsHr <- mbind(lapply(unique(transitionLabel), function(label) {
  setNames(dimSums(transitionsHr[, , which(transitionLabel == label)], dim = 3), label)
}))
getSets(transitionsHr, fulldim = FALSE)[3] <- "stage.from.to"


# ----------------------------------------------------
# Cropland, grassland, forest and built-up classes
# ----------------------------------------------------

# report class of each item of the land split; afforestation counts as planted forest if it is
# established as plantation, other planted forest (harvested and replanted) always does
splitItems <- getItems(landSplitHr, dim = 3)
classOf <- setNames(rep(NA_character_, length(splitItems)), splitItems)
classOf[startsWith(splitItems, "crop.")] <- "crop_other"
classOf[startsWith(splitItems, "crop.kbe.")] <- "crop_2G_bioen"
classOf[startsWith(splitItems, "past.")] <- "grass"
classOf[startsWith(splitItems, "primforest.") | startsWith(splitItems, "secdforest.")] <- "nat_regen_forest"
classOf[startsWith(splitItems, "forestry.")] <- "forest_planted"
classOf["forestry.ndc.total"] <- "nat_regen_forest"
if (as.logical(readGDX(gdx, "s32_aff_plantation"))) {
  classOf["forestry.aff.total"] <- "forest_planted"
} else {
  classOf["forestry.aff.total"] <- "nat_regen_forest"
}
classOf[startsWith(splitItems, "urban.")] <- "built_up_areas"

stateHr <- mbind(.classArea(landSplitHr, classOf, "crop_other"),
                 .classArea(landSplitHr, classOf, "crop_2G_bioen"),
                 .classArea(landSplitHr, classOf, "grass"),
                 .classArea(landSplitHr, classOf, "nat_regen_forest"),
                 .classArea(landSplitHr, classOf, "forest_planted"))
urbanHr <- .classArea(landSplitHr, classOf, "built_up_areas")


# -----------------------------------------------
# Recovered (abandoned & restored) & other land
# -----------------------------------------------

# Other land by origin along the grid cell transitions from the first time step on: area that came from
# cropland, pasture or managed forest counts as recovering land of that origin until it leaves other
# land (maturation to secondary forest or conversion); the newest area leaves first. Area from
# afforestation and NDC forest counts as other land.
otherOriginHr <- mrdownscale::toolGriddedLandOrigin(transitionsHr[, -1, ], landHr[, 1, ], "other")
recoveringHr <- mbind(.originArea(otherOriginHr, "crop", "rest_abn_crop"),
                      .originArea(otherOriginHr, "past", "rest_abn_grass"),
                      .originArea(otherOriginHr, "timber", "rest_forest"))
otherHr <- mbind(recoveringHr, setNames(landHr[, , "other"] - dimSums(recoveringHr, dim = 3), "other"))


# ----------------------
# Combine classes
# ----------------------

landOut <- mbind(stateHr, otherHr, urbanHr)
landOut[is.na(landOut)] <- 0

# calculate total land area
landArea <- dimSums(landOut, dim = 3, na.rm = TRUE)

# land cover share output
landOutShr <- landOut / landArea

# -----------------------------------
# Write regional outputs as CSV file
# -----------------------------------

# LU reporting classes and codes
outNames <- c(
  "1=cropland_other", "2=cropland_2Gbioen", "3=grassland",
  "4=nat_regen_forest", "5=forest_planted", "6=rest_abn_crop",
  "7=rest_abn_grass", "8=rest_forest", "9=other", "10=built_up_areas"
)


# Write CSV file for regional LU reporting
for (yr in getYears(landOut)) {
  csvOut <- landOut[, yr, ]
  csvOut <- toolAggregate(csvOut, rel = mapFile, from = "cell", to = "region")
  getNames(csvOut) <- outNames
  regionsOut <- getItems(csvOut, "region")
  csvOut <- as.data.frame(csvOut)
  csvOut <- csvOut %>%
    pivot_wider(
      names_from = Region,
      values_from = Value
    ) %>%
    rename(Row = Data1)

  write.csv(
    csvOut[, c("Row", regionsOut)],
    file.path(
      outputdir,
      paste0(
        .printProjectName(projectName, cfg$title), cfg$title,
        .printSuffix(suffix), "_", yr, ".csv"
      )
    ),
    row.names = FALSE
  )
}


# -----------------------------------
# Write NetCDF in requested format
# -----------------------------------

# create dimensions
lon <- seq(-179.75, 179.75, by = 0.5)
lat <- -seq(-89.75, 89.75, by = 0.5)
time <- as.numeric(sub("y", "", getYears(landOutShr)))
lcClass <- 1:length(getNames(landOut))
dimLon <- ncdf4::ncdim_def("lon", "degrees_east", lon)
dimLat <- ncdf4::ncdim_def("lat", "degrees_north", lat)
dimTime <- ncdf4::ncdim_def("time", "years", calendar = "standard", time, unlim = TRUE)
dimLandClass <- ncdf4::ncdim_def("lc_class", paste(outNames, collapse = "/"), lcClass)

# create variables
fillvalue <- NaN
varNameLandShr <- "share of pixel occupied by various land covers"
landCoverVar <- ncvar_def(
  name = "LC_area_share", units = "share of pixel area", longname = varNameLandShr,
  dim = list(dimLon, dimLat, dimLandClass, dimTime),
  missval = fillvalue, prec = "double", compression = 9
)
varNameTotArea <- "total area of the pixel"
totAreaVar <- ncvar_def(
  name = "pixel_area", units = "million ha", longname = varNameTotArea,
  dim = list(dimLon, dimLat), missval = fillvalue, prec = "double", compression = 9
)

### Land cover share

# create the empty data array for land cover share
landCoverVarArray <- array(
  NA,
  dim = c(length(lon), length(lat), length(lcClass), length(time)),
  dimnames = list(lon, lat, lcClass, time)
)

# convert magclass object to array
landOutShr <- as.array(landOutShr)
landOutShr <- aperm(landOutShr, c(1, 3, 2))

coord <- toolGetMappingCoord2Country(pretty = TRUE)
for (i in 1:ncells(landOutShr)) {
  landCoverVarArray[which(coord[i, "lon"] == lon), which(coord[i, "lat"] == lat), , ] <- landOutShr[i, , , drop = FALSE]
}

### Land area

# create the empty data array for land area
totAreaVarArray <- array(NA, dim = c(length(lon), length(lat)), dimnames = list(lon, lat))

# convert magclass object to array
landArea <- as.array(landArea)
landArea <- aperm(landArea, c(1, 3, 2))

for (i in 1:ncells(landArea)) {
  totAreaVarArray[which(coord[i, "lon"] == lon), which(coord[i, "lat"] == lat)] <- landArea[i, , "y1995", drop = FALSE]
}

# create & fill netcdf with two variables
ncnew <- nc_create(
  file.path(
    outputdir, paste0(.printProjectName(projectName, cfg$title), cfg$title, .printSuffix(suffix), ".nc")
  ),
  list(landCoverVar, totAreaVar),
  force_v4 = TRUE
)
ncvar_put(ncnew, totAreaVar, totAreaVarArray)
ncvar_put(ncnew, landCoverVar, landCoverVarArray)
# add attributes
ncatt_put(ncnew, 0, "title", "MAgPIE land cover projections")
ncatt_put(ncnew, 0, "scenario", cfg$title)
ncatt_put(ncnew, 0, "institution", "PIK")
ncatt_put(ncnew, 0, "contact", "F. Humpenöder, humpenoeder@pik-potsdam.de; P. v. Jeetze, vjeetze@pik-potsdam.de")
ncatt_put(ncnew, 0, "history", date())
# close
nc_close(ncnew)
