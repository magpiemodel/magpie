# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(gms)
source("scripts/start_functions.R")
source("config/default.cfg")
source("scripts/start/extra/lpjml_addon.R")

cfg$title          <- "PRtest_cropsuit33_lpjml5"
cfg$force_download <- TRUE
cfg$recalibrate    <- TRUE
cfg$gms$crop       <- "endo_apr21"
start_run(cfg=cfg)

cfg$gms$c30_marginal_land <- "all_marginal"   # def = "q33_marginal"
cfg$title          <- "PRtest_cropsuitall_lpjml5"
start_run(cfg=cfg)
