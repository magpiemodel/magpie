# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: checks variables for constraint violations
# comparison script: FALSE
# ---------------------------------------------------------------

#########################
#### check obb ####
#########################
# Version 1.0, Florian Humpenoeder
#
library(gdx2)
library(lucode2)
library(magclass)

options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- file.path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  lucode2::readArgs("outputdir")
}
###############################################################################
cat("\nStarting output generation\n")


for (i in 1:length(outputdir)) {
  print(paste("Processing",outputdir[i]))
  gdx<-file.path(outputdir[i],"fulldata.gdx")
  if(file.exists(gdx)) {
    x <- readGDX(gdx, "ov*", types="parameters", field = "All")
    for(i in names(x)) {
      print(i)
      try(z <- where(x[[i]][,,"level"] < x[[i]][,,"lower"] | x[[i]][,,"level"] > x[[i]][,,"upper"])$true, silent = TRUE)
      if(exists("z")) {
        if (length(z$individual) > 0) {
          for (r in z$regions) {
            for (y in z$years) {
              print(paste(i,r,y))
              print(x[[i]][r,y,])
            }
          }
        }
        rm(z)
      }
    }
  }
}
