# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
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

# Source the default config and then over-write it before starting the run.
source("config/default.cfg")

# Change results folder name
cfg$results_folder <- "output/:title:"

# Enable CO2 Pricing
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"

# Afforestation restrictions "unrestricted" "noboreal"
cfg$gms$c32_aff_mask <- "unrestricted"


for(bgp_setting in c("ann","nobgp","djf")){
  for(ac_setting in c("ac10","ac20","ac30")){
    
  }
  # Change bgp setting
  cfg$gms$c32_aff_bgp <- bgp_setting

  # Changing title flags
  if(bgp_setting == "nobgp") bgp_flag="nobgp"
  if(bgp_setting == "ann") bgp_flag="ann_bgp"
  if(bgp_setting == "djf") bgp_flag="djf_bgp"
  if(bgp_setting == "jja") bgp_flag="jja_bgp"


  # Update title
  cfg$title <- paste0("MAgPIE","_",bgp_flag,"_","unrestricted","_","ac0")

  # Start the run
  start_run(cfg=cfg)

}# Closing bgp settings loop
