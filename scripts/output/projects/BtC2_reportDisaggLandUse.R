# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Creates a NetCDF file with disaggregated land pools,
# reclassified to land types used in the Bending the Curve 2.0 project
# comparison script: FALSE
# ---------------------------------------------------------------

# Version 1.00 - Patrick v. Jeetze
# 1.00: first working version

library(lucode2)
library(magpie4)
library(madrat)
library(gms)
library(gdx2)
library(mstools)
library(ncdf4)

############################# BASIC CONFIGURATION #############################
if (!exists("source_include")) {
  outputdir <- NULL
  # Define arguments that can be read from command line
  readArgs("outputdir")
}
###############################################################################

suffix <- "firstruns"


mapFile <- Sys.glob(file.path(outputdir, "clustermap_*.rds"))
gdx <- file.path(outputdir, "fulldata.gdx")
landHrFile <- file.path(outputdir, "cell.land_0.5.mz")
landConsvHrFile <- file.path(outputdir, "cell.conservation_land_0.5.mz")
cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))

# -----------------------------------------
#  Helper functions
# -----------------------------------------
.calcDiffLand <- function(landPool) {
  dlandPool <- landPool[, 2:nyears(landPool), ] - setYears(landPool[, 1:nyears(landPool) - 1, ], tail(getYears(landPool), -1))
  return(dlandPool)
}


# ----------------------
# Read input data
# ----------------------

# Read disaggregated MAgPIE outputs
landHr <- read.magpie(landHrFile)[, 1985, , invert = TRUE]
landConsvHr <- read.magpie(landConsvHrFile)


# ----------------------
# Cropland classes
# ----------------------

carea <- magpie4::croparea(gdx,
    level = "cell", products = "kcr",
    product_aggr = FALSE, water_aggr = TRUE
  )
cropOtherLr <- setNames(dimSums(carea[, , c("begr", "betr"), invert = TRUE], dim = 3), "crop_other")
cropBELr <- setNames(dimSums(carea[, , c("begr", "betr")], dim = 3), "crop_2G_bioen")


careaShr <- mbind(cropOtherLr, cropBELr) / (dimSums(carea, dim = 3) + 10^-10)
careaShrHr <- madrat::toolAggregate(careaShr, mapFile, to = "cell")


careaHr <-  careaShrHr * setNames(landHr[, , "crop"], NULL)


# ----------------------
# Grassland class
# ----------------------

# Grassland share
grassHr <- setNames(landHr[, , "past"], "grass")

# -----------------------------------
# Recovered land
# -----------------------------------

# unmanaged land recovered after 2020 needs to be
# distributed among restored and abandoned land
landRecovrdHr <- landHr[,,c("primforest", "secdforest", "other")] - setYears(landHr[, "y2020", c("primforest", "secdforest", "other")], NULL)
landRecovrdHr[landRecovrdHr < 0] <- 0
# only consider recovered land after 2015
landRecovrdHr[, seq(1995, 2015, 5), ] <- 0

# for restoration only consider unmanaged vegetation classes
landConsvHr <- landConsvHr[, , c("primforest", "secdforest", "other")]
# only consider land conservation after 2015
landConsvHr[, seq(1995, 2015, 5), ] <- 0

# subtract restoration area from remaining unmanaged vegetation
landRestorHr <- pmin(landConsvHr, landRecovrdHr[, , c("primforest", "secdforest", "other")])
# Restored land
landRestorHr <- setNames(dimSums(landRestorHr, dim = 3), "rest")

#
landUnmgdHr <- landHr[, , c("primforest", "secdforest", "other")] - landRecovrdHr


# ----------------------
# Forest classes
# ----------------------

forestHr <- setNames(dimSums(landUnmgdHr[, , c("primforest", "secdforest")], dim = 3), "forest_unmanaged")
forestryHr <- setNames(dimSums(landHr[, , "forestry"], dim = 3), "forest_managed")

# ----------------------
# Non-forest land
# ----------------------

otherHr <- setNames(landUnmgdHr[, , "other"], "other")

# ----------------------
# Urban land
# ----------------------

urbanHr <- setNames(landHr[, , "urban"], "built_up_areas")

