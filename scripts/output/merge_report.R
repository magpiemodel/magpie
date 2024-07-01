# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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

# Version 1.0, Florian Humpenoeder
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
out <- NULL

if(file.exists("output/report_all.rds")) file.rename("output/report_all.rds","output/report_all_bak.rds")
if(file.exists("output/report_all.mif")) file.rename("output/report_all.mif","output/report_all_bak.mif")

for (i in 1:length(outputdir)) {
  print(paste("Processing",outputdir[i]))
  rep<-file.path(outputdir[i],"report.rds")
  if(file.exists(rep)) {
    a <- readRDS(rep)
    out <- rbind(out,a)
  } else missing <- c(missing,outputdir[i])
}

saveRDS(out,file="output/report_all.rds")
write.mif(out,"output/report_all.mif")

if (!is.null(missing)) {
  cat("\nList of folders with missing report.mif\n")
  print(missing)
}
