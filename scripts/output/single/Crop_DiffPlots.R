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
modout_croparea <- croparea(gdx,level="grid",products="kcr",product_aggr=FALSE,spamfiledirectory = outputdir,water_aggr=FALSE)
getNames(modout_croparea,dim=1) <- reportingnames(getNames(modout_croparea,dim=1))
getNames(modout_croparea,dim=2) <- reportingnames(getNames(modout_croparea,dim=2))

## Historical data
hist_croparea <- calcOutput("ValidCellularCroparea",aggregate=FALSE)

## Writing netcdf files
writeLines("\nWriting historical data to nc file\n")
write.magpie(hist_croparea,file_name=paste0(outputdir,"/hist_CA.nc"),comment="historical crop area")
writeLines("\nWriting model output to nc file\n")
write.magpie(modout_croparea,file_name=paste0(outputdir,"/modout_CA.nc"),comment="model output crop area")

sw<-swopen(paste0(outputdir,"/DiffPlot_Crops.pdf"))

swlatex(sw,c("\\title{Difference plots (Crops)}","\\author{PIK Landuse Group}"))
swlatex(sw,"\\huge")
swlatex(sw,"\\textbf{Difference plots for Crops (Model output-Historical)}\\newline")
swlatex(sw,"\\normalsize")
swlatex(sw,"\\newline")
swlatex(sw,"\\tableofcontents")
swlatex(sw,"\\newpage")

namediff <- length(setdiff(names(nc_open(paste0(outputdir,"/hist_CA.nc"))$var),names(nc_open(paste0(outputdir,"/modout_CA.nc"))$var)))

if( namediff > 0){
  stop("Names don't match for model output and historical data.")
} else {
  crops <- unique(gsub( "/.*$", "", names(nc_open(paste0(outputdir,"/hist_CA.nc"))$var)))
  irrig <- unique(gsub(".*/","",names(nc_open(paste0(outputdir,"/hist_CA.nc"))$var)))

  for (i in crops) {
    swlatex(sw,"\\section{",i,"}")
    for (j in irrig) {
      var=paste0(i,"/",j)
      swlatex(sw,paste0("\\subsection{",j,"}"))
      hist <- brick(paste0(outputdir,"/hist_CA.nc"),varname=var)
      model <- brick(paste0(outputdir,"/modout_CA.nc"),varname=var)
      yrs <- intersect(names(hist),names(model))
      breakpoints <- c(-0.10,-0.05,-0.01,0.01,0.05,0.10)
      colors <- c("red4","red","cadetblue1","green","green4")
      for(y in 1:length(yrs)){
        diff <- model[[yrs[y]]]-hist[[yrs[y]]]
        cat(paste0("Processing diff map :",var," --- ",gsub("X","",yrs[y]),"\n"))
        swfigure(sw,"plot",diff,sw_option="width=10,height=6",tex_caption = paste0("Diff plot for ",var," in ",gsub("X","",yrs[y])),breaks=breakpoints, col=colors)
      }
    }
  }

}
swclose(sw)
