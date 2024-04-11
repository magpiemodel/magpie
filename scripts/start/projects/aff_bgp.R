# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode2)
library(magclass)

# Switch between control and experiment, "exp", "ctr"
run_setting <- "ctr"

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
#cfg$force_download <- TRUE

 # Should an existing output folder be replaced if a new run with the same name is started?
cfg$force_replace <- TRUE



# Enable CO2 Pricing
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-26-REMIND-MAGPIE"

# Set relevant policies to NDC
cfg$gms$c22_ad_policy <- "ndc"
cfg$gms$c22_aolc_policy <- "ndc"
cfg$gms$c32_aff_policy <- "ndc"

# Afforestation restrictions "unrestricted" "noboreal"
cfg$gms$c32_aff_mask <- "unrestricted"

# SSP loop
for(ssp_setting in c("SSP1","SSP2","SSP3")){
  cfg <- setScenario(cfg,c(ssp_setting,"NDC"))

if(run_setting=="exp") bgp_setting="ann_bph"
if(run_setting=="ctr") bgp_setting="nobgp"

    #Change BGP setting
    cfg$gms$c32_aff_bgp <- bgp_setting

    #Set title flag
    if(bgp_setting == "nobgp") bgp_flag="nobgp"
    if(bgp_setting == "ann_bph") bgp_flag="ann_bph"
    if(ssp_setting == "SSP1") ssp_flag="SSP1"
    if(ssp_setting == "SSP2") ssp_flag="SSP2"
    if(ssp_setting == "SSP3") ssp_flag="SSP3"

    if (run_setting=="exp"){
      for(tcrearea_setting in c(0,1)){
        for(tcreuncert_setting in c("ann_TCREmean","ann_TCREhigh","ann_TCRElow")){

          #Change TCRE settings
          cfg$gms$s32_tcre_local <- tcrearea_setting #0<-global;1<-local
          cfg$gms$c32_tcre_ctrl <- tcreuncert_setting

          #Set title flags
          if(tcrearea_setting == 0) area_flag="global"
          if(tcrearea_setting == 1) area_flag="local"
          if(tcreuncert_setting == "ann_TCREmean") uncertainty_flag="meanTCRE"
          if(tcreuncert_setting == "ann_TCREhigh") uncertainty_flag="highTCRE"
          if(tcreuncert_setting == "ann_TCRElow") uncertainty_flag="lowTCRE"

          # Update title
          cfg$title <- paste0("BPHexp","_",bgp_flag,"_",ssp_flag,"_",area_flag,"_",uncertainty_flag,"_","afforunrestricted","_","ac10to30")

          # Start the run
          start_run(cfg=cfg,codeCheck=FALSE)

        }# TCRE uncertainty loop
      }# TCRE local vs global loop
    }# BGP set to ON loop
    else if (run_setting=="ctr"){
      # Update title
      cfg$title <- paste0("BPHexp","_",bgp_flag,"_",ssp_flag,"_","afforunrestricted")

      # Start the run
      start_run(cfg=cfg,codeCheck=FALSE)
    }# BGP set to OFF loop


}# Closing SSP settings loop
