# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

##########################################################
#### check modelstat ####
##########################################################
# Version 1.0, Florian Humpenoeder
#
library(lucode)
library(magpie4)

options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {  
  outputdirs <- path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  latexpath <- NA              # Latexpath necessary if swclose is performed in the queue
  #Define arguments that can be read from command line
  readArgs("outputdirs","latexpath")
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
  if (any(tmp!=2)) {
    current <- getwd()
    setwd(outputdirs[i])    
    #     main <- which(tmp[,,"main"] != 2)
    #     if (dim(tmp)[3] > 1) pre <- which(tmp[,,"presolve"] != 2) else pre <- NA
    #     if (length(main) == 0) main <- NA
    #     if (length(pre) == 0) pre <- NA
    #     bad <- min(main,pre,na.rm=TRUE)
    #    file.remove(list.files(pattern="magpie_y+")[bad:length(list.files(pattern="magpie_y+"))])
       if (file.exists("magpie_y1995.gdx")) file.remove("magpie_y1995.gdx")
    #    file.copy(path(current,"submit.cmd"),"submit.cmd",overwrite=TRUE)
    system("sbatch submit.sh") 
    setwd(current)
  }
}
