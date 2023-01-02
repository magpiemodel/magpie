# |  (C) 2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -------------------------------------------------------------
# description: run an empty model, output is the latest AMT run
# -------------------------------------------------------------

source("scripts/start_functions.R")
source("config/default.cfg")

cfg$title <- "empty_model"
cfg$model <- "standalone/empty_test_model.gms"

# Find latest fulldata.gdx from automated model test (AMT) runs
amtRunDirs <- list.files("/p/projects/landuse/tests/magpie/output",
                         pattern = "default_\\d{4}-\\d{2}-\\d{2}_\\d{2}\\.\\d{2}.\\d{2}",
                         full.names = TRUE)
fullDataGdxs <- file.path(amtRunDirs, "fulldata.gdx")
latestFullData <- sort(fullDataGdxs[file.exists(fullDataGdxs)], decreasing = TRUE)[[1]]

cfg$gms$c_input_gdx_path <- latestFullData

start_run(cfg = cfg, codeCheck = FALSE)
