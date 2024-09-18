# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Interpolates land pools to 0.5 degree resolution
# comparison script: FALSE
# ---------------------------------------------------------------

library(lucode2)
library(magpie4)
library(luscale)
library(madrat)
library(dplyr)
library(gms)
library(gdx2)

# =============================================
# Basic configuration
# =============================================
if (!exists("source_include")) {
  outputdir <- "output/default_2024-06-01_15.40.24/"
  readArgs("outputdir")
}
map_file <- Sys.glob(file.path(outputdir, "clustermap_*.rds"))
gdx <- file.path(outputdir, "fulldata.gdx")
land_hr_file <- file.path(outputdir, "avl_land_full_t_0.5.mz")
urban_land_hr_file <- file.path(outputdir, "f34_urbanland_0.5.mz")
wdpa_hr_file <- file.path(outputdir, "wdpa_baseline_0.5.mz")
consv_prio_hr_file <- file.path(outputdir, "consv_prio_areas_0.5.mz")
land_consv_hr_out_file <- file.path(outputdir, "cell.conservation_land_0.5.mz")
land_hr_out_file <- file.path(outputdir, "cell.land_0.5.mz")
land_hr_share_out_file <- file.path(outputdir, "cell.land_0.5_share.mz")
croparea_hr_share_out_file <- file.path(outputdir, "cell.croparea_0.5_share.mz")
land_hr_split_file <- file.path(outputdir, "cell.land_split_0.5.mz")
land_hr_shr_split_file <- file.path(outputdir, "cell.land_split_0.5_share.mz")
luh_side_layers <- file.path(outputdir, "luh2_side_layers_0.5.mz")
bii_hr_out_file <- file.path(outputdir, "cell.bii_0.5.mz")
peatland_v2_hr_file <- file.path(outputdir, "f58_peatland_area_0.5.mz")
peatland_on_intact_hr_file <- file.path(outputdir, "f58_peatland_intact_0.5.mz")
peatland_on_degrad_hr_file <- file.path(outputdir, "f58_peatland_degrad_0.5.mz")
peatland_hr_out_file <- file.path(outputdir, "cell.peatland_0.5.mz")
peatland_hr_share_out_file <- file.path(outputdir, "cell.peatland_0.5_share.mz")

cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))

withr::local_options(list(magclass_sizeLimit = 1e+12))

if (length(map_file) == 0) stop("Could not find map file!")
if (length(map_file) > 1) {
  warning("More than one map file found. First occurrence will be used!")
  map_file <- map_file[1]
}

# -----------------------------------------
#  Output functions
# -----------------------------------------

.fixCoords <- function(x) {
  getSets(x, fulldim = FALSE)[1] <- "x.y.iso"
  return(x)
}

.writeDisagg <- function(x, file, comment, message) {
  base::message(message)
  x <- .fixCoords(x)
  write.magpie(x, file, comment = comment)
}

.dissagcrop <- function(gdx, land_hr, map_file) {
  area <- croparea(gdx,
    level = "cell", products = "kcr",
    product_aggr = FALSE, water_aggr = FALSE
  )
  area_shr <- area / (dimSums(area, dim = 3) + 10^-10)

  # calculate share of crop land on total cell area
  crop_shr <- land_hr / dimSums(land_hr, dim = 3)
  crop_shr <- setNames(crop_shr[, getYears(area_shr), "crop_area"], NULL)

  # calculate crop area as share of total cell area
  area_shr_hr <- madrat::toolAggregate(area_shr, map_file, to = "cell") * crop_shr
  return(area_shr_hr)
}

