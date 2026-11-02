# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -------------------------------------------------------------------------------------------------
# description: Land of the 0.5 degree downscaling in the land classes of Bending the Curve 2.0, as NetCDF and regional CSV per year
# comparison script: FALSE
# -------------------------------------------------------------------------------------------------

library(lucode2)
library(magclass)
library(madrat)
library(mrdownscale)

############################# BASIC CONFIGURATION #############################
if (!exists("source_include")) {
  outputdir <- NULL
  # Define arguments that can be read from command line
  readArgs("outputdir")
}
###############################################################################

projectName <- "BtC2v04"

# the classes per grid cell (cell.land_btc2_0.5.mz) and the NetCDF, from the madrat cache of the default
# downscaling of this run (scripts/output/downscaling/downscale_default.R), which it computes if missing
downscaleRun(outputdir, "BTC2", projectName = projectName, cachefolder = file.path(outputdir, "cache/downscaling"),
             archive = FALSE, cores = as.integer(Sys.getenv("SLURM_CPUS_PER_TASK", "1")))

# regional land by class (Mha), one CSV per year
cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
prefix <- if (grepl(tolower(projectName), tolower(cfg$title))) "" else paste0(projectName, "_")
landHr <- read.magpie(file.path(outputdir, "cell.land_btc2_0.5.mz"))
landRegion <- toolAggregate(landHr, rel = Sys.glob(file.path(outputdir, "clustermap_*.rds")),
                            from = "cell", to = "region")
classCodes <- paste(seq_len(ndata(landRegion)), getNames(landRegion), sep = "=")
for (year in getYears(landRegion)) {
  csvOut <- data.frame(Row = classCodes, t(as.array(landRegion[, year, ])[, 1, ]), check.names = FALSE)
  utils::write.csv(csvOut, file.path(outputdir, paste0(prefix, cfg$title, "_", year, ".csv")), row.names = FALSE)
}
