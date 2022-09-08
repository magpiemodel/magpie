# |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Add health impacts to report.mif, report.rds, and report_iso.rds
# comparison script: FALSE
# ---------------------------------------------------------------

# Version 1.00 - Michael Crawford
# 1.00: first working version

library(gms)
library(m4fsdp)

message("Starting FSEC health impacts output runscript")

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

# Find the corresponding healthImpacts dataset
scenario_version <- strsplit(title, split = "_")[[1]][1]

healthImpacts_datasets_path <- file.path(outputdir, "..", "healthImpacts_raw")
healthImpacts_datasets <- list.files(healthImpacts_datasets_path)

healthImpacts_versionToUse <- grep(scenario_version, healthImpacts_datasets, value = TRUE)

if (length(healthImpacts_versionToUse) == 0) {
    stop("No corresponding health impacts dataset was found in the output/healthImpacts_raw directory.")
} else if (length(healthImpacts_versionToUse) >= 2) {
    stop("More than one health impacts datasets with this scenario's version ID were found. Only one is expected.")
}

healthImpacts_versionToUse_path <- file.path(healthImpacts_datasets_path, healthImpacts_versionToUse)

message("Using health impacts data located here: ", healthImpacts_versionToUse_path)

appendReportHealthImpacts(healthImpacts_path = healthImpacts_versionToUse_path,
                          scenario = title,
                          dir = outputdir)
