# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Scenarios for FSEC
# ----------------------------------------------------------

library(gms)
source("scripts/start_functions.R")
source("scripts/projects/fsec.R")

codeCheck <- FALSE

for (scenarioName in c("c_BAU")) {

    # Start runs
    cfg <- fsecScenario(scenario = scenarioName)
    cfg$title <- paste0("allCalib", scenarioName)
    start_run(cfg = cfg, codeCheck = codeCheck)

    cfg <- fsecScenario(scenario = scenarioName)
    cfg$gms$s39_ignore_calib <- 1
    cfg$title <- paste0("ignoreCalib", scenarioName)
    start_run(cfg = cfg, codeCheck = codeCheck)

    cfg <- fsecScenario(scenario = scenarioName)
    cfg$gms$s39_reward_shr <- 0
    cfg$title <- paste0("noRewardCalib", scenarioName)
    start_run(cfg = cfg, codeCheck = codeCheck)

}
