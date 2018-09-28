# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

library(gdx)
library(luscale)
library(luplot)
library(lucode)
library(lusweave)
library(magpie4)
library(ncdf4)
library(raster)
library(magpiesets)
library(moinput)
library(mrvalidation)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir    <-"."
}

gdx        <- paste0(outputdir, "/fulldata.gdx")

###############################################################################
setConfig(forcecache=TRUE)
## Model output
modout_land <- land(gdx,level="grid",spamfiledirectory = outputdir)
getNames(modout_land,dim=1) <- reportingnames(getNames(modout_land,dim=1))
destfile <- "mag_land.nc"
## Writing netcdf files
if(!file.exists(paste0(outputdir,"/",destfile))) {
  writeLines("\nSeems like the nCDF file I am looking for doesn't exist yet.\n")
  writeLines("\nWriting model output to nc file:\n")
  write.magpie(modout_land,file_name=paste0(outputdir,"/",destfile),comment="model output LU area")
} else {writeLines("\nFound the nCDF file I was looking for. Starting processing:\n")}

destplots <- "CroplandDiffPlots"
if(!dir.exists(file.path(outputdir,destplots))){
  writeLines(paste0("\nMaking new folder. Plots will be saved in directory: ",destplots,"\n"))
  dir.create(file.path(outputdir,destplots))
} else {writeLines(paste0("\nPlots will be saved in directory: ",destplots,"\n"))}

model <- read.magpie(paste0(outputdir,"/",destfile))

## Only cropland, no diff
writeLines(paste0("\n Plotting cropland .....\n"))
yr_to_plot <- c("y2050","y2100")
for(yr1 in yr_to_plot){
  plotmap2(model[,yr1,"Cropland"],file = paste0(outputdir, "/", destplots, "/", "Cropland_",yr1, ".png"),lowcol = "red",midcol = "white",highcol = "green",midpoint = 0,title = paste0("Cropland in ",yr1),sea = FALSE,text_size = 30,legendname = "Change in mha.",plot_height = 18,plot_width = 36)
  dev.off()
}

## All land types, diff with first year
for (i in getNames(model)) {
      var=i
      yrs <- getYears(model)
      #breakpoints <- c(-0.10,-0.05,-0.01,0.01,0.05,0.10)
      #colors <- c("red4","red","cadetblue1","green","green4")
      for(y in 2:length(yrs)){
        writeLines(paste0("\n",i," ",getYears(model)[y]," vs ",getYears(model)[1],"\n"))
        model_diff <- setYears(model[,y,var],NULL) - setYears(model[,1,var],NULL)
        plotmap2(model_diff,file = paste0(outputdir, "/", destplots, "/", var, "_", getYears(model)[y], " vs ", getYears(model)[1], ".png"),lowcol = "red",midcol = "white",highcol = "green",midpoint = 0,title = paste0(var, "_", getYears(model)[y], " vs ", getYears(model)[1]),sea = FALSE,text_size = 30,legendname = "Change in mha.",plot_height = 18,plot_width = 36)
        #swfigure(sw,"plot",model_diff,sw_option="width=10,height=6",tex_caption = paste0("Diff plot for ",var," in ",gsub("X","",yrs[y])),breaks=breakpoints, col=colors)
        dev.off()
  }
}
