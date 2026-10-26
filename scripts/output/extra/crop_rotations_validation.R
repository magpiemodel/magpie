# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Compares base-year croparea and fallow land per cluster against the
#              croparea initialisation data, to check how far the rotational
#              constraints move the base year away from the input data.
# comparison script: FALSE
# ---------------------------------------------------------------

library(gdx2)
library(magclass)
library(lucode2)

# =============================================
# Basic configuration
# =============================================
if (!exists("source_include")) {
  outputdir <- "output/default_2026-10-20_12.32.43/"
  readArgs("outputdir")
}

# The initialisation fallow area `im_fallow_start` has no time dimension; it refers
# to the first time step, so the comparison is only meaningful for that year.
year <- "y1995"

# Clusters below this share of their region's initialisation croparea are dropped,
# because ratios on tiny areas are dominated by rounding.
minShare <- 0.03

gdx <- file.path(outputdir, "fulldata.gdx")

# =============================================
# Read model output and initialisation data
# =============================================
# croparea by crop, summed over the water dimension
modArea <- dimSums(collapseNames(readGDX(gdx, "ov_area")[, year, "level"]), dim = "w")
iniArea <- dimSums(readGDX(gdx, "fm_croparea")[, year, ], dim = "w")
modFallow <- as.numeric(collapseNames(readGDX(gdx, "ov_fallow")[, year, "level"]))
iniFallow <- as.numeric(readGDX(gdx, "im_fallow_start"))

cluster <- getItems(modArea, dim = 1)
region <- sub("\\..*", "", cluster)
crops <- getItems(modArea, dim = 3)

# magpie -> plain cluster x crop matrices
asMatrix <- function(x) {
  array(x, dim(x)[c(1, 3)], dimnames = list(getItems(x, dim = 1), getItems(x, dim = 3)))
}
mod <- asMatrix(modArea)
ini <- asMatrix(iniArea)

# =============================================
# Cluster selection and ordering
# =============================================
iniTotal <- rowSums(ini)
regionShare <- iniTotal / tapply(iniTotal, region, sum)[region]
sel <- which(regionShare > minShare)
sel <- sel[order(-iniTotal[sel])] # largest initialisation croparea first

message("crop_rotations_validation: ", length(sel), " of ", length(cluster),
        " clusters hold more than ", round(minShare * 100), "% of their region's ",
        "initialisation croparea")

# =============================================
# Assemble the four tables
# =============================================
# All four share the same layout: cluster, region, the initialisation croparea used
# for sorting, the croparea total, one column per crop, and fallow in the last column.
buildTable <- function(cropValues, totalValue, fallowValue) {
  out <- data.frame(cluster = cluster[sel],
                    region = region[sel],
                    croparea_init_Mha = round(iniTotal[sel], 3),
                    croparea_total = round(totalValue, 3),
                    check.names = FALSE)
  for (k in crops) out[[k]] <- round(cropValues[, k], 3)
  out[["fallow"]] <- round(fallowValue, 3)
  out
}

# A ratio is undefined where the initialisation is zero: report Inf where the model
# grows the crop anyway, and NA where neither has any area.
ratio <- function(m, i) ifelse(i > 1e-6, m / i, ifelse(m > 1e-6, Inf, NA))

tables <- list(
  model_Mha = buildTable(mod[sel, , drop = FALSE],
                         rowSums(mod)[sel],
                         modFallow[sel]),
  init_Mha  = buildTable(ini[sel, , drop = FALSE],
                         iniTotal[sel],
                         iniFallow[sel]),
  diff_Mha  = buildTable(mod[sel, , drop = FALSE] - ini[sel, , drop = FALSE],
                         rowSums(mod)[sel] - iniTotal[sel],
                         modFallow[sel] - iniFallow[sel]),
  ratio     = buildTable(ratio(mod[sel, , drop = FALSE], ini[sel, , drop = FALSE]),
                         ratio(rowSums(mod)[sel], iniTotal[sel]),
                         ratio(modFallow[sel], iniFallow[sel]))
)

for (nm in names(tables)) {
  f <- file.path(outputdir, paste0("crop_rotations_validation_", nm, ".csv"))
  write.csv(tables[[nm]], f, row.names = FALSE, na = "")
  message("  wrote ", f)
}
