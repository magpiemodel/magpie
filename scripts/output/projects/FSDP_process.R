# |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -------------------------------------------------------------------------------------------------
# description: Post-processing of FSEC scenarios, specifically generating dietary data
# comparison script: TRUE
# -------------------------------------------------------------------------------------------------

# Version 1.00 - Michael Crawford

library(gms)
library(gdxrrw)
library(withr)

message("Starting FSDP_process output runscript")

############################# BASIC CONFIGURATION #######################################

if (!exists("source_include")) {

    outputdir <- file.path("output/", list.dirs("output/", full.names = FALSE, recursive = FALSE))
    lucode2::readArgs("outputdir")

}

#########################################################################################

# -----------------------------------------------------------------------------------------------------------------
# Merge dietary outputs from FSEC scenarios into two .csv files

message("Merging dietary outputs")

caloricSupply_mergePath     <- file.path("output", "caloricSupply.csv")
dietaryIndicators_mergePath <- file.path("output", "dietaryIndicators.csv")

if (file.exists(caloricSupply_mergePath) | file.exists(dietaryIndicators_mergePath)) {
    message("Merge files are already present for these runs. Removing these old files.")
    file.remove(caloricSupply_mergePath, dietaryIndicators_mergePath)
}

message("Creating merge files \"caloricSupply.csv\" and \"dietaryIndicators.csv\"")
file.create(caloricSupply_mergePath, dietaryIndicators_mergePath)

.writeDietaryIndicators <- function(.dir) {

    cfg <- gms::loadConfig(file.path(.dir, "config.yml"))
    title <- cfg$title

    caloricSupply     <- read.csv(file.path(.dir, paste0(title, "_caloricSupply.csv")), check.names = FALSE)
    dietaryIndicators <- read.csv(file.path(.dir, paste0(title, "_dietaryIndicators.csv")), check.names = FALSE)

    if (file.info(caloricSupply_mergePath)$size == 0) {
        # Include the header
        write.table(caloricSupply, file = caloricSupply_mergePath,
                    quote = TRUE, sep = ",", row.names = FALSE, col.names = FALSE)
    } else {
        # Otherwise simply append
        write.table(caloricSupply, file = caloricSupply_mergePath,
                    quote = TRUE, sep = ",", row.names = FALSE, col.names = FALSE,
                    append = TRUE)
    }

    if (file.info(dietaryIndicators_mergePath)$size == 0) {
        # Include the header
        write.table(dietaryIndicators, file = dietaryIndicators_mergePath,
                    quote = TRUE, sep = ",", row.names = FALSE, col.names = FALSE)
    } else {
        # Otherwise simply append
        write.table(dietaryIndicators, file = dietaryIndicators_mergePath,
                    quote = TRUE, sep = ",", row.names = FALSE, col.names = FALSE,
                    append = TRUE)
    }
}

message("Writing dietary datasets")

# Only merge dietary indicators from selected, dietary-related, scenarios
dietRelatedScenarios <- c("DietEmptyCals", "DietFish", "DietLegumes", "DietMonogastrics", "DietRuminants", "DietVegFruitsNutsSeeds",
                          "SoilMonogastric",
                          "LessFoodWaste",
                          "NoOverweight", "NoUnderweight",
                          "BAU",
                          "FSDP",
                          "SSP1", "SSP3", "SSP4", "SSP5")

outputdir_diets <- lapply(X = dietRelatedScenarios, FUN = function(.x) grep(x = dir, pattern = .x, value = TRUE))
outputdir_diets <- unlist(outputdir_diets)

lapply(X = outputdir, FUN = .writeDietaryIndicators)


# -----------------------------------------------------------------------------------------------------------------
# Produce .gdx files from two .csv files for Marco Springmann

message("Saving dietaryIndicators.csv and caloricSupply.csv as .gdx files")

with_dir(file.path("output"), {
    gamsScript <- "csv2gdx_dietaryIndicators.gms"
    gamsScriptLst <- "csv2gdx_dietaryIndicators.lst"
    file.create(gamsScript)
    cat("$call csv2gdx dietaryIndicators.csv output=dietaryIndicators.gdx id=dietaryIndicators index=1..6 values=7..11 useHeader=y\n",
        file = gamsScript, append = T)
    cat("$call csv2gdx caloricSupply.csv output=caloricSupply.gdx id=caloricSupply index=1,2,3,4 values=5 useHeader=y",
        file = gamsScript, append = T)
    gams(gamsScript)
    file.remove(gamsScript)
    file.remove(gamsScriptLst)
})
