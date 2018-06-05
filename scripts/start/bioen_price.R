# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")

cfg <- setScenario(cfg,"SSP2")

cfg$results_folder <- "output/:title:"
cfg$gms$c_timesteps <- 11
cfg$output <- c("report","validation","interpolation","LU_DiffPlots","LandusePlots")
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA0"
#cfg$gms$s15_elastic_demand = 0



#cfg$force_download <- TRUE
cfg$recalibrate <- TRUE


cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-noco2_rev29_h200_8a828c6ed5004e77d1ba2025e8ea2261.tgz",
               "rev3.15_8a828c6ed5004e77d1ba2025e8ea2261_magpie.tgz",
               "rev3.15_8a828c6ed5004e77d1ba2025e8ea2261_validation.tgz",
               "additional_data_rev3.27.tgz",
               "npi_ndc_base_SSP2_fixed.tgz")

cfg$title <- "fcostBIOold_mixed"
cfg$gms$factor_costs <- "mixed_feb17"
try(start_run(cfg=cfg, codeCheck=FALSE))

cfg$title <- "fcostBIOold_fixed"
cfg$gms$factor_costs <- "fixed_per_ton_mar18"
try(start_run(cfg=cfg, codeCheck=FALSE))



cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-noco2_rev29_h200_8a828c6ed5004e77d1ba2025e8ea2261.tgz",
               "rev3.15_8a828c6ed5004e77d1ba2025e8ea2261_magpie.tgz",
               "rev3.15_8a828c6ed5004e77d1ba2025e8ea2261_validation.tgz",
               "additional_data_rev3.28.tgz",
               "npi_ndc_base_SSP2_fixed.tgz")

cfg$title <- "fcostBIOnew_mixed"
cfg$gms$factor_costs <- "mixed_feb17"
try(start_run(cfg=cfg, codeCheck=FALSE))
file.copy(from = "scripts/npi_ndc/policies/npi_ndc_base.tgz",to = "output/npi_ndc_base_SSP2_mixed.tgz", overwrite = TRUE)

cfg$title <- "fcostBIOnew_fixed"
cfg$gms$factor_costs <- "fixed_per_ton_mar18"
try(start_run(cfg=cfg, codeCheck=FALSE))
file.copy(from = "scripts/npi_ndc/policies/npi_ndc_base.tgz",to = "output/npi_ndc_base_SSP2_fixed.tgz", overwrite = TRUE)
