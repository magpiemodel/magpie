# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test rountine for standardized test runs
# position: 5
# ----------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

# create additional information to describe the runs
cfg$info$flag <- "TEST" # choose a meaningful flag.
cfg$info$user <- Sys.info()[["user"]] # Grab user name

cfg$output <- c("rds_report") # Only run rds_report after model run

# support function to create standardized title
.title <- function(...) return(paste(...,cfg$info$flag, sep="_"))

# start a run with default settings
cfg$title <- .title("default")
start_run(cfg, codeCheck = TRUE)

# create a set of runs based on default.cfg
for(ssp in c("SSP1","SSP2")) { # Add SSP* here for testing other SSPs.
                               # Basic test should be for at least two SSPs to
                               #check if results until 2020 are identical

  cfg$title <- .title("ref", ssp)
  cfg <- setScenario(cfg,c(ssp,"NPI"))
  cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
  cfg$gms$c60_2ndgen_biodem    <- "R2M41-SSP2-NPi"
  start_run(cfg, codeCheck = FALSE)

  cfg$title <- .title("1p5deg", ssp)
  cfg <- setScenario(cfg,c(ssp,"NDC"))
  cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
  cfg$gms$c60_2ndgen_biodem    <- "R2M41-SSP2-Budg600"
  start_run(cfg, codeCheck = FALSE)

}
