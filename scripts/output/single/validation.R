# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

################################################################################
## Produces  a pdf with validation output ##
################################################################################

# Version 1.17 - Markus Bonsch, Florian Humpen?der, Jan Philipp Dietrich
# Version 1.01 - Introduced validation plots with FAO data
# Version 1.02 - Complete remake. Contains now Model setup information
# Version 1.03 - Adapted for local use
# Version 1.04 - Added source_include if statement (FH)
# Version 1.05 - gdx now only contains parameters of the gdx file (jpd)
# Version 1.06 - Made out a global variable (MB)
# Version 1.07 - Made out local again and changed cropland comparison to ovm_area
# Version 1.08 - Better representation of water shadow price
# Version 1.09 - Called now from main folder
# Version 1.10 - Adapted to new structure
# Version 1.11 - Several bugfixes (jpd)
# Version 1.12 - Adapted new library structure, deactivated code which directly
#                accessed landusedata
# Version 1.13 - bugfix due to changes in croparea(...) MB
# Version 1.14 - Added historical data for cropland validation MB
# Version 1.15 - Added land use change tables IW
# Version 1.16 - Introduced pasture validation plots with FAO data IW
# Version 1.17 - Replaced validation Plots by plots from validationLibrary MB

library(lucode)
library(ludata)
library(lusweave)
library(luplot)
library(magpie)
library(faodata)
library(validation)

############################# BASIC CONFIGURATION #############################
lr_input_folder        <- "../../input/cellular"

additional_input <- "fulldata.gdx"                # Further data that needs to be provided, can be gdx or lst

if(!exists("source_include")) {

  outputdir    <-"."
  data_workspace        <- "B0.RData"     # title of the run (with date)
  latexpath        <- ""
  title<-"dummy"
  
  #Define arguments that can be read from command line
  readArgs("outputdir","data_workspace","additional_input","latexpath")
}
###############################################################################

