# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

options(error=function()traceback(2))
#########################################################################
#### LUC4C output script #############
#########################################################################
#Author: FH based on interpolation output script

library(luscale)
library(magpie)
library(ludata)

#tmp
#sum_spam_file <- "0.5-to-h200_sum.spam"
#end tmp

luc4c_data_file <- path("output","luc4c_scen.csv")

gdx<-path(outputdir,"fulldata.gdx")
cfg<-path(outputdir,"config.Rdata")
in_folder <- "modules/10_land/input"
land_hr_file     <- "avl_land_0.5.mz"
land_hr_file_hyde     <- "avl_land_0.5_hyde_Oct15.mz"
lpjml_carbon <- "/iplex/01/landuse/data/input/raw_data/IPSL_CM5A_LR-rcp6p0-co2_rev21.1/0.5_set/lpj_carbon_stocks_0.5.mz"
start_year <- 1700
ref_year <- 2005
end_year <- 2100
t <- readGDX(gdx,"t")
t <- t[which(t == paste0("y",ref_year)):which(t == paste0("y",end_year))]

###create land_hr_file_hyde
print("create high resolution inital land-use dataset based on Hyde 3.1 and Erb et al.")
out <- new.magpie(getCells(hyde$area$land),NULL,c("crop","past","forest","urban","other"),0)
#take crop and past from Hyde
out[,,"crop"] <- setYears(setNames(hyde$landuse$cropland[,paste0("y",ref_year),],"crop"),NULL)
out[,,"past"] <- setYears(setNames(hyde$landuse$pasture[,paste0("y",ref_year),],"past"),NULL)
out[,,"urban"] <- setYears(setNames(hyde$landuse$urban[,paste0("y",ref_year),],"urban"),NULL)
#take forest and forestry from Krause et al.
out[,,"forest"] <- dimSums(read.magpie(path(in_folder,land_hr_file))[,,c("forestry","forest")],dim=c(3.1,3.2))
if(any(dimSums(out,dim=3.1) > hyde$area$land)) {
  forest <- out[,,"forest"]
  tmp <- hyde$area$land - dimSums(out,dim=3.1)
  forest[tmp<0] <- (hyde$area$land - dimSums(out[,,c("crop","past","urban")],dim=3.1))[tmp<0]
  out[,,"forest"] <- forest
}
#calculate other land as residual
out[,,"other"] <- hyde$area$land - dimSums(out,dim=3.1)
#set negative values to 0 (this solves mainly rounding issues)
out[out < 0] <- 0
#rouding
out <- round(out,7)
#check if the land area is identical with hyde
print("Land area of created dataset")
print(dimSums(out,dim=c(1,3.1)))
print("Hyde 3.1 land area")
print(dimSums(hyde$area$land,dim=1))
# which(out<0,arr.ind = T)
# out[48042,,]
# hyde$area$land[48326,,]
write.magpie(out,file_name = path(outputdir,land_hr_file_hyde))

###disaggregate land pools
print("disaggregate land pools")
interpolate<-function(x,x_ini_lr,x_ini_hr,spam,add_avail_hr=NULL,prev_year="y1985"){
  require(spam)
  if(!is.magpie(x) || !is.magpie(x_ini_lr)|| !is.magpie(x_ini_hr)) stop("x, x_ini_lr and x_ini_hr have to be magpie objects")
  if(nregions(x)!=nregions(x_ini_lr)) stop("x and x_ini_lr have to be of the same spatial aggregation")
  if(nyears(x_ini_lr)>1 || nyears(x_ini_hr)>1) stop("Initialization data must only have one timestep")
  if(!all(getNames(x)==getNames(x_ini_lr))||!all(getNames(x)==getNames(x_ini_hr))) stop("dimnames[[3]] of x, x_ini_lr and x_ini_hr have to be the same")
  if(!is.null(add_avail_hr)){ 
    stop("The add_avail functionality is deprecated and can't be used anymore")
  }
  
  dimnames(x_ini_lr)[[2]]<-prev_year
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
  hr[,prev_year,] <- x_ini_hr
  
  for(y in 2:nyears(hr)) hr[,y,] <- (1-reduct_hr[,y-1,])*setYears(hr[,y-1,],getYears(reduct_hr)[y-1]) + (rowSums(reduct_hr[,y-1,]*setYears(hr[,y-1,],getYears(reduct_hr)[y-1]))+add_avail_hr[,y-1,])*extent_hr[,y-1,]
  return(hr)
}
land_lr<-land(gdx,sum=FALSE,level="cell")[,t,]
land_lr[,,"forest"] <- dimSums(land_lr[,,"forest"] + land_lr[,,"forestry"],dim=3.1)
land_lr <- land_lr[,,c("crop","past","forest","urban","other")]
land_ini_hr<-read.magpie(path(outputdir,land_hr_file_hyde))
land_ini_lr <- speed_aggregate(land_ini_hr,read.spam(path(outputdir,sum_spam_file)))
land_hr <- interpolate(x=land_lr,x_ini_lr=land_ini_lr,x_ini_hr=land_ini_hr,spam=path(outputdir,sum_spam_file),prev_year=paste0("y",ref_year))
out_land <- setNames(land_hr,paste0("Land Cover|",c("Cropland","Pasture","Forest","Built-up Area","Other Natural Land")," (Mha)"))
reg <- superAggregate(out_land,level="SSP",aggr_type="sum")
glo <- superAggregate(out_land,level="glo",aggr_type="sum")
out_land <- mbind(reg,glo)