.dissagLandConsv <- function(gdx, cfg, map_file, wdpa_hr_file, consv_prio_hr_file) {
  land_consv_lr <- readGDX(gdx, "p22_conservation_area", react = "silent")
  wdpa_hr <- read.magpie(wdpa_hr_file)
  map <- readRDS(map_file)

  # create full time series
  land_consv_hr <- new.magpie(map[, "cell"], getYears(land_consv_lr), getItems(wdpa_hr, dim = 3.2),
    fill = 0, sets = c("x.y.iso", "year", "data")
  )

  iso <- readGDX(gdx, "iso")
  consv_iso <- readGDX(gdx, "policy_countries22")
  consv_iso <- consv_iso[consv_iso %in% getItems(wdpa_hr, dim = 1.3)]
  if (length(consv_iso) == 0) {
    warning("No countries selected in land conservation disaggregation. Results may be erroneous")
  }

  base_protect_select <- cfg$gms$c22_base_protect
  base_protect_noselect <- cfg$gms$c22_base_protect_noselect

  if (!all(c(base_protect_select, base_protect_noselect) %in% "none")) {

    if (base_protect_noselect != "none") {
      land_consv_hr[, getYears(land_consv_hr), ] <- collapseDim(wdpa_hr[, nyears(wdpa_hr), base_protect_noselect], dim = 3.1)
      land_consv_hr[, getYears(wdpa_hr), ] <- collapseDim(wdpa_hr[, , base_protect_noselect], dim = 3.1)
    }
    if (base_protect_select != "none") {
      land_consv_hr[consv_iso, , ] <- collapseDim(wdpa_hr[consv_iso, nyears(wdpa_hr), base_protect_select], dim = 3.1)
    } else {
      land_consv_hr[consv_iso, , ] <- 0
    }
  }

  consv_select <- cfg$gms$c22_protect_scenario
  consv_noselect <- cfg$gms$c22_protect_scenario_noselect

  if (!all(c(consv_select, consv_noselect) %in% "none")) {
    if (file.exists(consv_prio_hr_file)) {
      consv_prio_all <- read.magpie(consv_prio_hr_file)
      consv_prio_hr <- new.magpie(
        cells_and_regions = map[, "cell"],
        names = getNames(consv_prio_all, dim = 2), fill = 0,
        sets = c("x.y.iso", "year", "data")
      )

      if (consv_noselect != "none") {
        consv_prio_hr <- collapseDim(consv_prio_all[, , consv_noselect], dim = 3.1)
      }
      if (consv_select != "none") {
        consv_prio_hr[consv_iso, , ] <- collapseDim(consv_prio_all[consv_iso, , consv_select], dim = 3.1)
      } else {
        consv_prio_hr[consv_iso, , ] <- 0
      }
      # future conservation only pertains to natveg
      consv_prio_hr[, , c("crop", "past", "forestry", "urban")] <- 0
      consv_fader <- readGDX(gdx, "p22_conservation_fader", format = "first_found")
      consv_prio_hr <- consv_prio_hr * consv_fader[, getYears(land_consv_hr), ]

      # add conservation priority areas
      land_consv_hr <- (land_consv_hr + consv_prio_hr)
    } else {
      warning(paste(
        "Future land conservation used in MAgPIE run but high resolution",
        "conservation priority data for disaggregation not found."
      ))
    }
  }
  # Due to internal constraints and compensation (e.g. NDC forest conservation)
  # the actual land conservation can sometimes be smaller than the land
  # conservation in the input data (this can especially happen also if
  # land restoration is switched off). Therefore a scaling is applied here separately
  # for grassland and natural vegetation
  natveg <- c("primforest", "secdforest", "other")
  consv_sum_lr <- mbind(
    land_consv_lr[, , "past"],
    setNames(dimSums(land_consv_lr[, , natveg], dim = 3), "natveg")
  )
  consv_sum_hr_agg <- mbind(
    toolAggregate(land_consv_hr[, , "past"], map, from = "cell", to = "cluster"),
    toolAggregate(setNames(dimSums(land_consv_hr[, , natveg], dim = 3), "natveg"),
      map,
      from = "cell", to = "cluster"
    )
  )
  consv_scaling <- consv_sum_lr / consv_sum_hr_agg
  consv_scaling[is.na(consv_scaling) | is.infinite(consv_scaling)] <- 1
  consv_scaling <- toolAggregate(consv_scaling, map, from = "cluster", to = "cell")
  land_consv_hr[, , "past"] <- consv_scaling[, , "past"] * land_consv_hr[, , "past"]
  land_consv_hr[, , natveg] <- consv_scaling[, , "natveg"] * land_consv_hr[, , natveg]
  return(land_consv_hr)
}

