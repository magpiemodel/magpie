# |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Write only those variables into a report that are relevant for the REMIND coupling
# comparison script: FALSE
# ---------------------------------------------------------------


library(magpie4)
library(gms)
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- "/p/projects/remind/runs/REMIND-MAgPIE-2022-10-12/magpie/output/C_SDP-PkBudg1150-mag-4"
  readArgs("outputdir")
}

cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
gdx <- file.path(outputdir, "fulldata.gdx")
mif <- file.path(outputdir, "report.mif")
###############################################################################

report <- getReportMAgPIE2REMIND(gdx, scenario = cfg$title)
write.report(report, file = mif)

