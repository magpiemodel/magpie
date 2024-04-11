# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test routine for standardized test runs
# position: 5
# ----------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

#download default input data
#download_and_update(cfg)

# create additional information to describe the runs
cfg$info$flag <- "H100" 

cfg$output <- c("rds_report") # "extra/highres_country"
cfg$results_folder <- "output/:title:"
cfg$force_replace <- TRUE

# support function to create standardized title
.title <- function(...) return(paste(cfg$info$flag, sep="_",...))

#Reference and Policy run for SSP1, SSP2 and SSP5
for(ssp in c("SSP2")) {
          cfg$title <- .title(paste(ssp,"Ref",sep="-"))
          cfg <- setScenario(cfg,c(ssp,"NPI","rcp7p0"))
          cfg$gms$c56_pollutant_prices <- paste0("R21M42-",ssp,"-NPi")
          cfg$gms$c60_2ndgen_biodem    <- paste0("R21M42-",ssp,"-NPi")
          
          cfg$gms$processing <- "off"
          cfg$gms$residues <- "off"
#          cfg$gms$nr_soil_budget <- nr_soil_budget
          cfg$gms$disagg_lvst <- "off"
          # #H40
          # cfg$input["cellular"] <- "rev4.65_76adaf1c_1998ea10_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz"
          # cfg$input["validation"] <- "rev4.65_76adaf1c_validation.tgz"
          # cfg$input["regional"] <- "rev4.65_76adaf1c_magpie.tgz"
          # cfg$input["calibration"] <- "calibration_H40_23Dec21.tgz"
          #H100
          cfg$input["cellular"] <- "rev4.65_6755efa7_1998ea10_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz"
          cfg$input["validation"] <- "rev4.65_6755efa7_validation.tgz"
          cfg$input["regional"] <- "rev4.65_6755efa7_magpie.tgz"
          cfg$input["calibration"] <- "calibration_H100_26Dec21.tgz"
          
          cfg$recalibrate_landconversion_cost <- TRUE
          cfg$recalibrate <- TRUE
          # cfg$calib_maxiter <- 5
          # cfg$calib_maxiter_landconversion_cost <- 5
          
          download_and_update(cfg)
          Sys.sleep(3)
          if (file.exists("modules/14_yields/input/f14_yld_calib.csv")) file.remove("modules/14_yields/input/f14_yld_calib.csv")
          Sys.sleep(2)
          
          start_run(cfg, codeCheck = FALSE)
}
