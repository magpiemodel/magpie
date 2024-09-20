# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Starts SEALS allocation run based on gridded MAgPIE land cover projections
# comparison script: FALSE
# ---------------------------------------------------------------

# Version 1.00 - Patrick v. Jeetze, Pascal Sauer
# 1.00: first working version

library(gms)
library(gdx)
library(magpie4)
library(filelock)

message("Initialising SEALS allocation run")

############################# BASIC CONFIGURATION #######################################
if (!exists("source_include")) {
  title <- NULL
  outputdir <- NULL

  # Define arguments that can be read from command line
  readArgs("outputdir", "title")
}
#########################################################################################

# ========================
# User settings
# ========================

### SEALS python environment name
# see https://justinandrewjohnson.com/earth_economy_devstack/installation.html
# for instructions on how to set up a python environment for SEALS
sealsEnv <- "seals_dev"

### Path to SEALS base input file directory
dirBaseFiles <- "/p/projects/magpie/users/vjeetze/seals/files"

### Path to SEALS code base
dirSEALS <- "/p/projects/magpie/users/vjeetze/seals/files/seals/seals_dev"


# ========================
# Prepare MAgPIE output
# ========================

message("Script started for output directory: ", outputdir)

cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
title <- cfg$title

if (length(cfg$seals_years) != 0) {
  rep_years <- cfg$seals_years[cfg$seals_years > 2020]
  rep_years <- c(2020, rep_years)
} else {
  rep_years <- seq(2020, 2050, 5)
}

# Restructure data to conform to SEALS
reportLandUseForSEALS(
  magCellLand = "cell.land_0.5_share.mz",
  outFile = paste0("cell.land_0.5_SEALS_", title, ".nc"),
  dir = outputdir, selectyears = rep_years
)


# ========================
# Setup SEALS run
# ========================

# Check whether base data and local SEALS code repo exist
if (length(list.files(dirBaseFiles)) == 0) {
  stop(paste(
    "Please set the path to the SEALS base data",
    "directory under 'User settings' of the",
    "extra/runSEALSallocation.R script."
  ))
} else if (length(list.files(dirSEALS)) == 0) {
  stop(paste(
    "Please set the path to your local clone",
    "of the SEALS code under 'User settings' of the",
    "extra/runSEALSallocation.R script."
  ))
}

### Path to miniforge installation
miniforgePath <- "/p/projects/rd3mod/miniforge3/bin/activate"

# create output directory
dirProject <- "./output/seals"

if (!dir.exists(file.path(dirProject))) {
  dir.create(file.path(dirProject), recursive = TRUE)
}

iniLock <- file.path(dirProject, ".lock")
lockOn <- filelock::lock(iniLock, exclusive = TRUE, timeout = Inf)
Sys.chmod(iniLock, mode = "0664")


# --------------------------------
# Prepare SEALS start script
# --------------------------------

.setupSEALSrun <- function(title, dir, dirProject, dirSEALS, dirBaseFiles) {
  if (!dir.exists(file.path(dirProject, "scripts"))) {
    dir.create(file.path(dirProject, "scripts"), recursive = TRUE)
  }

  file.copy(
    from = list.files(file.path(dirSEALS, "seals"), full.names = TRUE),
    to = file.path(dirProject, "scripts"),
    overwrite = TRUE,
    recursive = TRUE
  )

  if (!dir.exists(file.path(dirProject, "inputs"))) {
    dir.create(file.path(dirProject, "inputs"), recursive = TRUE)
  }

  file.copy(
    from = file.path(dir, paste0("seals_scenario_config_", title, ".csv")),
    to = file.path(dirProject, "inputs", paste0("seals_scenario_config_", title, ".csv")),
    overwrite = TRUE
  )

  main <- readLines(file.path(dirProject, "scripts", "run_test_standard.py"))

  main[min(which(grepl("    p.user_dir =", main)))] <- paste0("    p.user_dir = \'", dirBaseFiles, "\'")
  main[min(which(grepl("    p.extra_dirs", main)))] <- paste0("    p.extra_dirs = '.'")
  main[min(which(grepl("    p.project_name =", main)))] <- paste0("    p.project_name = \'", title, "\'")
  main[min(which(grepl("    p.project_dir =", main)))] <- paste0(
    "    p.project_dir = \'", normalizePath(dirProject), "\'"
  )
  main[min(which(grepl("hb.pretty_time()", main)))] <- " "
  main[min(which(grepl("    p.base_data_dir =", main)))] <- paste0(
    "    p.base_data_dir = \'", dirBaseFiles, "/base_data\'"
  )
  main[min(which(grepl("    p.scenario_definitions_filename =", main)))] <- paste0(
    "    p.scenario_definitions_filename = \'", paste0("seals_scenario_config_", title, ".csv"), "\'"
  )

  writeLines(main, file.path(dirProject, "scripts", paste0("run_seals_", title, ".py")))


  if (!dir.exists(file.path(dirProject, "run_submit"))) {
    dir.create(file.path(dirProject, "run_submit"), recursive = TRUE)
  }
}

