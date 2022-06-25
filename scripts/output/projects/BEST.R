# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


# --------------------------------------------------------------
# description: Merges report.mif files from several runs into a single mif file
# comparison script: TRUE
# position: 3
# ---------------------------------------------------------------

library(lucode2)
library(magclass)
library(quitte)
library(iamc)
library(magpie4)

options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  readArgs("outputdir")
}
###############################################################################
cat("\nStarting output generation\n")

missing <- NULL

#if(file.exists("output/BEST_V7.csv")) file.rename("output/BEST_V7.csv","output/BEST_V7.bak")

for (i in 1:length(outputdir)) {
  print(paste("Processing",outputdir[i]))
  #gdx file
  rep<-path(outputdir[i],"report.mif")
  if(file.exists(rep)) {
    #read-in reporting file
    a <- read.report(rep,as.list = FALSE)
    #add to reporting csv file
#    write.reportProject(a,mapping="/p/projects/rd3mod/inputdata/mappings/reportingVariables/mapping_magpie_BEST.csv",file="output/BEST_V7.csv",append=TRUE,ndigit = 4,skipempty = FALSE)
    write.reportProject(a,mapping="BEST_mapping.csv",file="output/BEST_V11.csv",append=TRUE,ndigit = 4,skipempty = FALSE)
  } else missing <- c(missing,outputdir[i])
}
if (!is.null(missing)) {
  cat("\nList of folders with missing report.mif\n")
  print(missing)
}
