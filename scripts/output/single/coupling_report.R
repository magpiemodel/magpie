# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


library(gdx)
library(magclass)
library(magpie4)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {

  gdx_file    <-'fulldata.gdx'
  output_folder        <- '.'

  title <- "EMF27G1"


  #Define arguments that can be read from command line
  readArgs("gdx_file","output_folder","title")
} else{
  output_folder<-outputdir
  gdx_file<-path(outputdir,"fulldata.gdx")
  title <- title
}

###############################################################################

x <- getReport(gdx_file)

# Low-pass-filter CO2LUC data, leave out 1995 values since they are all NA
a<-x[,,"Emissions|CO2|Land Use (Mt CO2/yr)"]
a_1995<-a[,1,]
a_rest<-a[,-1,]
a_rest<-lowpass(a_rest,i=1,fix=NULL)
a<-mbind(a_1995,a_rest)
x[,,"Emissions|CO2|Land Use (Mt CO2/yr)"]<-a

write.report(x,file=path(output_folder,"coupling.mif"),scenario=title)
write.report(x,file=path(output_folder,"..","coupling.mif"),scenario=title,append=TRUE)
