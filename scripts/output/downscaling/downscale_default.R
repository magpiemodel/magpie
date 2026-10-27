# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ------------------------------------------------------------------------------------------------
# description: Default downscaling of MAgPIE to 0.5 degree along the transitions of the run: land (with land split, crop area shares, transitions and peatland), BII and land conservation
# comparison script: FALSE
# ------------------------------------------------------------------------------------------------
library(mrdownscale)

# the tgz of the madrat collection; its cell.* files go to the output folder. The madrat cache stays in the
# output folder, because only the downscaling of this run reuses it
tgz <- downscaleRun(outputdir, "DOWNSCALEDMAGPIE", downscaling = "transitions", harmonization = "none",
                    product = c("land", "BII", "landConservation"),
                    cachefolder = file.path(outputdir, "cache/downscaling"))
files <- grep("cell\\.", untar(tgz, list = TRUE), value = TRUE)
untar(tgz, files = files, exdir = outputdir)