.dissagBII <- function(gdx, map_file, dir) {
  # Biodiversity intactness indicator (BII) at cluster level
  bii_lr <- BII(gdx,
    file = NULL, level = "cell", mode = "auto", landClass = "all",
    bii_coeff = NULL, side_layers = NULL, dir = dir
  )

  # add BII values for primary other land (BII = 1)
  bii_lr <- mbind(
    bii_lr[, , "other", invert = TRUE],
    setNames(bii_lr[, , "other"], c("primother.forested", "primother.nonforested")),
    setNames(bii_lr[, , "other"], c("secdother.forested", "secdother.nonforested"))
  )
  bii_lr[, , c("primother.forested", "primother.nonforested")] <- 1

  # Disaggregate BII coefficients to grid cell level
  bii_hr <- toolAggregate(x = bii_lr, rel = map_file, from = "cluster", to = "cell")
  return(bii_hr)
}

.extend2luhv2 <- function(x, land = deparse(substitute(x))) {
  if (land == "land_lr") {
    grassland_areas <- readGDX(gdx, "ov31_grass_area")[, , "level"]
    grassland_areas <- collapseNames(grassland_areas)
    land_lr <- mbind(x, grassland_areas)
    drop_past <- !grepl("past$", getNames(land_lr))
    land_lr <- land_lr[, , drop_past]
    getNames(land_lr) <- gsub("pastr", "past", getNames(land_lr))
    return(land_lr)
  }

  if (land == "land_ini_lr") {
    grassland_areas <- readGDX(gdx, "ov31_grass_area")[, "y1995", "level"]
    grassland_areas <- collapseNames(grassland_areas)
    land_ini_lr <- mbind(x, grassland_areas)
    drop_past <- !grepl("past$", getNames(land_ini_lr))
    land_ini_lr <- land_ini_lr[, , drop_past]
    getNames(land_ini_lr) <- gsub("pastr", "past", getNames(land_ini_lr))
    return(land_ini_lr)
  }
}

# ========================================
# Prepare data for disaggregation
# ========================================

# ----------------------
# Load input data
# ----------------------
land_ini_lr <- readGDX(gdx, "f10_land", "f_land", format = "first_found")[, "y1995", ]
land_lr <- land(gdx, sum = FALSE, level = "cell")
land_ini_hr <- read.magpie(land_hr_file)[, "y1995", ]

### Make sure grassland types are consistent
magpie2luh2 <- data.frame(matrix(nrow = 4, ncol = 2))
names(magpie2luh2) <- c("MAgPIE", "LUH2")
magpie2luh2[1, ] <- c("crop", "crop")
magpie2luh2[4, ] <- c("urban", "urban")
magpie2luh2[5, ] <- c("primforest", "primforest")
magpie2luh2[6, ] <- c("secdforest", "secdforest")
magpie2luh2[7, ] <- c("forestry", "forestry")
magpie2luh2[8, ] <- c("other", "primother")
magpie2luh2[9, ] <- c("other", "secdother")

if (grepl("grass", cfg$gms$past)) {
  land_lr <- .extend2luhv2(land_lr)
  land_ini_lr <- .extend2luhv2(land_ini_lr)
  magpie2luh2[3, ] <- c("range", "range")
  magpie2luh2[2, ] <- c("past", "past")
} else {
  magpie2luh2[3, ] <- c("past", "range")
  magpie2luh2[2, ] <- c("past", "past")
}

land_ini_hr <- madrat::toolAggregate(land_ini_hr, magpie2luh2, from = "LUH2", to = "MAgPIE", dim = 3.1)
land_ini_hr <- land_ini_hr[, , getNames(land_lr)]
if (any(land_ini_hr < 0)) {
  warning(paste0("Negative values in inital high resolution dataset detected and set to 0. Check the file ", land_hr_file))
  land_ini_hr[which(land_ini_hr < 0, arr.ind = T)] <- 0
}

# -----------------------------
# Read in hr urban land
# -----------------------------
if (cfg$gms$urban == "exo_nov21") {
  urban_land_hr <- read.magpie(urban_land_hr_file)
  ssp <- cfg$gms$c34_urban_scenario
  urban_land_hr <- urban_land_hr[, , ssp]
  getNames(urban_land_hr) <- "urban"
} else if (cfg$gms$urban == "static") {
  urban_land_hr <- "static"
}

# ----------------------------------------
# Prepare land conservation data
# ----------------------------------------

