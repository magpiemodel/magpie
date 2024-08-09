# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Modifies gridded MAgPIE land use patterns so that they can be read in by the Spatial Economic Allocation Landscape Simulator (SEALS)
# comparison script: FALSE
# ---------------------------------------------------------------

# Version 1.00 - Patrick v. Jeetze
# 1.00: first working version

library(gms)
library(gdx2)
library(magpie4)

message("Starting to report gridded MAgPIE land use for SEALS")

############################# BASIC CONFIGURATION #######################################
if (!exists("source_include")) {
  title <- NULL
  outputdir <- NULL

  # Define arguments that can be read from command line
  readArgs("outputdir", "title")
}
#########################################################################################

message("Script started for output directory: ", outputdir)
cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
title <- cfg$title


# Restructure data to conform to SEALS
reportLandUseForSEALS(
  magCellLand = "cell.land_0.5_share.mz",
  outFile = paste0("cell.land_0.5_SEALS_", title, ".nc"),
  dir = outputdir, selectyears = c(2020, 2030, 2040, 2050)
)

# In case of reforestation using plantation growth curves set forestry to zero
# in order to calculated the difference in forest allocation between two SEALS runs
plantation <- readGDX(file.path(outputdir, "fulldata.gdx"), "s32_aff_plantation")

if (plantation) {
  land_hr <- read.magpie(file.path(outputdir, "cell.land_0.5_share.mz"))
  land_hr[, , "forestry"] <- 0

  reportLandUseForSEALS(
    magCellLand = land_hr,
    outFile = paste0("cell.land_0.5_SEALS_", title, "_noForestry.nc"),
    dir = outputdir, selectyears = c(2020, 2030, 2040, 2050)
  )
}
