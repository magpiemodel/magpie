# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

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
  outputdirs <- path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  readArgs("outputdirs")
}
###############################################################################
cat("\nStarting output generation\n")

out <- NULL
missing <- NULL

for (i in 1:length(outputdirs)) {
  print(paste("Checking",outputdirs[i]))
  #gdx file
  gdx<-path(outputdirs[i],"fulldata.gdx")
  if(file.exists(gdx)) tmp <- modelstat(gdx) else tmp <- 0
  if (any(tmp>2) | all(tmp==0)) {
    file.copy(from = "scripts/run_submit/submit.sh",to = path(outputdirs[i],"submit.sh"),overwrite = TRUE)
    current <- getwd()
    setwd(outputdirs[i])
    if (file.exists("magpie_y1995.gdx")) file.remove("magpie_y1995.gdx")
    system("sbatch submit.sh")
    setwd(current)
  }
}