land_consv_hr <- NULL
if (file.exists(wdpa_hr_file)) {
  land_consv_hr <- .dissagLandConsv(gdx, cfg, map_file, wdpa_hr_file, consv_prio_hr_file)

  # Write gridded conservation land
  .writeDisagg(land_consv_hr, land_consv_hr_out_file,
    comment = "unit: Mha per grid-cell",
    message = "Write outputs cell.conservation_land"
  )
}

# -------------------------------------------------------------
# Account for country-specific SNV shares in post-processing
# -------------------------------------------------------------
iso <- readGDX(gdx, "iso")
snv_pol_iso <- readGDX(gdx, "policy_countries29")
snv_pol_select <- readGDX(gdx, "s29_snv_shr")
snv_pol_noselect <- readGDX(gdx, "s29_snv_shr_noselect")
snv_pol_shr <- new.magpie(iso, fill = snv_pol_noselect)
snv_pol_shr[snv_pol_iso, , ] <- snv_pol_select

avl_cropland_hr <- file.path(outputdir, "avl_cropland_0.5.mz") # available cropland (at high resolution)
marginal_land <- cfg$gms$c29_marginal_land # marginal land scenario
snv_pol_fader <- readGDX(gdx, "i29_snv_scenario_fader")

# ============================================
# Start disaggregation
# ============================================

# ---------------------------------
#  Disaggregate MAgPIE land pools
# ---------------------------------

# Start interpolation (use interpolateAvlCroplandWeighted from luscale)
message("Disaggregating MAgPIE land pools")
land_hr <- interpolateAvlCroplandWeighted(
  x = land_lr,
  x_ini_lr = land_ini_lr,
  x_ini_hr = land_ini_hr,
  map = map_file,
  avl_cropland_hr = avl_cropland_hr,
  marginal_land = marginal_land,
  urban_land_hr = urban_land_hr,
  land_consv_hr = land_consv_hr,
  snv_pol_shr = snv_pol_shr,
  snv_pol_fader = snv_pol_fader
)
land_hr <- .fixCoords(land_hr)

# Write output
.writeDisagg(land_hr, land_hr_out_file,
  comment = "unit: Mha per grid-cell",
  message = "Write outputs cell.land"
)
.writeDisagg(land_hr / dimSums(land_hr, dim = 3.1), land_hr_share_out_file,
  comment = "unit: grid-cell land area fraction",
  message = "Write outputs cell.land_share"
)
gc()

# ---------------------------------
#  Split land pools
# ---------------------------------
t <- readGDX(gdx,"t")
land_split_hr <- land_hr[ ,t , ]

# split "crop" into crop_area, crop_fallow and crop_treecover
message("Disaggregating cropland")
carea <- land(gdx, level = "cell", subcategories = c("crop"))[,,c("crop_area","crop_fallow","crop_treecover")]
carea_shr <- carea / (dimSums(carea, dim = 3) + 10^-10)
# calculate crop area as share of total cell area
carea_hr <- madrat::toolAggregate(carea_shr, map_file, to = "cell") * setNames(land_split_hr[, , "crop"], NULL)
# check
if (abs(sum(dimSums(carea_hr, dim = 3) - setNames(land_split_hr[, , "crop"], NULL), na.rm = T)) > 0.1) warning("large Difference in crop disaggregation detected!")

# drop crop
land_split_hr <- land_split_hr[, , "crop", invert = TRUE]
# combine land_split_hr with carea_hr
land_split_hr <- mbind(carea_hr, land_split_hr)

rm(carea, carea_shr, carea_hr)
gc()

# ---------------------------------
#  Disaggregate MAgPIE crop types
# ---------------------------------

message("Disaggregating MAgPIE crop types")
area_shr_hr <- .dissagcrop(gdx, land_split_hr, map = map_file)

# Write output
.writeDisagg(area_shr_hr, croparea_hr_share_out_file,
  comment = "unit: croparea fractions of total grid-cell",
  message = "Write outputs cell.croparea_share"
)
gc()

area_hr <- area_shr_hr * dimSums(land_split_hr, dim = 3)

rm(area_shr_hr)
gc()

