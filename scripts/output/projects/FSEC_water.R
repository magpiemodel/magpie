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

### Grid-level water indicators ###
# Volume of environmental flow violations (EFV) (in km^3)
efvViolation <- waterEFViolation(gdx, level = "grid", dir = outputdir)
write.magpie(efvViolation, file_name = file.path(outputdir, "efvVolume.mz"))

# Total land
gridLand  <- reportGridLand(gdx, dir = outputdir)
totalLand <- dimSums(gridLand, dim = 3)
# Environmental flow violations per hectare of total area (in m3/ha)
efvViolation_ha <- (efvViolation * 1000) / totalLand
write.magpie(efvViolation_ha, file_name = file.path(outputdir, "efvVolume_ha.mz"))

# Binary indicator of EFV
efvViolation[efvViolation > 0] <- 1

# Water stress indicator (use-to-availability ratio)
watStress <- waterStressRatio(gdx, level = "grid", dir = outputdir)
watStressViolations <- watStress
watStressViolations[efvViolation == 1] <- 100

write.magpie(watStressViolations, file_name = file.path(outputdir, "watStressViolations.mz"))
