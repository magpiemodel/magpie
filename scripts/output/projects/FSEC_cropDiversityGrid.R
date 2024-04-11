# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Create FSEC Crop Diversity Map
# comparison script: FALSE
# ---------------------------------------------------------------

# Version 1.00 - Patrick v. Jeetze
# 1.00: first working version

library(gms)
library(magpie4)

message("Starting FSEC gridded crop diversity output runscript")

############################# BASIC CONFIGURATION #######################################
if (!exists("source_include")) {

    title       <- NULL
    outputdir   <- NULL

    # Define arguments that can be read from command line
    readArgs("outputdir", "title")

}
#########################################################################################

message("Script started for output directory: ", outputdir)
cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
title <- cfg$title

message("Generating crop diversity map for the run: ", title)
gdx <- file.path(outputdir, "fulldata.gdx")

# Grid-level nitrogen pollution
out <- getReportFSECCropDiversityGrid(gdx = gdx,
                                      reportOutputDir = outputdir,
                                      magpieOutputDir = outputdir,
                                      scenario = title)
