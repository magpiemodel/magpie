# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: checks the modelstat of several runs
# comparison script: TRUE
# ---------------------------------------------------------------

#########################
#### check modelstat ####
#########################
# Version 1.0, Florian Humpenoeder
#
library(lucode2)
library(magpie4)

options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- file.path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  lucode2::readArgs("outputdir")
}
###############################################################################
cat("\nStarting output generation\n")

out <- NULL
missing <- NULL

for (i in 1:length(outputdir)) {
  print(paste("Processing",outputdir[i]))
  #gdx file
  gdx<-file.path(outputdir[i],"fulldata.gdx")
  if(file.exists(gdx)) {
    tmp <- modelstat(gdx)
    dimnames(tmp)[[3]] <- paste(outputdir[i],dimnames(tmp)[[3]],sep=".")
    out <- mbind(out,tmp)
  } else missing <- c(missing,outputdir[i])
}
write.magpie(out,paste("./output/modelstat_",basename(getwd()),".csv",sep=""))
if (!is.null(missing)) {
  cat("\nList of folders with missing fulldata.gdx\n")
  print(missing)
}
if (all(out==2)) {
  cat("\nGood news! No time steps with modelstat different from 2 found!\n")
} else {
  cat("\nTime steps with modelstat different from 2 found!\n")
  for (i in c(1,3:19)) {
    if (any(out==i)) warning("Time steps with modelstat ",i," found!")
  }
}
