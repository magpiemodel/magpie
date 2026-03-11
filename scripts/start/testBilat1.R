# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -------------------------------------------------------------
# description: default run with new yield realization and data
# ------------------------------------------------------------

library(gms)
library(lucode2)

source("scripts/start_functions.R")
source("config/default.cfg")
cfg$recalibrate_landconversion_cost <- "ifneeded" #def "ifneeded"

cfg$gms$sm_fix_SSP2 <- 2025
# change sm fix in trade module to 2010
cfg$force_download <- FALSE

cfg$input <- c(regional    = "rev4.129DCTradeH15_36ac4cfd_magpie_debug.tgz",
               cellular    = "rev4.129DCTradeH15_36ac4cfd_1b5c3817_cellularmagpie_debug_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1.tgz",
               validation  = "rev4.129DCTradeH15_36ac4cfd_92e02314_validation_debug.tgz",
               additional  = "additional_data_rev4.63.tgz",
               calibration = "calibration_H15_FAO_08Jan26.tgz")

cfg$gms$c60_2ndgen_biodem <- "R34M410-SSP2-NPi2025"     # def = R34M410-SSP2-NPi2025
cfg$gms$c60_2ndgen_biodem_noselect <- "R34M410-SSP2-NPi2025"     # def = R34M410-SSP2-NPi2025



#residues bioenergy demand off 
cfg$gms$c60_res_2ndgenBE_dem <- "ssp2"     # def = ssp2

cfg$gms$croparea    <- "detail_apr24"               # def = simple_apr24


 cfg$info$flag <- "0902Feb_H15Scen_FAOCalib_SSP3npirollback_exoTAU"
# support function to create standardized title
.title <- function(cfg, ...) return(paste(cfg$info$flag, sep = "_", ...))

ssp_params <- data.frame(
  ssp = c("SSP1", "SSP2", "SSP3", "SSP4", "SSP5"),
  stddev_lib = c(2, 1.0, 0.5, 1.0, 2.0),
  import_supply = c(0.5, 1.0, 0.5, 2.0, 2.0),
  tariff_fadeout = c(0, 0, 0, 0, 0),
  stringsAsFactors = FALSE
)

#ssp3 above used to be 0.5, 0.5 but changed to 1 to then allow for trade disruptions

#for (ssp in c("SSP1", "SSP2", "SSP3", "SSP4", "SSP5")) {
  for (ssp in c("SSP3")){ #,"SSP4")) {

     cfg$gms$trade <- "selfsuff_reduced"
      cfg$title <- .title(cfg, paste("NOBilat", ssp, sep = "-"))
 
 #  cfg <- setScenario(cfg, c(ssp, "NPI", "rcp4p5"))


cfg$gms$c32_aff_policy <- "npi"
cfg$gms$c35_ad_policy <- "npi"
cfg$gms$c35_aolc_policy <- "npi"

cfg$gms$s22_base_protect_reversal <- 2030   # def = Inf (no reversal)
cfg$gms$s32_npi_ndc_reversal <- 2030          # def = Inf
cfg$gms$s35_npi_ndc_reversal <- 2030          # def = Inf


    if (ssp == "SSP4") { 
      sspi <- ssp
      ssp <- "SSP2"
    } else {
      sspi <- ssp
    }


    cfg$gms$c56_pollutant_prices <- paste0("R34M410-SSP3-rollBack")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-SSP3-rollBack")
  #cfg$gms$c56_mute_ghgprices_until <- "y2100" #noghg prices




#    start_run(cfg, codeCheck = FALSE)

       if (sspi == "SSP4") { 
       ssp <- sspi
    }

    cfg$gms$trade <- "selfsuff_reduced_bilateral22"
    # Get parameters from mapping
cfg$gms$tc <- "exo"              # def = endo_jan22

    cfg$gms$s21_trade_tariff_fadeout <- ssp_params$tariff_fadeout[ssp_params$ssp == ssp]
    cfg$gms$s21_tariff_factor <- 1
    cfg$gms$s21_stddev_lib_factor <- ssp_params$stddev_lib[ssp_params$ssp == ssp]
    cfg$gms$s21_import_supply_scenario <- ssp_params$import_supply[ssp_params$ssp == ssp]
    cfg$gms$s21_stddev_lib_factor <- 1
    cfg$gms$s21_trade_scenario_adjustments <- 0

cfg$title <- .title(cfg, paste("NOPOL", ssp, sep = "-"))

#start_run(cfg, codeCheck = FALSE)


          #### DIET OPTIONS #########
          cfg$gms$s15_exo_diet <- 3               # def = 0

          cfg$title <- .title(cfg, paste("EATall", ssp, sep = "-"))
           # start_run(cfg, codeCheck = FALSE)

         cfg$gms$scen_countries15  <- "ALA, AUT, BEL, BGR, CYP, CZE, DEU, DNK, ESP, EST, FIN, FRA, FRO, GBR, GGY, GIB, GRC, HRV, HUN, IMN, IRL, ITA, JEY, LTU, LUX, LVA, MLT, NLD, POL, PRT, ROU, SVK, SVN, SWE"
         cfg$title <- .title(cfg, paste("EATeur", ssp, sep = "-"))
        # start_run(cfg, codeCheck = FALSE)
         cfg$gms$s15_exo_diet <- 0               # def = 0
           #### Diet OPTIONS END #########


               # Loop through the three bilateral trade scenarios: USAex, CHAdom, EURex

  for (bilat_scen in c("USAex", "CHAdom", "EURex")) {
      cfg$gms$s21_trade_scenario_adjustments <- 1
    cfg$gms$c21_bilat_trade_scen <- bilat_scen
    cfg$title <- .title(cfg, paste(bilat_scen, ssp, sep = "-"))
   #start_run(cfg, codeCheck = FALSE)
  }

}


