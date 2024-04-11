# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: creates a validation pdf file for a run (short version - aggregated crop types)
# comparison script: FALSE
# position: 5
# ---------------------------------------------------------------


library(magpie4)
library(gms)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir    <-"."
}

cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
hist       <- c(paste0(outputdir, "/validation.mif"), "input/validation.mif")
file       <- paste0(outputdir, "/", cfg$title, "_validation.pdf")
reportrds  <- paste0(outputdir, "/report.rds")
gdx        <- paste0(outputdir, "/fulldata.gdx")
runinfo    <- paste0(outputdir, "/", cfg$title, "_*.RData")
###############################################################################

#### Choose validation data ###
# Use first hist file that can be found

for(h in hist) {
  if(file.exists(h)) break
}

runinfo <- Sys.glob(runinfo)
if(length(runinfo)>1) {
  runinfo <- runinfo[1]
  warnings("More than one runinfo file found. The first one will be used.")
} else if (length(runinfo)==0) {
  runinfo <- NULL
}

getReport <- getReport(gdx,scenario = cfg$title,detail=FALSE)

validation(gdx=gdx, hist=h, file = file, runinfo=runinfo, scenario=cfg$title, getReport=getReport)