###detailed output (crop types, rf + if)
print("detailed output (crop types, rf + if)")
area_share <- function(level="cell") {
  #total crop tpye specific croparea
  area_lr <- croparea(gdx,level=level,crops=NULL,water="all",crop_aggr=FALSE)[,t,]
  #Quickfix: area_lr[area_lr==0] <- 1e-10
  #share of crop types in terms of croparea
  area_share <- area_lr/dimSums(area_lr,dim=c(3.1,3.2))
  #set inf to 0
  area_share[is.na(area_share)] <- 0
  area_share[is.nan(area_share)] <- 0
  area_share[is.infinite(area_share)] <- 0
  return(area_share)
}
#If MAgPIE has no cropland in a cell but Hyde has cropland, this causes inconsistencies since the area share is NA or INF.
#Solution: set cellular area shares of cells without croparea to regional values. 
#This correction allows for area share calcuation for all cells (no NAs or INF).
area_share_lr <- area_share(level="cell")
area_share_reg <- area_share(level="reg")
for (y in t) {
  sel <- which(dimSums(area_share_lr[,y,],dim=c(3.1,3.2))==0)
  area_share_lr[sel,y,] <- area_share_reg[getRegions(area_share_lr[sel,y,]),y,]
}
#disaggregate share of crop types in terms of croparea to 0.5 resolution
area_share_hr <- speed_aggregate(area_share_lr,t(read.spam(path(outputdir,sum_spam_file))))
#calculate crop tpye specific croparea in 0.5 HYDE resolution
area_hr <- area_share_hr*setNames(land_hr[,,"crop"],NULL)
print("Croparea (sum over crop types and rf + ir")
print(dimSums(area_hr,dim=c(1,3.1,3.2)))
print("Croparea in land pools")
print(dimSums(land_hr,dim=1)[,,"crop"])


#calculate share of crop types in terms of total cell size
area_share_hr <- area_hr/hyde$area$land

print("LandCoverDetail")
var_list <- c("Land Cover|Cropland|Non-Energy Crops|rainfed",
              "Land Cover|Cropland|Non-Energy Crops|irrigated",
              "Land Cover|Cropland|Energy Crops|rainfed",
              "Land Cover|Cropland|Energy Crops|irrigated")
dims_area_share <- dimnames(unwrap(area_share_hr))
all <- new.magpie(cells_and_regions = dims_area_share[[1]],years = dims_area_share[[2]],names = var_list,fill = NA)
all[,,"Land Cover|Cropland|Non-Energy Crops|rainfed"] <- dimSums(collapseNames(area_share_hr[,,"rainfed"])[,,setdiff(dims_area_share[[3]],c("begr","betr"))],dim=3.1)
all[,,"Land Cover|Cropland|Non-Energy Crops|irrigated"] <- dimSums(collapseNames(area_share_hr[,,"irrigated"])[,,setdiff(dims_area_share[[3]],c("begr","betr"))],dim=3.1)
all[,,"Land Cover|Cropland|Energy Crops|rainfed"] <- dimSums(collapseNames(area_share_hr[,,"rainfed"])[,,c("begr","betr")],dim=3.1)
all[,,"Land Cover|Cropland|Energy Crops|irrigated"] <- dimSums(collapseNames(area_share_hr[,,"irrigated"])[,,c("begr","betr")],dim=3.1)
all <- time_interpolate(all,interpolated_year = seq(ref_year,end_year,by=1),integrate_interpolated_years = TRUE,extrapolation_type = "linear")
write.magpie(all,file_name = path(outputdir,paste0(title,"_LandCoverDetail.mz")))    
write.magpie(all,file_name = path(outputdir,paste0(title,"_LandCoverDetail.nc")))    
rm(all)
gc()


