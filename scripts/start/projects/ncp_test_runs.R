# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

##########################################################
#### Script for SEALS scenario test runs ####
##########################################################

library(lucode2)
library(magclass)
library(gms)

source("scripts/start_functions.R")
source("scripts/performance_test.R")

# set defaults
codeCheck <- FALSE

scenNames <- c("SSP2_NPI_base", "SSP2_CCpolicy", "SSP2_CCpolicy_plant", "SSP2_CCredd", "SSP2_CCall", "SSP2_CCpolicy_NCP2030",
               "SSP2_CCpolicy_NCP2050", "SSP2_CCredd_NCP2030", "SSP2_CCredd_NCP2050", "SSP2_CCall_NCP", "SSP2_PA_full")

for (scen in scenNames) {

   source("config/default.cfg")

   if (scen == "SSP2_NPI_base") {

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


   } else if (scen == "SSP2_CCpolicy") {

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

   } else if (scen == "SSP2_CCpolicy_plant") {

      # basic scenario setting
      cfg <- setScenario(cfg, c("SSP2", "NDC"))
      # tc
      cfg$gms$c13_tccost <- "medium"
      # forestry & natveg
      cfg$gms$s32_planing_horizon <- 50
      cfg$gms$s32_aff_plantation <- 1
      # ghg
      cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
      cfg$gms$c56_emis_policy <- "redd+natveg_nosoil"
      # bioenergy setting
      cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"

      #marginal land scenario
      cfg$gms$c30_marginal_land <- "q33_marginal"

   } else if (scen == "SSP2_CCredd") {

      # basic scenario setting
      cfg <- setScenario(cfg, c("SSP2", "NDC"))
      # tc
      cfg$gms$c13_tccost <- "medium"
      # forestry & natveg
      cfg$gms$s32_planing_horizon <- 50
      # ghg
      cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
      cfg$gms$c56_emis_policy <- "redd+_nosoil"
      # bioenergy setting
      cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"

      #marginal land scenario
      cfg$gms$c30_marginal_land <- "q33_marginal"

   } else if (scen == "SSP2_CCall") {

      # basic scenario setting
      cfg <- setScenario(cfg, c("SSP2", "NDC"))
      # tc
      cfg$gms$c13_tccost <- "medium"
      # forestry & natveg
      cfg$gms$s32_planing_horizon <- 50
      # ghg
      cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
      cfg$gms$c56_emis_policy <- "all"
      # bioenergy setting
      cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"

      #marginal land scenario
      cfg$gms$c30_marginal_land <- "q33_marginal"

   } else if (scen == "SSP2_CCpolicy_NCP2030") {

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

      # set aside share
      cfg$gms$s30_set_aside_shr <- 0.2
      # target year
      cfg$gms$c30_set_aside_target <- "by2030"

   } else if (scen == "SSP2_CCpolicy_NCP2050") {

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

      # set aside share
      cfg$gms$s30_set_aside_shr <- 0.2
      # target year
      cfg$gms$c30_set_aside_target <- "by2050"

   } else if (scen == "SSP2_CCredd_NCP2030") {

      # basic scenario setting
      cfg <- setScenario(cfg, c("SSP2", "NDC"))
      # tc
      cfg$gms$c13_tccost <- "medium"
      # forestry & natveg
      cfg$gms$s32_planing_horizon <- 50
      # ghg
      cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
      cfg$gms$c56_emis_policy <- "redd+_nosoil"
      # bioenergy setting
      cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"

      #marginal land scenario
      cfg$gms$c30_marginal_land <- "q33_marginal"

      # set aside share
      cfg$gms$s30_set_aside_shr <- 0.2
      # target year
      cfg$gms$c30_set_aside_target <- "by2030"

   } else if (scen == "SSP2_CCredd_NCP2050") {

      # basic scenario setting
      cfg <- setScenario(cfg, c("SSP2", "NDC"))
      # tc
      cfg$gms$c13_tccost <- "medium"
      # forestry & natveg
      cfg$gms$s32_planing_horizon <- 50
      # ghg
      cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
      cfg$gms$c56_emis_policy <- "redd+_nosoil"
      # bioenergy setting
      cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"

      #marginal land scenario
      cfg$gms$c30_marginal_land <- "q33_marginal"

      # set aside share
      cfg$gms$s30_set_aside_shr <- 0.2
      # target year
      cfg$gms$c30_set_aside_target <- "by2050"

   } else if (scen == "SSP2_CCall_NCP") {

      # basic scenario setting
      cfg <- setScenario(cfg, c("SSP2", "NDC"))
      # tc
      cfg$gms$c13_tccost <- "medium"
      # forestry & natveg
      cfg$gms$s32_planing_horizon <- 50
      # ghg
      cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
      cfg$gms$c56_emis_policy <- "all"
      # bioenergy setting
      cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"

      #marginal land scenario
      cfg$gms$c30_marginal_land <- "q33_marginal"

      # set aside share
      cfg$gms$s30_set_aside_shr <- 0.2
      # target year
      cfg$gms$c30_set_aside_target <- "by2030"

   } else if (scen == "SSP2_PA_full") {

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
      cfg$gms$c35_protect_scenario <- "full"

   }

   cfg$title <- scen
   start_run(cfg = cfg, codeCheck = codeCheck)
}

