# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source config
source("config/default.cfg")

cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev52_c200_690d3718e151be1b450b394c1064b1c5.tgz",
         "rev4.58_h12_magpie.tgz",
         "rev4.58_h12_validation.tgz",
         "calibration_H12_c200_23Feb21.tgz",
         "additional_data_rev3.98.tgz",
         "patch_f44_bii_coeff.tgz")

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,
                                "../patch_inputdata"=NULL),
                           getOption("magpie_repos"))

#bvPriceScen <- c("p0","p1_p10","p10_p100","p10_p10000")
bvPriceScen <- "p0"

# Test different price levels
for (pricelevel in bvPriceScen) {

  cfg$gms$c44_price_bv_loss <- pricelevel

  # Updating the title
  cfg$title = paste0("bv_",pricelevel)

  # Start run
  start_run(cfg=cfg,codeCheck=TRUE)
}


