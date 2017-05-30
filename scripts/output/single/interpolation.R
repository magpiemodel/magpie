# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

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

interpolate<-function(x,x_ini_lr,x_ini_hr,spam,add_avail_hr=NULL,prev_year="y1985"){
  if(!is.magpie(x) || !is.magpie(x_ini_lr)|| !is.magpie(x_ini_hr)) stop("x, x_ini_lr and x_ini_hr have to be magpie objects")
  if(nregions(x)!=nregions(x_ini_lr)) stop("x and x_ini_lr have to be of the same spatial aggregation")
  if(nyears(x_ini_lr)>1 || nyears(x_ini_hr)>1) stop("Initialization data must only have one timestep")
  if(!all(getNames(x)==getNames(x_ini_lr))||!all(getNames(x)==getNames(x_ini_hr))) stop("dimnames[[3]] of x, x_ini_lr and x_ini_hr have to be the same")
  if(!is.null(add_avail_hr)){ 
    stop("The add_avail functionality is deprecated and can't be used anymore")
  }
  
  getYears(x_ini_hr) <- prev_year
  getYears(x_ini_lr) <- prev_year
  lr<-mbind(x_ini_lr,x)
  #Test if the total sum is constant
  if(is.null(add_avail_hr)){
    test<-dimSums(lr,dim=c(1,3.1))[,2:nyears(lr),]- setYears(dimSums(lr,dim=c(1,3.1))[,1:nyears(lr)-1,],getYears(lr)[2:nyears(lr)])
    if(max(test)>0.1||min(test)< -0.1) warning("Total stock is not constant over time. See help for details")
  }
  #calculate reduction and extension shares which then can be disaggregated
  diff <- as.array(lr[,2:nyears(lr),]-setYears(lr[,1:(nyears(lr)-1),],getYears(lr)[2:nyears(lr)]))
  less <- diff; less[less>0] <- 0
  more <- diff; more[more<0] <- 0
  reduct <- -less/(lr[,1:(nyears(lr)-1),]+10^-100)
  avail <- rowSums(more,dims=2)
  extent <- as.magpie(more)
  for(e in getNames(extent)) extent[,,e] <- more[,,e]/(avail+10^-100)
  #disaggregate shares
  if(is.character(spam)){
    if(!file.exists(spam))stop("spam file ",spam," not found")
    rel <- read.spam(spam)
  }
  reduct_hr <- speed_aggregate(as.magpie(reduct),t(rel))
  extent_hr <- speed_aggregate(as.magpie(extent),t(rel))
  
  #calculate land pools in high res (hr)
  hr <- new.magpie(dimnames(reduct_hr)[[1]],c(prev_year,dimnames(reduct_hr)[[2]]),dimnames(reduct_hr)[[3]])
  if(is.null(add_avail_hr)){
    add_avail_hr<-array(0,dim=c(dim(reduct_hr)[1:2],1),dimnames=list(dimnames(reduct_hr)[[1]],dimnames(reduct_hr)[[2]],"add_avail_hr"))
  }
  add_avail_hr<-as.array(add_avail_hr)
  dimnames(x_ini_hr)[[1]] <- dimnames(reduct_hr)[[1]]
  hr[,prev_year,] <- x_ini_hr
  
  for(y in 2:nyears(hr)) hr[,y,] <- (1-reduct_hr[,y-1,])*setYears(hr[,y-1,],getYears(reduct_hr)[y-1]) + (rowSums(reduct_hr[,y-1,]*setYears(hr[,y-1,],getYears(reduct_hr)[y-1]))+add_avail_hr[,y-1,])*extent_hr[,y-1,]
  return(hr)
}

############################# BASIC CONFIGURATION #######################################
land_lr_file     <- "avl_land.cs3"  
land_hr_file     <- "avl_land_0.5.mz"
land_hr_out_file <- "cell.land_0.5.mz"
land_hr_share_out_file <- "cell_land_0.5_share.mz"
croparea_hr_share_out_file <- "cell_croparea_0.5_share.mz"

prev_year        <- "y1985"            #timestep before calculations in MAgPIE
in_folder        <- "modules/10_land/input"

if(!exists("source_include")) {
  sum_spam_file    <- "0.5-to-n200_sum.spam"
  title       <- "base_run"
  outputdir       <- "output/base_run"
  
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
land_ini_lr<-readGDX(gdx,"f10_land","f_land", format="first_found")
land_lr<-land(gdx,sum=FALSE,level="cell")
land_ini_hr<-read.magpie(path(in_folder,land_hr_file))
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
area <- croparea(gdx,level="cell",products="kcr",product_aggr=FALSE,water_aggr = FALSE)
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
