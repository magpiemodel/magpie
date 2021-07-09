# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test rountine for standardized test runs
# position: 5
# ----------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

prefix <- "RC10"

for (version in c("new")) {
  if (version == "old") {
    source("config/default.cfg")
    cfg$results_folder <- "output/:title:"
    cfg$output <- c("rds_report")
    cfg$gms$s80_optfile <- 1
    
    cfg$title <- paste(prefix,"SSP2-NPI",version,sep="_")
    cfg <- setScenario(cfg,c("SSP2","NPI"))
    cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
    cfg$gms$c60_2ndgen_biodem    <- "R2M41-SSP2-NPi"
    print(cfg$title)
    start_run(cfg,codeCheck=FALSE)
    
    cfg$title <- paste(prefix,"SSP2-1p5deg",version,sep="_")
    cfg <- setScenario(cfg,c("SSP2","NDC"))
    cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
    cfg$gms$c60_2ndgen_biodem    <- "R2M41-SSP2-Budg600"
    print(cfg$title)
    #start_run(cfg,codeCheck=FALSE)
    
  } else if (version == "new") {
    source("config/default.cfg")
    source("scripts/start/extra/lpjml_addon.R")
    cfg$results_folder <- "output/:title:"
    cfg$output <- c("rds_report")
    cfg$gms$s80_optfile <- 1
    #"mixed","sticky",
    for (cost in c("fixed")) {
      if (cost == "mixed") {
        cfg$gms$factor_costs <- "mixed_feb17"
        cfg$input['calibration'] = "calibration_H12_newlpjml_bestcalib_fc-mixed_crop-endoApr21_20May21.tgz"
      } else if (cost == "sticky") {
        cfg$gms$factor_costs <- "sticky_feb18"
        cfg$gms$c38_sticky_mode <- "dynamic"
        cfg$input['calibration'] = "calibration_H12_newlpjml_bestcalib_fc-sticky-dynamic_crop-endoApr21-allM_20May21.tgz"
      } else if (cost == "fixed") {
        cfg$gms$factor_costs <- "sticky_feb18"
        cfg$gms$c38_sticky_mode <- "free"
        cfg$input['calibration'] = "calibration_H12_newlpjml_bestcalib_fc-sticky-free_crop-endoApr21_20May21.tgz"
      }
      
      for (calib_int in c(1)) {
        cfg$title <- paste(prefix,"SSP2-NPI",version,"LConDev3",sep="_")
        cfg <- setScenario(cfg,c("SSP2","NPI","rcp7p0"))
        cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
        cfg$gms$c60_2ndgen_biodem    <- "R2M41-SSP2-NPi"
        cfg$gms$s12_interest_calib <- calib_int
        print(cfg$title)
        start_run(cfg,codeCheck=FALSE)
      }
      
      cfg$title <- paste(prefix,"SSP2-1p5deg",version,paste0("CalibInt",calib_int),sep="_")
      cfg <- setScenario(cfg,c("SSP2","NDC","rcp1p9"))
      cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
      cfg$gms$c60_2ndgen_biodem    <- "R2M41-SSP2-Budg600"
      print(cfg$title)
      #start_run(cfg,codeCheck=FALSE)
      
    }
  }
}