###############################################################################
# ScenarioMIP scenarios as bilateral trade runs
# Based on project_ScenarioMIP.R but with:
#   - selfsuff_reduced_bilateral22 (instead of selfsuff_reduced)
#   - endogenous tau (default endo_jan22, NOT exo)
#   - s21_trade_scenario_adjustments = 0 (no geopolitical adjustments)
###############################################################################

# Re-source default cfg to get a clean slate
source("config/default.cfg")
cfg$force_download <- FALSE
cfg$recalibrate_landconversion_cost <- "ifneeded"

# Use the H15 bilateral trade input data
cfg$input <- c(regional    = "rev4.129DCTradeH15_36ac4cfd_magpie_debug.tgz",
               cellular    = "rev4.129DCTradeH15_36ac4cfd_1b5c3817_cellularmagpie_debug_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1.tgz",
               validation  = "rev4.129DCTradeH15_36ac4cfd_92e02314_validation_debug.tgz",
               additional  = "additional_data_rev4.63.tgz",
               calibration = "calibration_H15_FAO_08Jan26.tgz")


# Common settings across all ScenarioMIP bilateral runs
cfg$info$flag <- "0903Bilat_ScenMIP"

.title <- function(cfg, ...) return(paste(cfg$info$flag, sep = "_", ...))

cfg$gms$cropland    <- "detail_apr24"
cfg$gms$som         <- "cellpool_jan23"
cfg$gms$c60_res_2ndgenBE_dem <- "ssp2"     # def = ssp2
cfg$gms$s15_elastic_demand <- 1
cfg$gms$s56_limit_ch4_n2o_price <- 734
cfg$gms$s32_annual_aff_limit <- 0.03

# Bilateral trade settings (common to all SMIP bilateral runs)
cfg$gms$trade <- "selfsuff_reduced_bilateral22"
# tc stays at default endo_jan22 (endogenous tau)
cfg$gms$s21_trade_tariff_fadeout <- 0
cfg$gms$s21_tariff_factor <- 1
cfg$gms$s21_stddev_lib_factor <- 1
cfg$gms$s21_import_supply_scenario <- 1
cfg$gms$s21_trade_scenario_adjustments <- 0


### H-SSP3-rollBack (bilateral)
cfg$title <- .title(cfg, "H-SSP3-rollBack")
cfg <- setScenario(cfg, c("SSP3", "NPI-revert", "AR-natveg", "nocc_hist"))
#cfg$gms$c56_pollutant_prices <- "coupling"
#cfg$gms$c60_2ndgen_biodem <- "coupling"
cfg$gms$c56_mute_ghgprices_until <- "y2150"
#cfg$path_to_report_ghgprices    <- "input/REMIND_generic_C_SMIPv06-H-SSP3-rollBack-def-rem-7.mif"
#cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv06-H-SSP3-rollBack-def-rem-7.mif"
cfg$gms$c15_food_scenario <- "SSP2"
cfg$gms$s32_npi_ndc_reversal <- 2030
cfg$gms$s35_npi_ndc_reversal <- 2030
cfg$gms$s29_treecover_target <- 0
cfg$gms$s44_bii_target <- 0
cfg$gms$c44_bii_decrease <- 1
cfg$gms$s44_start_year <- 2030
cfg$gms$s56_fader_cpriceaff_start <- 2030
cfg$gms$s56_fader_cpriceaff_end <- 2030
cfg$gms$s59_scm_target <- 0
cfg$gms$c60_1stgen_biodem <- "const2030"
# Re-apply bilateral trade settings (setScenario may overwrite trade)
cfg$gms$trade <- "selfsuff_reduced_bilateral22"
cfg$gms$s21_trade_scenario_adjustments <- 0
# SSP3 trade params
cfg$gms$s21_stddev_lib_factor <- 0.5
cfg$gms$s21_import_supply_scenario <- 0.5
cfg$gms$s21_trade_tariff_fadeout <- 0
start_run(cfg, codeCheck = FALSE)