# --------------------------------
# Submit run
# --------------------------------

.submitSEALS <- function(title, dirProject, miniforgePath, sealsEnv, qos = "short",
                         slurmID = FALSE, dependsID = NULL) {
  submitFile <- file.path(dirProject, "run_submit", paste0("submit_seals_", title, ".sh"))

  submit <- c(
    "#!/bin/bash", "\n",
    paste0("#SBATCH --qos=", qos),
    if (qos %in% c("priority", "standby")) "#SBATCH --partition=priority" else "#SBATCH --partition=standard",
    "#SBATCH --job-name=seals_allocation",
    paste0("#SBATCH --chdir=", normalizePath(file.path(dirProject, "scripts"))),
    "#SBATCH --output=outfile_%j.out",
    "#SBATCH --error=outfile_%j.err",
    "#SBATCH --mail-type=END,FAIL",
    "#SBATCH --time=3:00:00",
    "#SBATCH --nodes=1",
    "#SBATCH --ntasks=1",
    ifelse(!is.null(dependsID), paste0(
      "#SBATCH --dependency=afterok:", dependsID,
      "\n#SBATCH --kill-on-invalid-dep=yes"
    ),
    "#SBATCH --dependency=singleton"
    ), "\n",
    ifelse(qos == "priority", "#SBATCH --cpus-per-task=64", "#SBATCH --cpus-per-task=128"), "\n",
    paste("source", miniforgePath),
    paste("conda activate", sealsEnv), "\n",
    paste("python", paste0("run_seals_", title, ".py"))
  )
  writeLines(submit, submitFile)

  id <- system(paste("sbatch --parsable", submitFile), intern = TRUE)
  if (slurmID) {
    return(id)
  }
}

# --------------------------------
# Run SEALS allocation
# --------------------------------

if (!is.null(lockOn)) {
  sealsLock <- file.path(dirProject, "seals.lock")

  if (!file.exists(sealsLock) || file.size(sealsLock) == 0) {
    message(paste(
      "Starting SEALS allocation with input data creation.\n",
      "Stitched SEALS allocation outputs will be written to",
      "'./output/seals/intermediate/stitched_lulc_simplified_scenarios'"
    ))
    .setupSEALSrun(
      title = title,
      dir = outputdir,
      dirProject = dirProject,
      dirSEALS = dirSEALS,
      dirBaseFiles = dirBaseFiles
    )

    id <- .submitSEALS(
      title = title,
      dirProject = dirProject,
      miniforgePath = miniforgePath,
      sealsEnv = sealsEnv,
      qos = "short",
      slurmID = TRUE
    )

    writeLines(id, sealsLock)
  } else {
    message(paste(
      "Starting SEALS allocation using existing input data.\n",
      "Stitched SEALS allocation outputs will be written to",
      "'./output/seals/intermediate/stitched_lulc_simplified_scenarios'"
    ))

    id <- readLines(sealsLock)

    .setupSEALSrun(
      title = title,
      dir = outputdir,
      dirProject = dirProject,
      dirSEALS = dirSEALS,
      dirBaseFiles = dirBaseFiles
    )

    .submitSEALS(
      title = title,
      dirProject = dirProject,
      miniforgePath = miniforgePath,
      sealsEnv = sealsEnv,
      qos = "short",
      slurmID = FALSE,
      dependsID = id
    )
  }
  unlink(iniLock)
}
