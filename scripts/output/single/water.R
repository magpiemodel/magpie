# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de


###############################################
#### Calculates some water related outputs ####
###############################################
# Version 1.0, Markus bonsch
################################################################################
library(gdx)
library(magpie4)
library(validation)
library(lusweave)
############################# BASIC CONFIGURATION ##############################
additional_input<-"/iplex/01/landuse/data/input/other/"
lr_input_folder        <- "modules/10_land/input"
AEI_lr_file<-"avl_irrig.cs2"
AEI_hr_file<-"avl_irrig_0.5.mz"
AAI_hr_file<-"calibrated_area_0.5.mz"
AAI_hr_out_file<-"cell.AAI_0.5.mz"
land_hr_file<-"avl_land_0.5.mz"
prev_year        <- "y1985"            #timestep before calculations in MAgPIE

if(!exists("source_include")) {
  sum_spam_file    <- "0.5-to-h1000_sum.spam"
  outputdir        <- "/iplex/01/landuse/users/bonsch/projects/Papers/Alex_foley/rev7702_base1995/output/h1000/HadGEM2_ES-rcp2p6/BAU"
  title<-"test"
  rev<-20
  #Define arguments that can be read from command line
  readArgs("sum_spam_file","outputdir","title",rev)
} else{
  rev<-floor(cfg$rev)
}
hr_input_folder<-paste(additional_input,"rev",rev,sep="")
###############################################################################
gdx<-path(outputdir,"fulldata.gdx")
swout<-swopen(paste(outputdir,"/",title,"_water_results.pdf",sep=""),orientation="portrait")

# Regional and global area equipped for irrrigation
swlatex(swout,"\\section{Area equipped for irrigation}")
swfigure(swout,grid.draw,validationPlot(func=water_AEI,gdx=gdx,level="glo"),fig.orientation="landscape",tex_caption="Area equipped for irrigation (AEI) validation")
swfigure(swout,grid.draw,validationPlot(func=water_AEI,gdx=gdx,level="reg"),fig.orientation="landscape",tex_caption="Area equipped for irrigation (AEI) validation")
AEI_table<-water_AEI(gdx,level="reg")
AEI_table<-mbind(AEI_table,setCells(water_AEI(gdx,level="glo"),"GLO.11"))
swtable(swout,AEI_table,table.placement="H",caption.placement="top",lastdim.pos=1,caption="regional and global area equipped for irrigation [mio ha]",align="r",digits=0)


#Regional and global irrigated area
swlatex(swout,"\\section{Irrigated area}")
swfigure(swout,grid.draw,validationPlot(func=croparea,gdx=gdx,level="glo",water="ir",crop_aggr=TRUE),fig.orientation="landscape",tex_caption="Area actually irrigated (AAI) validation")
swfigure(swout,grid.draw,validationPlot(func=croparea,gdx=gdx,level="reg",water="ir",crop_aggr=TRUE),fig.orientation="landscape",tex_caption="Area actually irrigated (AAI) validation")
AAI_table<-croparea(gdx,water="ir",crop_aggr=TRUE,level="reg")
AAI_table<-mbind(AAI_table,setCells(croparea(gdx,water="ir",crop_aggr=TRUE,level="glo"),"GLO.11"))
swtable(swout,AAI_table,table.placement="H",caption.placement="top",lastdim.pos=1,caption="regional and global area actually irrigated (AAI) [mio ha]",align="r",digits=0)



# Regional irrigation efficiency
irr_eff<-round(water_efficiency(gdx,level="reg")*100,0)
swlatex(swout,"\\section{Irrigation efficiency}")
swfigure(swout,scratch_plot,irr_eff,add=FALSE,main="Irrigation efficiency",ylab="irrigation efficiency [per cent]",fig.orientation="landscape",tex_caption="Irrigation efficiency")
swtable(swout,irr_eff,digits=0,table.placement="H",caption.placement="top",caption="Irrigation efficiency [per cent]",align="r")

