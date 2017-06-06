# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

library(magpie4)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir    <-"."
}
load(paste0(outputdir, "/config.Rdata"))
hist    <- c(paste0(outputdir, "/validation.mif"), "input/validation.mif")
file    <- paste0(outputdir, "/", cfg$title, "_validation.pdf")
reportfile <- paste0(outputdir, "/", cfg$title, "_report.mif")
gdx     <- paste0(outputdir, "/fulldata.gdx")
runinfo <- Sys.glob("output/bau__default/*.RData")[1]
if(is.na(runinfo)) runinfo <- NULL
###############################################################################

#### Choose validation data ###
# Use first hist file that can be found

for(h in hist) {
  if(file.exists(h)) break
}

validation(gdx=gdx, hist=h, file = file, runinfo=runinfo, reportfile=reportfile)