# replace crop_area in land_hr in with crop_kfo_rf, crop_kfo_ir, crop_kbe_rf
# and crop_kbe_ir
kbe <- c("betr", "begr")
kfo <- setdiff(getNames(area_hr, dim = 1), kbe)
crop_kfo_rf <- setNames(
  dimSums(area_hr[, , kfo][, , "rainfed"], dim = 3),
  "crop_kfo_rf"
)
crop_kfo_ir <- setNames(
  dimSums(area_hr[, , kfo][, , "irrigated"], dim = 3),
  "crop_kfo_ir"
)
crop_kbe_rf <- setNames(
  dimSums(area_hr[, , kbe][, , "rainfed"], dim = 3),
  "crop_kbe_rf"
)
crop_kbe_ir <- setNames(
  dimSums(area_hr[, , kbe][, , "irrigated"], dim = 3),
  "crop_kbe_ir"
)
crop_hr <- mbind(crop_kfo_rf, crop_kfo_ir, crop_kbe_rf, crop_kbe_ir)
# drop crop_area
land_split_hr <- land_split_hr[, , "crop_area", invert = TRUE]
# combine land_split_hr with crop_hr.
land_split_hr <- mbind(crop_hr, land_split_hr)

rm(crop_kfo_rf, crop_kfo_ir, crop_kbe_rf, crop_kbe_ir, crop_hr, area_hr)

# split "forestry" into timber plantations, pre-scribed afforestation (NPi/NDC) and endogenous afforestation (CO2 price driven)
message("Disaggregating forestry")
farea <- dimSums(landForestry(gdx, level = "cell"), dim = "ac")
farea_shr <- farea / (dimSums(farea, dim = 3) + 10^-10)
# calculate forestry area as share of total cell area
farea_hr <- madrat::toolAggregate(farea_shr, map_file, to = "cell") * setNames(land_split_hr[, , "forestry"], NULL)
# check
if (abs(sum(dimSums(farea_hr, dim = 3) - setNames(land_split_hr[, , "forestry"], NULL), na.rm = T)) > 0.1) warning("large Difference in forestry disaggregation detected!")
# rename
df <- data.frame(matrix(nrow = 3, ncol = 2))
names(df) <- c("internal", "output")
df[1, ] <- c("aff", "PlantedForest_Afforestation")
df[2, ] <- c("ndc", "PlantedForest_NPiNDC")
df[3, ] <- c("plant", "PlantedForest_Timber")
farea_hr <- madrat::toolAggregate(farea_hr, df, from = "internal", to = "output", dim = 3.1)

# drop forestry
land_split_hr <- land_split_hr[, , "forestry", invert = TRUE]
# combine land_split_hr with farea_hr
land_split_hr <- mbind(land_split_hr, farea_hr)

rm(farea, farea_shr, farea_hr)
gc()

# Write output
.writeDisagg(land_split_hr, land_hr_split_file,
  comment = "unit: Mha per grid-cell",
  message = "Write cropsplit land area"
)
.writeDisagg(land_split_hr / dimSums(land_split_hr, dim = 3), land_hr_shr_split_file,
  comment = "unit: grid-cell land area fraction",
  message = "Write cropsplit land area share"
)
rm(land_split_hr)
gc()

# --------------------------------
# Disaggregate BII
# --------------------------------

message("Disaggregating BII values")

# Load input data for BII disaggregation
land_ini_hr <- read.magpie(land_hr_file)[, "y1995", ]
side_layers_hr <- read.magpie(luh_side_layers)
landArea <- dimSums(land_ini_hr, dim = 3)
side_layers_lr <- toolAggregate(x = side_layers_hr, rel = map_file, weight = landArea, from = "cell", to = "cluster")

# Convert land types for BII disaggregation
land_ini_hr <- mbind(
  land_ini_hr[, , c("primother", "secdother"), invert = TRUE],
  setNames(dimSums(land_ini_hr[, , c("primother", "secdother")], dim = 3),
    nm = "other"
  )
)
getNames(land_ini_hr) <- gsub(
  "past", "manpast",
  gsub("range", "rangeland", getNames(land_ini_hr))
)

