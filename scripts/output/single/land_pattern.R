# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

##########################################################
#### Cellular land pattern ####
##########################################################
# Version 1.0,  Florian Humpenoeder

library(magpie4)
library(luplot)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  
  outputdir        <- 'output/BECCS_REDD_simple_emis_tech_2013-08-05_11.55.46/'     # title of the run (with date)
  gdx<-path(outputdir,"fulldata.gdx")
  title <- "default"
  load(path(outputdir,"config.Rdata"))
  gms <- cfg$gms
  #Define arguments that can be read from command line
  readArgs("outputdir","title")
} else{
  gdx<-path(outputdir,"fulldata.gdx")
}
###############################################################################

land_pools <- land(gdx,level="cell")
alloc_plot(land_pools,level="cell",weight="Value",print=F,ylab="Share of cluster",norm=T,file=path(outputdir,paste(title,"land_pattern_cellular.pdf",sep="_")),scale=4)
