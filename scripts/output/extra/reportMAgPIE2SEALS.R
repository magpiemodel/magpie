# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
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
  magCellLand = "cell.land_0.5_share.nc",
  outFile = paste0("cell.land_0.5_SEALS_", title, ".nc"),
  dir = outputdir, selectyears = c(2015, 2050)
)
