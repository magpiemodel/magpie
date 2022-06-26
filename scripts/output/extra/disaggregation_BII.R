# |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Derives BII at 0.5 degree resolution from MAgPIE cluster-level biodiversity value results
# comparison script: FALSE
# ---------------------------------------------------------------

library(lucode2)
library(magpie4)
library(luscale)
library(madrat)
library(mrcommons)

############################# BASIC CONFIGURATION ##############################
if(!exists("source_include")) {
  outputdir <- file.path("output/", list.dirs("output/", full.names = FALSE, recursive = FALSE))
  # Define arguments that can be read from command line
  lucode2::readArgs("outputdir")
}

map_file           <- Sys.glob(file.path(outputdir, "clustermap_*.rds"))
gdx                <- file.path(outputdir, "fulldata.gdx")
land_hr_file       <- file.path(outputdir, "avl_land_full_t_0.5.mz")
urban_land_hr_file <- file.path(outputdir, "f34_urbanland_0.5.mz")
side_layers        <- file.path(outputdir, "luh2_side_layers_0.5.mz")

cfg   <- gms::loadConfig(file.path(outputdir, "config.yml"))
title <- cfg$title
################################################################################

sizelimit <- getOption("magclass_sizeLimit")
options(magclass_sizeLimit = 1e+12)
on.exit(options(magclass_sizeLimit = sizelimit))

if(length(map_file) == 0) stop("Could not find map file!")
if(length(map_file) > 1) {
  warning("More than one map file found. First occurrence will be used!")
  map_file <- map_file[1]
}

mapping <- readRDS(map_file)

# Biodiversity intactness indicator (BII) at cluster level
bii_lr <- BII(gdx, file = NULL, level = "cell", mode = "auto", landClass = "all",
           bii_coeff = NULL, side_layers = NULL)

# Load input data
land_ini_lr     <- readGDX(gdx, "f10_land", "f_land", format = "first_found")[, "y1995", ]
land_lr         <- land(gdx, sum = FALSE, level = "cell")
land_ini_hr     <- read.magpie(land_hr_file)[, "y1995", ]
side_layers_hr  <- toolCell2isoCell(read.magpie(side_layers))
landarea        <- dimSums(land_ini_hr, dim = 3)
side_layers_lr  <- toolAggregate(x = side_layers_hr, rel = mapping, weight = landarea, from = "cell", to = "cluster")

# Aggregate other land
land_ini_hr  <- mbind(land_ini_hr[, , c("primother", "secdother"), invert = TRUE],
                      setNames(dimSums(land_ini_hr[, , c("primother", "secdother")], dim = 3),
                               nm = "other"))
getNames(land_ini_hr) <- gsub("range", "rangeland", getNames(land_ini_hr))
getNames(land_ini_hr) <- gsub("past", "manpast", getNames(land_ini_hr))

# Disaggregate pasture
land_ini_lr  <- mbind(land_ini_lr[, , c("past"), invert = TRUE],
                      collapseNames(land_ini_lr[, , "past"]) * side_layers_lr[, , c("manpast", "rangeland")])

land_lr  <- mbind(land_lr[, , c("past"), invert = TRUE],
                  collapseNames(land_lr[, , "past"]) * side_layers_lr[, , c("manpast", "rangeland")])

# Disaggregate BII to grid cell level
message("Disaggregation BII")
bii_hr <- toolAggregate(x = bii_lr, rel = mapping, from = "cluster", to = "cell")

# Disaggregate land use types
if(any(land_ini_hr < 0)) {
  warning(paste0("Negative values in inital high resolution dataset detected and set to 0. Check the file ", land_hr_file))
  land_ini_hr[which(land_ini_hr < 0,arr.ind = T)] <- 0
}

# Prepare data for available cropland interpolation:
# read in hr urban land
if (cfg$gms$urban == "exo_nov21" ) {
  urban_land_hr <- read.magpie(urban_land_hr_file)
  ssp           <- cfg$gms$c34_urban_scenario
  urban_land_hr <- urban_land_hr[,,ssp]
  getNames(urban_land_hr) <- "urban"
} else if (cfg$gms$urban == "static"){
  urban_land_hr <- "static"
}

# account for country-specific SNV shares in post-processing
iso                <- readGDX(gdx, "iso")
snv_pol_iso      <- readGDX(gdx, "policy_countries30")
snv_pol_select   <- readGDX(gdx, "s30_snv_shr")
snv_pol_noselect <- readGDX(gdx, "s30_snv_shr_noselect")
snv_pol_shr      <- new.magpie(iso, fill = snv_pol_noselect)
snv_pol_shr[snv_pol_iso,,] <- snv_pol_select

avl_cropland_hr <- file.path(outputdir, "avl_cropland_0.5.mz")    # available cropland (at high resolution)
marginal_land   <- cfg$gms$c30_marginal_land                      # marginal land scenario
target_year     <- cfg$gms$c30_snv_target                   # target year of SNV policy (default: "none")
snv_pol_fader <- readGDX(gdx, "f30_scenario_fader", format = "first_found")[, , target_year]

# Sort and rename
land_ini_hr <- land_ini_hr[,,getNames(land_ini_lr)]
getSets(land_ini_hr)["d3.1"] <- "land"

# Start interpolation (use interpolateAvlCroplandWeighted from luscale)
message("Disaggregation Land use types")
land_hr <- interpolateAvlCroplandWeighted(x               = land_lr,
                                          x_ini_lr        = land_ini_lr,
                                          x_ini_hr        = land_ini_hr,
                                          avl_cropland_hr = avl_cropland_hr,
                                          map             = map_file,
                                          marginal_land   = marginal_land,
                                          snv_pol_shr   = snv_pol_shr,
                                          snv_pol_fader = snv_pol_fader,
                                          urban_land_hr   = urban_land_hr,
                                          unit            = "share")

land_hr <- land_hr[, "y1985", invert = TRUE]
land_hr <- land_hr * side_layers_hr[, , c("forested", "nonforested")]

# Sum over land classes
bii_hr <- dimSums(land_hr * bii_hr, dim = 3, na.rm = TRUE)

# Create new output folder for BII
baseDir      <- getwd()
biiOutputDir <- file.path(baseDir, "output", "BII")
if (!dir.exists(biiOutputDir)) {
    dir.create(biiOutputDir)
}

write.magpie(bii_hr, file.path(biiOutputDir, paste0(title, "_cell.bii_0.5.nc")), comment = "unitless")
write.magpie(bii_hr, file.path(biiOutputDir, paste0(title, "_cell.bii_0.5.mz")), comment = "unitless")

# Clean up
rm(bii_hr)
gc()
