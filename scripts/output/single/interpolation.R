# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de

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
library(magpie4)
library(luscale)

############################# BASIC CONFIGURATION #######################################
land_lr_file     <- "avl_land_t.cs3"
land_hr_file     <- "avl_land_t_0.5.mz"
land_hr_out_file <- "cell.land_0.5.mz"
land_hr_share_out_file <- "cell_land_0.5_share.mz"
croparea_hr_share_out_file <- "cell_croparea_0.5_share.mz"

prev_year        <- "y1985"            #timestep before calculations in MAgPIE
in_folder        <- "modules/10_land/input"

if(!exists("source_include")) {
  sum_spam_file    <- "0.5-to-n200_sum.spam"
  title       <- "base_run"
  outputdir       <- "output/SSP2_Ref_c200"

  ###Define arguments that can be read from command line
  readArgs("sum_spam_file","outputdir","title")
}
#########################################################################################
load(paste0(outputdir, "/config.Rdata"))
title <- cfg$title
print(title)

# Function to extract information from info.txt
get_info <- function(file, grep_expression, sep, pattern="", replacement="") {
  if(!file.exists(file)) return("#MISSING#")
  file <- readLines(file, warn=FALSE)
  tmp <- grep(grep_expression, file, value=TRUE)
  tmp <- strsplit(tmp, sep)
  tmp <- sapply(tmp, "[[", 2)
  tmp <- gsub(pattern, replacement ,tmp)
  if(all(!is.na(as.logical(tmp)))) return(as.vector(sapply(tmp, as.logical)))
  if (all(!(regexpr("[a-zA-Z]",tmp) > 0))) {
    tmp <- as.numeric(tmp)
  }
  return(tmp)
}
low_res  <- get_info(paste0(outputdir,"/info.txt"),"^\\* Output ?resolution:",": ")
sum_spam_file <- paste0("0.5-to-",low_res,"_sum.spam")
print(sum_spam_file)

gdx<-path(outputdir,"fulldata.gdx")
land_ini_lr<-readGDX(gdx,"f10_land","f_land", format="first_found")[,"y1995",]
land_lr<-land(gdx,sum=FALSE,level="cell")
land_ini_hr<-read.magpie(path(in_folder,land_hr_file))[,"y1995",]
land_ini_hr <- land_ini_hr[,,getNames(land_lr)]
if(any(land_ini_hr < 0)) {
  warning(paste0("Negative values in inital high resolution dataset detected and set to 0. Check the file ",land_hr_file))
  land_ini_hr[which(land_ini_hr < 0,arr.ind = T)] <- 0
}
print("Interpolation")
land_hr<-interpolate(x=land_lr,x_ini_lr=land_ini_lr,x_ini_hr=land_ini_hr,spam=path(outputdir,sum_spam_file),prev_year=prev_year)

#write spam files
for(y in getYears(land_hr)) create_spam(land_hr[,y,"crop"],read.spam(path(outputdir,sum_spam_file)),fname=path(outputdir,sub("sum",paste("crop_weighted_mean",y,sep="_"),sum_spam_file)))

#Disaggregate other cellular files
reshape_folder(outputdir)

print("Disaggregation crop types")
### detailed output (crop types, rf + if)
#get rid of y1985
land_hr <- land_hr[,-1,]
#total crop tpye specific croparea
area <- croparea(gdx,level="cell",products="kcr",product_aggr=FALSE,water_aggr = FALSE)
#share of crop types in terms of croparea
area_shr <- area/dimSums(area,dim=c(3.1,3.2))
#set inf to 0
area_shr[is.na(area_shr)] <- 0
area_shr[is.nan(area_shr)] <- 0
area_shr[is.infinite(area_shr)] <- 0
#disaggregate share of crop types in terms of croparea to 0.5 resolution
area_shr_hr <- speed_aggregate(area_shr,t(read.spam(path(outputdir,sum_spam_file))))
#calculate crop tpye specific croparea in 0.5 resolution
area_hr <- area_shr_hr*setNames(land_hr[,,"crop"],NULL)
#calculate share of crop types in terms of total cell size
area_shr_hr <- area_hr/dimSums(land_hr,dim=3.1)
#write share of crop types in terms of total cell size
write.magpie(area_shr_hr,path(outputdir,paste(croparea_hr_share_out_file,sep="_")),comment="unit: grid-cell land area fraction")
write.magpie(area_shr_hr,path(outputdir,paste(sub(".mz",".nc",croparea_hr_share_out_file),sep="_")),comment="unit: grid-cell land area fraction", verbose=FALSE)

print("Write netCDF outputs #1")
### replace crop in land_hr in with crop_kfo_rf, crop_kfo_ir, crop_kbe_rf and crop_kbe_ir
kbe <- c("betr","begr")
kfo <- setdiff(getNames(area_hr,dim=1),kbe)
crop_kfo_rf <- setNames(dimSums(area_hr[,,kfo][,,"rainfed"],dim=3),"crop_kfo_rf")
crop_kfo_ir <- setNames(dimSums(area_hr[,,kfo][,,"irrigated"],dim=3),"crop_kfo_ir")
crop_kbe_rf <- setNames(dimSums(area_hr[,,kbe][,,"rainfed"],dim=3),"crop_kbe_rf")
crop_kbe_ir <- setNames(dimSums(area_hr[,,kbe][,,"irrigated"],dim=3),"crop_kbe_ir")
crop_hr <- mbind(crop_kfo_rf,crop_kfo_ir,crop_kbe_rf,crop_kbe_ir)
#drop crop
land_hr <- land_hr[,,"crop",invert=TRUE]
#combine land_hr with crop_hr. 
land_hr <- mbind(crop_hr,land_hr)
#write landpool
write.magpie(land_hr,path(outputdir,paste(land_hr_out_file,sep="_")),comment="unit: Mha per grid-cell")
write.magpie(land_hr,path(outputdir,paste(sub(".mz",".nc",land_hr_out_file),sep="_")),comment="unit: Mha per grid-cell", verbose=FALSE)

print("Write netCDF outputs #2")
#calculate share of land pools in terms of tatal cell size
land_shr_hr <- land_hr/dimSums(land_hr,dim=3.1)
#write landpool shares
write.magpie(land_shr_hr,path(outputdir,paste(land_hr_share_out_file,sep="_")),comment="unit: grid-cell land area fraction")
write.magpie(land_shr_hr,path(outputdir,paste(sub(".mz",".nc",land_hr_share_out_file),sep="_")),comment="unit: grid-cell land area fraction", verbose=FALSE)
