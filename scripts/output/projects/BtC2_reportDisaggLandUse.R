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
landConsvHrFile <- file.path(outputdir, "cell.conservation_land_0.5.mz")
cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))

# -----------------------------------------
#  Helper functions
# -----------------------------------------

.calcDiffLand <- function(landPool) {
  dlandPool <- landPool[, 2:nyears(landPool), ] -
    setYears(landPool[, 1:nyears(landPool) - 1, ], tail(getYears(landPool), -1))
  return(dlandPool)
}

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


# ----------------------
# Read input data
# ----------------------

# MAgPIE land pools per time step
landLr <- readGDX(gdx, "ov_land", select = list(type = "level"))
# Land reduction during model optimisation
landReducOptLr <- readGDX(gdx, "ov_landreduction", select = list(type = "level"))

# Read disaggregated MAgPIE outputs
landHr <- read.magpie(landHrFile)[, 1985, , invert = TRUE]
landSplitHr <- read.magpie(landSplitHrFile)[, 1985, , invert = TRUE]
landConsvHr <- read.magpie(landConsvHrFile)


# ----------------------
# Cropland classes
# ----------------------

cropOtherLr <- setNames(dimSums(landSplitHr[, , c("crop_kfo_rf", "crop_kfo_ir")], dim = 3), "crop_other")
cropBELr <- setNames(dimSums(landSplitHr[, , c("crop_kbe_rf", "crop_kbe_ir")], dim = 3), "crop_2G_bioen")
careaHr <- mbind(cropOtherLr, cropBELr)

# ----------------------
# Grassland class
# ----------------------

# Grassland share
grassHr <- setNames(landHr[, , "past"], "grass")


# ----------------------
# Forest classes
# ----------------------

plantationAff <- as.logical(readGDX(gdx, "s32_aff_plantation"))

if (plantationAff) {
  forestHr <- setNames(dimSums(
    landSplitHr[, , c(
      "primforest", "secdforest",
      "PlantedForest_NPiNDC"
    )],
    dim = 3
  ), "nat_regen_forest")

  forestryHr <- setNames(landSplitHr[, , c("PlantedForest_Timber", "PlantedForest_Afforestation")], "forest_planted")
} else {
  forestHr <- setNames(dimSums(
    landSplitHr[, , c(
      "primforest", "secdforest",
      "PlantedForest_Afforestation", "PlantedForest_NPiNDC"
    )],
    dim = 3
  ), "nat_regen_forest")

  forestryHr <- setNames(landSplitHr[, , "PlantedForest_Timber"], "forest_planted")
}

# -----------------------------------------------
# Recovered (abandoned & restored) & other land
# -----------------------------------------------

# define sets
otherLandTypes <- c("rest_abn_crop", "rest_abn_grass", "rest_forest", "other")
origLandTypes <- otherLandTypes[otherLandTypes != "other"]

### Other land expansion and reduction

otherDiff <- .calcDiffLand(landHr[, , "other"])
otherExpan <- otherDiff
otherExpan[otherDiff < 0] <- 0

otherReduc <- otherDiff
otherReduc[otherReduc > 0] <- 0
otherReduc <- abs(otherReduc)

# --- Contribution of abandoned managed land types to other land expansion -------

# Reduction of managed land types
mnglandReduc <- mbind(
  .calcDiffLand(landHr[, , c("crop", "past")]),
  .calcDiffLand(landSplitHr[, , "PlantedForest_Timber"])
)
mnglandReduc[mnglandReduc > 0] <- 0
# Contribution of managed land types to total managed land reduction
mnglandReducShr <- mnglandReduc / dimSums(mnglandReduc, dim = 3)
mnglandReducShr[is.nan(mnglandReducShr)] <- 0

# Contribution of managed land reduction to transition to other land
otherExpanMngShr <- abs(dimSums(mnglandReduc, dim = 3)) / otherExpan
otherExpanMngShr[is.na(otherExpanMngShr) | is.infinite(otherExpanMngShr)] <- 0
otherExpanMngShr[otherExpanMngShr > 1] <- 1
# make sure that managed land transition to other is 0 in first time step
otherExpanMngShr[, 1, ] <- 0

# Share of total other land expansion attributed to overall managed land reduction
otherExpanMng <- otherExpanMngShr * otherExpan
# residual other land expansion
otherExpanResidual <- (1 - otherExpanMngShr) * otherExpan

# Attribute other land expansion to reduction of different managed land types
otherExpanOrig <- mnglandReducShr * otherExpanMng
getNames(otherExpanOrig) <- origLandTypes

# --- Contribution of secondary forest maturation to other land reduction -------

