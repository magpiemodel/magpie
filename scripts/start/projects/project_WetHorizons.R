# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Project WetHorizons Peatland
# position: 5
# ----------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)
library(gdx2)
library(magpie4)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

# create additional information to describe the runs
cfg$info$flag <- "WH03"

cfg$results_folder <- "output/:title:"
cfg$results_folder_highres <- "output"
cfg$force_replace <- TRUE
cfg$force_download <- FALSE
cfg$qos <- "standby"

# support function to create standardized title
.title <- function(cfg, ...)
  return(paste(cfg$info$flag, sep = "_", ...))

cfg$repositories <- append(
  list(
    "https://rse.pik-potsdam.de/data/magpie/public" = NULL,
    "./patch_inputdata" = NULL
  ),
  getOption("magpie_repos")
)

cfg$gms$c_timesteps <- "5year"
ssp <- "SSP2"

# Reference
cfg$title <- .title(cfg, paste(ssp, "Ref", sep = "-"))
cfg <- setScenario(cfg, c(ssp, "NPI", "rcp7p0"))
cfg$gms$c56_mute_ghgprices_until <- "y2150"
cfg$gms$c56_pollutant_prices <- "R32M46-SSP2EU-NPi"
cfg$gms$c60_2ndgen_biodem    <- "R32M46-SSP2EU-NPi"
start_run(cfg, codeCheck = FALSE)

# PkBudg650
cfg$title <- .title(cfg, paste(ssp, "PkBudg650", sep = "-"))
cfg <- setScenario(cfg, c(ssp, "NDC", "rcp1p9"))
cfg$gms$c56_mute_ghgprices_until <- "y2025"
cfg$gms$c56_pollutant_prices <- "R32M46-SSP2EU-PkBudg650"
cfg$gms$c60_2ndgen_biodem    <- "R32M46-SSP2EU-PkBudg650"
start_run(cfg, codeCheck = FALSE)

#PkBudg650 without peatland policy
cfg$title <- .title(cfg, paste(ssp, "PkBudg650", "noPeatland", sep = "-"))
cfg <- setScenario(cfg, c(ssp, "NDC", "rcp1p9"))
cfg$gms$c56_mute_ghgprices_until <- "y2025"
cfg$gms$c56_pollutant_prices <- "R32M46-SSP2EU-PkBudg650"
cfg$gms$c60_2ndgen_biodem    <- "R32M46-SSP2EU-PkBudg650"
cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
start_run(cfg, codeCheck = FALSE)

## Exo rewet scenarios
# 15% of currently drained peatland rewetted by 2050
cfg$title <- .title(cfg, paste(ssp, "PkBudg650", "NRL15", sep = "-"))
cfg <- setScenario(cfg, c(ssp, "NDC", "rcp1p9"))
cfg$gms$c56_mute_ghgprices_until <- "y2025"
cfg$gms$c56_pollutant_prices <- "R32M46-SSP2EU-PkBudg650"
cfg$gms$c60_2ndgen_biodem    <- "R32M46-SSP2EU-PkBudg650"
cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
cfg$gms$s58_rewetting_exo <- 1
cfg$gms$s58_rewet_exo_start_value <- 0
cfg$gms$s58_rewet_exo_target_value <- 0.15
cfg$gms$s58_annual_rewetting_limit <- 1
cfg$gms$s58_intact_prot_exo <- 1
start_run(cfg, codeCheck = FALSE)

## Exo rewet scenarios
# 25% of currently drained peatland rewetted by 2050
cfg$title <- .title(cfg, paste(ssp, "PkBudg650", "NRL25", sep = "-"))
cfg <- setScenario(cfg, c(ssp, "NDC", "rcp1p9"))
cfg$gms$c56_mute_ghgprices_until <- "y2025"
cfg$gms$c56_pollutant_prices <- "R32M46-SSP2EU-PkBudg650"
cfg$gms$c60_2ndgen_biodem    <- "R32M46-SSP2EU-PkBudg650"
cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
cfg$gms$s58_rewetting_exo <- 1
cfg$gms$s58_rewet_exo_start_value <- 0
cfg$gms$s58_rewet_exo_target_value <- 0.25
cfg$gms$s58_annual_rewetting_limit <- 1
cfg$gms$s58_intact_prot_exo <- 1
start_run(cfg, codeCheck = FALSE)

## Exo rewet scenarios
# 50% of currently drained peatland rewetted by 2050
cfg$title <- .title(cfg, paste(ssp, "PkBudg650", "NRL50", sep = "-"))
cfg <- setScenario(cfg, c(ssp, "NDC", "rcp1p9"))
cfg$gms$c56_mute_ghgprices_until <- "y2025"
cfg$gms$c56_pollutant_prices <- "R32M46-SSP2EU-PkBudg650"
cfg$gms$c60_2ndgen_biodem    <- "R32M46-SSP2EU-PkBudg650"
cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
cfg$gms$s58_rewetting_exo <- 1
cfg$gms$s58_rewet_exo_start_value <- 0
cfg$gms$s58_rewet_exo_target_value <- 0.5
cfg$gms$s58_annual_rewetting_limit <- 1
cfg$gms$s58_intact_prot_exo <- 1
start_run(cfg, codeCheck = FALSE)

## Exo rewet scenarios
# 100% of currently drained peatland rewetted by 2050
cfg$title <- .title(cfg, paste(ssp, "PkBudg650", "NRL100", sep = "-"))
cfg <- setScenario(cfg, c(ssp, "NDC", "rcp1p9"))
cfg$gms$c56_mute_ghgprices_until <- "y2025"
cfg$gms$c56_pollutant_prices <- "R32M46-SSP2EU-PkBudg650"
cfg$gms$c60_2ndgen_biodem    <- "R32M46-SSP2EU-PkBudg650"
cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
cfg$gms$s58_rewetting_exo <- 1
cfg$gms$s58_rewet_exo_start_value <- 0
cfg$gms$s58_rewet_exo_target_value <- 1
cfg$gms$s58_annual_rewetting_limit <- 1
cfg$gms$s58_intact_prot_exo <- 1
start_run(cfg, codeCheck = FALSE)
