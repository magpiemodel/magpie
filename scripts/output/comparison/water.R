# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

##################################################
#### MAgPIE scenario comparison water results ####
##################################################
# Version 1.0, Markus Bonsch

library(ludata)
library(luplot)
library(lusweave)
library(magpie4)
library(lucode)
library(validation)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
outputdirs <- c("output/SSP1_450forc_2013-08-26_11.34.57/","output/SSP1_550forc_2013-08-26_11.35.59/")
  #Define arguments that can be read from command line
  readArgs("outputdirs")
}
###############################################################################
years <- getYears(modelstat(path(outputdirs[1],"fulldata.gdx")))

gdx <- list()
title_list <- list()

print("Starting data preparation")
for (i in 1:length(outputdirs)) {
  #title of the run
  if(file.exists(path(outputdirs[i],"config.Rdata"))) {
    load(path(outputdirs[i],"config.Rdata"))
    title <- cfg$title
    gms      <- cfg$gms
    title_list[[title]] <- title
  } else {
    config <- grep("\\.cfg$",list.files(outputdirs[i]), value=TRUE)
    l<-readLines(path(outputdirs[i],config))
    title <- strsplit(grep("title +<-",l,value=TRUE),"\"")[[1]][2]
    gms <- list()
    gms$scenarios <- strsplit(grep("(cfg\\$|)gms\\$scenarios +<-",l,value=TRUE),"\"")[[1]][2]
    title_list[[title]] <- title
  }
  gdx[[title]] <- path(outputdirs[i],"fulldata.gdx")
}

print("Starting output generation")
sw<-swopen(paste("./output/water_results_",basename(getwd()),".pdf",sep=""))
swlatex(sw,"\\huge")
swlatex(sw,"\\textbf{MAgPIE scenario comparison water results}\\newline")
swlatex(sw,"\\normalsize")
swlatex(sw,"\\newline")
swlatex(sw,"\\tableofcontents")

print("modelstat")
print(names(gdx))
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{modelstat}")
modstat<-read_all(gdx,modelstat,as.list=FALSE)
if(is.list(modstat)){
  tmp<-modstat
  modstat<-NULL
  for(i in 1:length(tmp)){
    modstat<-mbind(modstat,setNames(tmp[[i]],paste(names(tmp)[i],getNames(tmp[[i]]),sep=".")))
  }
}
swtable(sw,modstat,caption="modelstat",table.placement="H")

print("tc")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{TC}")
swfigure(sw,print,validationPlot(func=tau,level="glo",gdx=gdx,index=TRUE),fig.placement="H",fig.orientation="landscape")
swfigure(sw,print,validationPlot(func=tau,level="reg",gdx=gdx,index=TRUE),fig.placement="H",fig.orientation="landscape")

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Croparea}")
swfigure(sw,print,validationPlot(func=land,types="crop",level="glo",gdx=gdx),fig.placement="H",fig.orientation="landscape")
swtable(sw,read_all(gdx,land,types="crop",level="glo",as.list=FALSE),caption="Global cropland mio ha")
swfigure(sw,print,validationPlot(func=land,types="crop",level="reg",gdx=gdx),fig.placement="H",fig.orientation="landscape")
swtable(sw,read_all(gdx,land,types="crop",level="reg",as.list=FALSE)[,1,],caption="Regional cropland 1995mio ha")

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Agricultural Water Withdrawals}")
swfigure(sw,print,validationPlot(func=water_usage,level="glo",gdx=gdx,users="agriculture"),fig.placement="H",fig.orientation="landscape")
swfigure(sw,print,validationPlot(func=water_usage,level="reg",gdx=gdx,users="agriculture"),fig.placement="H",fig.orientation="landscape")

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Irrigated area}")
swfigure(sw,print,validationPlot(func=croparea,level="glo",gdx=gdx,water="ir",crop_aggr=TRUE),fig.placement="H",fig.orientation="landscape")
swfigure(sw,print,validationPlot(func=croparea,level="reg",gdx=gdx,water="ir",crop_aggr=TRUE),fig.placement="H",fig.orientation="landscape")

swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Irrigated production}")
swfigure(sw,print,validationPlot(func=production,level="glo",gdx=gdx,water="ir",crop_aggr=TRUE),fig.placement="H",fig.orientation="landscape",tex_caption="Irrigated Production [mio tDM]")
swfigure(sw,print,validationPlot(func=production,level="reg",gdx=gdx,water="ir",crop_aggr=TRUE),fig.placement="H",fig.orientation="landscape",tex_caption="Irrigated Production [mio tDM]")

swclose(sw)
