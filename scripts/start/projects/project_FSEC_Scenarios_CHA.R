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

### ---------------------prepare patch data----------------------------------
dir <- "./scripts/start/fsecCHA"

#unlink("./modules/50_nr_soil_budget/input/f50_snupe.cs4")

dir.create("./patch_data")

# ammend snupe of fertilizer zero growh policy on that of fsdp
if (!file.exists("./patch_data/50_snupe")){
  dir.create("./patch_data/50_snupe")
}

file.copy(from=paste0(dir,"/inputdata/fertilizer/f50_snupe.cs4"),
         to="./patch_data/50_snupe/.")
gms::tardir(dir="patch_data/50_snupe",
tarfile="patch_data/50_snupe.tgz")
unlink("patch_data/50_snupe", recursive=TRUE)

#------fertilizer cost data-----

##fertilize cost--Improve the fertilizer costs from 600 to 930of China since 2015

if (!file.exists("./patch_data/50_fertilizer_costs")){
  dir.create("./patch_data/50_fertilizer_costs")
}

file.copy(from=paste0(dir,"/inputdata/fertilizer/f50_fertilizer_costs.cs3"),
         to="./patch_data/50_fertilizer_costs/.")
gms::tardir(dir="patch_data/50_fertilizer_costs",
tarfile="patch_data/50_fertilizer_costs.tgz")
unlink("patch_data/50_fertilizer_costs", recursive=TRUE)


codeCheck <- FALSE

for (scenarioName in c("e_FSDP")) {

    # Start runs
    cfg <- fsecScenario(scenario = scenarioName)
    cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,
                                         "./patch_data"=NULL),
                                        getOption("magpie_repos"))
     cfg$input['snupe'] <- "50_snupe.tgz"
     cfg$input['fert_cost'] <- "50_fertilizer_costs.tgz"

    # change fertilizer costs in CHA
    cfg$gms$nr_soil_budget <- "FertSubRm"    # def = exoeff_aug16
    cfg$gms$c50_reg_fertilizer_costs <- "rm330"

    cfg$title <- "ve_FSDP_China"
    start_run(cfg = cfg, codeCheck = codeCheck)

  }
