# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Create FSEC water indicator gridded outputs for map
# comparison script: FALSE
# ---------------------------------------------------------------

# Version 1.00 - Felicitas Beier
# 1.00: first working version

library(gms)
library(magpie4)

message("Starting FSEC water output runscript")

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

message("Generating water indicators output for the run: ", title)
gdx     <- file.path(outputdir, "fulldata.gdx")

# Grid-level water intdicators
efvViolation <- waterEFViolation(gdx, level = "grid", dir = outputdir)
efvViolation[efvViolation > 0] <- 1
watStress <- waterStressRatio(gdx, level = "grid", dir = outputdir)
watStressViolations <- watStress
watStressViolations[efvViolation == 1] <- 100

write.magpie(watStressViolations, file_name = file.path(outputdir, "watStressViolations.mz"))
