# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ------------------------------------------------------------------------------------------------
# description: Downscale the age classes of secondary forest, forestry and other land to 0.5 degree on the downscaled land (cell.ageclass_*)
# comparison script: FALSE
# ------------------------------------------------------------------------------------------------
library(mrdownscale)

# the tgz of the madrat collection; its cell.* files go to the output folder
tgz <- downscaleRun(outputdir, "DOWNSCALEDMAGPIE", downscaling = "transitions", harmonization = "none",
                    product = "ageClasses")
files <- grep("cell\\.", untar(tgz, list = TRUE), value = TRUE)
untar(tgz, files = files, exdir = outputdir)