# Regional water use
swlatex(swout,"\\section{Water withdrawals}")
watdem<-water_usage(gdx,sum=FALSE)
watdem_glo<-colSums(watdem)
dimnames(watdem_glo)[[1]]<-"GLO.11"
watdem<-mbind(watdem,watdem_glo)
watdem_agr<-water_usage(gdx,users="kcr",sum=TRUE)
dimnames(watdem_agr)[[3]]<-"Irrigation water withdrawals"
watdem_agr_glo<-colSums(watdem_agr)
dimnames(watdem_agr_glo)[[1]]<-"GLO.11"
dimnames(watdem_agr_glo)[[3]]<-dimnames(watdem_agr)[[3]]
watdem_agr<-mbind(watdem_agr,watdem_agr_glo)
out_watdem_agr<-(array(NA,dim=c(dim(watdem_agr)[1]+1,dim(watdem_agr)[2],dim(watdem_agr)[3]),dimnames=list(c(dimnames(watdem_agr)[[1]],"GLO.12"),dimnames(watdem_agr)[[2]],dimnames(watdem_agr)[[3]])))
out_watdem_agr[1:dim(watdem_agr)[1],,]<-round(watdem_agr,2)
out_watdem_agr["GLO.12",1,]<-"2100 - 3400 Sauer2010"
out_watdem_agr<-as.magpie(out_watdem_agr)
swlatex(swout,"\\subsection{Irrigation water withdrawals}")
swfigure(swout,scratch_plot,watdem_agr[1:10,,],add="region_name",main="Irrigation water withdrawals",ylab="water use [km3]",fig.orientation="landscape",tex_caption="Irrigation water withdrawals")
swtable(swout,out_watdem_agr,digits=0,table.placement="H",caption.placement="top",caption="regional and global irrigation water withdrawals  [km3]  ",align="r")
for(i in getNames(watdem)){
  swlatex(swout,paste("\\subsection{",i," water withdrawals}"))
  swfigure(swout,scratch_plot,watdem[1:10,,i],add="region_name",main=paste(i," water withdrawals"),ylab="water use [km3]",fig.orientation="landscape",tex_caption=paste(i," water withdrawals"))
  swtable(swout,watdem[,,i],digits=0,table.placement="H",caption.placement="top",caption=paste("regional and global", i," water withdrawals  [km3]  ",align="r"))
}

# AWW Validation with data
swfigure(swout,grid.draw,validationPlot(func=water_usage,gdx=gdx,users="agriculture",level="glo",xlim=c(1970,2095)),fig.orientation="landscape",tex_caption="Global water withdrawal validation")


# Regional water availability
swlatex(swout,"\\section{Available water}")
wat_avail<-round(water_avail(gdx,sum=FALSE),digits=6)
watavail_glo<-round(colSums(wat_avail),digits=6)
dimnames(watavail_glo)[[1]]<-"GLO.11"
wat_avail<-mbind(wat_avail,watavail_glo)
watavail_tot<-rowSums(wat_avail,dims=2)
dimnames(watavail_tot)[[3]]<-"total"
wat_avail<-round(mbind(wat_avail,watavail_tot))
swlatex(swout,"\\subsection{Total}")
swfigure(swout,scratch_plot,wat_avail[1:10,,"total"],add="region_name",main="Available water",ylab="AW [km3]",fig.orientation="landscape",tex_caption="Available Water (AW)")
swtable(swout,wat_avail[,,"total"],table.placement="H",caption.placement="top",lastdim.pos=1,caption="regional and global available water  [km3]  ",digits=1)
for(i in (getNames(wat_avail)[-which(getNames(wat_avail)=="total")])) {
  swlatex(swout,paste("\\subsection{",i,"}"))
  swtable(swout,wat_avail[,,i],table.placement="H",caption.placement="top",lastdim.pos=1,caption=paste("regional and global available water from",i," [km3]  "),digits=1)
}
# Maps of areas
if(file.exists(hr_input_folder)){
  if(file.exists(path(outputdir,sum_spam_file))){
    print("cellular stuff produced")
  # Disaggregate AEI to cells using start information
    AEI_ini_lr<-readGDX(gdx,"fm_irrig","f41_irrig","f17_irrig", format="first_found"); dimnames(AEI_ini_lr)[[2]]<-prev_year ; dimnames(AEI_ini_lr)[[3]]<-"AEI"
    NAEI_ini_lr<-rowSums(input_land(gdx,siclass="sum"))
    NAEI_ini_lr<-as.magpie(NAEI_ini_lr-AEI_ini_lr)
    dimnames(NAEI_ini_lr)[[2]]<-prev_year; dimnames(NAEI_ini_lr)[[3]]<-"NAEI"
    AEI_ini_lr<-mbind(AEI_ini_lr,NAEI_ini_lr)
    rm(NAEI_ini_lr)
    AEI_out<-water_AEI(gdx,level="cell")
    NAEI_out<-land(gdx,level="cell",siclass="sum",sum=TRUE)
    NAEI_out<-as.magpie(NAEI_out-AEI_out)
    dimnames(NAEI_out)[[3]]<-"NAEI"
    AEI_out<-mbind(AEI_out,NAEI_out)
    rm(NAEI_out)
    AEI_ini_hr<-read.magpie(path(hr_input_folder,AEI_hr_file)); dimnames(AEI_ini_hr)[[2]]<-prev_year; dimnames(AEI_ini_hr)[[3]]<-"AEI"
    NAEI_ini_hr<-as.magpie(rowSums(read.magpie(path(lr_input_folder,land_hr_file)))-AEI_ini_hr); dimnames(NAEI_ini_hr)[[2]]<-prev_year; dimnames(NAEI_ini_hr)[[3]]<-"NAEI"
    AEI_ini_hr<-mbind(AEI_ini_hr,NAEI_ini_hr)
    AEI_hr<-interpolate(x=AEI_out,x_ini_lr=AEI_ini_lr,x_ini_hr=AEI_ini_hr,spam=path(outputdir,sum_spam_file))

    swlatex(swout,"\\section{Cellular area equipped for irrigation}")
    if(any(is.infinite(range(AEI_hr[,"y1995",1])))|any(is.na(range(AEI_hr[,"y1995",1])))){
      swlatex(swout,"No plot created because of infinite limits")
    } else {
      swfigure(swout,plotmap2,AEI_hr[,"y1995",1],legendname="10^6 ha",title="Area equipped for irrigation 1995 mio ha",fig.placement="H",fig.orientation="landscape",fig.width=0.8)
    }
    if(dim(AEI_hr)[2]>=6){
      if(any(is.infinite(range(AEI_hr[,6,1])))|any(is.na(range(AEI_hr[,6,1])))){
        swlatex(swout,"No plot created because of infinite limits")
      } else {
        swfigure(swout,plotmap2,AEI_hr[,6,1],legendname="10^6 ha",title=paste("Area equipped for irrigation in ",getYears(AEI_hr)[6],"(Mha)",sep=""),fig.placement="H",fig.orientation="landscape",fig.width=0.8)
      }
    }
  }
}

