# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

#########################
#### check modelstat ####
#########################
# Version 1.0, Florian Humpenoeder
#
library(lucode)
library(magclass)
library(quitte)

options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdirs <- path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  readArgs("outputdirs")
}
###############################################################################
cat("\nStarting output generation\n")

missing <- NULL

if(file.exists("output/report_comp.csv")) file.rename("output/report_comp.csv","output/report_comp.bak")

for (i in 1:length(outputdirs)) {
  print(paste("Processing",outputdirs[i]))
  #gdx file
  rep<-path(outputdirs[i],"report.mif")
  if(file.exists(rep)) {
    #get scenario name
    load(path(outputdirs[i],"config.Rdata"))
    scen <- cfg$title
    #read-in reporting file
    a <- read.report(rep,as.list = FALSE)
    getNames(a,dim=1) <- scen
    #add to reporting csv file
    write.report2(a,file="output/report_comp.csv",append=TRUE,ndigit = 4,skipempty = FALSE)
  } else missing <- c(missing,outputdirs[i])
}
if (!is.null(missing)) {
  cat("\nList of folders with missing report.mif\n")
  print(missing)
}

if(file.exists("output/report_comp.csv")) saveRDS(read.quitte("output/report_comp.csv"),file = "output/report_comp.rds")