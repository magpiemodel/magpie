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
cfg$recalibrate = FALSE

#cfg$gms$sm_fix_SSP2 <- 2025
# change sm fix in trade module to 2010
cfg$force_download <- FALSE


# cfg$input <- c(regional    = "rev4.129DCTradeBlocs_ff7773cc_magpie_debug.tgz",
#                cellular    = "rev4.129DCTradeBlocs_ff7773cc_1b5c3817_cellularmagpie_debug_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1.tgz",
#                validation  = "rev4.129DCTradeBlocs_ff7773cc_92e02314_validation_debug.tgz",
#                additional  = "additional_data_rev4.63.tgz")
# #               calibration = "calibration_H12_FAO_18Sep25.tgz")


#fix TC? 


#residues bioenergy demand off 
cfg$gms$c60_res_2ndgenBE_dem <- "ssp2"     # def = ssp2
# cap those above 1 if newly above 1, re-distribute

cfg$gms$croparea    <- "detail_apr24"               # def = simple_apr24
 cfg$info$flag <- "26TestBilatNOPol"
# support function to create standardized title
.title <- function(cfg, ...) return(paste(cfg$info$flag, sep = "_", ...))


ssp_params <- data.frame(
  ssp = c("SSP1", "SSP2", "SSP3", "SSP4", "SSP5"),
  stddev_lib = c(1.5, 1.0, 0.5, 1.0, 2.0),
  import_supply = c(0.5, 1.0, 0.5, 2.0, 2.0),
  tariff_fadeout = c(0, 0, 0, 0, 0),
  stringsAsFactors = FALSE
)

#for (ssp in c("SSP1", "SSP2", "SSP3", "SSP4", "SSP5")) {
  for (ssp in c("SSP2")){ #,"SSP4")) {

     cfg$gms$trade <- "selfsuff_reduced"
    cfg$title <- .title(cfg, paste("OFF", ssp, "NPi2025", sep = "-"))
 #   cfg <- setScenario(cfg, c(ssp, "NPI", "rcp4p5"))
    cfg$gms$c56_mute_ghgprices_until <- "y2150"
    cfg$gms$c56_mute_ghgprices_until <- "y2100"

    if (ssp == "SSP4") { 
      sspi <- ssp
      ssp <- "SSP2"
    } else {
      sspi <- ssp
    }
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-", ssp, "-NPi2025")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-", ssp, "-NPi2025")
   # start_run(cfg, codeCheck = FALSE)

       if (sspi == "SSP4") { 
       ssp <- sspi
    }

   cfg$title <- .title(cfg, paste("ON_minWindow_H12_noCellLivst", ssp, sep = "-"))
    cfg$gms$trade <- "selfsuff_reduced_bilateral22"
    # Get parameters from mapping


cfg$gms$disagg_lvst <- "off"                  # def = foragebased_jul23

    cfg$gms$s21_trade_tariff_fadeout <- ssp_params$tariff_fadeout[ssp_params$ssp == ssp]
    cfg$gms$s21_tariff_factor <- 1
    cfg$gms$s21_stddev_lib_factor <- ssp_params$stddev_lib[ssp_params$ssp == ssp]
    cfg$gms$s21_import_supply_scenario <- ssp_params$import_supply[ssp_params$ssp == ssp]
    cfg$gms$s21_trade_scenario_adjustments <- 0

    #cfg$gms$s21_trade_tariff_fadeout <- 1
     start_run(cfg, codeCheck = FALSE)
}




# ### Step 3: Add scalars to config

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
