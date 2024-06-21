# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: check that summations add up in report.mif file
# comparison script: FALSE
# ---------------------------------------------------------------

## Load necessary libraries
library(quitte)
library(piamInterfaces)
options(width = 180)

## Check outputdir
if (!exists("source_include")) {
  outputdir <- "."
}

f <- file.path(outputdir, "report.mif")

if (!file.exists(f)) {
  warning("report.mif missing, cannot check anything. Please create report first!")
} else {
  failvar <- checkSummations(f, outputDirectory = NULL, absDiff = 0.001,
                             summationsFile = "extractVariableGroups")
  if (nrow(failvars) > 0) saveRDS(failvar, file.path(outputdir, "summationCheck.rds"))
}
