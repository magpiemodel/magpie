# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test Li2020 bioenergy yield calibration in gsadapt_nov25
#              3 BE calibration options (off, regional, global) x
#              2 gsadapt options (gsconst, gsadapt) = 6 runs
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################
source("scripts/start_functions.R")
source("config/default.cfg")

title <- "l2m_apr26"

cfg$gms$yields <- "gsadapt_nov25"
cfg$gms$tc     <- "endo_nov25"
cfg$recalibrate_landconversion_cost <- FALSE

cfg$input <- c(regional    = "rev4.130l2m_v5-10-0m2_mar2026+BEdata_h12_magpie.tgz",
               cellular    = "rev4.130l2m_v5-10-0m2_mar2026+BEdata_h12_00e02813_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-a0c283bd.tgz",
               validation  = "rev4.130l2m_v5-10-0m2_mar2026+BEdata_h12_92e02314_validation.tgz",
               additional  = "additional_data_rev4.63.tgz",
               calibration = "calibration_H12_FAO_18Sep25.tgz")

for (becalib in c("off", "regional", "global")) {
  cfg$gms$c14_be_calib <- becalib

  for (gsadapt in c("gsconst", "gsadapt")) {
    if (gsadapt == "gsconst") {
      cfg$gms$s14_use_gsadapt <- 0
      cfg$gms$s14_gsadapt2tau <- 0
    } else {
      cfg$gms$s14_use_gsadapt <- 1
      cfg$gms$s14_gsadapt2tau <- 1
    }

    cfg$title <- paste0(title, "_BEcalib", becalib, "_", gsadapt)
    start_run(cfg, codeCheck = TRUE)
  }
}
