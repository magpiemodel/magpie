# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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
library(dplyr)
library(tidyr)

message("Starting FSDP_process output runscript")

############################# BASIC CONFIGURATION #######################################

if (!exists("source_include")) {

    outputdir <- file.path("output/", list.dirs("output/", full.names = FALSE, recursive = FALSE))
    lucode2::readArgs("outputdir")

}

#########################################################################################

# -----------------------------------------------------------------------------------------------------------------
# Merge dietary outputs from multiple FSEC scenarios into two .csv files

message("Merging dietary outputs into \"caloricSupply.csv\" and \"dietaryIndicators.csv\"")

caloricSupply_mergePath     <- file.path("output", "caloricSupply.csv")
dietaryIndicators_mergePath <- file.path("output", "dietaryIndicators.csv")

if (file.exists(caloricSupply_mergePath) || file.exists(dietaryIndicators_mergePath)) {
    message("Merge files are already present for these runs. Removing these old files.")
    file.remove(caloricSupply_mergePath, dietaryIndicators_mergePath)
}

file.create(caloricSupply_mergePath, dietaryIndicators_mergePath)

.writeDietaryIndicators <- function(.dir) {

    cfg <- gms::loadConfig(file.path(.dir, "config.yml"))
    title <- cfg$title

    caloricSupply     <- read.csv(file.path(.dir, paste0(title, "_caloricSupply.csv")),     check.names = FALSE)
    dietaryIndicators <- read.csv(file.path(.dir, paste0(title, "_dietaryIndicators.csv")), check.names = FALSE)

    dietaryIndicators <- dietaryIndicators %>%
        pivot_longer(cols = c("population",
                              "bodyweight",
                              "bodyheight",
                              "PAL",
                              "intake"),
                     names_to = "Data",
                     values_to = "Value")

    if (file.info(caloricSupply_mergePath)$size == 0) {
        # Include the header
        write.table(caloricSupply, file = caloricSupply_mergePath,
                    quote = TRUE, sep = ",", row.names = FALSE, col.names = TRUE)
    } else {
        # Otherwise simply append
        write.table(caloricSupply, file = caloricSupply_mergePath,
                    quote = TRUE, sep = ",", row.names = FALSE, col.names = FALSE,
                    append = TRUE)
    }

    if (file.info(dietaryIndicators_mergePath)$size == 0) {
        # Include the header
        write.table(dietaryIndicators, file = dietaryIndicators_mergePath,
                    quote = TRUE, sep = ",", row.names = FALSE, col.names = TRUE)
    } else {
        # Otherwise simply append
        write.table(dietaryIndicators, file = dietaryIndicators_mergePath,
                    quote = TRUE, sep = ",", row.names = FALSE, col.names = FALSE,
                    append = TRUE)
    }
}

# Only merge dietary indicators from selected, dietary-related, scenarios
dietRelatedScenarios <- c("c_BAU",
                          "d_SSP1bau", "d_SSP1PLUSbau", "d_SSP2bau", "d_SSP3bau", "d_SSP4bau", "d_SSP5bau",
                          "d_SSP1fsdp", "d_SSP1PLUSfsdp", "d_SSP2fsdp", "d_SSP3fsdp", "d_SSP4fsdp", "d_SSP5fsdp",
                          "a_NoUnderweight", "a_HalfOverweight", "a_NoOverweight",
                          "a_DietVegFruitsNutsSeeds", "a_DietMonogastrics", "a_DietRuminants",
                          "a_DietLegumes", "a_DietEmptyCals", "a_DietFish",
                          "a_LessFoodWaste",
                          "a_Population", "a_EconDevelop",
                          "e_FSDP",
                          "b_REDDaffRuminants", "b_Diet", "b_DietRotations", "b_MonogastricsRotations",
                          "b_ExternalPressures", "b_TradeMonogastrics", "b_TradeRuminants", "b_TradeVeggies",
                          "b_MonogastricsVeggies", "b_SoilMonogastric_", "b_SoilMonogastricRuminants_",
                          "b_AllNitrogen", "b_AllHealth", "b_Efficiency", "b_Sufficiency")

outputdir_diets <- lapply(X = dietRelatedScenarios, FUN = function(.x) grep(x = outputdir, pattern = .x, value = TRUE))
outputdir_diets <- unlist(outputdir_diets)

lapply(X = outputdir_diets, FUN = .writeDietaryIndicators)


# -----------------------------------------------------------------------------------------------------------------
# Produce .gdx files from two .csv files for Marco Springmann

with_dir(file.path("output"), {
    gamsScript    <- "csv2gdx_dietaryIndicators.gms"
    gamsScriptLst <- "csv2gdx_dietaryIndicators.lst"
    file.create(gamsScript)
    cat("$call csv2gdx dietaryIndicators.csv output=dietaryIndicators.gdx id=dietaryIndicators index=1..7 values=8 useHeader=y\n",
        file = gamsScript, append = TRUE)
    cat("$call csv2gdx caloricSupply.csv output=caloricSupply.gdx id=caloricSupply index=1..4 values=5 useHeader=y",
        file = gamsScript, append = TRUE)
    gams(gamsScript)
    file.remove(gamsScript)
    file.remove(gamsScriptLst)
})
