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
library(ncdf4)
library(raster)
library(magpiesets)
library(moinput)
library(mrvalidation)
library(magclass)
library(madrat)
library(moinput)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir    <-"."
}

gdx        <- paste0(outputdir, "/fulldata.gdx")

###############################################################################

## Model output
modout_landuse <- land(gdx,level="grid",spamfiledirectory = outputdir)
getNames(modout_landuse,dim=1) <- reportingnames(getNames(modout_landuse,dim = 1))

sw<-swopen(paste0(outputdir,"/AreaPlots_LU.pdf"))

swlatex(sw,c("\\title{LU plots}","\\author{PIK Landuse Group}"))
swlatex(sw,"\\huge")
swlatex(sw,"\\textbf{LU plots}\\newline")
swlatex(sw,"\\normalsize")
swlatex(sw,"\\newline")
swlatex(sw,"\\tableofcontents")
swlatex(sw,"\\newpage")

LU <- getNames(modout_landuse,dim = 1)

for (i in LU) {
  swlatex(sw,"\\section{",i,"}")
  breakpoints <- c(0,0.1,0.2,0.3)
  for (j in getYears(modout_landuse)) {
    cat(paste0(":::",LU," ",j,"\n"))
    swfigure(sw,"plotmap2",sw_option="width=10,height=6",
             modout_landuse[,j,i], title = paste0(i),legend_breaks = breakpoints,
             lowcol = "white",midcol = "red",highcol = "green",
             legendname = "m ha",
             legend_range = c(0,0.3),land_colour = "grey",sea=F)
  }
}

swclose(sw)
