# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -------------------------------------------------
# description: just download default.cfg input data
# position: 3
# -------------------------------------------------

source("scripts/start_functions.R")
source("config/default.cfg")

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,
                                "./patch_inputdata"=NULL),
                           getOption("magpie_repos"))
                           
cfg$input <- c(regional    = "rev4.131.9001BRA_H13_C200_W3_MapbiomasIBGE_5638d5dc_magpie.tgz",
               cellular    = "rev4.131.9001BRA_H13_C200_W3_MapbiomasIBGE_5638d5dc_d8411e75_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1_clusterweight-d0236589.tgz",
               validation  = "rev4.131.9001BRA_H13_C200_W3_MapbiomasIBGE_5638d5dc_92e02314_validation.tgz",
               additional  = "additional_data_rev4.65.tgz",
               calibration = "calibration_BRA_H13_C200_W2_MapbiomasIBGE_17Jun26.tgz")

# cfg$input <- c(regional    = "rev4.131.9001NZB_BRA_H13_C200_W3_SwpFunBRA_5638d5dc_magpie.tgz",
#                cellular    = "rev4.131.9001NZB_BRA_H13_C200_W3_SwpFunBRA_5638d5dc_d8411e75_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1_clusterweight-d0236589.tgz",
#                validation  = "rev4.131.9001NZB_BRA_H13_C200_W3_SwpFunBRA_5638d5dc_92e02314_validation.tgz",
#                additional  = "additional_data_rev4.65.tgz",
#                calibration = "calibration_H12_FAO_01Apr26.tgz")
download_and_update(cfg)
