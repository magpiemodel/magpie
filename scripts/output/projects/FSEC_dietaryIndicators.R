# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Extract population-level dietary information and consumption data from a MAgPIE run
# comparison script: FALSE
# ---------------------------------------------------------------

# Version 1.00 - Michael Crawford
# 1.00: first working version

library(gms)
library(magpie4)

message("Starting FSEC_DietaryIndicators output runscript")

############################# BASIC CONFIGURATION #######################################
if (!exists("source_include")) {

    title       <- NULL
    outputdir   <- NULL

    # Define arguments that can be read from command line
    readArgs("outputdir", "title")

}
#########################################################################################

baseDir <- getwd()
message("Script started for output directory: ", outputdir)
cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
title <- cfg$title

message("Generating DietaryIndicators output for the run: ", title)
gdx <- file.path(outputdir, "fulldata.gdx")
report <- getReportDietaryIndicators(gdx, scenario = title)

Map(f = function(x, i) write.csv(x, file = file.path(outputdir, paste0(title, "_", i, ".csv")),
                                 row.names = FALSE, quote = TRUE),
    x = report,
    i = names(report))