swlatex(swout,"\\section{Water shadow price}")
wat_price<-water_price(gdx,level="cell")
rel <- read.spam(path(outputdir,sum_spam_file))
wat_price<-speed_aggregate(wat_price,t(rel))
if(max(wat_price[,"y1995",])<=0){
  legend_range<-c(0,0.000001,0.5,0.7,1)
} else{
  int<-round(max(wat_price[,"y1995",])/4,4)
  legend_range<-c(0,int,2*int,3*int,4*int+0.01)
}
if(any(is.infinite(legend_range))|any(is.na(legend_range))){
  swlatex(swout,"No plot created because of infinite limits")
} else {
  swfigure(swout,plotmap_discrete,wat_price[,"y1995",1],legend_breaks=c(0,0.2,0.5,0.8,1.5,max(wat_price[,"y1995",1])),legendname="US$m^-3",title="Water shadow price 1995",fig.placement="H",fig.orientation="landscape",fig.width=0.8)
}

if(dim(wat_price)[2]>=6){
  if(max(wat_price[,6,])<=0){
    legend_range<-c(0,0.000001,0.5,0.7,1)
  } else{
    int<-round(max(wat_price[,6,])/4,4)
    legend_range<-c(0,int,2*int,3*int,4*int+0.01)
  }
  if(any(is.infinite(legend_range))|any(is.na(legend_range))){
    swlatex(swout,"No plot created because of infinite limits")
  } else {
    swfigure(swout,plotmap_discrete,wat_price[,6,1],legend_breaks=c(0,0.2,0.5,0.8,1.5,max(wat_price[,6,1])),legendname="US$m^-3",title=paste("Water shadow price in ",getYears(wat_price)[6],sep=""),fig.placement="H",fig.orientation="landscape",fig.width=0.8)
  }
}

num<-water_usage(gdx,level="cell",sum=TRUE,digits=10)
num<-reshape_file(num,spam=path(outputdir,sum_spam_file))
den<-water_avail(gdx,level="cell",sum=TRUE,digits=10)
den<-reshape_file(den,spam=path(outputdir,sum_spam_file))
out<-as.array(num/den)
out[is.na(out)]<-1
out[is.infinite(out)]<-1000
out<-as.magpie(out)
swlatex(swout,"\\section{WSI on cluster level}")
swfigure(swout,plotmap_discrete,out[,"y1995",1],legend_breaks=c(0,0.1,0.2,0.4,0.8,1),colours=c(colorRampPalette(colors=c("blue","orange"))(5),"red"),legendname="index",title="Water withdrawal over availability 1995 ",fig.placement="H",sw_option="width=11.69",fig.width=0.8)
if(dim(out)[2]>=6)swfigure(swout,plotmap_discrete,out[,6,1],legend_breaks=c(0,0.1,0.2,0.4,0.8,1),colours=c(colorRampPalette(colors=c("blue","orange"))(5),"red"),legendname="index",title=paste("Water withdrawal over availability in ",getYears(out)[6],sep=""),fig.placement="H",sw_option="width=11.69",fig.width=0.8)

swclose(swout,clean_output=TRUE)
