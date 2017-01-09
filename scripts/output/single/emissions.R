# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

##########################################################
#### Emission outputs ####
##########################################################
# Version 1.1, Benjamin bodirsky, Markus bonsch, Florian Humpen?der
#
# Version 1.1: magpie data is now read directly from fulldata.gdx (fh)
# version 1.2: speed improvment; only needed parameter is now read from fulldata.gdx (fh)

library(lucode)
library(ludata)
library(luplot)
library(lusweave)
library(magpie)
library(Matrix)
library(validation)
options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  gdx    <-'/iplex/01/landuse/users/florianh/magpie/dev_rev16/output/default_2013-01-16_16.24.01/fulldata.gdx'
  outputdir        <- '/iplex/01/landuse/users/florianh/magpie/dev_rev16/output/default_2013-01-16_16.24.01'
  outputdir        <- '../../../output/default_2013-05-31_17.19.03/'
  gdx        <- '../../../output/default_2013-05-31_17.19.03/fulldata.gdx'
  
  latexpath        <-NA              # Latexpath necessary if swclose is performed in the queue
  title <- "test"
  #Define arguments that can be read from command line
  readArgs("outputdir","latexpath")
} else {
  gdx<-path(outputdir,"fulldata.gdx")
}
###############################################################################

out<-swopen(paste(outputdir,"/",title,"_emission_results.pdf",sep=""))


swlatex(out,"\\section{Emissions}")


edgar_n2o_emission_sources<-c(
#  "Agricultural waste burning"
  "Direct soil emissions",
#  "Forest fires",
#  "Grassland fires"
  "Indirect N2O from agriculture",
  "Manure in pasture/range/paddock",
  "Manure management"
#  "Other waste handling",
# "Production of chemicals",
#  "Savanna burning",
#  "Solvent and other product use: other",
#  "Wastewater handling"
  )

edgar_ch4_emission_sources<-c(
  "Agricultural waste burning"
  ,"Enteric fermentation"
#  ,"Forest fires"
  ,"Manure management"
#  ,"Other waste handling"
  ,"Rice cultivation"
#  ,"Savanna burning"
#  ,"Wastewater handling"
  )


edgar_co2_emission_sources<-c(
  "Forest fires"
  ,"Forest Fires-Post burn decay" 
#  ,"Lime production"
#  ,"Other direct soil emissions"
#  ,"Peat fires and decay of drained peatland"
)

edgar_nox_nhy_emission_sources<-c(
  "Agricultural waste burning"
  ,"Direct soil emissions"
  ,"Forest fires"
  ,"Grassland fires"
  ,"Manure in pasture/range/paddock"
  ,"Manure management"
  ,"Production of chemicals"
  ,"Savanna burning"
) 

plotoutput<-function(emisname, emistype, edgar_data, edgar_sources,unit,lowpass_iter=0){
  if(emistype=="co2_c"){y1995<-FALSE}else{y1995<-TRUE}
  magpie_data <- lowpass(emissions(gdx,level="reg",type=emistype,y1995=y1995),i=lowpass_iter)
  if(nnzero(magpie_data) == 0) {
    warning(paste("No", emisname, "emissions found in GDX file! Probably emission module was not active."))
    return(NULL)
  } else {
    print(paste(emisname, "emissions found!"))
    #magpie_data <- superAggregate(magpie_data,"sum","reg")
    magpie_data <- setNames(magpie_data,"MAgPIE")
#     swlatex(out,paste("\\subsection{",emisname,"}",sep=""))

    # aggregate EDGAR
    edgar_total<-rowSums(edgar_data[,,edgar_sources],dim=2)/1000
    edgar_total <- setNames(edgar_total,"EDGAR")

    #combine data
    data<-mbind(edgar_total,magpie_data)
    
    #create plot
    swfigure(out,"scratch_plot",data,add="region",ylab=unit)
    
    #create table
    magpie <- mbind(emissions(gdx,level="reg",type=emistype,y1995=FALSE),emissions(gdx,level="glo",type=emistype,y1995=FALSE))
    swtable(out,round(magpie,4),table.placement="H",caption.placement="top",transpose=TRUE,caption=paste("MAgPIE ",emisname," emissions (",unit,")",sep=""),vert.lines=1,align="r",hor.lines=1)
    edgar_glo<-superAggregate(edgar_total,level="glo",aggr_type="sum")
    dimnames(edgar_glo)[[1]] <- "GLO.11"
    edgar <- mbind(edgar_total,edgar_glo)
    swtable(out,round(edgar[,26:36,],4),table.placement="H",caption.placement="top",transpose=TRUE,caption=paste("EDGAR ",emisname," emissions (",unit,")",sep=""),vert.lines=1,align="r",hor.lines=1)
  }
}  

swlatex(out,"\\subsection{CO2}")
tmp<-try(validationPlot(func=emissions,type="co2_c",gdx=gdx,level="glo"))
if(!is(tmp,"try-error")){
  swlatex(out,"\\subsubsection{Global}")
  swfigure(out,grid.draw,tmp,fig.orientation="landscape",fig.placement="H")
}
tmp<-try(validationPlot(func=emissions,type="co2_c",gdx=gdx,level="reg"))
if(!is(tmp,"try-error")){
  swlatex(out,"\\subsection{Regional}")
  swfigure(out,grid.draw,tmp,fig.orientation="landscape",fig.placement="H")
  plotoutput(
  emisname="C",
  emistype="co2_c",
  edgar_data=edgar$co2,
  edgar_sources=edgar_co2_emission_sources,
  unit="Mt C"
  )
  plotoutput(
  emisname="C (lowpass filter)",
  emistype="co2_c",
  edgar_data=edgar$co2,
  edgar_sources=edgar_co2_emission_sources,
  unit="Mt C",
  lowpass_iter=5
  )
}

swlatex(out,"\\subsection{N2o-N}")
tmp<-try(validationPlot(func=emissions,type="n2o_n",gdx=gdx,level="glo"))
if(!is(tmp,"try-error")){
  swlatex(out,"\\subsubsection{Global}")
  swfigure(out,grid.draw,tmp,fig.orientation="landscape",fig.placement="H")
}
tmp<-try(validationPlot(func=emissions,type="n2o_n",gdx=gdx,level="reg"))
if(!is(tmp,"try-error")){
  swlatex(out,"\\subsection{Regional}")
  swfigure(out,grid.draw,tmp,fig.orientation="landscape",fig.placement="H")
  plotoutput(
  emisname="N2O-N",
  emistype="n2o_n",
  edgar_data=edgar$n2o,
  edgar_sources=edgar_n2o_emission_sources, 
  unit="Mt N2O-N"
  )
}

swlatex(out,"\\subsection{CH4}")
tmp<-try(validationPlot(func=emissions,type="ch4",gdx=gdx,level="glo"))
if(!is(tmp,"try-error")){
  swlatex(out,"\\subsubsection{Global}")
  swfigure(out,grid.draw,tmp,fig.orientation="landscape",fig.placement="H")
}
tmp<-try(validationPlot(func=emissions,type="ch4",gdx=gdx,level="reg"))
if(!is(tmp,"try-error")){
  swlatex(out,"\\subsection{Regional}")
  swfigure(out,grid.draw,tmp,fig.orientation="landscape",fig.placement="H")
  
  plotoutput(
  emisname="CH4",
  emistype="ch4",
  edgar_data=edgar$ch4,
  edgar_sources=edgar_ch4_emission_sources,
  unit="Mt CH4"  
  )
}

if(!is.na(latexpath)){
  swclose(out,latexpath=latexpath)
} else{
  swclose(out)
}

