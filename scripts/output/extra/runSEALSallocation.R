# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Starts SEALS allocation run based on gridded MAgPIE land cover projections
# comparison script: FALSE
# ---------------------------------------------------------------

# Version 1.1.0 - Patrick v. Jeetze, Pascal Sauer
# 1.0.0: first working version
# 1.1.0: SEALS coefficients are modified based on scenario settings

library(gms)
library(gdx2)
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
sealsInput <- paste0("cell.land_0.5_SEALS_", title, ".nc")
reportLandUseForSEALS(
  magCellLand = "cell.land_0.5_share.mz",
  outFile = sealsInput,
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

.setupSEALSrun <- function(cfg, sealsInput, dir, dirProject, dirSEALS, dirBaseFiles) {
  if (!dir.exists(file.path(dirProject, "scripts"))) {
    dir.create(file.path(dirProject, "scripts"), recursive = TRUE)
  }

  title <- cfg$title

  file.copy(
    from = list.files(file.path(dirSEALS, "seals"), full.names = TRUE),
    to = file.path(dirProject, "scripts"),
    overwrite = TRUE,
    recursive = TRUE
  )

  if (!dir.exists(file.path(dirProject, "inputs"))) {
    dir.create(file.path(dirProject, "inputs"), recursive = TRUE)
  }

  rcp <- unlist(strsplit(cfg$input["cellular"], "_"))[6]
  rcp <- paste0("rcp", substr(rcp, nchar(rcp) - 1, nchar(rcp)))

  ssp <- tolower(cfg$gms$c09_pop_scenario)

  if (length(cfg$seals_years) != 0) {
    sealsYears <- cfg$seals_years[cfg$seals_years > 2020]
    sealsYears <- paste(sealsYears, collapse = " ")
  } else {
    sealsYears <- "2050"
  }

  scenarioType <- ifelse(grepl("default|bau|ssp\\d-ref", tolower(title)), "bau", "policy")

  if (cfg$gms$c22_protect_scenario == "none") {
    consv <- cfg$gms$c22_base_protect
  } else {
    consv <- cfg$gms$c22_protect_scenario
  }

  ### Modify SEALS model coefficients based on scenario settings

  message("Updating SEALS model coefficients based on scenario settings")

  sealsCoeff <- paste0(c("./", "../", "../../"), "input/seals_global_coefficients.csv")
  sealsCoeff <- Find(file.exists, sealsCoeff)

  if (!is.null(sealsCoeff)) {
    sealsCoeff <- read.csv(sealsCoeff)
    consvRow <- which(sealsCoeff[, "spatial_regressor_name"] == "land_conservation")
    sealsCoeff[consvRow, "data_location"] <- sub(
      "WDPA", consv, sealsCoeff[consvRow, "data_location"]
    )

    if (cfg$gms$s29_snv_shr != 0) {
      if (cfg$gms$s29_snv_shr == 0.2) {
        # snv policy reallocation incentive
        snvRow1 <- which(sealsCoeff[, "spatial_regressor_name"] == "snv20_realloc")
        sealsCoeff[snvRow1, c("forest", "othernat")] <- -100
        # snv policy expansion constraint
        snvRow2 <- which(sealsCoeff[, "spatial_regressor_name"] == "snv20_expan")
        sealsCoeff[snvRow2, "cropland"] <- 0
      } else {
        warning("Only if s29_snv_shr is 0.2 can it be explicitly considered at the 1x1km scale during the SEALS allocation.")
      }
    }

    peatArea <- PeatlandArea(file.path(dir, "fulldata.gdx"))[, as.numeric(sealsYears), ]
    rewetSwitch <- dimSums(peatArea[, , "rewet"], dim = 1) / dimSums(peatArea, dim = c(1, 3)) > 0.01
    if (any(c(rewetSwitch))) {
      peatRow <- which(sealsCoeff[, "spatial_regressor_name"] == "peatland_rewetting")
      # SEALS rewetting coefficient
      rewetCoeff <- 10000
      # disincentivise agricultural expansion
      sealsCoeff[peatRow, c("cropland", "grassland")] <- rewetCoeff
      # peatland rewetting incentive
      sealsCoeff[peatRow, c("forest", "othernat")] <- -rewetCoeff
    }

    sealsCoeffPath <- file.path(
      dirProject, "inputs",
      paste0("seals_global_coefficients_", title, ".csv")
    )

    write.csv(sealsCoeff, sealsCoeffPath,
      row.names = FALSE, na = "", quote = FALSE # quote = FALSE is critical here!
    )
  } else {
    stop("Could not find seals_global_coefficients.csv file")
  }


  ### Create SEALS scenario definitions CSV

  message("Creating SEALS scenario definitions CSV")

  sealsConfig <- paste0(c("./", "../", "../../"), "input/seals_scenario_config.csv")
  sealsConfig <- Find(file.exists, sealsConfig)

  if (!is.null(sealsConfig)) {
    sealsConfig <- read.csv(sealsConfig)
    sealsConfig[nrow(sealsConfig), "scenario_label"] <- title
    sealsConfig[nrow(sealsConfig), "scenario_type"] <- scenarioType
    sealsConfig[nrow(sealsConfig), "exogenous_label"] <- ssp
    sealsConfig[nrow(sealsConfig), "climate_label"] <- rcp
    sealsConfig[nrow(sealsConfig), "counterfactual_label"] <- title
    sealsConfig[nrow(sealsConfig), "comparison_counterfactual_labels"] <- ifelse(scenarioType == "bau", "", "bau")
    sealsConfig[, "coarse_projections_input_path"] <- normalizePath(file.path(dir, sealsInput))
    sealsConfig[nrow(sealsConfig), "years"] <- sealsYears
    sealsConfig[nrow(sealsConfig), "calibration_parameters_source"] <- normalizePath(sealsCoeffPath)
    write.csv(sealsConfig, file.path(dirProject, "inputs", paste0("seals_scenario_config_", title, ".csv")),
      row.names = FALSE, na = "", quote = FALSE # quote = FALSE is critical here!
    )
  } else {
    stop("Could not find seals_scenario_config.csv file template")
  }

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

  .setupSEALSrun(
    cfg = cfg,
    sealsInput = sealsInput,
    dir = outputdir,
    dirProject = dirProject,
    dirSEALS = dirSEALS,
    dirBaseFiles = dirBaseFiles
  )

  if (!file.exists(sealsLock) || file.size(sealsLock) == 0) {
    message(paste(
      "Starting SEALS allocation with input data creation.\n",
      "Stitched SEALS allocation outputs will be written to",
      "'./output/seals/intermediate/stitched_lulc_simplified_scenarios'"
    ))

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
    id <- readLines(sealsLock)

    message(paste(
      "Starting SEALS allocation using existing input data.\n",
      "Stitched SEALS allocation outputs will be written to",
      "'./output/seals/intermediate/stitched_lulc_simplified_scenarios'"
    ))

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