if (grepl("grass", cfg$gms$past)) {
  getNames(land_ini_lr) <- gsub(
    "past", "manpast",
    gsub("range", "rangeland", getNames(land_ini_lr))
  )
  getNames(land_lr) <- gsub(
    "past", "manpast",
    gsub("range", "rangeland", getNames(land_lr))
  )
} else {
  # Disaggregate pasture
  land_ini_lr <- mbind(
    land_ini_lr[, , c("past"), invert = TRUE],
    collapseNames(land_ini_lr[, , "past"]) * side_layers_lr[, , c("manpast", "rangeland")]
  )

  land_lr <- mbind(
    land_lr[, , c("past"), invert = TRUE],
    collapseNames(land_lr[, , "past"]) * side_layers_lr[, , c("manpast", "rangeland")]
  )
}

# Sort and rename
land_ini_hr <- land_ini_hr[, , getNames(land_ini_lr)]
getSets(land_ini_hr)["d3.1"] <- "land"

# Disaggregate BII values to high resolution
bii_hr <- .dissagBII(gdx, map = map_file, dir = outputdir)

# Disaggregate land pools for BII estimation
land_bii_hr <- interpolateAvlCroplandWeighted(
  x = land_lr,
  x_ini_lr = land_ini_lr,
  x_ini_hr = land_ini_hr,
  map = map_file,
  avl_cropland_hr = avl_cropland_hr,
  marginal_land = marginal_land,
  urban_land_hr = urban_land_hr,
  land_consv_hr = land_consv_hr,
  snv_pol_shr = snv_pol_shr,
  snv_pol_fader = snv_pol_fader,
  unit = "share"
)

rm(land_consv_hr, urban_land_hr)

land_bii_hr <- .fixCoords(land_bii_hr)

# Add primary and secondary other land
land_bii_hr <- PrimSecdOtherLand(land_bii_hr, land_hr_file)

# specify potential natural vegetation
land_bii_hr <- land_bii_hr * side_layers_hr[, , c("forested", "nonforested")]

# Sum over land classes
bii_hr <- dimSums(land_bii_hr * bii_hr, dim = 3, na.rm = TRUE)
rm(land_bii_hr)

# Write output
.writeDisagg(bii_hr, bii_hr_out_file,
  comment = "unitless",
  message = "Write output BII at 0.5°"
)
rm(bii_hr)
gc()


# --------------------------------
# Disaggregate peatland
# --------------------------------

message("Disaggregating peatland")

# check for peatland version
if (cfg$gms$peatland == "v2") {
  peat_lr <- PeatlandArea(gdx, level = "cell", sum = FALSE)
  peat_ini_hr <- read.magpie(peatland_v2_hr_file)
  peat_ini_hr <- add_columns(peat_ini_hr, addnm = "rewetted", dim = "d3", fill = 0)
  peat_ini_hr <- add_columns(peat_ini_hr, addnm = "unused", dim = "d3", fill = 0)
  peat_hr <- suppressWarnings(luscale::interpolate2(peat_lr, peat_ini_hr, map_file))
  peat_hr <- peat_hr[, getYears(peat_hr, as.integer = T) >= cfg$gms$s58_fix_peatland, ]
} else if (cfg$gms$peatland == "on") {
  peat_lr <- PeatlandArea(gdx, level = "cell", sum = TRUE)
  peat_ini_hr <- mbind(setNames(read.magpie(peatland_on_intact_hr_file), "intact"), setNames(read.magpie(peatland_on_degrad_hr_file), "degrad"))
  peat_ini_hr <- add_columns(peat_ini_hr, addnm = "rewet", dim = "d3", fill = 0)
  peat_hr <- suppressWarnings(luscale::interpolate2(peat_lr, peat_ini_hr, map_file))
  peat_hr <- peat_hr[, getYears(peat_hr, as.integer = T) >= cfg$gms$s58_fix_peatland, ]
}
peat_hr <- .fixCoords(peat_hr)

# Write output
.writeDisagg(peat_hr, peatland_hr_out_file,
  comment = "unit: Mha per grid-cell",
  message = "Write outputs peatland Mha"
)
gc()

out <- peat_hr / dimSums(land_hr[, getYears(peat_hr), ], dim = 3)
out[is.nan(out)] <- 0
out[is.infinite(out)] <- 0

rm(land_hr, peat_hr)

.writeDisagg(out, peatland_hr_share_out_file,
  comment = "unit: grid-cell land area fraction",
  message = "Write outputs peatland share"
)
gc()

message("Finished disaggregation")
