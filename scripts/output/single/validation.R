# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

library(magpie4)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir    <-"."
}

load(paste0(outputdir, "/config.Rdata"))
hist       <- c(paste0(outputdir, "/validation.mif"), "input/validation.mif")
file       <- paste0(outputdir, "/", cfg$title, "_validation.pdf")
reportfile <- paste0(outputdir, "/report.mif")
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

validation(gdx=gdx, hist=h, file = file, runinfo=runinfo, reportfile=reportfile, scenario=cfg$title)
