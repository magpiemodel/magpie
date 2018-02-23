# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de

#########################
#### check modelstat ####
#########################
# Version 1.0, Florian Humpenoeder
#
library(lucode)
library(magpie4)

options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdirs <- path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  readArgs("outputdirs")
}
###############################################################################
cat("\nStarting output generation\n")

out <- NULL
missing <- NULL

for (i in 1:length(outputdirs)) {
  print(paste("Processing",outputdirs[i]))
  #gdx file
  gdx<-path(outputdirs[i],"fulldata.gdx")
  if(file.exists(gdx)) {
    tmp <- modelstat(gdx)
    dimnames(tmp)[[3]] <- paste(outputdirs[i],dimnames(tmp)[[3]],sep=".")
    out <- mbind(out,tmp)
  } else missing <- c(missing,outputdirs[i])
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
