# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(gms)
source("scripts/start_functions.R")
source("config/default.cfg")

cfg$input <- c("rev4.47+mrmagpie7_h12_magpie_debug.tgz",
               "rev4.47+mrmagpie7_h12_238dd4e69b15586dde74376b6b84cdec_cellularmagpie_debug.tgz",
               "rev4.47+mrmagpie7_h12_validation_debug.tgz",
               "additional_data_rev3.85.tgz")

cfg$gms$yields    <- "managementcalib_aug19"
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

      cfg$title <- paste0("newlpjml_",names(fc_real[i]),"_",cc_nocc,"_",co2_price_path) 
      start_run(cfg,codeCheck=TRUE) # Start MAgPIE run
      cat(cfg$title)
    }
  }
}