# ----------------------
# Abandonend land
# ----------------------

landAbnHr <- setNames(dimSums(landRecovrdHr, dim = 3) - landRestorHr, "abn_land")


# ----------------------
# Combine classes
# ----------------------

landOut <- mbind(
  careaHr,
  grassHr,
  forestHr,
  forestryHr,
  landRestorHr,
  otherHr,
  urbanHr,
  landAbnHr
)

# land cover share output
landOutShr <- landOut / dimSums(landOut, dim = 3)
landOutShr <- toolConditionalReplace(landOutShr, "is.na()")

# caculate total land area
landArea <- dimSums(landOut, dim = 3)

# -----------------------------------
# Write NetCDF in requested format
# -----------------------------------

# create dimensions
lon <- seq(-179.75, 179.75, by = 0.5)
lat <- -seq(-89.75, 89.75, by = 0.5)
time <- as.numeric(sub("y","",getYears(landOutShr)))
lcClass <- 1:9
dimLon <- ncdf4::ncdim_def("lon", "degrees_east",lon)
dimLat <- ncdf4::ncdim_def("lat", "degrees_north",lat)
dimTime <- ncdf4::ncdim_def("time", "years", calendar="standard",time,unlim=TRUE)
dimLandClass <- ncdf4::ncdim_def("lc_class", "1=cropland_other/2=cropland_2Gbioen/3=grassland/4=forest_unmanaged/5=forest_managed/6=restored/7=other/8=built-up/9=abn_land",lcClass)

# create variables
fillvalue <- NaN
varNameLandShr <- 'share of pixel occupied by various land covers'
LandCoverVar <- ncvar_def(name = "LC_area_share",units = "share of pixel area",longname = varNameLandShr,dim = list(dimLon,dimLat,dimLandClass,dimTime), missval=fillvalue,prec = "double",compression = 9)
varNameTotArea<- 'total area of the pixel'
totAreaVar <- ncvar_def(name = "pixel_area",units = "million ha",  longname = varNameTotArea,
                           dim = list(dimLon,dimLat), missval=fillvalue, prec = "double",compression = 9)

### Land cover share

# create the empty data array for land cover share
LandCoverVarArray <- array(NA, dim = c(length(lon), length(lat), length(lcClass), length(time)),dimnames = list(lon, lat, lcClass, time))

# convert magclass object to array
landOutShr <- as.array(landOutShr)
landOutShr <- aperm(landOutShr, c(1,3,2))

coord <- toolGetMappingCoord2Country(pretty = TRUE)
for (i in 1:ncells(landOutShr)) {
  LandCoverVarArray[which(coord[i, "lon"] == lon), which(coord[i, "lat"] == lat), , ] <- landOutShr[i, , , drop = FALSE]
}

### Land area

# create the empty data array for land area
totAreaVarArray <- array(NA, dim = c(length(lon), length(lat)), dimnames = list(lon, lat))

# convert magclass object to array
landArea <- as.array(landArea)
landArea <- aperm(landArea, c(1,3,2))

for (i in 1:ncells(landArea)) {
  totAreaVarArray[which(coord[i, "lon"] == lon), which(coord[i, "lat"] == lat)] <- landArea[i, ,"y1995", drop = FALSE]
}

# create & fill netcdf with two variables
ncnew <- nc_create(file.path(outputdir, paste0("BendingTheCurve2_LCproj_MAgPIE_",cfg$title,"_",suffix,".nc")), list(LandCoverVar,totAreaVar),force_v4=TRUE)
ncvar_put(ncnew,totAreaVar,totAreaVarArray)
ncvar_put(ncnew,LandCoverVar,LandCoverVarArray)
# add attributes
ncatt_put(ncnew,0,"title",'MAgPIE land cover projections')
ncatt_put(ncnew,0,"scenario",cfg$title)
ncatt_put(ncnew,0,"institution",'PIK')
ncatt_put(ncnew,0,"contact","F. Humpenöder, humpenoeder@pik-potsdam.de; P. v. Jeetze, vjeetze@pik-potsdam.de")
ncatt_put(ncnew,0,"history",date())
# close
nc_close(ncnew)

