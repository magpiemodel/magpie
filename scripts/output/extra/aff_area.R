# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: extracts afforstation area from multiple runs and creates a PDF (useful template for other variables)
# comparison script: TRUE
# ---------------------------------------------------------------

# Version 1.0, Florian Humpenoeder
#
library(lucode2)
library(magclass)
library(luplot)
library(magpie4)
library(ggplot2)
library(gms)

options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdirs <- file.path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  lucode2::readArgs("outputdirs")
}
###############################################################################
cat("\nStarting output generation\n")

forestry <- NULL
missing <- NULL

for (i in 1:length(outputdirs)) {
  print(paste("Processing",outputdirs[i]))
  #gdx file
  gdx<-file.path(outputdirs[i],"fulldata.gdx")
  if(file.exists(gdx)) {
    #get scenario name
    cfg <- gms::loadConfig(file.path(outputdirs[i], "config.yml"))
    scen <- cfg$title
    #read-in reporting file
    x <- collapseNames(land(gdx,level="glo")[,,"forestry"])
    x <- x-setYears(x[,1,],NULL)
    getNames(x) <- scen
    forestry <- mbind(forestry,x)
  } else missing <- c(missing,outputdirs[i])
}
if (!is.null(missing)) {
  cat("\nList of folders with missing fulldata.gdx\n")
  print(missing)
}

p <- magpie2ggplot2(forestry,scenario = 1,ylab = "Mha",title = "Afforestation",legend_position = "bottom",group = NULL,legend_ncol = 1)
ggsave(plot = p,filename = "output/aff_area.pdf",width = 8,height = 7)
