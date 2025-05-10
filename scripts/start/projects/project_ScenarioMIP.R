# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: ScenarioMIP runs
# position: 1
# ----------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

# create additional information to describe the runs
cfg$info$flag <- "SMIP63"
cfg$qos <- "standby_dayMax"

cfg$results_folder <- "output/:title:"
cfg$force_replace <- TRUE

# support function to create standardized title
.title <- function(cfg, ...) return(paste(cfg$info$flag, sep="_",...))

#download default input data
cfg$input[["report_coupling"]] <- "SMIPv06_report_coupling.tgz"
download_and_update(cfg)

cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
cfg$gms$cropland    <- "detail_apr24"
cfg$gms$som <- "cellpool_jan23"
cfg$gms$s15_elastic_demand <- 1
cfg$gms$s56_limit_ch4_n2o_price <- 734
cfg$gms$s32_annual_aff_limit <- 0.03

### Main scenarios

#H-SSP3-rollBack
cfg$title <- .title(cfg, "H-SSP3-rollBack")
cfg <- setScenario(cfg,c("SSP3","NPI-revert","AR-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2150"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv06-H-SSP3-rollBack-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv06-H-SSP3-rollBack-def-rem-7.mif"
cfg$gms$c15_food_scenario <- "SSP2"
cfg$gms$s32_npi_ndc_reversal <- 2030
cfg$gms$s35_npi_ndc_reversal <- 2030
cfg$gms$s29_treecover_target <- 0
cfg$gms$s44_bii_target <- 0
cfg$gms$c44_bii_decrease <- 1
cfg$gms$s44_start_year <- 2030
cfg$gms$s59_scm_target <- 0
cfg$gms$c60_1stgen_biodem <- "const2030"
start_run(cfg, codeCheck = FALSE)

#M-SSP2-NPi2025
cfg$title <- .title(cfg, "M-SSP2-NPi2025")
cfg <- setScenario(cfg,c("SSP2","NPI","AR-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2150"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv06-M-SSP2-NPi2025-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv06-M-SSP2-NPi2025-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0
cfg$gms$s44_bii_target <- 0
cfg$gms$c44_bii_decrease <- 1
cfg$gms$s44_start_year <- 2030
cfg$gms$s59_scm_target <- 0
cfg$gms$c60_1stgen_biodem <- "const2030"
start_run(cfg, codeCheck = FALSE)

#ML-SSP2-PkBudg1500
cfg$title <- .title(cfg, "ML-SSP2-PkBudg1500")
cfg <- setScenario(cfg,c("SSP2","NPI","AR-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2040"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv06-ML-SSP2-EcPrice310-var-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv06-ML-SSP2-EcPrice310-var-rem-7.mif"
cfg$gms$s29_treecover_target <- 0
cfg$gms$s44_bii_target <- 0
cfg$gms$c44_bii_decrease <- 1
cfg$gms$s44_start_year <- 2030
cfg$gms$s59_scm_target <- 0
cfg$gms$c60_1stgen_biodem <- "const2030"
start_run(cfg, codeCheck = FALSE)

#L-SSP2-PkBudg1000
cfg$title <- .title(cfg, "L-SSP2-PkBudg1000")
cfg <- setScenario(cfg,c("SSP2","NDC","AR-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv06-L-SSP2-PkPrice400-var-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv06-L-SSP2-PkPrice400-var-rem-7.mif"
cfg$gms$s29_treecover_scenario_start <- 2030
cfg$gms$s29_treecover_target <- 0.01
cfg$gms$s44_bii_target <- 0
cfg$gms$c44_bii_decrease <- 0
cfg$gms$s44_start_year <- 2030
cfg$gms$s59_scm_scenario_start <- 2030
cfg$gms$s59_scm_target <- 0.1
cfg$gms$c60_1stgen_biodem <- "const2030"
start_run(cfg, codeCheck = FALSE)

#VLHO-SSP2-EcBudg400
cfg$title <- .title(cfg, "VLHO-SSP2-EcBudg400")
cfg <- setScenario(cfg,c("SSP2","NPI","AR-plant","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv06-VLHO-SSP2-EcPrice1250-var-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv06-VLHO-SSP2-EcPrice1250-var-rem-7.mif"
cfg$gms$s29_treecover_scenario_start <- 2030
cfg$gms$s29_treecover_target <- 0.02
cfg$gms$s44_bii_target <- 0
cfg$gms$c44_bii_decrease <- 0
cfg$gms$s44_start_year <- 2050
cfg$gms$s59_scm_scenario_start <- 2030
cfg$gms$s59_scm_target <- 0.2
cfg$gms$c60_1stgen_biodem <- "const2030"
start_run(cfg, codeCheck = FALSE)

#VLLO-SSP1-PkBudg650
cfg$title <- .title(cfg, "VLLO-SSP1-PkBudg650")
cfg <- setScenario(cfg,c("VLLO","NDC","AR-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv06-VLLO-SSP1-PkPrice500-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv06-VLLO-SSP1-PkPrice500-def-rem-7.mif"
cfg$gms$s29_treecover_scenario_start <- 2025
cfg$gms$s29_treecover_target <- 0.02
cfg$gms$s44_bii_target <- 0.7
cfg$gms$c44_bii_decrease <- 0
cfg$gms$s44_start_year <- 2030
cfg$gms$s59_scm_scenario_start <- 2025
cfg$gms$s59_scm_target <- 0.2
cfg$gms$c60_1stgen_biodem <- "const2030"
start_run(cfg, codeCheck = FALSE)

### Variants

#H-SSP3-NPi2025 - no rollback
cfg$title <- .title(cfg, "H-SSP3-NPi2025")
cfg <- setScenario(cfg,c("SSP3","NPI","AR-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2150"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv06-M-SSP3-NPi2025-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv06-M-SSP3-NPi2025-def-rem-7.mif"
cfg$gms$c15_food_scenario <- "SSP2"
cfg$gms$s29_treecover_target <- 0
cfg$gms$s44_bii_target <- 0
cfg$gms$c44_bii_decrease <- 1
cfg$gms$s44_start_year <- 2030
cfg$gms$s59_scm_target <- 0
cfg$gms$c60_1stgen_biodem <- "const2030"
start_run(cfg, codeCheck = FALSE)

#VLHO-SSP2-EcBudg400-ARnatveg
cfg$title <- .title(cfg, "VLHO-SSP2-EcBudg400-ARnatveg")
cfg <- setScenario(cfg,c("SSP2","NPI","AR-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv06-VLHO-SSP2-EcBudg400-var_natveg-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv06-VLHO-SSP2-EcBudg400-var_natveg-rem-7.mif"
cfg$gms$s29_treecover_scenario_start <- 2030
cfg$gms$s29_treecover_target <- 0.02
cfg$gms$s44_bii_target <- 0
cfg$gms$c44_bii_decrease <- 0
cfg$gms$s44_start_year <- 2050
cfg$gms$s59_scm_scenario_start <- 2030
cfg$gms$s59_scm_target <- 0.2
cfg$gms$c60_1stgen_biodem <- "const2030"
start_run(cfg, codeCheck = FALSE)

#VLLO-SSP1-PkBudg650-noAnnualAffLimit
cfg$title <- .title(cfg, "VLLO-SSP1-PkBudg650-noAnnualAffLimit")
cfg <- setScenario(cfg,c("VLLO","NDC","AR-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv06-VLLO-SSP1-PkPrice500-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv06-VLLO-SSP1-PkPrice500-def-rem-7.mif"
cfg$gms$s29_treecover_scenario_start <- 2025
cfg$gms$s29_treecover_target <- 0.02
cfg$gms$s44_bii_target <- 0.7
cfg$gms$c44_bii_decrease <- 0
cfg$gms$s44_start_year <- 2030
cfg$gms$s59_scm_scenario_start <- 2025
cfg$gms$s59_scm_target <- 0.2
cfg$gms$c60_1stgen_biodem <- "const2030"
cfg$gms$s32_annual_aff_limit <- 1
start_run(cfg, codeCheck = FALSE)
