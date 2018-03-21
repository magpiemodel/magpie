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
writeLines("\nWriting historical data to spatially explicit file\n")
write.magpie(hist_croparea,file_name=paste0(outputdir,"/hist_CA.mz"),comment="historical crop area")
writeLines("\nWriting model output to spatially explicit file\n")
write.magpie(modout_croparea,file_name=paste0(outputdir,"/modout_CA.mz"),comment="model output crop area")

# Open a sweave stream
sw<-swopen(paste0(outputdir,"/DiffPlot_CropReshuffling.pdf"))

# Aesthetics
swlatex(sw,"\\huge")
swlatex(sw,"\\textbf{Reshuffling information for Crops (Model output-Historical)}\\newline")
swlatex(sw,"\\normalsize")
swlatex(sw,"\\newline")
swlatex(sw,"\\tableofcontents")
swlatex(sw,"\\newpage")

# Read back the historical and model data
hist <- read.magpie(paste0(outputdir,"/hist_CA.mz"))
model <- read.magpie(paste0(outputdir,"/modout_CA.mz"))

# Historical data cells are having an ISO first name here so set that to cells from model data
getCells(hist) <- getCells(model)

# Check if the names match between model and historical data
namediff <- length(setdiff(getNames(model),getNames(hist)))

if( namediff > 0){
  stop("Names don't match for model output and historical data.")
} else {
  # Extract crop names
  crops <- getNames(hist,dim = 1)
  # Extract Irrigation type
  irrig <- getNames(hist,dim = 2)

  ## Start plotting for each crop
  for (i in crops) {
    swlatex(sw,"\\section{",i,"}")
    for (j in irrig) {
      var=paste0(i,".",j)
      swlatex(sw,paste0("\\subsection{",j,"}"))
      hist_temp <- hist[,,var]
      model_temp <- model[,,var]

      # Only need common years
      yrs <- intersect(getYears(hist_temp),getYears(model_temp))
     for(y in yrs){
        cat(j,i,"in",y,"\n")
        ## Calculate differences
        diff <- model_temp[,y,]-hist_temp[,y,]

        ## Spatially explicit map
        swfigure(sw,"plotmap2",sw_option="width=10,height=6",
                 data=diff,midpoint = 0,title = paste0(i," (",j,")"),
                 midcol = "white",highcol = "blue",lowcol = "red",
                 sea = F,legend_range = c(-0.15,0.15),legendname = "mha")

        ## Global numbers
        abs <- dimSums(diff,dim = 1)
        abs_gross <- dimSums(abs(diff),dim = 1)
        global <- mbind(abs,abs_gross)
        getNames(global) <- c("Net","Gross")
        swtable(sw,global,vert.lines = 1,hor.lines = 1,caption = "Global change (mha)",caption.placement="top",transpose = F)

        ## Regional numbers
        diff_pos <- diff[which(diff>=0)]
        expansion <- superAggregate(diff_pos,aggr_type = "sum",level = "regglo")
        diff_neg <- diff[which(diff<=0)]
        reduction <- superAggregate(diff_neg,aggr_type = "sum",level = "regglo")

        shuffling <- setNames(mbind(expansion,reduction),c("Expansion","Reduction"))
        shuffling <- add_columns(shuffling,addnm = "Net change",dim = 3.1)
        shuffling[,,"Net change"] <- shuffling[,,"Expansion"]+shuffling[,,"Reduction"]
        shuffling <- add_columns(shuffling,addnm = "Gross change",dim = 3.1)
        shuffling[,,"Gross change"] <- shuffling[,,"Expansion"]+(shuffling[,,"Reduction"]*(-1))
        swtable(sw,shuffling,
                vert.lines = 1,hor.lines = 1,label = "Re-Shuffling (mha)",caption = "Regional reshuffling",
                transpose = TRUE,colsplit = dim(expansion)[1]+1,caption.placement="top")
      }
    }

    ## Sum of irrigation types
    swlatex(sw,paste0("\\subsection{Irrigation total}"))
    yrs <- intersect(getYears(hist_temp),getYears(model_temp))
    for(y in yrs){
      cat(i,"(rainfed+irrigated) in",y,"\n")
      hist_total_irrig <- dimSums(hist[,y,i],dim = 3.2)
      model_total_irrig <- dimSums(model[,y,i],dim = 3.2)
      diff <- model_total_irrig-hist_total_irrig
      ## Spatially explicit map
      swfigure(sw,"plotmap2",sw_option="width=10,height=6",
               data=diff,midpoint = 0,title = paste0(i," (Rainfed+Irrigated)"),
               midcol = "white",highcol = "blue",lowcol = "red",
               sea = F,legend_range = c(-0.15,0.15),legendname = "mha")

      ## Global numbers
      abs <- dimSums(diff,dim = 1)
      abs_gross <- dimSums(abs(diff),dim = 1)
      global <- mbind(abs,abs_gross)
      getNames(global) <- c("Net","Gross")
      swtable(sw,global,vert.lines = 1,hor.lines = 1,caption = "Regiona specific change (mha)",caption.placement="top",transpose = F)

      ## Regional numbers
      diff_pos <- diff[which(diff>=0)]
      expansion <- superAggregate(diff_pos,aggr_type = "sum",level = "regglo")
      diff_neg <- diff[which(diff<=0)]
      reduction <- superAggregate(diff_neg,aggr_type = "sum",level = "regglo")

      shuffling <- setNames(mbind(expansion,reduction),c("Expansion","Reduction"))
      shuffling <- add_columns(shuffling,addnm = "Net change",dim = 3.1)
      shuffling[,,"Net change"] <- shuffling[,,"Expansion"]+shuffling[,,"Reduction"]
      shuffling <- add_columns(shuffling,addnm = "Gross change",dim = 3.1)
      shuffling[,,"Gross change"] <- shuffling[,,"Expansion"]+(shuffling[,,"Reduction"]*(-1))
      swtable(sw,shuffling,
              vert.lines = 1,hor.lines = 1,label = "Re-Shuffling (mha)",caption = "Regional reshuffling",
              transpose = TRUE,colsplit = dim(expansion)[1]+1,caption.placement="top")

    }

  }

}
swclose(sw)
