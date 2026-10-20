# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ------------------------------------------------------------------------------------------------
# description: Downscale the land conservation of MAgPIE to 0.5 degree on the downscaled land (cell.conservation_land_0.5.mz)
# comparison script: FALSE
# ------------------------------------------------------------------------------------------------
library(mrdownscale)

# the tgz of the madrat collection; its cell.* files go to the output folder
tgz <- downscaleRun(outputdir, "DOWNSCALEDMAGPIE", downscaling = "transitions", harmonization = "none",
                    product = "landConservation")
files <- grep("cell\\.", untar(tgz, list = TRUE), value = TRUE)
untar(tgz, files = files, exdir = outputdir)
