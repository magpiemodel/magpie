# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: extract report in rds and mif format from run with additional aggregated regions
# comparison script: FALSE
# ---------------------------------------------------------------

library(magclass)
library(magpie4)
library(gms)
library(quitte)
source("scripts/helper.R")
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if (!exists("source_include")) {
  readArgs("outputdir")
  stopifnot(exists("outputdir"))
}

cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
gdx <- file.path(outputdir, "fulldata.gdx")
rds <- file.path(outputdir, "report.rds")
mif <- sub(".rds", ".mif", rds)
runstatistics  <- file.path(outputdir, "runstatistics.rda")
###############################################################################

#
# Find aggregated region mapping and convert to long format
#
regionmappings <- list.files(outputdir, pattern = "regionmapping.*csv")
selectedMappingName <- NULL
if (length(regionmappings) == 1) {
  selectedMappingName <- regionmappings[[1]]
} else {
  # Try a fallback strategy: Check whether only one of the mappings has a fourth column.
  # This should normally not be necessary, as output folders should only contain one regionmapping.
  columnCounts <- lapply(regionmappings, function(mappingName) {
    m <- read.csv(file.path(outputdir, mappingName), sep = ";")
    return(length(colnames(m)))
  })
  if (sum(columnCounts == 4) == 1) {
    selectedMappingName <- regionmappings[columnCounts == 4]
  }
}

if (!is.null(selectedMappingName)) {
  mapping <- mappingToLongFormat(file.path(outputdir, selectedMappingName))
  aggrRegionMappingFile <- file.path(outputdir, "report_aggr_region_mapping.csv")
  write.csv(mapping, aggrRegionMappingFile, row.names = FALSE)
} else {
  stop("Could not determine a suitable regionmapping in the output dir, thus automatic detection of ",
        "aggregated region mapping failed (either no suitable mapping or more than one).")
}

#
# Generate and upload report with aggregated regions
#
report <- getReport(gdx, scenario = cfg$title, level = aggrRegionMappingFile)

for (mapping in c("AR6", "NAVIGATE", "SHAPE", "AR6_MAgPIE")) {
  expectVariablesPresent(report, piamInterfaces::getMappingVariables(mapping, "M"))
}

write.report(report, file = mif)

qu <- useWorld(as.quitte(report))

saveRDS(qu, file = rds, version = 2)

saveToResultsArchive(qu, runstatistics, submit = cfg$runstatistics)
