# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(lucode)
source("scripts/start_functions.R")
source("config/default.cfg")

buildInputVector <- function(regionmapping   = "h12",
                             project_name    = "isimip_rcp",
                             climatescen_name= "rcp2p6",
                             co2             = "co2",
                             climate_model   = "HadGEM2_ES",
                             resolution      = "c200",
                             archive_rev     = "46",
                             madrat_rev      = "4.47+mrmagpie7",
                             validation_rev  = "4.47+mrmagpie7",
                             additional_data = "additional_data_rev3.85.tgz") {
  mappings <- c(h11="8a828c6ed5004e77d1ba2025e8ea2261",
                h12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a",
                inms="1ffb3a6fd3ac74779d7fb03a215fbec6",
                inms2="ef2ae7cd6110d5d142a9f8bd7d5a68f2",
                agmip="c77f075908c3bc29bdbe1976165eccaf")
  archive_name=paste(project_name,climate_model,climatescen_name,co2,sep="-")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings[regionmapping], ".tgz")
  madrat  <- paste0("rev", madrat_rev,"_", mappings[regionmapping], "_magpie_debug.tgz")
  validation  <- paste0("rev",validation_rev,"_", mappings[regionmapping], "_validation_debug", ".tgz")
  return(c(archive,madrat,validation,additional_data))
}
#cfg$input <- buildInputVector()
cfg$input <- c("rev4.47+mrmagpie7_h12_magpie_debug.tgz",
               "rev4.47+mrmagpie7_h12_238dd4e69b15586dde74376b6b84cdec_cellularmagpie_debug.tgz",
               "rev4.47+mrmagpie7_h12_validation_debug.tgz",
               "additional_data_rev3.85.tgz")


cfg$gms$forestry  <- "static_sep16"

fc_real <- c(mixed="mixed_feb17",fixed="fixed_per_ton_mar18", sticky="sticky_feb18")

for(i in 1:length(fc_real)) {
  for(cc_nocc in c("nocc","cc")) {
    for (co2_price_path in c("BAU","POL")) {

      cfg$gms$factor_costs <- fc_real[i]
      cfg<-lucode::setScenario(cfg,cc_nocc)

      if (co2_price_path == "BAU") {
        cfg$recalibrate <- TRUE
        cfg <- setScenario(cfg,c("SSP2","NPI"))
        cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
        cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"

      } else if (co2_price_path == "POL"){
        cfg$recalibrate <- FALSE
        cfg <- setScenario(cfg,c("SSP2","NDC"))
        cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-26-REMIND-MAGPIE"
        cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-26-REMIND-MAGPIE"
      }

      cfg$title <- paste0("LpjmL_Test_",names(fc_real[i]),"_",cc_nocc,"_",co2_price_path)
      start_run(cfg,codeCheck=TRUE) # Start MAgPIE run
      cat(cfg$title)
    }
  }
}
