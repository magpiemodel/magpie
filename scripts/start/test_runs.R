# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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
cfg$info$flag <- "weeklyTests"

cfg$results_folder <- "output/:title:"
cfg$force_replace <- TRUE

# support function to create standardized title
.title <- function(cfg, ...) return(paste(cfg$info$flag, sep="_",...))

# Single time step run
timeSteps <- cfg$gms$c_timesteps
cfg$gms$c_timesteps <- 1
cfg$title <- .title(cfg, "singleTimeStep")
start_run(cfg, codeCheck = TRUE)
cfg$gms$c_timesteps <- timeSteps


# Reference and Policy run for SSP1, SSP2 and SSP5
for(ssp in c("SSP1","SSP2","SSP5")) {

  cfg$title <- .title(cfg, paste(ssp,"Ref",sep="-"))
  cfg <- setScenario(cfg,c(ssp,"NPI","rcp7p0"))
  cfg$gms$c56_mute_ghgprices_until <- "y2150"
  cfg$gms$c56_pollutant_prices <- paste0("R32M46-", if (ssp=="SSP2") "SSP2EU" else ssp,"-NPi")
  cfg$gms$c60_2ndgen_biodem    <- paste0("R32M46-", if (ssp=="SSP2") "SSP2EU" else ssp,"-NPi")
  start_run(cfg, codeCheck = FALSE)

  cfg$title <- .title(cfg, paste(ssp,"NDC",sep="-"))
  cfg <- setScenario(cfg,c(ssp,"NDC","rcp4p5"))
  cfg$gms$c56_mute_ghgprices_until <- "y2150"
  cfg$gms$c56_pollutant_prices <- paste0("R32M46-", if (ssp=="SSP2") "SSP2EU" else ssp,"-NDC")
  cfg$gms$c60_2ndgen_biodem    <- paste0("R32M46-", if (ssp=="SSP2") "SSP2EU" else ssp,"-NDC")
  start_run(cfg, codeCheck = FALSE)

  cfg$title <- .title(cfg, paste(ssp,"PkBudg650",sep="-"))
  cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9"))
  cfg$gms$c56_mute_ghgprices_until <- "y2030"
  cfg$gms$c56_pollutant_prices <- paste0("R32M46-", if (ssp=="SSP2") "SSP2EU" else ssp,"-PkBudg650")
  cfg$gms$c60_2ndgen_biodem    <- paste0("R32M46-", if (ssp=="SSP2") "SSP2EU" else ssp,"-PkBudg650")
  start_run(cfg, codeCheck = FALSE)

}

#####################################################
### FSEC Test runs (BAU + FSDP) with FSEC regions ###
#####################################################
source("scripts/projects/fsec.R")

codeCheck <- FALSE

### Business-as-usual
cfg <- fsecScenario(scenario = "c_BAU")
cfg$results_folder_highres <- "output"
start_run(cfg = cfg, codeCheck = codeCheck)

### NatureSparing
cfg <- fsecScenario(scenario = "b_NatureSparing")
cfg$results_folder_highres <- "output"
start_run(cfg = cfg, codeCheck = codeCheck)

### LandscapeElements
cfg <- fsecScenario(scenario = "a_LandscapeElements")
cfg$results_folder_highres <- "output"
start_run(cfg = cfg, codeCheck = codeCheck)

### FSDP Scenario
cfg <- fsecScenario(scenario = "e_FSDP")
cfg$results_folder_highres <- "output"
start_run(cfg = cfg, codeCheck = codeCheck)
