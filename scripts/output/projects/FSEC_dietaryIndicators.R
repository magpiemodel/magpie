# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
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

library(lucode2)
library(magpie4)

print("Start FSEC dietary indicators output runscript")

############################# BASIC CONFIGURATION #######################################

if(!exists("source_include")) {

    title       <- NULL
    outputdir   <- NULL

    # Define arguments that can be read from command line
    readArgs("outputdir", "title")
}
#########################################################################################

print(paste0("Script started for output directory: ", outputdir))

old_wd <- getwd()
on.exit(setwd(old_wd))
setwd(outputdir)

load("config.Rdata")
title <- cfg$title
print(paste0("Generating DeitaryIndicators output for the run: ", title))

gdx <- paste0("fulldata.gdx")
output <- getReportDietaryIndicators(gdx, scenario = title)

dir.create(paste0(old_wd, "/output/DietaryIndicators"))

Map(f = function(x, i) write.csv(x, file = paste0(old_wd, "/output/DietaryIndicators/", title, "_", i, ".csv"),
                                 row.names = FALSE, quote = TRUE),
    output,
    names(output))
