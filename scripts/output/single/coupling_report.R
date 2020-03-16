# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
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
