# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
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

#start MAgPIE run
source("config/default.cfg")

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"

identifier_flag <- "PR03"
cfg$gms$s73_price_adjuster <- 0
cfg$recalc_npi_ndc <- TRUE

for(ssp in c("SSP2")){

  for(c32_rotation_extension in c(0)){

    cfg$gms$c32_rotation_extension <- c32_rotation_extension

    cfg <- setScenario(cfg,c(ssp,"NPI"))

    for (co2_price_path in c("NPI","2deg")) {

      cfg$gms$c56_pollutant_prices <- "coupling"
      cfg$gms$c60_2ndgen_biodem <- "coupling"

      file.copy(from = paste0("input/input_bioen_dem_",co2_price_path,".csv"), to = "modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv",overwrite = TRUE)
      file.copy(from = paste0("input/input_ghg_price_",co2_price_path,".cs3"), to = "modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3",overwrite = TRUE)

      ### Create flags

      rot_flag <- paste0(c32_rotation_extension*5,"yE")

      cfg$title <- paste0(identifier_flag,"_",ssp,"_",rot_flag,"_",co2_price_path)

      cfg$output <- c("rds_report")

      start_run(cfg,codeCheck=FALSE)
    }
  }
}
