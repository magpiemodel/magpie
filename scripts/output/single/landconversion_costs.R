# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

#####################################
#### landconversion costs output ####
#####################################
# Version 1.00, Florian Humpenoeder
#

##########################################################
library(magpie4)
library(luplot)
library(lusweave)
############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {

  gdx    <-'/iplex/01/landuse/users/bonsch/magpie/test_si0/r4373/output/results/fulldata.gdx'
  outputdir        <- '/iplex/01/landuse/users/bonsch/magpie/test_si0/r4373/output/results'
  title <- "default"
  #Define arguments that can be read from command line
  readArgs("outputdir","title")
} else{
  gdx<-path(outputdir,"fulldata.gdx")
}
###############################################################################

sw<-swopen(paste(outputdir,"/",title,"_lndcon_costs.pdf",sep=""))
years_all <- getYears(modelstat(gdx))

swlatex(sw,"\\huge")
swlatex(sw,"\\textbf{Landconversion costs}\\newline")
swlatex(sw,"\\normalsize")

lndcon <- setNames(readGDX(gdx,"p39_lndcon_costs","f39_c_lndcon", format="first_found")[,,c("crop","forestry","forest")],c("crop,past,urban","forestry","forest,other"))
swoutput(sw,lndcon,unit="[US Dollar per ha]",color="Data1",labs=c("Land type"))

swclose(sw)
