# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

library(gdx)
library(luscale)
library(luplot)
library(lucode)
library(lusweave)
library(magpie4)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir    <-"."
}

gdx        <- paste0(outputdir, "/fulldata.gdx")

pdf_file       <- paste0(outputdir, "/", "_defaultAreaplot.pdf")
###############################################################################

pdf(pdf_file)

x <- land(gdx,level = "grid",spamfiledirectory = outputdir)

for(i in getYears(x)){
  print(plotmap2(x[,i,"crop"],title = paste0("Crop area ",i),legendname = "m ha"))
  }

for(i in getYears(x)){
  print(plotmap2(x[,i,"past"],title = paste0("Pasture area ",i),legendname = "m ha"))
  }

dev.off()