### M-SSP2-NPi2025 (bilateral)
cfg$title <- .title(cfg, "M-SSP2-NPi2025")
cfg <- setScenario(cfg, c("SSP2", "NPI", "AR-natveg", "nocc_hist"))
#cfg$gms$c56_pollutant_prices <- "coupling"
#cfg$gms$c60_2ndgen_biodem <- "coupling"
cfg$gms$c56_mute_ghgprices_until <- "y2150"
#cfg$path_to_report_ghgprices    <- "input/REMIND_generic_C_SMIPv06-M-SSP2-NPi2025-def-rem-7.mif"
#cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv06-M-SSP2-NPi2025-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0
cfg$gms$s44_bii_target <- 0
cfg$gms$c44_bii_decrease <- 1
cfg$gms$s44_start_year <- 2030
cfg$gms$s56_fader_cpriceaff_start <- 2030
cfg$gms$s56_fader_cpriceaff_end <- 2030
cfg$gms$s59_scm_target <- 0
cfg$gms$c60_1stgen_biodem <- "const2030"
# Re-apply bilateral trade settings
cfg$gms$trade <- "selfsuff_reduced_bilateral22"
cfg$gms$s21_trade_scenario_adjustments <- 0
# SSP2 trade params
cfg$gms$s21_stddev_lib_factor <- 1.0
cfg$gms$s21_import_supply_scenario <- 1.0
cfg$gms$s21_trade_tariff_fadeout <- 0
start_run(cfg, codeCheck = FALSE)


### VLLO-SSP1-PkBudg650 (bilateral)
cfg$title <- .title(cfg, "VLLO-SSP1-PkBudg650")
cfg <- setScenario(cfg, c("VLLO", "NDC", "AR-natveg", "nocc_hist"))
#cfg$gms$c56_pollutant_prices <- "coupling"
#cfg$gms$c60_2ndgen_biodem <- "coupling"
cfg$gms$c56_mute_ghgprices_until <- "y2150"
#cfg$path_to_report_ghgprices    <- "input/REMIND_generic_C_SMIPv06-VLLO-SSP1-PkPrice500-def-rem-7.mif"
#cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv06-VLLO-SSP1-PkPrice500-def-rem-7.mif"
cfg$gms$s29_treecover_scenario_start <- 2025
cfg$gms$s29_treecover_scenario_target <- 2050
cfg$gms$s29_treecover_target <- 0.03
cfg$gms$s44_bii_target <- 0.7
cfg$gms$c44_bii_decrease <- 1
cfg$gms$s44_start_year <- 2030
cfg$gms$s56_fader_cpriceaff_start <- 2030
cfg$gms$s56_fader_cpriceaff_end <- 2030
cfg$gms$s59_scm_scenario_start <- 2025
cfg$gms$s59_scm_scenario_target <- 2050
cfg$gms$s59_scm_target <- 0.3
cfg$gms$c60_1stgen_biodem <- "const2030"
# Re-apply bilateral trade settings
cfg$gms$trade <- "selfsuff_reduced_bilateral22"
cfg$gms$s21_trade_scenario_adjustments <- 0
# SSP1 trade params
cfg$gms$s21_stddev_lib_factor <- 2.0
cfg$gms$s21_import_supply_scenario <- 0.5
cfg$gms$s21_trade_tariff_fadeout <- 0
start_run(cfg, codeCheck = FALSE)


###############################################################################
# End ScenarioMIP bilateral scenarios
###############################################################################

# Add to `config/default.cfg`:
# ```r
# cfg$gms$s21_intrabloc_lib_factor <- 2
# cfg$gms$s21_crossbloc_trade_factor <- 0
# cfg$gms$s21_intrabloc_tariff_factor <- 0
# cfg$gms$s21_bloc_scenario_startyear <- 2025
# ```

