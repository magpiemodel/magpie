# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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
library(lucode2)
library(quitte)
library(gms)
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if (!exists("source_include")) {
  outputdir <- NULL
  readArgs("outputdir")
}

cfg     <- gms::loadConfig(file.path(outputdir, "config.yml"))
gdx     <- file.path(outputdir,"fulldata.gdx")
rds_iso <- paste0(outputdir, "/report_iso.rds")
###############################################################################

report <- getReportIso(gdx, scenario = cfg$title, dir = outputdir)

q <- as.quitte(report)
# as.quitte converts "World" into "GLO". But we want to keep "World" and therefore undo these changes
q <- droplevels(q)
levels(q$region)[levels(q$region) == "GLO"] <- "World"
q$region <- factor(q$region,levels = sort(levels(q$region)))

if (all(is.na(q$value))) {
  stop("No values in reporting!")
}

saveRDS(q, file = rds_iso, version = 2, compress = "xz")
