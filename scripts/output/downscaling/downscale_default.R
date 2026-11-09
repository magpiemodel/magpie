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

# cores of the SLURM job; jobs without --cpus-per-task (coupled runs) use the cores of the node, at most 3;
# outside SLURM one core
cores <- as.integer(Sys.getenv("SLURM_CPUS_PER_TASK", unset = NA))
if (is.na(cores)) {
  cores <- min(as.integer(Sys.getenv("SLURM_CPUS_ON_NODE", "1")), 3)
}

# the cell.* files go to the output folder. The madrat cache goes to the output folder, because only the
# downscaling of this run reuses it
downscaleRun(outputdir, "DOWNSCALEDMAGPIE", downscaling = "transitions", harmonization = "none",
             product = c("land", "BII", "landConservation"),
             logFile = "consistencyCheck_downscale_default.log",
             cachefolder = file.path(outputdir, "cache/downscaling"), archive = FALSE,
             cores = cores)

# the cache only serves later scripts of this run that reuse it (they recompute it if it is missing)
cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
if (!any(c("downscaling/downscale_ageClasses", "projects/BtC2_reportLand") %in% cfg$output)) {
  unlink(file.path(outputdir, "cache/downscaling"), recursive = TRUE)
}
