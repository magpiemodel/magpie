# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: extract report in rds format from run
# comparison script: FALSE
# position: 3
# ---------------------------------------------------------------


library(magclass)
library(magpie4)
library(gms)
library(quitte)
source("scripts/helper.R")
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if (!exists("source_include")) {
  readArgs("outputdir")
  stopifnot(exists("outputdir"))
}

cfg     <- gms::loadConfig(file.path(outputdir, "config.yml"))
gdx     <- file.path(outputdir, "fulldata.gdx")
rds_iso <- paste0(outputdir, "/report_iso.rds")
###############################################################################

report <- getReportIso(gdx, scenario = cfg$title)

mif <- sub(".rds", ".mif", rds_iso)
write.report(report, file = mif, scenario = cfg$title)

report <- read.report(file = mif, as.list = FALSE)
q <- useWorld(as.quitte(report))
saveRDS(q, file = rds_iso, version = 2, compress = "xz")
