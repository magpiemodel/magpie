# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

options(error=function()traceback(2))
#########################################################################
#### ipbes output script #############
#########################################################################
#Author: FH based on interpolation output script

library(lucode)
library(luscale)
library(magpie4)
library(ludata)

############################# BASIC CONFIGURATION #######################################
if(!exists("source_include")) {
  sum_spam_file    <- "0.5-to-h1000_sum.spam"
  title       <- "REF-noCC"
  outputdir       <- "output/h1000/REF-noCC/"
  
  ###Define arguments that can be read from command line
  readArgs("sum_spam_file","outputdir","title")
}

gdx<-path(outputdir,"fulldata.gdx")
cfg<-path(outputdir,"config.Rdata")
#in_folder <- "input/cellular"
#land_hr_file     <- "avl_land_0.5.mz"
#start_year <- 1700
#ref_year <- 1995
#end_year <- 2100

#########################################################################################

#t <- readGDX(gdx,"t")
#t <- t[which(t == paste0("y",ref_year)):which(t == paste0("y",end_year))]

#Land inputs
#land_ini_lr<-dimSums(readGDX(gdx,"f10_land","f_land", format="first_found"),dim=3.2)
#land_lr<-land(gdx,sum=FALSE,level="cell")[,t,]
#land_ini_hr<-dimSums(read.magpie(path(in_folder,land_hr_file)),dim=3.2)
#land_hr <- interpolate(x=land_lr,x_ini_lr=land_ini_lr,x_ini_hr=land_ini_hr,spam=path(outputdir,sum_spam_file),prev_year="y1990")
#land_hr <- land_hr[,-1,]

#add hyde3.1 data
#print("add hyde 3.1 data")
#land_hr_hyde <- new.magpie(getCells(land_hr),seq(start_year,1990,by=10),getNames(land_hr),fill = NA)
#land_hr_hyde[,,"crop"] <- hyde$landuse$cropland[,getYears(land_hr_hyde),]
#land_hr_hyde[,,"past"] <- hyde$landuse$pasture[,getYears(land_hr_hyde),]
#land_hr_hyde[,,"urban"] <- hyde$landuse$urban[,getYears(land_hr_hyde),]
#land_hr <- mbind(land_hr_hyde,land_hr)
#rm(land_hr_hyde)
#gc()

#calculate share of land pools in terms of tatal cell size
#land_share_hr <- land_hr/hyde$area$land

#rename
#land_share_hr[,,"forest"] <- dimSums(land_share_hr[,,"forest"] + land_share_hr[,,"forestry"],dim=3.1)
#land_share_hr <- land_share_hr[,,c("crop","past","forest","urban","other")]
#land_share_hr <- setNames(land_share_hr,paste0("Land Cover|",c("Cropland","Pasture","Forest","Built-up Area","Other Natural Land")))

#print("LandCoverAll")
#write.magpie(land_share_hr,file_name = path(outputdir,paste0(title,"_LandCoverAll.mz")))    
#write.magpie(land_share_hr,file_name = path(outputdir,paste0(title,"_LandCoverAll.nc")))    
#write.magpie(land_share_hr[,t,],file_name = path(outputdir,paste0(title,"_LandCoverAllNoHist.mz")))    
#write.magpie(land_share_hr[,t,],file_name = path(outputdir,paste0(title,"_LandCoverAllNoHist.nc")))   

# yields
print("Yields")
print(outputdir)

spam <- path(outputdir,"0.5-to-h1000_sum.spam")
x <- dimSums(readGDX(gdx,"ov_yld")[,,"level"],dim=3.3)
x[is.na(x)|is.infinite(x)] <- 9999
x <- speed_aggregate(x,t(spam))
#oder mit reshape_file -> gleiches Ergebnis
#x <- reshape_file(x,spam=spam)
x[x == 9999] <- NA
write.magpie(x,file_name = path(paste0("output/",title,"_yields.nc")))
write.magpie(x,file_name = path(paste0("output/",title,"_yields.csv")))

  
print("Prices")
#prices(gdx,unit = "FM",level = "reg")
rep_magpie<-NULL
reg <- producer.price(gdx,commodities="k")
getNames(reg) <- paste0("Prices|",getNames(reg))

write.report(mbind(reg),file=path("output/sofa_prices_mar16.csv"),scenario=title,model="MAgPIE",append=TRUE,unit = "US Dollar 2005 in Market exchange rate per ton dry matter")
