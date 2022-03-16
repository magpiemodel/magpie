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
tc13 <- c("endo_jan22", "exo")
past31 <- c("grasslands_mar22", "endo_jun13", "static")
for (i in tc13) {
  cfg$gms$tc <- i
  for (j in past31) {
    cfg$gms$past <- j
    cfg$title <- paste0(i,"_",j)
    start_run(cfg=cfg)
  }
}
