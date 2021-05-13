# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
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

# set defaults
codeCheck <- FALSE

scenNames <- c("SSP2_NPI_base_LPJmL5", "SSP2_BiodivPol_LPJmL5", "SSP2_BiodivPol+CO2price_LPJmL5", "SSP2_BiodivPol+CO2price+NCP_LPJmL5")

for (scen in scenNames) {

source("config/default.cfg")
source("scripts/start/extra/lpjml_addon.R")

cfg$input <- c("additional_data_rev4.02.tgz",
               "rev4.59newparam_h12_magpie_debug.tgz",
               "rev4.59newparam_h12_c5cdbf33_cellularmagpie_debug.tgz",
               "rev4.59newparam_h12_validation_debug.tgz",
               "patch_protection_fader.tgz")

cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,
                                "../patch_inputdata"=NULL),
                                getOption("magpie_repos"))

cfg <- setScenario(cfg,"nocc")

cfg$force_download <- TRUE
cfg$recalibrate    <- TRUE
cfg$gms$crop       <- "endo_apr21"

cfg$gms$factor_costs <- "sticky_feb18"
#cfg$gms$c38_sticky_mode  <- "dynamic"

   if (scen == "SSP2_NPI_base_LPJmL5") {

      # basic scenario setting
      cfg <- setScenario(cfg, c("SSP2", "NPI"))
      # tc
      cfg$gms$c13_tccost <- "medium"
      # forestry & natveg
      cfg$gms$s32_planing_horizon <- 50
      # ghg
      cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
      cfg$gms$c56_emis_policy <- "redd+natveg_nosoil"
      # bioenergy setting
      cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"

      #marginal land scenario
      cfg$gms$c30_marginal_land <- "q33_marginal"


   } else if (scen == "SSP2_BiodivPol_LPJmL5") {

      # basic scenario setting
      cfg <- setScenario(cfg, c("SSP2", "NPI"))
      # tc
      cfg$gms$c13_tccost <- "medium"
      # forestry & natveg
      cfg$gms$s32_planing_horizon <- 50
      # ghg
      cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
      cfg$gms$c56_emis_policy <- "redd+natveg_nosoil"
      # bioenergy setting
      cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"

      #marginal land scenario
      cfg$gms$c30_marginal_land <- "q33_marginal"

      # protected areas
      cfg$gms$c35_protect_scenario <- "Forest+BH"

   } else if (scen == "SSP2_BiodivPol+CO2price_LPJmL5") {

      # basic scenario setting
      cfg <- setScenario(cfg, c("SSP2", "NDC"))
      # tc
      cfg$gms$c13_tccost <- "medium"
      # forestry & natveg
      cfg$gms$s32_planing_horizon <- 50
      # ghg
      cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
      cfg$gms$c56_emis_policy <- "redd+natveg_nosoil"
      # bioenergy setting
      cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"

      #marginal land scenario
      cfg$gms$c30_marginal_land <- "q33_marginal"

      # protected areas
      cfg$gms$c35_protect_scenario <- "Forest+BH"

   } else if (scen == "SSP2_BiodivPol+CO2price+NCP_LPJmL5") {

      # basic scenario setting
      cfg <- setScenario(cfg, c("SSP2", "NDC"))
      # tc
      cfg$gms$c13_tccost <- "medium"
      # forestry & natveg
      cfg$gms$s32_planing_horizon <- 50
      # ghg
      cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
      cfg$gms$c56_emis_policy <- "redd+natveg_nosoil"
      # bioenergy setting
      cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"

      #marginal land scenario
      cfg$gms$c30_marginal_land <- "q33_marginal"

      # protected areas
      cfg$gms$c35_protect_scenario <- "Forest+BH"

      # set aside share
      cfg$gms$s30_set_aside_shr <- 0.2
      # target year
      cfg$gms$c30_set_aside_target <- "by2030"

   }

#cfg$title <- paste0(scen,"_q66")
cfg$title <- paste0(scen,"_sticky")
#cfg$title <- scen
start_run(cfg = cfg, codeCheck = codeCheck)

}
