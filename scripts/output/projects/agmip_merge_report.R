# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: merge agmip-reports of single runs into one project-report
# comparison script: TRUE
# ---------------------------------------------------------------

library(lucode2)
library(magclass)
library(quitte)

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

if(file.exists("output/agmip_report_comp.csv")) file.rename("output/agmip_report_comp.csv","output/agmip_report_comp.bak")

for (i in 1:length(outputdir)) {
  print(paste("Processing",outputdir[i]))
  #gdx file
  rep<-path(outputdir[i],"agmip_report.mif")
  if(file.exists(rep)) {
    #get scenario name
    load(path(outputdir[i],"config.Rdata"))
    scen <- cfg$title
    #read-in reporting file
    a <- read.report(rep,as.list = FALSE)
    getNames(a,dim=1) <- scen
    #add to reporting csv file
    write.report2(a,file="output/agmip_report_comp.csv",append=TRUE,ndigit = 4,skipempty = FALSE)
  } else missing <- c(missing,outputdir[i])
}
if (!is.null(missing)) {
  cat("\nList of folders with missing agmip_report.mif\n")
  print(missing)
}

if(file.exists("output/agmip_report_comp.csv")) saveRDS(read.quitte("output/agmip_report_comp.csv"),file = "output/agmip_report_comp.rds")
