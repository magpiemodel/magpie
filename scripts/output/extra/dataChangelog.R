# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: add to data changelog as configured in cfg
# comparison script: FALSE
# ---------------------------------------------------------------

source("config/default.cfg")
dataChangelog <- cfg$dataChangelog

cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
cfg$dataChangelog <- dataChangelog

stopifnot(cfg$dataChangelog$path != "")

report <- readRDS(file.path(cfg$results_folder, "report.rds"))




# TODO add quitte version requirement to description
versionId <- cfg$info$flag
if (is.null(versionId)) {
  versionId <- sub("^output/", "", cfg$results_folder)
}
quitte::addToDataChangelog(report = report,
                           changelog = cfg$dataChangelog$path,
                           versionId = versionId,
                           years = cfg$dataChangelog$years,
                           variables = cfg$dataChangelog$variables)
