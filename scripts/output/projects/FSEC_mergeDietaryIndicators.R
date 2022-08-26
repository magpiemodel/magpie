# |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -------------------------------------------------------------------------------------------------
# description: Merge caloricSupply and dietaryIndicators from all scenarios in an output folder
# comparison script: FALSE
# -------------------------------------------------------------------------------------------------

# Version 1.00 - Michael Crawford
# 1.00: first working version

library(gms)
library(gdxrrw)

message("Starting mergeDietaryIndicators output runscript")

############################# BASIC CONFIGURATION #######################################
if (!exists("source_include")) {

    outputdir   <- NULL
    title       <- NULL
    # Define arguments that can be read from command line
    readArgs("outputdir", "title")

}
#########################################################################################

message("Script started for output directory: ", outputdir)
cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
title <- cfg$title

message("Merging dietaryIndicators output for the run: ", title)

caloricSupply <- read.csv(file.path(outputdir, paste0(title, "_caloricSupply.csv")), check.names = FALSE)
dietaryIndicators <- read.csv(file.path(outputdir, paste0(title, "_dietaryIndicators.csv")), check.names = FALSE)

caloricSupply_mergePath <- file.path(outputdir, "..", "caloricSupply.csv")
dietaryIndicators_mergePath <- file.path(outputdir, "..", "dietaryIndicators.csv")

if (!file.exists(caloricSupply_mergePath) | !file.exists(dietaryIndicators_mergePath)) {
    .generateHeader <- function(colnames) {
        header <- lapply(X = colnames, FUN = function(i) {
            return(paste0("\"", i, "\""))
        })
        unlist(header)
    }

    file.create(caloricSupply_mergePath)
    cat(.generateHeader(colnames(caloricSupply)), sep = ",", file = caloricSupply_mergePath)

    file.create(dietaryIndicators_mergePath)
    cat(.generateHeader(colnames(dietaryIndicators)), sep = ",", file = dietaryIndicators_mergePath)
    message("Created new files for merged caloricSupply and dietaryIndicators")
}

write.table(caloricSupply, file = caloricSupply_mergePath,
            append = TRUE,
            quote = TRUE, sep = ",",
            row.names = FALSE, col.names = FALSE)

write.table(dietaryIndicators, file = dietaryIndicators_mergePath,
            append = TRUE,
            quote = TRUE, sep = ",",
            row.names = FALSE, col.names = FALSE)
