# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Write land use information on cluster level to land_cluster.gpkg (GeoPackage)
# comparison script: FALSE
# ---------------------------------------------------------------

if (packageVersion("magpie4") < "1.180.0") {
  stop("land_cluster.R requires magpie4 >= 1.180.0, please update magpie4")
}

if (!exists("source_include")) {
  outputdir <- utils::tail(Sys.glob("output/default_*"), 1)
  lucode2::readArgs("outputdir")
}

landUse <- magpie4::land(file.path(outputdir, "fulldata.gdx"), level = "cell")
cropArea <- magpie4::croparea(file.path(outputdir, "fulldata.gdx"), level = "cell", product_aggr = FALSE)
x <- magclass::mbind(landUse, cropArea)
if (!isTRUE(all.equal(x[, , "crop"],
                      magclass::dimSums(x[, , dimnames(cropArea)[[3]]]),
                      check.attributes = FALSE))) {
  stop("Summing up crop area for all crops from magpie4::croparea != crop area from magpie4::land")
}

clustermap <- Sys.glob(file.path(outputdir, "clustermap_*.rds"))
if (length(clustermap) == 0) {
  stop("no clustermap file found")
} else if (length(clustermap) > 1) {
  warning("found multiple clustermaps, using ", clustermap[[1]])
  clustermap <- clustermap[[1]]
}
clustermap <- readRDS(clustermap)

clusterPolygons <- magpie4::clusterOutputToTerraVector(x, clustermap)

outfile <- file.path(outputdir, "land_cluster.gpkg")
message("Writing ", outfile)
terra::writeVector(clusterPolygons, outfile, overwrite = TRUE)
