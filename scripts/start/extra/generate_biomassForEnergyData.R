# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Calculate biomass potential for energy use 
#              (wood fuel, crop residues, manure) for multiple 
#              SSP/NPi2025 scenarios
# position: 5
# ----------------------------------------------------------

library(lucode2)
library(gms)

source("scripts/start_functions.R")
source("config/default.cfg")

download_and_update(cfg)

cfg$info$flag <- "biomassEnergy"

# Read MAgPIE version from CITATION.cff (machine-readable source)
magpieVersion <- citation::read_cff("CITATION.cff")$version

.title <- function(cfg, version = magpieVersion, scenario) {
  return(paste(cfg$info$flag, version, scenario, sep = "_"))
}

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
        # Note: SSP2 default assumptions used here to fill missing SSP4 scenario info
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
    cfg$title <- .title(cfg, scenario = paste(s$name, s$titleSuffix, sep = "-"))
    cfg <- setScenario(cfg, s$scen)
    cfg$gms$c60_res_2ndgenBE_dem    <- "off"
    cfg$gms$c56_mute_ghgprices_until <- "y2150"
    cfg$gms$c56_pollutant_prices    <- s$pollString
    cfg$gms$c60_2ndgen_biodem       <- s$bioString
    start_run(cfg, codeCheck = FALSE)
}
