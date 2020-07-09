# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source the default config and then over-write it before starting the run.
source("config/default.cfg")

# Change results folder name
cfg$results_folder <- "output/:title:"

# Change input datasource to include my personal preprocessing
cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev46_0.5.tgz",
        "isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev46_c200_690d3718e151be1b450b394c1064b1c5.tgz",
        "isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev44_c200_690d3718e151be1b450b394c1064b1c5.tgz",
         "rev4.47_h12_magpie.tgz",
         "rev4.47_h12_validation.tgz",
 			   "calibration_H12_c200_26Feb20.tgz",
         "additional_data_rev3.85.tgz")

 # Should input data be downloaded from source even if cfg$input did not change?
cfg$force_download <- TRUE

 # Should an existing output folder be replaced if a new run with the same name is started?
cfg$force_replace <- TRUE



#cfg <- setScenario(cfg,c("SSP1"))

# Enable CO2 Pricing
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"

# Afforestation restrictions "unrestricted" "noboreal"
cfg$gms$c32_aff_mask <- "unrestricted"

# Global vs local TCRE
cfg$gms$s32_tcre_local <- 0


for(bgp_setting in c("ann_bph","nobgp")){

  # Change bgp setting
  cfg$gms$c32_aff_bgp <- bgp_setting

  # Change bgp ageclass_setting
  cfg$gms$c32_bgp_ac <- c("ac10")

  # Changing title flags
  if(bgp_setting == "nobgp") bgp_flag="nobgp"
  if(bgp_setting == "ann_bph") bgp_flag="ann_bph"
  if(bgp_setting == "djf") bgp_flag="djf_bgp"
  if(bgp_setting == "jja") bgp_flag="jja_bgp"


  # Update title
  cfg$title <- paste0("test_splitdata_0707","_",bgp_flag,"_","unrestricted","_global")

  # Start the run
  start_run(cfg=cfg,codeCheck=FALSE)

}# Closing bgp settings loop
