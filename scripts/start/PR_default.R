# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

##### Version log (YYYYMMDD - Description - Author(s))
## 20200527 - Default SSP2 Baseline and Policy runs - FH,AM,EMJB,JPD

## Load lucode to use setScenario later
library(lucode)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

# Use user name and model version defined in default.cfg for generating the titel
pr_flag <- "PR05"

# Grab user name
user <- Sys.info()[["user"]]
#version <- cfg$model_version ## Havong this somehow throws compilation errors in maccs module

cfg$results_folder <- "output/:title:"

cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev44_c200_690d3718e151be1b450b394c1064b1c5.tgz",
               "rev4.45MACC_h12_magpie.tgz",
               "rev4.45MACC_h12_validation.tgz",
               "calibration_H12_c200_26Feb20.tgz",
               "additional_data_rev3.81.tgz")


## Create a set of runs based on default.cfg
ssp <- "SSP2"
for(macc in c("PBL_2007","PBL_2019")) { 
  cfg$gms$c57_macc_source <- macc
  if (macc == "PBL_2007") cfg$gms$s56_limit_ch4_n2o_price <- 1000 else if (macc == "PBL_2019") cfg$gms$s56_limit_ch4_n2o_price <- 4000
  for (co2_price_path in c("BAU","POL")) {

    if (co2_price_path == "BAU") {
      cfg <- setScenario(cfg,c(ssp,"NPI"))
    } else if (co2_price_path == "POL"){
      cfg <- setScenario(cfg,c(ssp,"NDC"))
      cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600" #update to most recent coupled runs asap
      cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600" ##update to most recent coupled runs asap
    }

    cfg$title <- paste0(pr_flag,"_",user,"_",ssp,"-",co2_price_path,"_",macc) #Create easily distinguishable run title

    cfg$output <- c("rds_report") # Only run rds_report after model run

    start_run(cfg,codeCheck=TRUE) # Start MAgPIE run
  }
}
