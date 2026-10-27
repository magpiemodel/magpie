# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ------------------------------------------------------------------------------------------------
# description: Downscale land (with land split, crop area shares, transitions and peatland), BII and land conservation to 0.5 degree along the transitions of the run
# comparison script: FALSE
# ------------------------------------------------------------------------------------------------
library(mrdownscale)

# the cell.* files go to the output folder. The madrat cache goes to the output folder, because only the
# downscaling of this run reuses it. The allocation runs on the cores of the SLURM job, outside SLURM on one core
downscaleRun(outputdir, "DOWNSCALEDMAGPIE", downscaling = "transitions", harmonization = "none",
             product = c("land", "BII", "landConservation"),
             logFile = "consistencyCheck_downscale_default.log",
             cachefolder = file.path(outputdir, "cache/downscaling"), archive = FALSE,
             cores = as.integer(Sys.getenv("SLURM_CPUS_PER_TASK", "1")))
