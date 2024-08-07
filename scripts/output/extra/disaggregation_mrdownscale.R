# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ------------------------------------------------------------------------------------------------
# description: Downscale MAgPIE results to 0.25 degree resolution in LUH2 format for ESMs
# comparison script: FALSE
# ------------------------------------------------------------------------------------------------
library(mrdownscale)

outputdir <- normalizePath(outputdir)

clustermap <- Sys.glob(file.path(outputdir, "clustermap_*.rds"))
gdx <- file.path(outputdir, "fulldata.gdx")
stopifnot(file.exists(gdx), length(clustermap) == 1)

scenario <- gsub("_", "-", sub("-mag-[0-9]+$", "", basename(outputdir)))

local({ # redirectSource is local by default, running it in the global environment does not work
  redirectSource("MagpieFulldataGdx", c(clustermap, gdx), linkOthers = FALSE)
  stopifnot(length(getConfig("redirections")) >= 1)
  retrieveData("ESM", rev = format(Sys.time(), "%Y-%m-%d"), scenario = scenario, progress = FALSE,
               outputfolder = outputdir)
})