validationPDF <- function(lr_input_folder,additional_input,outputdir,data_workspace,latexpath,title) {

  ##############################Load data sources ###############################
  # Load workspace with model setup and FAO data
  load(data_workspace)
  # Set gdx path
  gdx<-path(outputdir,additional_input)
  
  ################################################################################
  ############################Open the swstream object############################
  # Open the R to Latex stream
  swout<-swopen(paste(outputdir,"/",title,"_validation.pdf",sep=""))
  swlatex(swout,c("\\title{MAgPIE results}","\\author{PIK Landuse Group}","\\maketitle","\\tableofcontents"))
  
  ################################################################################
  #############################Prepare output production##########################
  
  on.exit(
    if(!is.na(latexpath)){
      swclose(swout,clean_output=FALSE,latexpath=latexpath,engine="knitr")
    }else{
      swclose(swout,clean_output=FALSE,engine="knitr")
    }
  )
  
  ################################################################################
  ############################Write Model outputs#################################
  
  #########Warnings##############
  if(!is.null(validation$technical$last.warning)) {
    swlatex(swout,"\\newpage")
    swlatex(swout,"\\section{Warnings}")
    swR(swout,"structure",validation$technical$last.warning, class = "warnings")
  }
  
  #########Results##############
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\section{Results}")
  
  
  #########Modelstat and goal function value##############
  swlatex(swout,"\\subsection{Modelstat}")
  #Modelstat
  modstat<-modelstat(gdx)
  swtable(swout,modstat,table.placement="H",caption.placement="top",transpose=TRUE,caption="main",vert.lines=1,align="c")
  #global costs in billion USD
  swlatex(swout,"\\subsection{Goal function value}")
  costs_glo<-setNames(costs(gdx,level = "glo",type = "total")/1000,"Global costs (billion USD)")
  swtable(swout,costs_glo,table.placement="H",caption.placement="top",transpose=TRUE,caption="Global costs (billion USD)",vert.lines=1,align="c")
  
  ########Traffic Light ###########
  swlatex(swout,"\\subsection{TrafficLights}")
  #Tau
  TL<-trafficLight(func=tau,gdx=gdx,level="glo",plot=FALSE)
  #Cropland
  TL<-mbind(TL,trafficLight(func=land,types="crop",gdx=gdx,level="glo",plot=FALSE))
  #Pasture
  TL<-mbind(TL,trafficLight(func=land,types="past",gdx=gdx,level="glo",plot=FALSE))
  #forest
  TL<-mbind(TL,trafficLight(func=land,types="forest",gdx=gdx,level="glo",plot=FALSE))
  #Carbon emissions
  TL<-mbind(TL,trafficLight(func=emissions,gdx=gdx,level="glo",plot=FALSE))
  #Irrigated area
  TL<-mbind(TL,trafficLight(func=croparea,gdx=gdx,level="glo",water="ir",crop_aggr=TRUE,plot=FALSE))
  #Agricultural water withdrawals
  TL<-mbind(TL,trafficLight(func=water_usage,gdx=gdx,level="glo",users="agriculture",plot=FALSE))
  
  p<-plot_TL(TL,text_size=20)
  swfigure(swout,print,p,fig.orientation="landscape",tex_caption = "Traffic light validation for different global model outputs")
  
  ############Comparison plots############################3
  swlatex(swout,"\\subsection{Visual validation}")
  
  #########Tau comaprison######################
  swlatex(swout,"\\subsubsection{Tau}")
  swfigure(swout,plot_func=grid.draw,validationPlot(func=tau,level="glo",gdx=gdx,same_yscale=T,withTL=TRUE),fig.placement="H",fig.orientation="landscape",sw_option="height=10")  
  swfigure(swout,plot_func=grid.draw,validationPlot(func=tau,level="reg",gdx=gdx,same_yscale=T),fig.placement="H",fig.orientation="landscape",sw_option="height=10")  
  swtable(swout,tc(gdx)[,"y1995",],table.placement="H",caption.placement="top",transpose=TRUE,caption="TC 1995 (-)",vert.lines=1,align="c",digits=3)
  swlatex(swout,"\\newpage")
  
  #########cropland comparison##############
  swlatex(swout,"\\subsubsection{Cropland comparison (absolute)}")
  swfigure(swout,plot_func=grid.draw,validationPlot(func=land,types="crop",level="glo",gdx=gdx,index=F,same_yscale=T,years=c(1960,NA),withTL=TRUE),fig.placement="H",fig.orientation="landscape",sw_option="height=10")
  swfigure(swout,plot_func=grid.draw,validationPlot(func=land,types="crop",level="reg",gdx=gdx,index=F,same_yscale=T,years=c(1960,NA)),fig.placement="H",fig.orientation="landscape",sw_option="height=10")
  swlatex(swout,"\\subsubsection{Cropland comparison (index)}")
  swfigure(swout,plot_func=grid.draw,validationPlot(func=land,types="crop",level="reg",gdx=gdx,index=T,same_yscale=T,years=c(1960,NA)),fig.placement="H",fig.orientation="landscape",sw_option="height=10")
  
  #########Pasture comparison##############
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\subsubsection{Pasture comparison (absolute)}")
  swfigure(swout,plot_func=grid.draw,validationPlot(func=land,types="past",level="glo",gdx=gdx,index=F,same_yscale=T,years=c(1960,NA),withTL=TRUE),fig.placement="H",fig.orientation="landscape",sw_option="height=10")
  swfigure(swout,plot_func=grid.draw,validationPlot(func=land,types="past",level="reg",gdx=gdx,index=F,same_yscale=T,years=c(1960,NA)),fig.placement="H",fig.orientation="landscape",sw_option="height=10")
  swlatex(swout,"\\subsubsection{Pasture comparison (index)}")
  swfigure(swout,plot_func=grid.draw,validationPlot(func=land,types="past",level="reg",gdx=gdx,index=T,same_yscale=T,years=c(1960,NA)),fig.placement="H",fig.orientation="landscape",sw_option="height=10")
  
  #########Forest comparison##############
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\subsubsection{Forest comparison (absolute)}")
  swfigure(swout,plot_func=grid.draw,validationPlot(func=land,types="forest",level="glo",gdx=gdx,index=F,same_yscale=T,years=c(1960,NA),withTL=TRUE),fig.placement="H",fig.orientation="landscape",sw_option="height=10")
  swfigure(swout,plot_func=grid.draw,validationPlot(func=land,types="forest",level="reg",gdx=gdx,index=F,same_yscale=T,years=c(1960,NA)),fig.placement="H",fig.orientation="landscape",sw_option="height=10")
  swlatex(swout,"\\subsubsection{Forest comparison (index)}")
  swfigure(swout,plot_func=grid.draw,validationPlot(func=land,types="forest",level="reg",gdx=gdx,index=T,same_yscale=T,years=c(1960,NA)),fig.placement="H",fig.orientation="landscape",sw_option="height=10")
  
  #########Carbon emission comparison##############
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\subsubsection{Carbon emission comparison (absolute)}")
  swfigure(swout,plot_func=grid.draw,validationPlot(func=emissions,type="co2_c",level="glo",gdx=gdx,index=F,same_yscale=T,years=c(1960,NA),withTL=TRUE),fig.placement="H",fig.orientation="landscape",sw_option="height=10")
  swfigure(swout,plot_func=grid.draw,validationPlot(func=emissions,type="co2_c",level="reg",gdx=gdx,index=F,same_yscale=T,years=c(1960,NA)),fig.placement="H",fig.orientation="landscape",sw_option="height=10")
  
  #########Irriated area comparison##############
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\subsubsection{Irrigated area comparison (absolute)}")
  swfigure(swout,plot_func=grid.draw,validationPlot(func=croparea,water="ir",crop_aggr=TRUE,level="glo",gdx=gdx,index=F,same_yscale=T,years=c(1960,NA),withTL=TRUE),fig.placement="H",fig.orientation="landscape",sw_option="height=10")
  swfigure(swout,plot_func=grid.draw,validationPlot(func=croparea,water="ir",crop_aggr=TRUE,level="reg",gdx=gdx,index=F,same_yscale=T,years=c(1960,NA)),fig.placement="H",fig.orientation="landscape",sw_option="height=10")
  
  #########Agricutlural water withdrawal comparison##############
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\subsubsection{Agricultural water withdrawal comparison (absolute)}")
  swfigure(swout,plot_func=grid.draw,validationPlot(func=water_usage,users="agriculture",level="glo",gdx=gdx,index=F,same_yscale=T,years=c(1960,NA),withTL=TRUE),fig.placement="H",fig.orientation="landscape",sw_option="height=10")
  swfigure(swout,plot_func=grid.draw,validationPlot(func=water_usage,users="agriculture",level="reg",gdx=gdx,index=F,same_yscale=T,years=c(1960,NA)),fig.placement="H",fig.orientation="landscape",sw_option="height=10")
  
  
  #########Land use change##############
  swlatex(swout,"\\newpage")
  #########Land use change cropland 1995##############
  swlatex(swout,"\\subsection{Land use change in 1995 (reshuffling)}")
  ovm_land<-land(path(outputdir,additional_input),level="cell",sum=FALSE)[,"y1995",]
  fm_land<-readGDX(path(outputdir,additional_input),"pm_land_start", format="first_found")[,,getNames(ovm_land)]
  dimnames(fm_land)[[2]]<-"y1995"
  diff <- as.magpie(ovm_land - fm_land)
  contraction <- as.magpie((diff < 0) *diff)
  expansion <- as.magpie((diff > 0) *diff)
  contraction_reg <- superAggregate(contraction,level="reg",aggr_type="sum")
  contraction_glo <- superAggregate(contraction,level="glo",aggr_type="sum")
  contraction<-mbind(contraction_reg,contraction_glo)
  expansion_reg <- superAggregate(expansion,level="reg",aggr_type="sum")
  expansion_glo <- superAggregate(expansion,level="glo",aggr_type="sum")
  expansion<-mbind(expansion_reg,expansion_glo)
  
  ovm_land_reg<-superAggregate(ovm_land,level="reg",aggr_type="sum")
  ovm_land_glo<-superAggregate(ovm_land,level="glo",aggr_type="sum")
  ovm_land<-mbind(ovm_land_reg,ovm_land_glo)
  fm_land_reg<-superAggregate(fm_land,level="reg",aggr_type="sum")
  fm_land_glo<-superAggregate(fm_land,level="glo",aggr_type="sum")
  fm_land<-mbind(fm_land_reg,fm_land_glo)
  
  croparea<-croparea(path(outputdir,additional_input),water="sum")
  getNames(croparea)<-"crop"
  croparea_glo<-croparea(path(outputdir,additional_input),level="glo",water="sum")
  getNames(croparea_glo)<-"crop"
  croparea<-mbind(croparea,croparea_glo)
  
  
  expansion_crop <- expansion[,,"crop"]
  dimnames(expansion_crop)[[3]]<-"expansion"
  contraction_crop <- contraction[,,"crop"]
  dimnames(contraction_crop)[[3]]<-"contraction"
  net_changes<-ovm_land[,,"crop"]-fm_land[,,"crop"]
  dimnames(net_changes)[[3]]<-"net changes"
  gross_changes<-as.magpie(abs(expansion_crop)+abs(contraction_crop))
  dimnames(gross_changes)[[3]]<-"gross changes"
  all<-mbind(expansion_crop,contraction_crop,net_changes,gross_changes)
  swtable(swout,all[,"y1995",],transpose=TRUE,caption.placement="top",caption="Land use change cropland 1995 (Mio. ha)",table.placement="H",vert.lines=1,align="r",hor.lines=1)
  
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\subsection{Land use change tables}")
  land <- land(gdx,level="reg")
  landtypes <- getNames(land)
  for(i in 1:length(landtypes)){
    landtype_area<-land(gdx,level="reg",types=paste(landtypes[i]))
    dimnames(landtype_area)[[3]]<-paste(landtypes[i],"area in mio ha")
    landtype_area_glo <- colSums(landtype_area)
    dimnames(landtype_area_glo)[[3]]<-paste(landtypes[i],"area in mio ha")
    landtype_area_total <- mbind(landtype_area,landtype_area_glo)
    swtable(swout,round(landtype_area_total),table.placement="H",caption.placement="top",caption=paste(landtypes[i],"area in mio ha"),vert.lines=1,align="r",
            hor.lines=1,digits=0,transpose=TRUE)
  }
  swlatex(swout,"\\newpage")
  
  
  #########Land allocation##############
  #swlatex(swout,"\\subsection{Land allocation}")
  #swfigure(swout,alloc_plot,land=land(gdx,level="reg"),title="Total land (si0+nsi0 | global)",level="glo",fig.orientation="landscape")
  #swfigure(swout,alloc_plot,land=land(gdx,level="reg"),title="Total land (si0+nsi0 | regional)",fig.orientation="landscape")
  #swfigure(swout,alloc_plot,land=land(gdx,level="reg",siclass="si0"),title="Suitable land (si0 | global)",level="glo",fig.orientation="landscape")
  #swfigure(swout,alloc_plot,land=land(gdx,level="reg",siclass="si0"),title="Suitable land (si0 | regional)",fig.orientation="landscape")
  #swfigure(swout,alloc_plot,land=land(gdx,level="reg",siclass="nsi0"),title="Non-suitable land (nsi0 | global)",level="glo",fig.orientation="landscape")
  #swfigure(swout,alloc_plot,land=land(gdx,level="reg",siclass="nsi0"),title="Non-suitable land (nsi0 | regional)",fig.orientation="landscape")
  
  compare2fao <- function(swout,gdx,type) {
    swlatex(swout,paste0("\\subsection{MAgPIE - FAO ", type, " comparison }"))
    #read results from gdx
    func <- get(type,mode="function")
    mag <- func(gdx,level="reg",crop_aggr=FALSE,water="sum",crops="kcr")[,1995,]
    #create output
    i2iso <- readGDX(gdx,"i_to_iso")
    func <- switch(type, croparea = ludata::getArea, yields = ludata::getYields, production = ludata::getProduction)
    fao <- as.magpie(func(level=i2iso)[,getNames(mag,fulldim=FALSE)])
    fao_vec<-as.vector(fao)
    mag_vec<-as.vector(mag)
    xlab <- switch(type, croparea = "FAO regional area 1995 [mio. ha]", yields = "FAO regional yield 1995 [t / ha]", production = "FAO regional production [t]")
    ylab <- switch(type, croparea = "MAgPIE regional area 1995 [mio. ha]", yields = "MAgPIE regional yield 1995 [t / ha]", production = "MAgPIE regional production 1995 [t]")
    swfigure(swout,performancePlot,pdata=mag_vec,odata=fao_vec,measures=c("Willmott","Willmott refined","Nash Sutcliffe","RMSE","MAE","Pearson"),na.rm=T,xlab=xlab,ylab=ylab,main=paste0("Crop- and regionspecific ", type, " comparison MAgPIE / FAO"),fig.placement="H",fig.width=0.5)
    swtable(swout,mag/fao,table.placement="H",caption.placement="top",transpose=TRUE,caption=paste0("MAgPIE ", type, " / FAO ", type, " regional"),vert.lines=1,align="c",hor.lines=1)
  }

  #########cropland comparison 2##############
  compare2fao(swout,gdx,"croparea")
    
  #########Yield comparison##############
  compare2fao(swout,gdx,"yields")
    
  #########Production comparison##############
  compare2fao(swout,gdx,"production")



  #########Water shadow price##############
  # Get low_res and high_res from info.txt
  info.txt <- readLines(path(outputdir,"info.txt"),warn=FALSE)
  get_res <- function(file,pattern,sep) {
    res <- grep(pattern,file, value=TRUE)
    res <- strsplit(res, sep)
    res <- sapply(res, "[[", 2)
    if (!regexpr("[a-z]",res) > 0) {
      res <- as.numeric(res)
    }
    return(res)
  }
  low_res <- get_res(info.txt,"^Low resolution",": ")
  high_res <- get_res(info.txt,"^High resolution",": ")  
  sum_spam_file <- paste("",high_res,"-to-",low_res,"_sum.spam", sep="")
  
  watnames <- c("ov_watdem","ovm_watdem")
   
  if(any(watnames %in% readGDX(gdx,format="name")) && file.exists(path(lr_input_folder,sum_spam_file))){
    swlatex(swout,"\\subsection{Water shadow price}")
    wat_price<-collapseNames(-1* readGDX(gdx, watnames, format="first_found")[,,"agriculture"][,,"marginal"])
  
    rel <- read.spam(path(lr_input_folder,sum_spam_file))
    wat_price<-speed_aggregate(wat_price,t(rel))
    if(max(wat_price[,"y1995",])<=0){
      legend_range<-c(0,0.000001,0.5,0.7,1)
    } else{
      int<-round(max(wat_price[,"y1995",])/4,4)
      legend_range<-c(0,int,2*int,3*int,4*int+0.01)
    }
    swfigure(swout,plotmap,wat_price[,"y1995",1],legend_discrete=TRUE,legend_range=legend_range,legend_colours=c("blue","green","yellow","red"),legend_xy = c(-180, -15),main="Water shadow price 1995",fig.placement="H",fig.orientation="landscape",fig.width=0.8)
  
    if("y2045" %in% getYears(wat_price)){
      if(max(wat_price[,"y2045",])<=0){
        legend_range<-c(0,0.000001,0.5,0.7,1)
      } else{
      int<-round(max(wat_price[,"y2045",])/4,4)
        legend_range<-c(0,int,2*int,3*int,4*int+0.01)
      }
      swfigure(swout,plotmap,wat_price[,"y2045",1],legend_discrete=TRUE,legend_range=legend_range,legend_colours=c("blue","green","yellow","red"),legend_xy = c(-180, -15),main="Water shadow price 2045",fig.placement="H",fig.orientation="landscape",fig.width=0.8)
    }
  }
  
  #########fraction of actually irrigated area over AEI##############
  # Regional and global area equipped for irrrigation
  AEI<-water_AEI(gdx,level="reg")
  dimnames(AEI)[[3]]<-"AEI"
  AEI_glo<-colSums(AEI)
  dimnames(AEI_glo)[[3]]<-"AEI"
  AEI<-mbind(AEI,AEI_glo)
  #Regional and global irrigated area
  AAI <- croparea(gdx,level="reg",water="ir")
  dimnames(AAI)[[3]]<-"AAI"
  AAI_glo<-colSums(AAI)
  dimnames(AAI_glo)[[3]]<-"AAI"
  AAI<-mbind(AAI,AAI_glo)
  # Ratio of the two
  AAI_AEI_frac<-as.magpie(AAI/AEI)
  swtable(swout,AAI_AEI_frac,table.placement="H",caption.placement="top",caption="regional and global fraction of actually used area equipped for irrigation ",vert.lines=1,align="c",hor.lines=1)
  
  # swlatex(swout,"\\newpage")
  # swlatex(swout,"\\subsection{Food Price Index}")
  # swfigure(swout,plot_func=grid.draw,validationPlot(func=priceIndex,crops=c("kfo","kli"),gdx=gdx,level="glo"),fig.placement="H",fig.orientation="landscape",fig.width=1)
  # swtable(swout,mbind(priceIndex(gdx,crops=c("kfo","kli"),level="reg"),priceIndex(gdx,crops=c("kfo","kli"),level="glo")),table.placement="H",caption.placement="top",transpose=TRUE,caption="Index 1995=100",vert.lines=1,align="c",digits=1)
  
  # swlatex(swout,"\\newpage")
  # swlatex(swout,"\\subsection{C Emissions}")
  # swfigure(swout,plot_func=grid.draw,validationPlot(func=emissions,type="co2_c",gdx=gdx,level="glo"),fig.placement="H",fig.orientation="landscape",fig.width=1)
  # swfigure(swout,plot_func=grid.draw,validationPlot(func=emissions,type="co2_c",gdx=gdx,level="reg"),fig.placement="H",fig.orientation="landscape",fig.width=1)
  # swtable(swout,mbind(emissions(gdx,type="co2_c",level="reg"),emissions(gdx,type="co2_c",level="glo")),table.placement="H",caption.placement="top",transpose=TRUE,caption="MtC per year",vert.lines=1,align="c",digits=2)
  
  
  # ################################################################################
  ############################ Write Technical stuff and inputs###################
  
  swlatex(swout,"\\newpage")
  swlatex(swout,"\\section{Model settings}")
  swR(swout,"cat","model run:",title)
  
  #########yield calib factor##############
  swlatex(swout,"\\subsection{Yield calibration factors}")
  calib_factor<-input_yieldcalib(gdx)
  dimnames(calib_factor)[[3]]<-c("crops","pasture")
  swtable(swout,calib_factor[,1,],table.placement="H",include.rownames=TRUE,transpose=TRUE,vert.lines=1,align="c",hor.lines=1)
  #write yield calib factors to file
  input_yieldcalib(gdx,file=paste(outputdir,"/",title,"_reg.calib_factor.csv",sep=""))
  
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
  
  
  #########Model version##############
  if(!is.null(validation$technical$model_setup)) { 
    swlatex(swout,"\\subsection{Code settings}")
    svn<-validation$technical$model_setup
    swR(swout,"cat",svn,sep='\n')
  }
  #########Input dataset##############
  if(!is.null(validation$technical$input_data)) { 
    swlatex(swout,"\\subsection{Dataset}")
    input_data<-validation$technical$input_data
    swR(swout,"cat",input_data,sep='\n')
  }
  #########Module Interfaces##############
  if(!is.null(validation$technical$modules)) { 
    swlatex(swout,"\\subsection{Module Interfaces}")
    swR(swout,print,validation$technical$modules)
  }
  
  #########R Informations##############
  if(!is.null(validation$technical$setup_info)) { 
    swlatex(swout,"\\subsection{R Information}")
    for(n in names(validation$technical$setup_info)) {
      swlatex(swout,paste0("\\paragraph{",n,"}"))
      swR(swout,print,validation$technical$setup_info[[n]]$sessionInfo)
      swR(swout,print,validation$technical$setup_info[[n]]$libPaths)
      swR(swout,print,validation$technical$setup_info[[n]]$installedpackages[,"Version"])
    }
  }
  
  
  #########Runtime information##############
  swlatex(swout,"\\section{Runtime information}")
  runtime<-NULL
  for(d in c(lapply(validation$technical$time,as.numeric,units="hours"),recursive=TRUE)) {
    runtime <- c(runtime,paste(format(floor(d),width=2),'h ',
                         format(floor((d-floor(d))*60),width=2),'m ',
                         format(round(((d-floor(d))*60-floor((d-floor(d))*60))*60),width=2),'s',
                         sep=''))
  }
  names(runtime) <- names(validation$technical$time)
  tmp <- NULL
  for(i in 1:length(runtime)) {
    runtime[i] <- paste(format(names(runtime[i]),width=20),': ',runtime[i],sep='')
  }
  swR(swout,"cat",runtime,sep='\n')
  
  ################################################################################
  ###################Create pdf###################################################
  
  ### -> moved to on.exit at the beginning
  
  #Save the Sweavestream
  sw_validation<-swout
  save(sw_validation,validation,file=data_workspace)
  ##############################################################################
}

validationPDF(lr_input_folder,additional_input,outputdir,data_workspace,latexpath,title)
