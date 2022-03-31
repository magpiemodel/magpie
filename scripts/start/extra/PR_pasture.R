# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


# ----------------------------------------------------------
# description: creating runs to test the PR for pasture management
# ----------------------------------------------------------

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")
#start MAgPIE run
tc13 <- c("endo_jan22")
past31 <- c("grasslands_apr22", "endo_jun13", "static")
for (i in tc13) {
  cfg$gms$tc <- i
  for (j in past31) {
    if(j == "grasslands_apr22") {
      cfg$input["calibration"] <- "calibration_H12_grassland_mar22.tgz"
    } else {
      cfg$input["calibration"] <- "calibration_H12_sticky_feb18_free_18Jan22.tgz"
    }
    cfg$gms$past <- j
    cfg$title <- paste0("PR1_I_",i,"_I_",j)
    start_run(cfg=cfg)
  }
}
