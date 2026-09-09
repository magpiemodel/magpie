# |  (C) 2008-2026 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Earth Commission stand-alone runs
# position: 3
# ----------------------------------------------------------


# ====================
# General setup
# ====================

# Load packages required for setScenario()
library(lucode2)
library(gms)

# Load start_run()
source("scripts/start_functions.R")


# ====================
# Project settings
# ====================

# Label for the version of EC scenario implementation
run_flag <- "ECv05"

# Project-specific MAgPIE scenario configuration
scenario_config_ec <- "config/projects/scenario_config_ec.csv"

# Scenarios included in the test matrix
policies_to_run <- c("NPi2025", "PkBudg1000", "PkBudg650")
pathways_to_run <- c("SSP2", "UF", "OC", "LM")


scenario_grid <- expand.grid(
  pathway = pathways_to_run,
  policy = policies_to_run,
  KEEP.OUT.ATTRS = FALSE,
  stringsAsFactors = FALSE
)

# Mapping from pathway labels used in run titles to the shorter column names
# in scenario_config_ec.csv.
ec_config_column <- c(
  UF = "EC-UF",
  OC = "EC-OC",
  LM = "EC-LM"
)

# Run the full code check for the first scenario only.
code_check_first_run <- TRUE

# Support function for standardized run titles
.make_title <- function(flag, pathway, policy) {
  paste(flag, pathway, policy, sep = "_")
}


# ====================
# Scenario runs
# ====================

# Climate-policy variants:
# NPi2025: continuation of current climate policies
# PkBudg1000: ambitious climate policy broadly in line with 2deg C Paris target
# PkBudg650: ambitious climate policy broadly in line with 1.5deg C Paris target


for (i in seq_len(nrow(scenario_grid))) {

  pathway <- scenario_grid$pathway[i]
  policy <- scenario_grid$policy[i]

  # Start every run from default configuration.
  source("config/default.cfg")


  # ------------------------------------
  # Run identification and technical setup
  # ------------------------------------

  cfg$info$flag <- run_flag

  cfg$qos <- "short_highMem"

  # Preserve individual tests and prevent replacement.
  cfg$results_folder <- "output/:title::date:"
  cfg$force_replace <- FALSE

  # !!! Optional reduced output set for preliminary testing:
  # cfg$output <- c("output_check", "rds_report")



  # ------------------------------------
  # Shared scenario basis
  # ------------------------------------

  # SSP2 is the common starting point before pathway-specific EC settings
  # are applied. Future climate-change impacts are switched off.
  cfg <- setScenario(cfg, c("SSP2", "nocc_hist"))

  # !!! ForestryExo is intentionally not activated for EC scenario set.
  # Add it only after a deliberate decision to use exogenous forestry:
  # cfg <- setScenario(cfg, "ForestryExo")


  # ------------------------------------
  # Climate-policy settings
  # ------------------------------------

  # !!! Align GHG-price muting years with corresponding REMIND scenario configurations.

  if (policy == "NPi2025") {

    cfg <- setScenario(cfg, "NPI")
    cfg$gms$c56_mute_ghgprices_until <- "y2150"

  } else if (policy %in% c("PkBudg1000", "PkBudg650")) {

    cfg <- setScenario(cfg, "NDC")
    cfg$gms$c56_mute_ghgprices_until <- "y2030"

  } else {

    stop("Unknown climate-policy variant: ", policy)
  }

  # !!! COUPLING: Provisional stand-alone inputs based on the existing SSP2 REMIND runs.
  # Replace these with coupled-run inputs once the corresponding
  # REMIND-MAgPIE simulations are available.
  cfg$gms$c56_pollutant_prices <- paste0("R34M410-SSP2-", policy)
  cfg$gms$c60_2ndgen_biodem <- paste0("R34M410-SSP2-", policy)


  # ------------------------------------
  # Earth Commission pathway settings
  # ------------------------------------

  # Keep this as the final setScenario() call because comma-separated EC settings such as
  # kfo_rd and land_snv are converted by setScenario() into vectors.
  # A subsequent setScenario() call would fail on these vector settings.
  if (pathway %in% names(ec_config_column)) {
    cfg <- setScenario(
      cfg,
      ec_config_column[[pathway]],
      scenario_config = scenario_config_ec
    )
  }


  # ------------------------------------
  # Explicit EC project overrides
  # ------------------------------------

  # !!! Keep these explicit for later alignment with the REMIND configurations.
  # They are applied after the scenario presets so that the values below
  # override previous settings.
  cfg$gms$s56_limit_ch4_n2o_price <- 734
  cfg$gms$s32_annual_aff_limit <- 0.03
  cfg$gms$s15_elastic_demand <- 0


  # !!! The following settings currently match develop defaults and are therefore
  # not repeated here. Add them explicitly only if the EC project should pin
  # these choices against future default changes:
  # cfg$gms$cropland <- "detail_apr24"
  # cfg$gms$som <- "cellpool_jan23"
  # cfg$gms$factor_costs <- "sticky_feb18"


  # ------------------------------------
  # Coupled-run settings for later use
  # ------------------------------------

  # !!! COUPLING: Replace with the actual pathway-specific REMIND report file.
  # path_to_coupled_output <- paste0(
  #   "/p/projects/magpie/users/.../...",
  #   "/REMIND_generic_C_....mif"
  # )
  #
  # cfg$gms$c56_pollutant_prices <- "coupling"
  # cfg$gms$c60_2ndgen_biodem <- "coupling"
  # cfg$path_to_report_ghgprices <- path_to_coupled_output
  # cfg$path_to_report_bioenergy <- path_to_coupled_output


  # ------------------------------------
  # Start run
  # ------------------------------------

  cfg$title <- .make_title(run_flag, pathway, policy)

  start_run(
    cfg = cfg,
    codeCheck = code_check_first_run && i == 1
  )
}
