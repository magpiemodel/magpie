# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

options(error=function()traceback(2))
#########################################################################
#### Interpolates land pools from low to high resolution, calculates ####
#### corresponding spam-files for following disaggregations #############
#########################################################################

#Version 1.03 - Jan Philipp Dietrich
# 1.00: first working version
# 1.01: execution of reshape_folder function added at the end
# 1.02: uses now the land function to read the simulated land input
# 1.03: introduced function interpolate, all possible input is read from the GDX file now

library(lucode)
library(luscale)
library(magpie)

############################# BASIC CONFIGURATION #######################################
land_lr_file     <- "avl_land.cs3"  
land_hr_file     <- "avl_land_0.5.mz"
land_hr_out_file <- "cell.land_0.5.mz"
land_hr_share_out_file <- "cell_land_0.5_share.mz"
croparea_hr_share_out_file <- "cell_croparea_0.5_share.mz"

prev_year        <- "y1985"            #timestep before calculations in MAgPIE
in_folder        <- "modules/10_land/input"

if(!exists("source_include")) {
  sum_spam_file    <- "0.5-to-h600_sum.spam"
  title       <- "REF-NoCC"
  outputdir       <- "output/h600/REF-NoCC/"
  
  ###Define arguments that can be read from command line
  readArgs("sum_spam_file","outputdir","title")
}
#########################################################################################

gdx<-path(outputdir,"fulldata.gdx")
land_ini_lr<-dimSums(readGDX(gdx,"f10_land","f_land", format="first_found"),dim=3.2)
land_lr<-land(gdx,sum=FALSE,level="cell")
land_ini_hr<-dimSums(read.magpie(path(in_folder,land_hr_file)),dim=3.2)
if(any(land_ini_hr < 0)) {
  warning(paste0("Negative values in inital high resolution dataset detected and set to 0. Check the file ",land_hr_file))
  land_ini_hr[which(land_ini_hr < 0,arr.ind = T)] <- 0
}
land_hr<-interpolate(x=land_lr,x_ini_lr=land_ini_lr,x_ini_hr=land_ini_hr,spam=path(outputdir,sum_spam_file),prev_year=prev_year)

#write outputs
write.magpie(land_hr,path(outputdir,land_hr_out_file))
for(y in getYears(land_hr)) create_spam(land_hr[,y,"crop"],read.spam(path(outputdir,sum_spam_file)),fname=path(outputdir,sub("sum",paste("crop_weighted_mean",y,sep="_"),sum_spam_file)))


#Disaggregate other cellular files
reshape_folder(outputdir)

### detailed output (crop types, rf + if)
#get rid of y1985
land_hr <- land_hr[,-1,]
#total crop tpye specific croparea
area <- croparea(gdx,level="cell",crops=NULL,water="all",crop_aggr=FALSE)
#share of crop types in terms of croparea
area_share <- area/dimSums(area,dim=c(3.1,3.2))
#set inf to 0
area_share[is.na(area_share)] <- 0
area_share[is.nan(area_share)] <- 0
area_share[is.infinite(area_share)] <- 0
#disaggregate share of crop types in terms of croparea to 0.5 resolution
area_share_hi <- speed_aggregate(area_share,t(read.spam(path(outputdir,sum_spam_file))))
#calculate crop tpye specific croparea in 0.5 resolution
area_hi <- area_share_hi*setNames(land_hr[,,"crop"],NULL)
#calculate share of crop types in terms of total cell size
area_share_hi <- area_hi/dimSums(land_hr,dim=3.1)
#write share of crop types in terms of total cell size
write.magpie(area_share_hi,path(outputdir,paste(title,croparea_hr_share_out_file,sep="_")),comment="cell share")
write.magpie(area_share_hi,path(outputdir,paste(title,sub(".mz",".nc",croparea_hr_share_out_file),sep="_")),comment="cell share")
#calculate share of land pools in terms of tatal cell size
land_hr <- land_hr/dimSums(land_hr,dim=3.1)
#write landpool shares
write.magpie(land_hr,path(outputdir,paste(title,land_hr_share_out_file,sep="_")),comment="cell share")
write.magpie(land_hr,path(outputdir,paste(title,sub(".mz",".nc",land_hr_share_out_file),sep="_")),comment="cell share")
