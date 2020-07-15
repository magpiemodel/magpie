# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description:
# comparison script: TRUE
# ---------------------------------------------------------------

#########################
#### check modelstat ####
#########################
# Version 1.0, Florian Humpenoeder
#
library(lucode2)
library(magclass)
library(luplot)
library(quitte)

options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  lucode2::readArgs("outputdir")
}
###############################################################################
cat("\nStarting output generation\n")

defor <- NULL
missing <- NULL

for (i in 1:length(outputdir)) {
  print(paste("Processing",outputdir[i]))
  #gdx file
  rep<-path(outputdir[i],"cell.land_0.5.mz")
  if(file.exists(rep)) {
    #get scenario name
    load(path(outputdir[i],"config.Rdata"))
    scen <- cfg$title
    #read-in reporting file
    land_hr <- read.magpie(rep)
    land_hr <- dimSums(land_hr[,c(2020,2050,2100),c("primforest","secdforest")],dim=3) - dimSums(setYears(land_hr[,1995,c("primforest","secdforest")],NULL),dim=3)
    getCells(land_hr) <- paste("GLO",1:59199,sep=".")
    getNames(land_hr) <- scen
    defor <- mbind(defor,land_hr)
  } else missing <- c(missing,outputdir[i])
}
if (!is.null(missing)) {
  cat("\nList of folders with missing report.mif\n")
  print(missing)
}

plotmap2(defor,"output/defor_area.pdf",legend_range = c(-0.1,0.1),title = "Diff forest area compared to 1995",legendname = "Mha",midpoint = 0,lowcol = "darkred",midcol = "grey95",highcol = "darkgreen",plot_height=10,plot_width=30,legend_height = NULL)
# plotmap2(defor[,2050,],"defor_2050_area.pdf",ncol=6,legend_range = c(-0.5,0.5),title = "Diff 2050",midpoint = 0,lowcol = "darkred",midcol = "grey95",highcol = "darkgreen",plot_height=10,plot_width=30,legend_height = NULL)
# plotmap2(defor[,2100,],"defor_2100_area.pdf",ncol=6,legend_range = c(-0.5,0.5),title = "Diff 2100",midpoint = 0,lowcol = "darkred",midcol = "grey95",highcol = "darkgreen",plot_height=10,plot_width=30,legend_height = NULL)
