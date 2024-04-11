# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: re-submits runs to different queues (e.g. priority) 
# comparison script: TRUE
# ---------------------------------------------------------------

######################
#### resubmit run ####
######################
# Version 1.0, Florian Humpenoeder
#
library(lucode2)
library(magpie4)

options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- file.path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  readArgs("outputdir")
}
###############################################################################
cat("\nStarting output generation\n")

out <- NULL
missing <- NULL

for (i in 1:length(outputdir)) {
  print(paste("Checking",outputdir[i]))
  #gdx file
  gdx<-file.path(outputdir[i],"fulldata.gdx")
  if(file.exists(gdx)) tmp <- modelstat(gdx) else tmp <- 0
  if (any(tmp>2) | all(tmp==0)) {
    file.copy(from = "scripts/run_submit/submit.sh",to = file.path(outputdir[i],"submit.sh"),overwrite = TRUE)
    current <- getwd()
    setwd(outputdir[i])
    if (file.exists("magpie_y1995.gdx")) file.remove("magpie_y1995.gdx")
    system("sbatch submit.sh")
    setwd(current)
  }
}
