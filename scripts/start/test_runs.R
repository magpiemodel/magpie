# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test routine for standardized test runs
# position: 5
# ----------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

#download default input data
download_and_update(cfg)

# create additional information to describe the runs
arguments <- commandArgs(trailingOnly = TRUE)
if (length(arguments) == 1) {
  cfg$info$flag <- paste0("release-", arguments)
} else {
  cfg$info$flag <- "weeklyTests"
}

cfg$results_folder <- "output/:title:"
cfg$force_replace <- TRUE

# support function to create standardized title
.title <- function(cfg, ...) return(paste(cfg$info$flag, sep = "_", ...))

# Single time step run
timeSteps <- cfg$gms$c_timesteps
cfg$gms$c_timesteps <- 1
cfg$title <- .title(cfg, "singleTimeStep")
start_run(cfg, codeCheck = TRUE)
cfg$gms$c_timesteps <- timeSteps

# Reference and Policy run for SSP1, SSP2 and SSP3
# NPi2025: continuation of current climate polices
# PkBudg1000: ambitious climate policy broadly in line with 2deg C Paris target
# PkBudg650: ambitious climate policy broadly in line with 1.5deg C Paris target
# SSP3-PkBudg650 is not feasible, therefore only PkBudg1000 is used.
for (ssp in c("SSP1", "SSP2", "SSP3")) {
  if (ssp %in% c("SSP1", "SSP2")) {
    cfg$title <- .title(cfg, paste(ssp, "NPi2025", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NPI", "rcp4p5"))
    cfg$gms$c56_mute_ghgprices_until <- "y2150"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-", ssp, "-NPi2025")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-", ssp, "-NPi2025")
    start_run(cfg, codeCheck = FALSE)

    cfg$title <- .title(cfg, paste(ssp, "PkBudg1000", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NDC", "rcp2p6"))
    cfg$gms$c56_mute_ghgprices_until <- "y2030"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-", ssp, "-PkBudg1000")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-", ssp, "-PkBudg1000")
    start_run(cfg, codeCheck = FALSE)

    cfg$title <- .title(cfg, paste(ssp, "PkBudg650", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NDC", "rcp1p9"))
    cfg$gms$c56_mute_ghgprices_until <- "y2030"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-", ssp, "-PkBudg650")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-", ssp, "-PkBudg650")
    start_run(cfg, codeCheck = FALSE)
  } else if (ssp == "SSP3") {
    cfg$title <- .title(cfg, paste(ssp, "NPi2025", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NPI", "rcp6p0"))
    cfg$gms$c56_mute_ghgprices_until <- "y2150"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-", ssp, "-NPi2025")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-", ssp, "-NPi2025")
    start_run(cfg, codeCheck = FALSE)

    cfg$title <- .title(cfg, paste(ssp, "rollBack", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NPI-revert", "rcp7p0"))
    cfg$gms$c56_mute_ghgprices_until <- "y2150"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-", ssp, "-rollBack")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-", ssp, "-rollBack")
    start_run(cfg, codeCheck = FALSE)

    cfg$title <- .title(cfg, paste(ssp, "PkBudg1000", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NDC", "rcp2p6"))
    cfg$gms$c56_mute_ghgprices_until <- "y2030"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-", ssp, "-PkBudg1000")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-", ssp, "-PkBudg1000")
    start_run(cfg, codeCheck = FALSE)
  }
}

# test FSEC setup (even though FSEC is no longer ongoing) as that checks many important switches
source("scripts/projects/fsec.R")

codeCheck <- FALSE

### Business-as-usual
cfg <- fsecScenario(scenario = "c_BAU")
cfg$force_replace <- TRUE
cfg$results_folder <- "output/:title:"
cfg$results_folder_highres <- "output"
start_run(cfg = cfg, codeCheck = codeCheck)

### NatureSparing
cfg <- fsecScenario(scenario = "b_NatureSparing")
cfg$force_replace <- TRUE
cfg$results_folder <- "output/:title:"
cfg$results_folder_highres <- "output"
start_run(cfg = cfg, codeCheck = codeCheck)

### LandscapeElements
cfg <- fsecScenario(scenario = "a_LandscapeElements")
cfg$force_replace <- TRUE
cfg$results_folder <- "output/:title:"
cfg$results_folder_highres <- "output"
start_run(cfg = cfg, codeCheck = codeCheck)

### FSDP Scenario
cfg <- fsecScenario(scenario = "e_FSDP")
cfg$force_replace <- TRUE
cfg$results_folder <- "output/:title:"
cfg$results_folder_highres <- "output"
start_run(cfg = cfg, codeCheck = codeCheck)
