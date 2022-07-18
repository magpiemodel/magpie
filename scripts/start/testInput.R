# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test routine for standardized test runs
# position: 5
# ----------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

#download default input data
download_and_update(cfg)

cfg$info$flag <- "475Test"

cfg$output <- c("rds_report") # Only run rds_report after model run
cfg$results_folder <- "output/:title:"
cfg$force_replace <- TRUE

# support function to create standardized title
.title <- function(...) return(paste(cfg$info$flag, sep="_",...))

#test productive run setting
cfg$gms$c30_marginal_land <- "q33_marginal"   # def = "all_marginal"

cfg$title <- .title(paste("New"))
start_run(cfg, codeCheck = TRUE)

cfg$title <- .title(paste(ssp,"CurrentDvp",sep="-"))

cfg$input <- c(regional    = "rev4.73_h12_magpie.tgz",
               cellular    = "rev4.73_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
               validation  = "rev4.73_h12_validation.tgz",
               additional  = "additional_data_rev4.26.tgz",
               calibration = "calibration_H12_per_ton_fao_may22_28May22.tgz")

start_run(cfg, codeCheck = TRUE)
