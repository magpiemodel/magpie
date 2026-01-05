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

# Define scenarios and their specific parameters, then iterate over them
scenarios <- list(
    list(
        name        = "SSP1",
        titleSuffix = "NPi2025",
        scen        = c("SSP1", "NPI", "nocc_hist"),
        pollString  = "R34M410-SSP1-NPi2025",
        bioString   = "R34M410-SSP1-NPi2025"
    ),
    list(
        name        = "SSP2",
        titleSuffix = "NPi2025",
        scen        = c("SSP2", "NPI", "nocc_hist"),
        pollString  = "R34M410-SSP2-NPi2025",
        bioString   = "R34M410-SSP2-NPi2025"
    ),
    list(
        name        = "SSP3",
        titleSuffix = "NPi2025",
        scen        = c("SSP3", "NPI", "nocc_hist"),
        pollString  = "R34M410-SSP3-NPi2025",
        bioString   = "R34M410-SSP3-NPi2025"
    ),
    list(
        name        = "SSP4",
        titleSuffix = "NPi2025",
        scen        = c("SSP4", "NPI", "nocc_hist"),
        # Note: pollString and bioString intentionally match original SSP4 block (SSP2 strings)
        pollString  = "R34M410-SSP2-NPi2025",
        bioString   = "R34M410-SSP2-NPi2025"
    ),
    list(
        name        = "SSP5",
        titleSuffix = "NPi2025",
        scen        = c("SSP5", "NPI", "nocc_hist"),
        pollString  = "R34M410-SSP5-NPi2025",
        bioString   = "R34M410-SSP5-NPi2025"
    ),
    list(
        name        = "SDP",
        titleSuffix = "NPi2025",
        scen        = c("SDP", "NPI", "nocc_hist"),
        pollString  = "R32M46-SDP_MC-NPi",
        bioString   = "R32M46-SDP_MC-NPi"
    )
)

for (s in scenarios) {
    cfg$title <- .title(cfg, paste(s$name, s$titleSuffix, sep = "-"))
    cfg <- setScenario(cfg, s$scen)
    cfg$gms$c60_res_2ndgenBE_dem    <- "off"
    cfg$gms$c56_mute_ghgprices_until <- "y2150"
    cfg$gms$c56_pollutant_prices    <- s$pollString
    cfg$gms$c60_2ndgen_biodem       <- s$bioString
    start_run(cfg, codeCheck = FALSE)
}
