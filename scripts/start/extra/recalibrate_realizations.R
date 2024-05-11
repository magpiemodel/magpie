# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------
# description: calculate and store new land conversion cost calibration factors for all factor cost module realizations (time consuming; up to 40 model runs with 5 time steps)
# --------------------------------------------------------

library(magpie4)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# get default settings
source("config/default.cfg")

realizations <- c("per_ton_fao_may22", "sticky_feb18") # "sticky_labor" is very similar to sticky_feb18. No extra calibration needed.
type <- NULL

cfg$results_folder <- "output/:title:"
cfg$recalibrate <- FALSE
cfg$recalibrate_landconversion_cost <- TRUE

cfg$output <- c("rds_report")
cfg$force_download <- TRUE

cfg$gms$c_timesteps <- "calib"

for (r in realizations) {
  cfg$gms$factor_costs <- r

  cfg$best_calib <- TRUE

  for (fac_req in c("reg", "glo")) {
    cfg$gms$c38_fac_req <- fac_req
    cfg$gms$c70_fac_req_regr <- fac_req
    cfg$title <- paste("calib_run", r, fac_req, sep = "_")
    cfg$qos <- "priority"
    start_run(cfg)
    magpie4::submitCalibration(paste("H12", r, fac_req, sep = "_"))
  }
}
