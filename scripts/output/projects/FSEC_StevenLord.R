# |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Create FSEC output dataset for Steven Lord
# comparison script: FALSE
# ---------------------------------------------------------------

# Version 1.00 - Michael Crawford
# 1.00: first working version

library(gms)
library(magpie4)

message("Starting FSEC_StevenLord output runscript")

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

message("Generating StevenLord output for the run: ", title)
gdx <- file.path(outputdir, "fulldata.gdx")

baseDir <- getwd()
stevenLordOutputDir <- file.path(baseDir, "output", "StevenLord")
if (!dir.exists(stevenLordOutputDir)) {
    dir.create(stevenLordOutputDir)
}

# Grid-level nitrogen pollution
out <- getReportFSECStevenLord(gdx = gdx,
                               reportOutputDir = stevenLordOutputDir,
                               magpieOutputDir = outputdir,
                               scenario = title)