print("LandCoverAgriculture")
crops <- dimnames(unwrap(area_share_hr))[[3]]
rf <- setNames(collapseNames(area_share_hr[,,"rainfed"])[,,crops],paste0("Land Cover|Cropland|",crops,"|rainfed"))
ir <- setNames(collapseNames(area_share_hr[,,"irrigated"])[,,crops],paste0("Land Cover|Cropland|",crops,"|irrigated"))
all <- mbind(rf,ir)
all <- time_interpolate(all,interpolated_year = seq(ref_year,end_year,by=1),integrate_interpolated_years = TRUE,extrapolation_type = "linear")
write.magpie(all,file_name = path(outputdir,paste0(title,"_LandCoverAgriculture.mz")))
write.magpie(all,file_name = path(outputdir,paste0(title,"_LandCoverAgriculture.nc")))
rm(all,rf,ir)
gc()


#add hyde3.1 data
print("add hyde 3.1 data")
land_hr_hyde <- new.magpie(getCells(land_hr),seq(start_year,ref_year-5,by=10),getNames(land_hr),fill = NA)
land_hr_hyde[,,"crop"] <- hyde$landuse$cropland[,getYears(land_hr_hyde),]
land_hr_hyde[,,"past"] <- hyde$landuse$pasture[,getYears(land_hr_hyde),]
land_hr_hyde[,,"urban"] <- hyde$landuse$urban[,getYears(land_hr_hyde),]
land_hr <- mbind(land_hr_hyde,land_hr)
rm(land_hr_hyde)
gc()

print("LandCoverAll")
#calculate share of land pools in terms of tatal cell size
land_share_hr <- land_hr/hyde$area$land
#rename
land_share_hr <- setNames(land_share_hr,paste0("Land Cover|",c("Cropland","Pasture","Forest","Built-up Area","Other Natural Land")))
#annual values
print("interpolation of missing time steps")
land_share_hr <- time_interpolate(land_share_hr,interpolated_year=seq(start_year,end_year,by=1),integrate_interpolated_years = TRUE,extrapolation_type = "linear")
write.magpie(land_share_hr,file_name = path(outputdir,paste0(title,"_LandCoverAll.mz")))    
write.magpie(land_share_hr,file_name = path(outputdir,paste0(title,"_LandCoverAll.nc")))    
write.magpie(land_share_hr[,seq(ref_year,end_year,by=1),],file_name = path(outputdir,paste0(title,"_LandCoverAllNoHist.mz")))    
write.magpie(land_share_hr[,seq(ref_year,end_year,by=1),],file_name = path(outputdir,paste0(title,"_LandCoverAllNoHist.nc")))    

#save all
save(list=ls(all=TRUE),file = path(outputdir,"luc4c.RData"),envir = sys.frame(which=sys.nframe()))

#### END cellular data

### additional outputs
crops <- getNames(area_hr,dim=1)
out_crop <- mbind(setNames(dimSums(area_hr[,,setdiff(crops,c("begr","betr"))],dim=3),"Land Cover|Cropland|Non-Energy Crops (Mha)"),
                  setNames(dimSums(area_hr[,,c("begr","betr")],dim=3),"Land Cover|Cropland|Energy Crops (Mha)"))
reg <- superAggregate(out_crop,level="SSP",aggr_type="sum")
glo <- superAggregate(out_crop,level="glo",aggr_type="sum")
out_crop <- mbind(reg,glo)


reg <- yields(gdx,crops=c("tece", "trce", "maiz","rice_pro"),level="SSP",water="sum")
glo <- yields(gdx,crops=c("tece", "trce", "maiz","rice_pro"),level="glo",water="sum")
out_yld_cereal <- mbind(reg,glo)[,t,]
getNames(out_yld_cereal) <- "Yield|Cereal (tDM/ha)"

kcr <- readGDX(gdx,"kcr")
kcr <- setdiff(kcr,c("begr","betr"))
reg <- yields(gdx,crops=kcr,level="SSP",water="sum")
glo <- yields(gdx,crops=kcr,level="glo",water="sum")
out_yld <- mbind(reg,glo)[,t,]
getNames(out_yld) <- "Yield (tDM/ha)"

reg <- yields(gdx,crops=c("begr","betr"),level="SSP",water="sum")
glo <- yields(gdx,crops=c("begr","betr"),level="glo",water="sum")
out_yld_bio <- mbind(reg,glo)[,t,]
getNames(out_yld_bio) <- "Yield|Bio-energy (tDM/ha)"

