# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: FSEC diet simulations
# ----------------------------------------------------------
library(gms)
source("scripts/start_functions.R")
source("scripts/performance_test.R")
source("config/default.cfg")

# set defaults
codeCheck <- FALSE

# settings
cfg$results_folder <- "output/:title:"
cfg$recalibrate    <- TRUE
cfg$force_download <- TRUE

### SSP runs ###
# SSP1
cfg$title <- "FSEC_diets_SSP1"
cfg<-gms::setScenario(cfg,"SSP1")
cfg<-gms::setScenario(cfg,"nocc")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP2
cfg$title <- "FSEC_diets_SSP2"
cfg<-gms::setScenario(cfg,"SSP2")
cfg<-gms::setScenario(cfg,"nocc")
start_run(cfg=cfg,codeCheck=codeCheck)
