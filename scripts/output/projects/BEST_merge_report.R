# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


# --------------------------------------------------------------
# description: Merges single report files into one file
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

file_name <- "output/BEST_V13.csv"

missing <- NULL

if(file.exists(file_name)) file.rename(file_name,(sub(".csv",".bak",file_name)))

for (i in 1:length(outputdir)) {
  print(paste("Processing",outputdir[i]))
  #gdx file
  rep<-path(outputdir[i],"report.mif")
  if(file.exists(rep)) {
    #read-in reporting file
    a <- read.report(rep,as.list = FALSE)
    #add to reporting csv file
    mapfile <- system.file("extdata", "variablemappingBEST.csv", package="magpie4")
    write.reportProject(a,mapping=mapfile,file=file_name,append=TRUE,ndigit = 4,skipempty = FALSE)
  } else missing <- c(missing,outputdir[i])
}
if (!is.null(missing)) {
  cat("\nList of folders with missing report.mif\n")
  print(missing)
}