reg <- yields(gdx,crops=c("begr"),level="SSP",water="sum")
glo <- yields(gdx,crops=c("begr"),level="glo",water="sum")
out_yld_bio_grass <- mbind(reg,glo)[,t,]
getNames(out_yld_bio_grass) <- "Yield|Bio-energy|Grassy (tDM/ha)"

reg <- yields(gdx,crops=c("betr"),level="SSP",water="sum")
glo <- yields(gdx,crops=c("betr"),level="glo",water="sum")
out_yld_bio_woody <- mbind(reg,glo)[,t,]
getNames(out_yld_bio_woody) <- "Yield|Bio-energy|Woody (tDM/ha)"

reg <- Production(gdx,categories = "livst_rum",sum=T,level="SSP")/land(gdx,types = c("past"),sum = TRUE,level="SSP")
glo <- Production(gdx,categories = "livst_rum",sum=T,level="glo")/land(gdx,types = c("past"),sum = TRUE,level="glo")
out_yld_livst <- mbind(reg,glo)[,t,]
getNames(out_yld_livst) <- "Ruminant Efficiency (tDM/ha)"

kli <- readGDX(gdx,"kli")
feed_per_animal <- readGDX(gdx,"i70_feed_bask")
feed_per_animal <- dimSums(feed_per_animal,dim=3.2)[,,kli]
prod <- readGDX(gdx,"ov_prod_reg",select = list(type="level"))[,,kli]
feed <- feed_per_animal*prod
reg <- dimSums(superAggregate(prod,level="SSP",aggr_type = "sum"),dim=3.1)/dimSums(superAggregate(feed,level="SSP",aggr_type = "sum"),dim=3.1)
glo <- dimSums(superAggregate(prod,level="glo",aggr_type = "sum"),dim=3.1)/dimSums(superAggregate(feed,level="glo",aggr_type = "sum"),dim=3.1)
out_livst_prod <- mbind(reg,glo)[,t,]
getNames(out_livst_prod) <- "Livestock Feed Efficiency (kg DM product/kg DM feed)"


reg <- tc(gdx,level="SSP",annual = TRUE,avrg = TRUE)*100
glo <- tc(gdx,level="glo",annual = TRUE,avrg = TRUE)*100
out_tc <- mbind(reg,glo)
getNames(out_tc) <- "Average annual yield-increasing TC (%/yr)"


im_years <- readGDX(gdx,"im_years")[,-1,]
emis <- superAggregate(readGDX(gdx,"p52_emis"),level="SSP",aggr_type="sum")*44/12

reg <- setNames(dimSums(emis,dim=3.1),paste("Emissions|CO2|Land total (Gt CO2)",NULL,sep=""))
glo <- superAggregate(reg,level="glo",aggr_type="sum")
years <- getYears(glo,as.integer=TRUE)
yeardiff <- years[-1]-years[-length(years)]
names(yeardiff) <- getYears(glo)[-1]
a <- mbind(reg,glo)[,-1,]
a[,1,] <- 0
a <- a * yeardiff[getYears(a)]
a <- as.magpie(apply(a, c(1, 3), cumsum),spatial=2,temporal=1)/1000
emis_total <- a

reg <- setNames(emis[,,"luc"],paste("Emissions|CO2|Land-use change (Gt CO2)",NULL,sep=""))
glo <- superAggregate(reg,level="glo",aggr_type="sum")
a <- mbind(reg,glo)[,-1,]
a[,1,] <- 0
a <- a * im_years[, getYears(a), ]
a <- as.magpie(apply(a, c(1, 3), cumsum),spatial=2,temporal=1)/1000
emis_luc <- a

reg <- setNames(emis[,,"vegdyn"],paste("Emissions|CO2|Regrowth (Gt CO2)",NULL,sep=""))
glo <- superAggregate(reg,level="glo",aggr_type="sum")
a <- mbind(reg,glo)[,-1,]
a[,1,] <- 0
a <- a * im_years[, getYears(a), ]
a <- as.magpie(apply(a, c(1, 3), cumsum),spatial=2,temporal=1)/1000
emis_regrowth <- a

emis_netland <- setNames(dimSums(mbind(emis_luc,emis_regrowth),dim=3.1),"Emissions|CO2|Net Land (Gt CO2)")

out <- mbind(out_land[,,1],out_crop,out_land[,,-1],out_yld_cereal,out_yld_livst,out_livst_prod,out_tc,out_yld_bio,out_yld_bio_grass,out_yld_bio_woody,out_yld,emis_total,emis_luc,emis_regrowth,emis_netland)

write.report(out,path(luc4c_data_file),model = "MAgPIE",scenario = title,ndigit = 4,append = TRUE)
