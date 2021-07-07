# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -------------------------------------------------------------
# description: default run with new yield realization and data
# ------------------------------------------------------------

library(gms)
source("scripts/start_functions.R")
source("config/default.cfg")
source("scripts/start/extra/lpjml_addon.R")

cfg$results_folder <- "output/:title:"
cfg$output <- c("rds_report")
cfg$gms$s80_optfile <- 1

cfg$gms$factor_costs <- "sticky_feb18"
cfg$gms$c38_sticky_mode <- "free"
cfg$input['calibration'] = "calibration_H12_newlpjml_bestcalib_fc-sticky-free_crop-endoApr21_20May21.tgz"

cfg$gms$maccs  <- "off_jul16"
cfg$gms$s12_interest_calib <- 1
cfg$gms$s13_ignore_tau_historical <- 0
cfg$title <- paste("RC10","SSP2-NPI","new","TAUhistFix2",sep="_")
start_run(cfg=cfg,codeCheck=FALSE)

# cfg$title <- paste("RC10","SSP2-NPI","new",paste0("CalibInt",0.7),sep="_")
# cfg$gms$s12_interest_calib <- 0.7
# start_run(cfg=cfg,codeCheck=FALSE)
# 
# cfg$title <- paste("RC10","SSP2-NPI","new",paste0("CalibInt",0.5),sep="_")
# cfg$gms$s12_interest_calib <- 0.5
# start_run(cfg=cfg,codeCheck=FALSE)
# 
# cfg$title <- paste("RC10","SSP2-NPI","new",paste0("CalibInt",0.3),sep="_")
# cfg$gms$s12_interest_calib <- 0.3
# start_run(cfg=cfg,codeCheck=FALSE)
