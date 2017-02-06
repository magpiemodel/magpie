# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de



library(mip)
library(magpie4)

############################# BASIC CONFIGURATION #############################
validation_mif        <- "input/validation.mif"
###############################################################################

load(path(outputdir,"config.Rdata"))
gdx<-path(outputdir,"fulldata.gdx")
x <- getReport(gdx)

validationpdf(x=x, hist=validation_mif, file=path(outputdir,paste0("dval_",cfg$title,".pdf")), style="detailed")

  

