# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: merges several inms report files into one mif
# comparison script: TRUE
# ---------------------------------------------------------------

# Version 1.0, merge_report script by Florian Humpeblder
# Version 1.01, adaptted to merge inms script by Benjamin Leon Bodirsky
#
library(lucode2)
library(magclass)
library(quitte)
library(gms)

options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- file.path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  lucode2::readArgs("outputdir")
}
###############################################################################
cat("\nStarting output generation\n")

missing <- NULL

combined <- "output/inms.csv"

if(file.exists(combined)) file.rename(combined,"output/inms.bak")

for (i in 1:length(outputdir)) {
  print(paste("Processing",outputdir[i]))
  #gdx file
  rep <- file.path(outputdir[i], "report_inms.mif")
  if(file.exists(rep)) {
    #get scenario name
    cfg <- gms::loadConfig(file.path(outputdir[i], "config.yml"))
    scen <- cfg$title
    #read-in reporting file
    a <- read.report(rep,as.list = FALSE)
    getNames(a,dim=1) <- scen
    #add to reporting csv file
    write.report(a, file = combined, append = TRUE, ndigit = 4, skipempty = FALSE)
  } else {
    missing <- c(missing,outputdir[i])
  }
}
if (!is.null(missing)) {
  cat("\nList of folders with missing report.mif\n")
  print(missing)
}

if(file.exists(combined)) saveRDS(read.quitte(combined),file = "output/inms.rds")
