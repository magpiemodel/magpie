# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


# ----------------------------------------------------------
# description: Food Demand Standalone
# ----------------------------------------------------------

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# start MAgPIE run
source("config/default.cfg")
cfg$model                   <- "standalone/demand_model.gms"
cfg$recalibrate             <- FALSE
cfg$gms$c_timesteps         <- "pastandfuture"
cfg$gms$s15_calibrate       <- 1
cfg$gms$s15_elastic_demand  <- 0

cfg$title <- "test1"
start_run(cfg = cfg)
