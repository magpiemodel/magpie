# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ------------------------------------------------
# description: start run with Forestry (Endogenous)
# position: 6
# ------------------------------------------------


library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
#cfg$results_folder <- "output/:title:"

cfg <- setScenario(cfg,c("SSP2","NPI","ForestryEndo"))
#cfg <- setScenario(cfg,c("SSP2","NPI","ForestryExo"))
#cfg <- setScenario(cfg,c("SSP2","NPI","ForestryOff"))

cfg$title <- "forestry"
start_run(cfg,codeCheck = FALSE)
