# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

################################################################################
## Produces  a pdf with validation output ##
################################################################################

## Version 0.1 - Benjamin Leon Bodirsky, Miodrag Stevanović, Abhijeet Mishra 
##-----------------------------------------------------------------------------------------
## Skeleton function for Validation pdf. Crude results included (can be changed later).
## Also includes the use of fulldata.gdx file
## Some directories are from my local machine. Please make changes before running the code.
options(error=recover)

library(lucode)
library(ludata)
library(lusweave)
library(luplot)
library(magpie4)
library(faodata)
library(validation)
library(ggplot2)

############################# BASIC CONFIGURATION #############################
#lr_input_folder        <- "../../input/cellular"

if(!exists("source_include")) {

  outputdir    <- "C:/Users/mishra/Desktop/R Files"
  data_workspace        <- "B0.RData"     # title of the run (with date)
  latexpath        <- ""
  title <- "DEMO"
	
  #Define arguments that can be read from command line
  readArgs("outputdir","data_workspace","additional_input","latexpath")
}
###############################################################################

validationPDF <- function(outputdir,title) {
  
  report_mif <- path(outputdir,"report.mif")
  valid_mif <- "input/validation.mif"
  
  
  result <- read.report(report_mif,as.list=FALSE)
  valid <- read.report(valid_mif,as.list=FALSE)
    
  gdx <- path(outputdir,"fulldata.gdx")
  
  ################################################################################
  ############################Open the swstream object############################
  # Open the R to Latex stream
  swout<-swopen(paste(outputdir,"/",title,"_validation.pdf",sep=""))
  swlatex(swout,c("\\title{MAgPIE results}","\\author{PIK Landuse Group}","\\maketitle","\\tableofcontents"))
  
  ################################################################################
  #############################Prepare output production##########################
  
  ##### Why Specify explicitly ?? ####
  
  on.exit(
    if(!is.na(latexpath)){
      swclose(swout,clean_output=FALSE,latexpath=latexpath,engine="knitr")
    }else{
      swclose(swout,clean_output=FALSE,engine="knitr")
    }
  )
  
  ################################################################################
  ############################Write Model outputs#################################
  
  #########Results##############
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\section{Results}")
  
  #########Modelstat and goal function value##############
  swlatex(swout,"\\subsection{Modelstat}")
  #Modelstat
  modstat<-modelstat(gdx)
  swtable(swout,modstat,table.placement="H",caption.placement="top",transpose=TRUE,caption="main",vert.lines=1,align="c")
  #global costs in billion US$
  swlatex(swout,"\\subsection{Goal function value}")
  costs_glo<-setNames(costs(gdx,level = "glo",type = "total")/1000,"Global costs (billion US$)")
  swtable(swout,costs_glo,table.placement="H",caption.placement="top",transpose=TRUE,caption="Global costs (billion US$)",vert.lines=1,align="c")
  
   
  ########Traffic Light ###########
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\subsection{SomeTables}")
  swtable(swout,result[,,1],table.placement="H",caption.placement="top",transpose=TRUE,caption="Default.MAgPIE.Population (million)",vert.lines=1,align="c")
  swtable(swout,valid[,,1],table.placement="H",caption.placement="top",transpose=TRUE,caption="Historical.FAO.Agricultural demand|Food",vert.lines=1,align="c")
  ############Comparison plots############################3
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\subsection{Visual validation}")
  
  #########Tau comaprison######################
  swlatex(swout,"\\subsubsection{Tau}")

  swfigure(swout,plot_func=grid.draw,validationPlot(func=tau,level="glo",gdx=gdx,same_yscale=T,withTL=TRUE),fig.placement="H",fig.orientation="landscape",sw_option="height=10")  
  swfigure(swout,plot_func=grid.draw,validationPlot(func=tau,level="reg",gdx=gdx,same_yscale=T),fig.placement="H",fig.orientation="landscape",sw_option="height=10")  
  swtable(swout,tc(gdx)[,"y1995",],table.placement="H",caption.placement="top",transpose=TRUE,caption="TC 1995 (-)",vert.lines=1,align="c",digits=3)
  swlatex(swout,"\\newpage")
	
	######## TEST PLOT ############
	swlatex(swout,"\\subsubsection{Test Plot}")
	swfigure(swout, plot_func=mipLineHistorical, result["GLO",,"default.MAgPIE.Agriculture|Demand|Food (Mt DM/yr) (NA)"], valid["GLO",,"historical.FAO.Agricultural demand|Food| (Mt DM)"],fig.placement="H",fig.orientation="landscape",sw_option="height=10")
	# print(p)
	# swfigure(swout,print,p,fig.placement="H",fig.orientation="landscape",sw_option="height=10")  
  
    #########cropland comparison##############
  swlatex(swout,"\\subsubsection{Cropland comparison (absolute)}")
  swlatex(swout,"\\subsubsection{Cropland comparison (index)}")
  
  
  #########Pasture comparison##############
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\subsubsection{Pasture comparison (absolute)}")
  swlatex(swout,"\\subsubsection{Pasture comparison (index)}")
  
  #########Forest comparison##############
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\subsubsection{Forest comparison (absolute)}")
  
  swlatex(swout,"\\subsubsection{Forest comparison (index)}")
  
  #########Carbon emission comparison##############
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\subsubsection{Carbon emission comparison (absolute)}")
  
  #########Irriated area comparison##############
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\subsubsection{Irrigated area comparison (absolute)}")
  
  #########Agricutlural water withdrawal comparison##############
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\subsubsection{Agricultural water withdrawal comparison (absolute)}")
  
  #########Land use change##############
  swlatex(swout,"\\newpage")
  #########Land use change cropland 1995##############
  swlatex(swout,"\\subsection{Land use change in 1995 (reshuffling)}")
  
  
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\subsection{Land use change tables}")
  
  swlatex(swout,"\\newpage")
  
  
  #########Land allocation##############
  swlatex(swout,"\\subsection{Land allocation}")
  
  
  
  # ################################################################################
  ############################ Write Technical stuff and inputs###################
  
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\section{Model settings}")
  swR(swout,"cat","model run:",title)
  
  #########yield calib factor##############
  swlatex(swout,"\\subsection{Yield calibration factors}")
  
  #########check calib##############
  #swlatex(swout,"\\subsection{Check calibration}")
  #temporary: should be moved to landuse library
  #check_calib<-function(gdx_file,area_input="fao"){
  #  dummy_croparea<-croparea(gdx_file,level="reg",water="sum",crops="kcr",crop_aggr=FALSE)[,"y1995",]
  #  tmp_magpie<-croparea(gdx_file,level="reg",water="sum",crops="kcr",crop_aggr=TRUE)[,"y1995",]
  #  years<-paste("y",1990:1999,sep="")
  #  if(area_input=="fao"){
  #    tmp_cropdata<-rowMeans(fao_land_reg[,years,"Area.Arable_land_and_Permanent_crops"])
  #    tmp_pastdata<-rowMeans(fao_land_reg[,years,"Area.Permanent_meadows_and_pastures"])
  #  } else if(area_input=="hyde1990"){
  #    tmp_cropdata<-as.magpie(getArea(level="region",source="hyde")[,"y1990"])
  #    tmp_pastdata<-rowMeans(fao_land_reg[,years,"Area.Permanent_meadows_and_pastures"])
  #  } else {
  #    stop("Unknown area input for yield calibration")
  #  }
  #  magpie_croparea<-dummy_croparea
  #  data_croparea<-dummy_croparea
  #  for(crop in getNames(magpie_croparea)){
  #    magpie_croparea[,,crop]<-tmp_magpie 
  #    data_croparea[,,crop]<-tmp_cropdata
  #  }
  #  magpie_croparea<-mbind(magpie_croparea,setNames(land(gdx_file,level="reg",type="past",siclass="sum")[,"y1995",],"pasture"))
  #  data_croparea<-mbind(data_croparea,setNames(tmp_pastdata,"pasture"))
  #  area_factor<-magpie_croparea/data_croparea
  #  tc_factor<-(tc(gdx_file)+1)[,"y1995",]
  #  kve<-expand.set("kve",fullset="kve",gdx=gdx_file)
  #  calib_factor<-area_factor
  #  calib_factor[,,kve]<-calib_factor[,,kve]*as.numeric(tc_factor)
  #  return(calib_factor)
  #}
  #check<-check_calib(gdx)
  #check<-check[,,c("maiz","pasture")]
  #dimnames(check)[[3]]<-c("crops","pasture")
  #swtable(swout,check[,1,],table.placement="H",include.rownames=TRUE,transpose=TRUE,vert.lines=1,align="c",hor.lines=1)
  
  
  #########Runtime information##############
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\section{Runtime information}")
  
  ################################################################################
  ###################Create pdf###################################################
  
  ### -> moved to on.exit at the beginning
  
  #Save the Sweavestream
  sw_validation<-swout
  save(sw_validation,result, file = "Demo.RData")
  ##############################################################################
}

validationPDF(outputdir,title)
