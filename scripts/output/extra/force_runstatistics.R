# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Forces runstatistics submission in central repo
# comparison script: FALSE
# ---------------------------------------------------------------

### version.0.1: Abhi - Forces runstatistics submission in central repo

## Load necessary libraries
library(lucode2)
library(magpie4)
library(gms)

## Check outputdir
if(!exists("source_include")) {
  outputdir    <-"."
}

## Create path to runstatistics
runstatistics <- paste0(outputdir,"/runstatistics.rda")
## Create path to fulldata gdx
gdx <- paste0(outputdir,"/fulldata.gdx")

## Load run config
cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))

## Load runstatistics
load(runstatistics)

## Check if runstatistics are null and force submission if yes. Print a message if no.
if(is.null(stats$id)){
runstatistics(file= runstatistics,
              modelstat  = modelstat(gdx),
              config     = cfg,
              runtime    = 0,
              setup_info = setup_info(),
              submit     = cfg$runstatistics)
} else {cat("\nRunstatistics is not NULL.\nThis result should already appear in appResults.")}