# Secondary forest maturation is happening before optimisation
# so the ratio between other land reduction during the optimisation
# and total other land reduction between time steps gives the share
# of other land that is reduced due to maturation.
# This share is calculated at the native MAgPIE resolution and
# then disaggregated to estimate the contribution of secondary forest
# maturation to other land reduction at 0.5 degrees.

# Overall other land reduction at MAgPIE cluster level
otherDiffLr <- .calcDiffLand(landLr[, , "other"])
otherReducLr <- otherDiffLr
otherReducLr[otherReducLr > 0] <- 0
otherReducLr <- abs(otherReducLr)

# Other land reduction during optimisation divided by total other land reduction
# to derive the share of secondary forest maturation in total other land reduction
otherSecdforestMatShr <- landReducOptLr[, -1, "other"] / otherReducLr
otherSecdforestMatShr[!is.finite(otherSecdforestMatShr) | otherSecdforestMatShr > 1] <- 1
# make sure that secondary forest maturation is 0 in the first time step
otherSecdforestMatShr[, 1, ] <- 0

# Weighted disaggregation of forest maturation share to 0.5 degree
disaggWeightLr <- dimSums(landLr[, -1, "other"], dim = 3)
otherSecdforestMatShr <- toolAggregate(otherSecdforestMatShr * disaggWeightLr,
                                       rel = mapFile, from = "cluster", to = "cell")
disaggWeightHr <- toolAggregate(disaggWeightLr, rel = mapFile, from = "cluster", to = "cell")
otherSecdforestMatShr <- otherSecdforestMatShr / disaggWeightHr
otherSecdforestMatShr[is.na(otherSecdforestMatShr)] <- 0

# --- Attribute other land change -------

otherHr <- new.magpie(
  cells_and_regions = getCells(landHr),
  years = getYears(landHr),
  names = otherLandTypes,
  fill = NA,
  sets = names(dimnames(landHr))
)
otherHr[, 1, "other"] <- landHr[, 1, "other"]
otherHr[, , origLandTypes] <- 0

for (yrIdx in 2:nyears(landHr)) {
  # --- Abandoned/restored & other land expansion -------

  # concatenate attributed and residual other land expansion
  otherExpanAll <- mbind(otherExpanOrig[, yrIdx - 1, ], otherExpanResidual[, yrIdx - 1, ])
  # Allocate abandoned/restored & other land expansion
  otherHr[, yrIdx, ] <- setYears(otherHr[, yrIdx - 1, ], NULL) + otherExpanAll

  # --- Abandoned/restored & other land reduction -------

  # Total secondary forest maturation in time step
  secdforestMaturation <- setNames(otherReduc[, yrIdx - 1, ] * otherSecdforestMatShr[, yrIdx - 1, ], NULL)
  # Total secondary forest maturation cannot be larger than
  # abandoned/restored land in previous time step.
  totAbnLand <- setYears(dimSums(otherHr[, yrIdx - 1, origLandTypes], dim = 3), NULL)
  secdforestMaturation[secdforestMaturation > totAbnLand] <- totAbnLand[secdforestMaturation > totAbnLand]

  # Residual other land reduction in time step
  otherReducResidual <- setYears(otherReduc[, yrIdx - 1, ], NULL) - secdforestMaturation
  otherReducResidual[otherReducResidual > otherHr[, yrIdx, "other"]] <-
    otherHr[, yrIdx, "other"][otherReducResidual > otherHr[, yrIdx, "other"]]

  # Using MAgPIE cluster transitions underestimates loss of recovered land
  missAbnReduction <- setNames(
    otherReduc[, yrIdx - 1, ] - dimSums(secdforestMaturation + otherReducResidual, dim = 3),
    NULL
  )
  secdforestMaturation <- secdforestMaturation + missAbnReduction

  # Total secondary forest maturation is attributed to abandoned/restored land types
  origLandTypesShr <- otherHr[, yrIdx - 1, origLandTypes] / dimSums(otherHr[, yrIdx - 1, origLandTypes], dim = 3)
  origLandTypesShr[!is.finite(origLandTypesShr)] <- 0
  secdforestMaturation <- secdforestMaturation * setYears(origLandTypesShr, NULL)

  # Allocate abandoned/restored & other land reduction
  otherReducAll <- mbind(secdforestMaturation, otherReducResidual)
  otherHr[, yrIdx, ] <- setYears(otherHr[, yrIdx, ], NULL) - otherReducAll
}


# ----------------------
# Urban land
# ----------------------

urbanHr <- setNames(landHr[, , "urban"], "built_up_areas")


# ----------------------
# Combine classes
# ----------------------

landOut <- mbind(
  careaHr,
  grassHr,
  forestHr,
  forestryHr,
  otherHr,
  urbanHr
)
landOut[is.na(landOut)] <- 0

# caculate total land area
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
