# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Calculate residue potential for 2nd generation bioenergy for multiple SSP/NPi2025 scenarios
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

cfg$info$flag <- "residuePot" 

# support function to create standardized title
.title <- function(cfg, ...) return(paste(cfg$info$flag, sep = "_", ...))

    cfg$title <- .title(cfg, paste("SSP1", "NPi2025", sep = "-"))
    cfg <- setScenario(cfg, c("SSP1", "NPI", "nocc_hist"))
    cfg$gms$c60_res_2ndgenBE_dem <- "off"
    cfg$gms$c56_mute_ghgprices_until <- "y2150"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-SSP1-NPi2025")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-SSP1-NPi2025")
    start_run(cfg, codeCheck = FALSE)

    cfg$title <- .title(cfg, paste("SSP2", "NPi2025", sep = "-"))
    cfg <- setScenario(cfg, c("SSP2", "NPI", "nocc_hist"))
    cfg$gms$c60_res_2ndgenBE_dem <- "off"
    cfg$gms$c56_mute_ghgprices_until <- "y2150"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-SSP2-NPi2025")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-SSP2-NPi2025")
    start_run(cfg, codeCheck = FALSE)

 
    cfg$title <- .title(cfg, paste("SSP3", "NPi2025", sep = "-"))
    cfg <- setScenario(cfg, c("SSP3", "NPI", "nocc_hist"))
    cfg$gms$c60_res_2ndgenBE_dem <- "off"
    cfg$gms$c56_mute_ghgprices_until <- "y2150"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-SSP3-NPi2025")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-SSP3-NPi2025")
    start_run(cfg, codeCheck = FALSE)

    cfg$title <- .title(cfg, paste("SSP4", "NPi2025", sep = "-"))
    cfg <- setScenario(cfg, c("SSP4", "NPI", "nocc_hist"))
    cfg$gms$c60_res_2ndgenBE_dem <- "off"
    cfg$gms$c56_mute_ghgprices_until <- "y2150"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-SSP2-NPi2025")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-SSP2-NPi2025")
    start_run(cfg, codeCheck = FALSE)

    cfg$title <- .title(cfg, paste("SSP5", "NPi2025", sep = "-"))
    cfg <- setScenario(cfg, c("SSP5", "NPI", "nocc_hist"))
    cfg$gms$c60_res_2ndgenBE_dem <- "off"
    cfg$gms$c56_mute_ghgprices_until <- "y2150"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-SSP5-NPi2025")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-SSP5-NPi2025")
    start_run(cfg, codeCheck = FALSE)

    cfg$title <- .title(cfg, paste("SDP", "NPi2025", sep = "-"))
    cfg <- setScenario(cfg, c("SDP", "NPI", "nocc_hist"))
    cfg$gms$c60_res_2ndgenBE_dem <- "off"
    cfg$gms$c56_mute_ghgprices_until <- "y2150"
    cfg$gms$c56_pollutant_prices <- paste0("R32M46-SDP_MC-NPi")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R32M46-SDP_MC-NPi")
    start_run(cfg, codeCheck = FALSE)

