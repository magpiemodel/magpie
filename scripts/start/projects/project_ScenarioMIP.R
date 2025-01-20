# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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
cfg$info$flag <- "SMIP20"

cfg$results_folder <- "output/:title:"
cfg$force_replace <- TRUE

# support function to create standardized title
.title <- function(cfg, ...) return(paste(cfg$info$flag, sep="_",...))

#download default input data
cfg$input[["report_coupling"]] <- "SMIPv04_report_coupling.tgz"
download_and_update(cfg)

cfg$gms$c56_pollutant_prices <- "coupling"
cfg$gms$c60_2ndgen_biodem <- "coupling"
cfg$gms$cropland    <- "detail_apr24"

#H-SSP3-NPi2025
cfg$title <- .title(cfg, "H-SSP3-NPi2025")
cfg <- setScenario(cfg,c("SSP3","NPI","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2150"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-M-SSP3-NPi2025-var-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-M-SSP3-NPi2025-var-rem-7.mif"
cfg$gms$s29_treecover_target <- 0
start_run(cfg, codeCheck = FALSE)

#H-SSP3-rollBack
cfg$title <- .title(cfg, "H-SSP3-rollBack")
cfg <- setScenario(cfg,c("SSP3","NPI-revert","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2150"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-H-SSP3-rollBack-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-H-SSP3-rollBack-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0
start_run(cfg, codeCheck = FALSE)

#M-SSP2-NPi2025
cfg$title <- .title(cfg, "M-SSP2-NPi2025")
cfg <- setScenario(cfg,c("SSP2","NPI","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2150"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-M-SSP2-NPi2025-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-M-SSP2-NPi2025-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0
start_run(cfg, codeCheck = FALSE)

#ML-SSP2-PkBudg1500
cfg$title <- .title(cfg, "ML-SSP2-PkBudg1500")
cfg <- setScenario(cfg,c("SSP2","NPI","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2040"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-ML-SSP2-PkBudg1500-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-ML-SSP2-PkBudg1500-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0.015
start_run(cfg, codeCheck = FALSE)

#L-SSP2-PkBudg1000
cfg$title <- .title(cfg, "L-SSP2-PkBudg1000")
cfg <- setScenario(cfg,c("SSP2","NDC","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-L-SSP2-PkBudg1000-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-L-SSP2-PkBudg1000-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0.015
start_run(cfg, codeCheck = FALSE)

#L-SSP2-PkBudg1000-AFoff
cfg$title <- .title(cfg, "L-SSP2-PkBudg1000-AFoff")
cfg <- setScenario(cfg,c("SSP2","NDC","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-L-SSP2-PkBudg1000-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-L-SSP2-PkBudg1000-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0
start_run(cfg, codeCheck = FALSE)

#L-SSP2-PkBudg1000-AFoff-simple
cfg$title <- .title(cfg, "L-SSP2-PkBudg1000-AFoff-simple")
cfg <- setScenario(cfg,c("SSP2","NDC","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-L-SSP2-PkBudg1000-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-L-SSP2-PkBudg1000-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0
cfg$gms$cropland    <- "simple_apr24"
start_run(cfg, codeCheck = FALSE)
cfg$gms$cropland    <- "detail_apr24"

#VLHO-SSP2-EcBudg400
cfg$title <- .title(cfg, "VLHO-SSP2-EcBudg400")
cfg <- setScenario(cfg,c("SSP2","NDC","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-VLHO-SSP2-EcBudg400-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-VLHO-SSP2-EcBudg400-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0.015
start_run(cfg, codeCheck = FALSE)

#VLHO-SSP2-EcBudg400-plant
cfg$title <- .title(cfg, "VLHO-SSP2-EcBudg400-plant")
cfg <- setScenario(cfg,c("SSP2","NDC","GHG-Price-Fader","AF-plant","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-VLHO-SSP2-EcBudg400-var_plantation-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-VLHO-SSP2-EcBudg400-var_plantation-rem-7.mif"
cfg$gms$s29_treecover_target <- 0.015
start_run(cfg, codeCheck = FALSE)

#VLLO-SSP1-PkBudg650
cfg$title <- .title(cfg, "VLLO-SSP1-PkBudg650")
cfg <- setScenario(cfg,c("SDP-MC","SSP1-POP-GDP","NDC","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0.015
start_run(cfg, codeCheck = FALSE)

#VLLO-SSP1-PkBudg650-all_nosoil
cfg$title <- .title(cfg, "VLLO-SSP1-PkBudg650-all_nosoil")
cfg <- setScenario(cfg,c("SDP-MC","SSP1-POP-GDP","NDC","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0.015
cfg$gms$c56_emis_policy <- "all_nosoil"
start_run(cfg, codeCheck = FALSE)

#VLLO-SSP1-PkBudg650-min18
cfg$title <- .title(cfg, "VLLO-SSP1-PkBudg650-min18")
cfg <- setScenario(cfg,c("SDP-MC","SSP1-POP-GDP","NDC","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0.015
cfg$gms$s56_minimum_cprice <- 18
start_run(cfg, codeCheck = FALSE)

#VLLO-SSP1-PkBudg650-min7
cfg$title <- .title(cfg, "VLLO-SSP1-PkBudg650-min7")
cfg <- setScenario(cfg,c("SDP-MC","SSP1-POP-GDP","NDC","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0.015
cfg$gms$s56_minimum_cprice <- 7
start_run(cfg, codeCheck = FALSE)

#VLLO-SSP1-PkBudg650-min4
cfg$title <- .title(cfg, "VLLO-SSP1-PkBudg650-min4")
cfg <- setScenario(cfg,c("SDP-MC","SSP1-POP-GDP","NDC","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0.015
cfg$gms$s56_minimum_cprice <- 4
start_run(cfg, codeCheck = FALSE)

#VLLO-SSP1-PkBudg650-min3p67
cfg$title <- .title(cfg, "VLLO-SSP1-PkBudg650-min3p67")
cfg <- setScenario(cfg,c("SDP-MC","SSP1-POP-GDP","NDC","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0.015
cfg$gms$s56_minimum_cprice <- 3.67
start_run(cfg, codeCheck = FALSE)

#VLLO-SSP1-PkBudg650-min0
cfg$title <- .title(cfg, "VLLO-SSP1-PkBudg650-min0")
cfg <- setScenario(cfg,c("SDP-MC","SSP1-POP-GDP","NDC","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0.015
cfg$gms$s56_minimum_cprice <- 0
start_run(cfg, codeCheck = FALSE)

#VLLO-SSP1-PkBudg650-2060
cfg$title <- .title(cfg, "VLLO-SSP1-PkBudg650-2060")
cfg <- setScenario(cfg,c("SDP-MC","SSP1-POP-GDP","NDC","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0.015
cfg$gms$s56_fader_end <- 2060
start_run(cfg, codeCheck = FALSE)

#VLLO-SSP1-PkBudg650-2070
cfg$title <- .title(cfg, "VLLO-SSP1-PkBudg650-2070")
cfg <- setScenario(cfg,c("SDP-MC","SSP1-POP-GDP","NDC","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0.015
cfg$gms$s56_fader_end <- 2070
start_run(cfg, codeCheck = FALSE)

#VLLO-SSP1-PkBudg650-2070-form2
cfg$title <- .title(cfg, "VLLO-SSP1-PkBudg650-2070-form2")
cfg <- setScenario(cfg,c("SDP-MC","SSP1-POP-GDP","NDC","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0.015
cfg$gms$s56_fader_end <- 2070
cfg$gms$s56_fader_functional_form <- 2
start_run(cfg, codeCheck = FALSE)

#VLLO-SSP1-PkBudg650-FaderOff
cfg$title <- .title(cfg, "VLLO-SSP1-PkBudg650-FaderOff")
cfg <- setScenario(cfg,c("SDP-MC","SSP1-POP-GDP","NDC","GHG-Price-Fader","AF-natveg","nocc_hist"))
cfg$gms$s56_ghgprice_fader <- 0
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$path_to_report_ghgprices <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$path_to_report_bioenergy    <- "input/REMIND_generic_C_SMIPv04-VLLO-SSP1-PkBudg650-def-rem-7.mif"
cfg$gms$s29_treecover_target <- 0.015
#start_run(cfg, codeCheck = FALSE)
