# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test routine for standardized test runs for each release
# ----------------------------------------------------------

arguments <- commandArgs(trailingOnly = TRUE)
if (length(arguments) != 1) {
  stop("Please provide the release number as argument, for example:\n",
       "Rscript scripts/start/extra/testRunsRelease.R 4.9.3")
}

source("config/default.cfg")

source("scripts/start_functions.R")
download_and_update(cfg)

cfg$info$flag <- paste0("release-", arguments)

source("scripts/runTestRuns.R")
runTestRuns(cfg)
