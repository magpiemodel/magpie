# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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
cfg   <- gms::loadConfig(file.path(outputdir, "config.yml"))
title <- cfg$title

message("Creating an output directory for Steven Lord's datasets")
stevenLordDir <- file.path(".", "output", "StevenLord")
if (!dir.exists(stevenLordDir)) {
    dir.create(stevenLordDir)
}

reportOutputDir <- file.path(stevenLordDir, title)
if (dir.exists(reportOutputDir)) {
    message("Warning in FSEC_StevenLord: Output directory for " , title, " already exists. Results will be overwritten.")
}
suppressWarnings(dir.create(reportOutputDir))

message("Generating Steven Lord's output for the run: ", title)

out <- getReportFSECStevenLord(magpieOutputDir = outputdir,
                               reportOutputDir = reportOutputDir,
                               scenario = title)