# ## Scenario Examples

# ### Scenario 1: Trade Fragmentation (Decoupling)
# Cross-bloc trade collapses, intra-bloc trade increases:
# ```r
# s21_intrabloc_lib_factor <- 3      # Triple flexibility within bloc
# s21_crossbloc_trade_factor <- 0    # Cross-bloc can go to zero
# s21_intrabloc_tariff_factor <- 0   # No tariffs within bloc
# ```

# ### Scenario 2: Partial Fragmentation
# Cross-bloc trade reduced but not eliminated:
# ```r
# s21_intrabloc_lib_factor <- 2
# s21_crossbloc_trade_factor <- 0.5  # 50% of normal minimum
# s21_intrabloc_tariff_factor <- 0
# ```

# ### Scenario 3: Bloc Formation Only (No Cross-Bloc Restriction)
# Blocs form with internal free trade, but cross-bloc trade unchanged:
# ```r
# s21_intrabloc_lib_factor <- 2
# s21_crossbloc_trade_factor <- 1    # Normal cross-bloc trade
# s21_intrabloc_tariff_factor <- 0   # No tariffs within bloc
# ```

# ## Equation Logic

# ### Intra-Bloc Trade (`q21_trade_lower_intrabloc`)
# - Applied when `p21_same_bloc(i_ex,i_im) = 1`
# - Uses `i21_intrabloc_lib_factor` to widen the trade cone
# - Tariffs calculated with `i21_trade_tariff_bloc` (can be zero)

# ### Cross-Bloc Trade (`q21_trade_lower_crossbloc`)
# - Applied when `p21_cross_bloc(i_ex,i_im) = 1`
# - Entire lower bound multiplied by `i21_crossbloc_trade_factor`
# - When factor = 0, minimum trade = 0 (can decouple completely)





cfg$title   <- paste0("0910_TestBilat_newFAO_defSSP2")
cfg$gms$trade <- "selfsuff_reduced_bilateral22"             # def = selfsuff_reduced
cfg$gms$s21_trade_tariff_fadeout <- 0
cfg$gms$s21_tariff_factor <- 1
cfg$gms$s21_stddev_lib_factor <- 1
cfg$gms$s21_import_supply_scenario <- 1

# start_run(cfg=cfg)



cfg$title   <- paste0("0910_TestBilat_newFAO_SSP1_15stddev")
cfg$gms$trade <- "selfsuff_reduced_bilateral22"             # def = selfsuff_reduced
cfg$gms$s21_trade_tariff_fadeout <- 0
cfg$gms$s21_tariff_factor <- 1
cfg$gms$s21_stddev_lib_factor <- 1.5
cfg$gms$s21_import_supply_scenario <- 0.5
#start_run(cfg=cfg)


cfg$title   <- paste0("0910_TestBilat_newFAO_SSP3")
cfg$gms$trade <- "selfsuff_reduced_bilateral22"             # def = selfsuff_reduced
cfg$gms$s21_trade_tariff_fadeout <- 0
cfg$gms$s21_tariff_factor <- 1
cfg$gms$s21_stddev_lib_factor <- 0.5
cfg$gms$s21_import_supply_scenario <- 0.5
#start_run(cfg=cfg)



cfg$title   <- paste0("0910_TestBilat_newFAO_SSP4")
cfg$gms$trade <- "selfsuff_reduced_bilateral22"             # def = selfsuff_reduced
cfg$gms$s21_trade_tariff_fadeout <- 0
cfg$gms$s21_tariff_factor <- 1
cfg$gms$s21_stddev_lib_factor <- 1
cfg$gms$s21_import_supply_scenario <- 2  
#start_run(cfg=cfg)


cfg$title   <- paste0("0910_TestBilat_newFAO_SSP5")
cfg$gms$trade <- "selfsuff_reduced_bilateral22"             # def = selfsuff_reduced
cfg$gms$s21_trade_tariff_fadeout <- 0
cfg$gms$s21_tariff_factor <- 1
cfg$gms$s21_stddev_lib_factor <- 2
cfg$gms$s21_import_supply_scenario <- 2
 #start_run(cfg=cfg)


# cfg$title   <- paste0("1312BilatImportRatio_RotConstraint_NoTariff")


# cfg$gms$croparea    <- "detail_apr24"               # def = simple_apr24
# cfg$gms$s30_rotation_scenario_start <- 2015    # def = 2025
# cfg$gms$s30_implementation <- 0   # def = 0
