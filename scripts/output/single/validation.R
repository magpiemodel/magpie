# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

library(magpie4)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir    <-"."
  data_workspace        <- "B0.RData"     # title of the run (with date)
  title<-"dummy"
}
hist    <- c(paste0(outputdir, "/validation.mif"), "input/validation.mif")
file    <- paste0(outputdir, "/", title, "_validation.pdf")
gdx     <- paste0(outputdir, "/fulldata.gdx")
runinfo <- data_workspace
###############################################################################

#### Choose validation data ###
# Use first hist file that can be found

for(h in hist) {
  if(file.exists(h)) break
}

validation(gdx=gdx, hist=h, file = file, runinfo=runinfo)
