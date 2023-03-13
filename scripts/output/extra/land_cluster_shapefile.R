# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Write land use information on cluster level to a shapefile
# comparison script: FALSE
# ---------------------------------------------------------------

if (packageVersion("magpie4") < "1.180.0") {
  stop("land_cluster_shapefile.R requires magpie4 >= 1.180.0, please update magpie4")
}

if (!exists("source_include")) {
  outputdir <- Sys.glob("output/*")[[1]]
  lucode2::readArgs("outputdir")
}

landUse <- magpie4::land(file.path(outputdir, "fulldata.gdx"),
                         dir = outputdir,
                         level = "cell")

clustermap <- Sys.glob(file.path(outputdir, "clustermap_*.rds"))
if (length(clustermap) == 0) {
  stop("no clustermap file found")
} else if (length(clustermap) > 1) {
  warning("found multiple clustermaps, using ", clustermap[[1]])
  clustermap <- clustermap[[1]]
}
clustermap <- readRDS(clustermap)

clusterPolygons <- magpie4::clusterOutputToTerraVector(landUse, clustermap)

outfile <- file.path(outputdir, "cluster_resolution.shp")
message("Writing ", outfile)
terra::writeVector(clusterPolygons, outfile, overwrite = TRUE)
