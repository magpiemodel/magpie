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

if (!exists("source_include")) {
  outputdir <- Sys.glob("output/*")[[1]]
  lucode2::readArgs("outputdir")
}

landUse <- magpie4::land(file.path(outputdir, "fulldata.gdx"),
                         dir = outputdir,
                         level = "cell")
stopifnot(identical(names(dimnames(landUse)), c("j.region", "t", "land")))

clustermap <- Sys.glob(file.path(outputdir, "clustermap_*.rds"))
if (length(clustermap) == 0) {
  stop("no clustermap file found")
} else if (length(clustermap) > 1) {
  warning("found multiple clustermaps, using ", clustermap[[1]])
  clustermap <- clustermap[[1]]
}
clustermap <- readRDS(clustermap)

cells <- magclass::getCells(landUse)
clusterMagclass <- magclass::new.magpie(cells, names = "clusterId", fill = seq_along(cells))
clusterMagclass <- madrat::toolAggregate(clusterMagclass, clustermap, from = "cluster", to = "cell")

clusterPolygons <- terra::as.polygons(magclass::as.SpatRaster(clusterMagclass))
clusterPolygons <- terra::merge(clusterPolygons, magclass::as.data.frame(landUse, rev = 3),
                                by.x = "clusterId", by.y = "region")
names(clusterPolygons) <- c("clusterId", "region", "year", "landtype", "value")

clusterIdToCountry <- clustermap$country
names(clusterIdToCountry) <- as.integer(sub("^[A-Z]{3}\\.", "", clustermap$cluster))
clusterPolygons$country <- clusterIdToCountry[clusterPolygons$clusterId]
clusterPolygons <- clusterPolygons[, c("clusterId", "country", "region", "year", "landtype", "value")]

terra::crs(clusterPolygons) <- "+proj=longlat +datum=WGS84 +no_defs"

outfile <- file.path(outputdir, "cluster_resolution.shp")
message("Writing ", outfile)
terra::writeVector(clusterPolygons, outfile, overwrite = TRUE)
