# |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ------------------------------------------------------------------------------------------------
# description: Interpolates MAgPIE results to 0.5 degree resolution in LUH2 format for ISIMIP 3b
# comparison script: FALSE
# ------------------------------------------------------------------------------------------------

library(lucode2)
library(magpie4)
library(luscale)
library(madrat)
library(raster)
library(mrcommons)

############################# BASIC CONFIGURATION ##############################
if(!exists("source_include")) {
  outputdir <- "/p/projects/magpie/data/ISIMIP/ISIMIP_150322/magpie/output/c1000_150322_Calib/ISIMIP_150322_med_ssp585_IPSL-CM6A-LR_cc_c1000/"

  readArgs("outputdir")
}

map_file                   <- Sys.glob(file.path(outputdir, "clustermap_*.rds"))
gdx                        <- file.path(outputdir,"fulldata.gdx")
land_hr_file               <- file.path(outputdir,"avl_land_full_t_0.5.mz")
urban_land_hr_file         <- file.path(outputdir,"f34_urbanland_0.5.mz")
land_hr_out_file           <- file.path(outputdir,"cell.land_0.5.mz")
croparea_hr_share_out_file <- file.path(outputdir,"cell.croparea_0.5_share.mz")

cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
if (!file.exists(file.path(outputdir,"cell.land_0.5.mz"))) stop('No disaggrated land use patterns found. Run "disaggregation.R" first!')
################################################################################


#### Folder for saving results
out_dir<-paste0(outputdir,"/disaggregation_LUH2")
    if(!dir.exists(out_dir)) dir.create(out_dir)


#### Year interpolation and re-projection from  0.5 to 0.25 degree

convertLUH2 <- function(x) {
  #interpolate years
  years <- getYears(x,as.integer = TRUE)
  x <- toolFillYears(x,seq(range(years)[1],range(years)[2],by=1))


  for(n in seq(1995,2085,15)){
      x_1<- if(n==1995) as.RasterBrick(x[,n:(n+15),]) else  as.RasterBrick(x[,(n+1):(n+15),])
      x_aux<- if(n==1995) x_1 else stack(x_aux,x_1)
  }
  #re-project raster from 0.5 to 0.25 degree
  x <- suppressWarnings(projectRaster(x_aux,raster(res=c(0.25,0.25)),method = "ngb"))
  return(x)

}

sizelimit <- getOption("magclass_sizeLimit")
options(magclass_sizeLimit = 1e+12)
on.exit(options(magclass_sizeLimit = sizelimit))


#### Spatial mapping
if(length(map_file)==0) stop("Could not find map file!")
if(length(map_file)>1) {
  warning("More than one map file found. First occurrence will be used!")
  map_file <- map_file[1]
}

#### Crops mapping and grid to cell mapping
mapping_spatial<-readRDS(map_file)
gdx<-paste0(outputdir,"/fulldata.gdx")
mapping<-calcOutput(type = "LUH2MAgPIE", aggregate = FALSE, share = "LUHofMAG", bioenergy = "fix", missing = "fill",rice="total")[,2010,]
if(!dir.exists(paste0(out_dir,"/mappingLUH2MAgPIE/"))) dir.create(paste0(out_dir,"/mappingLUH2MAgPIE"))
if(!file.exists(paste0(out_dir,"/mappingLUH2MAgPIE/LUH2MAgPIE.csv"))) write.csv(as.data.frame(mapping),file=paste0(out_dir,"/mappingLUH2MAgPIE/LUH2MAgPIE.csv"))
countries<-intersect(getCells(mapping),unique(mapping_spatial$country))
mapping_spatial<-subset(mapping_spatial,country %in% countries)
map_LUHMAg_grid<-setYears(speed_aggregate(mapping[countries,,],rel=mapping_spatial,weight=NULL,from="country",to="cell",dim=1),NULL)

#### calculates grid cell area of the earths sphere
land_hr <- read.magpie(land_hr_out_file)
land_hr <- land_hr[,-1,]
cal_area <- function(ix,iy,res=0.5,mha=1) { # pixelarea in m2, mha as factor
  mha*(111.263*1000*res)*(111.263*1000*res)*cos(iy*pi/180.)
}

# grid cell area as magclass object
coord <- mrcommons:::magpie_coord
grarea <- new.magpie(cells_and_regions=mapping_spatial$cell,
                     fill=cal_area(coord[,"lon"],coord[,"lat"], mha=10^-10))
#grarea <- round(grarea,6)

# adjust total grid land area so that it is smaller than the gridcell area (some cells have a larger area acually; should be investigated)
frac <- grarea/dimSums(land_hr, dim=3)
frac[frac>1] <- 1
land_hr <- land_hr*frac

land_hr_shr <- land_hr/dimSums(land_hr, dim=3)
land_hr_shr[is.na(land_hr_shr)] <- 0

#### Crops including bioenergy crops
crop_hr_shr<- read.magpie(croparea_hr_share_out_file)
crop_hr_shr[!is.finite(crop_hr_shr)]<-0
crop_hr<-crop_hr_shr*dimSums(land_hr,dim=3)
crop_hr[!is.finite(crop_hr)]<-0
bioener<-c("begr","betr")
noBioener<-getNames(crop_hr,dim=1)[!(getNames(crop_hr,dim=1)%in%bioener)]
crop_hr_noBio<-crop_hr[,,noBioener]*map_LUHMAg_grid[,,noBioener]

names<-unique(getNames(collapseNames(crop_hr_noBio[,,"tece"])))
crop_hr_LUH<-new.magpie(cells_and_regions=getCells(crop_hr_noBio),years=getYears(crop_hr_noBio),names=names)

for(n in names){
crop_hr_LUH[,,n]<-dimSums(crop_hr_noBio[,,n],dim=3.1)
}

crop_hr_Bio<-setNames(crop_hr[,,bioener],c("c4per.rainfed","c4per.irrigated","c3per.rainfed","c3per.irrigated"))
crop_hr_LUH<-dimOrder(crop_hr_LUH,perm=c(2,1),dim=3)

for (n in getNames(crop_hr_Bio)){
  crop_hr_LUH[,,n]<- crop_hr_LUH[,,n]+crop_hr_Bio[,,n]
}

crop_hr_shr_LUH2_FAO<-round(crop_hr_LUH/dimSums(land_hr,dim=3),3)
crop_hr_shr_LUH2_FAO[!is.finite(crop_hr_shr_LUH2_FAO)]<-0

rm(crop_hr_Bio,crop_hr_noBio)

#### Disaggregation Forestry
forestry_hr_shr <- land_hr_shr[,,"forestry"]
.dissagForestry <- function(gdx, forestry_hr_shr, map) {
  message("Disaggregation Forestry")
  area     <- dimSums(landForestry(gdx, level="cell"),dim="ac")
  area_shr <- area/(dimSums(area,dim=3) + 10^-10)

  # calculate forestry area as share of total cell area
  forestry_hr_shr <- forestry_hr_shr[,getYears(area_shr),]
  area_shr_hr <- madrat::toolAggregate(area_shr, map, to="cell") * setNames(forestry_hr_shr,NULL)

  #check
  if (abs(sum(dimSums(area_shr_hr,dim=3)-forestry_hr_shr,na.rm=T)) > 0.1) warning("large Difference in crop disaggregation detected!")

  return(area_shr_hr)
}
forestry_hr_shr <- .dissagForestry(gdx, forestry_hr_shr, map=map_file)

#### Split pasture into pasture and rangeland
avl_land_full_his <- read.magpie(land_hr_file)
past_range <- c("past","range")
past_range_his_shr <- avl_land_full_his[,,past_range]/dimSums(avl_land_full_his[,,past_range],dim=3)
past_range_his_shr[!is.finite(past_range_his_shr)] <- 0.5
past_range_hr_shr<- new.magpie(cells_and_regions=getCells(past_range_his_shr),years=getYears(land_hr),
                     names=past_range)
past_range_land<- new.magpie(cells_and_regions=getCells(past_range_his_shr),years=getYears(land_hr),
                      names=past_range)
past_range_land[,getYears(past_range_his_shr),]<-past_range_his_shr*land_hr[,getYears(past_range_his_shr),"past"]
range_land_2015<-setYears(past_range_land[,2015,"range"],NULL)

yer<-getYears(past_range_land,as.integer=TRUE)[getYears(past_range_land,as.integer=TRUE)>2015]
past_range_land[,yer,"range"]<-range_land_2015[,,"range"]
past_range_land[,yer,"range"]<-magpply(X = mbind(past_range_land[,yer,"range"],land_hr[,yer,"past"]), FUN = min, DIM = 3)
past_range_land[,yer,"past"]<-land_hr[,yer,"past"]-past_range_land[,yer,"range"]
past_range_hr_shr<-round(past_range_land/dimSums(land_hr,dim=3),3)
past_range_hr_shr[!is.finite(past_range_hr_shr)]<-0
rm(past_range_his_shr,past_range_land,range_land_2015)

#### Split other land into primary and secondary other land
other <- c("primother","secdother")
avl_land_full <- setYears(avl_land_full_his[,1995,],NULL)
other_hr_shr <- avl_land_full[,,other]/dimSums(avl_land_full[,,other],dim=3)
other_hr_shr[is.na(other_hr_shr)] <- 0.5
other_hr_shr <- other_hr_shr * setNames(land_hr_shr[,,"other"],NULL)

if(!file.exists(paste0(out_dir,"/LUH2_states.nc"))){
states <- mbind(dimSums(crop_hr_shr_LUH2_FAO,dim=3.2),
                setNames(past_range_hr_shr[,,"past"],"pastr"),
                setNames(past_range_hr_shr[,,"range"],"range"),
                setNames(land_hr_shr[,,"primforest"],"primf"),
                setNames(forestry_hr_shr[,,"plant"],"timber"),
                setNames(land_hr_shr[,,"secdforest"]+forestry_hr_shr[,,"ndc"]+forestry_hr_shr[,,"aff"],"secdf"),
                setNames(other_hr_shr[,,"primother"],"primn"),
                setNames(other_hr_shr[,,"secdother"],"secdn"),
                setNames(land_hr_shr[,,"urban"],"urban")
)

rm(avl_land_full,past_range_hr_shr,forestry_hr_shr,other_hr_shr)
gc()
saveRDS(states,paste0(outputdir,"/states.rds"))
gc()
states <- convertLUH2(states)
gc()
write.magpie(states,paste0(out_dir,"/LUH2_states.nc"),comment = "unit: fraction of grid-cell area")
rm(states)
gc()
}

#### Protected areas

b <- protectedArea(gdx,level = "grid",dir=outputdir) / dimSums(land_hr, dim=3)
b[is.na(b)] <- 0
luh2 <- data.frame(matrix(nrow=3,ncol=2))
names(luh2) <- c("LUH2","MAgPIE")
luh2[1,] <- c("primf_prot","primforest")
luh2[2,] <- c("secdf_prot","secdforest")
luh2[3,] <- c("primn_secdn_prot","other")
b <- madrat::toolAggregate(b, luh2, from="MAgPIE", to="LUH2",dim = 3)
gc()
if(!file.exists(paste0(out_dir,"/LUH2_protected_area.nc"))){
b <- convertLUH2(b)
gc()
write.magpie(b,paste0(out_dir,"/LUH2_protected_area.nc"),comment = "unit: fraction of grid-cell")
rm(b)
gc()
}

####### ONLY DYNAMIC FORESTRY ON#############

#### Wood
land_lr <- madrat::toolAggregate(dimSums(land_hr,dim=3), map_file, from = "cell",to = "cluster")

### Wood: Harvested Area
a <- harvested_area_timber(gdx,level = "cell")
b <- a / land_lr
b <- madrat::toolAggregate(b, map_file, from = "cluster",to = "cell")
luh2 <- data.frame(matrix(nrow=4,ncol=2))
names(luh2) <- c("LUH2","MAgPIE")
luh2[1,] <- c("timber_harv","Forestry")
luh2[2,] <- c("primf_harv","Primary forest")
luh2[3,] <- c("secdf_harv","Secondary forest")
luh2[4,] <- c("primn_secdn_harv","Other land")
b <- madrat::toolAggregate(b, luh2, from="MAgPIE", to="LUH2",dim = 3)
gc()
if(!file.exists(paste0(out_dir,"/LUH2_wood_harvest_area.nc"))){
b <- convertLUH2(b)
gc()
write.magpie(b,paste0(out_dir,"/LUH2_wood_harvest_area.nc"),comment = "unit: fraction of grid-cell area per year")
rm(a,b)
gc()
}

#### Wood: Yields
a <- ForestYield(gdx,level="cell")
a_fix<- new.magpie(cells_and_regions=getCells(a),years=getYears(a),
                      names=getNames(a))

# BugFix in the mean time. Strange jump from ForestYield
a_fix[,1,]<-0
a_fix[,-1,]<-setYears(a[,2100,,invert=TRUE],getYears(a_fix[,-1,]))
a[a>500]<-a_fix[a>500]
b <- madrat::toolAggregate(a, map_file, from = "cluster",to = "cell")
luh2 <- data.frame(matrix(nrow=4,ncol=2))
names(luh2) <- c("LUH2","MAgPIE")
luh2[1,] <- c("timber_bioh","Forestry")
luh2[2,] <- c("primf_bioh","Primary forest")
luh2[3,] <- c("secdf_bioh","Secondary forest")
luh2[4,] <- c("primn_secdn_bioh","Other land")
b <- madrat::toolAggregate(b, luh2, from="MAgPIE", to="LUH2",dim = 3)
gc()
if(!file.exists(paste0(out_dir,"/LUH2_wood_harvest_yields.nc"))){
b <- convertLUH2(b)
gc()
write.magpie(b,paste0(out_dir,"/LUH2_wood_harvest_yields.nc"),comment = "unit: m3 per ha per year")
rm(a,b)
gc()
}

#### Wood: Harvested Biomass Product Split
b <- TimberProductionVolumetric(gdx,level = "cell",sumSource = FALSE,sumProduct = FALSE)
b <- dimSums(b,dim=3.1)
b <- b/dimSums(b,dim=3)
getNames(b) <- c("rndwd","fulwd")
b <- madrat::toolAggregate(b, map_file, from = "cluster",to = "cell")
if(!file.exists(paste0(out_dir,"/LUH2_wood_harvest_biomass_split.nc"))){
b <- convertLUH2(b)
gc()
write.magpie(b,paste0(out_dir,"/LUH2_wood_harvest_biomass_split.nc"),comment = "unit: fraction of wood harvest biomass")
rm(b)
gc()
}

####### ONLY DYNAMIC FORESTRY ON#############

#### Irrigation
irrig_hr_shr <- collapseNames(crop_hr_shr_LUH2_FAO[,,"irrigated"],collapsedim = 3.2)
getNames(irrig_hr_shr) <- paste("irrig",getNames(irrig_hr_shr),sep="_")
irrig_hr_shr <- collapseNames(irrig_hr_shr/(round(setNames(land_hr_shr[,,"crop"],NULL),3)))
irrig_hr_shr[!is.finite(irrig_hr_shr)]<-0
d <- dimSums(irrig_hr_shr*dimSums(land_hr[,,"crop"],dim=3),dim=c(1,3))-croparea(gdx,level="glo",product_aggr = T,water_aggr = FALSE)[,,"irrigated"]
if (any(abs(d) > 0.1 )) message(paste0("Difference between cluster and grid cell production > 0.1 detected!"))

if(!file.exists(paste0(out_dir,"/LUH2_irrigation.nc"))){
irrig_hr_shr <- convertLUH2(irrig_hr_shr)
gc()
write.magpie(irrig_hr_shr,paste0(out_dir,"/LUH2_irrigation.nc"),comment = "unit: fraction of crop area")
rm(irrig_hr_shr,d)
gc()
}

#### Flood

rice_historical<-calcOutput("Ricearea",cellular=TRUE,aggregate=FALSE, share = FALSE)
rice_historical<-speed_aggregate(rice_historical,rel=mapping_spatial,from="cell",to="region",weight=NULL)
share_rice_flooded<-setNames(1-(rice_historical[,,"nonflooded"]/rice_historical[,,"total"])[,c(1995,2000,2005,2010),],NULL)
share<-speed_aggregate(share_rice_flooded,rel=mapping_spatial,from="region",to="cell",weight=NULL)

rice <- dimSums(crop_hr_shr[,,"rice_pro"],dim=3.2)
rice[,c(1995,2000,2005,2010),]<-rice[,c(1995,2000,2005,2010),]*share[,c(1995,2000,2005,2010),]
ye<-getYears(rice, as.integer=T)[!(getYears(rice, as.integer=T) %in% c(1995,2000,2005,2010))]
rice[,ye,]<-rice[,ye,]*setYears(share[,2010,],NULL)
flooded<-round(rice,3)
getNames(flooded,dim=1) <- "flood"
flooded <- flooded / dimSums(crop_hr_shr_LUH2_FAO[,,"c3ann"],dim=3)
flooded[!is.finite(flooded)]<-0
d <- dimSums(flooded* dimSums(crop_hr_shr_LUH2_FAO[,,"c3ann"],dim=3)*dimSums(land_hr,dim=3),dim=c(1,3))-croparea(gdx,level="glo",product_aggr = F,water_aggr = T)[,,"rice_pro"]
if (any(abs(d) > 0.1 )) message(paste0("Difference between cluster and grid cell production > 0.1 detected!"))
if(!file.exists(paste0(out_dir,"/LUH2_flood.nc"))){
flooded <- convertLUH2(flooded)
gc()
write.magpie(flooded,paste0(out_dir,"/LUH2_flood.nc"),comment = "unit: flooded fraction of C3 annual crop area")
rm(flooded,d)
gc()
}

#### Bioenergy
bio_hr_shr <- dimSums(crop_hr_shr[,,c("begr","betr")],dim=3.2)
getNames(bio_hr_shr,dim=1) <- c("c4per","c3per")
bio_hr_shr[bio_hr_shr<0.01]<-0
bio_hr_shr <- round(bio_hr_shr,3) / dimSums(crop_hr_shr_LUH2_FAO[,,c("c4per","c3per")],dim=3.2)
bio_hr_shr[!is.finite(bio_hr_shr)]<-0
d<-dimSums((bio_hr_shr[,,c("c4per","c3per")])*dimSums(crop_hr_shr_LUH2_FAO[,,c("c4per","c3per")],dim=3.2)*dimSums(land_hr,dim=3),dim=c(1,3))-croparea(gdx,level="glo",products = c("begr","betr"),product_aggr = T)
if (any(abs(d) > 0.1 )) message(paste0("Difference between cluster and grid cell production > 0.1 detected!"))
getNames(bio_hr_shr,dim=1) <- c("crpbf_c4per","crpbf_c3per")

if(!file.exists(paste0(out_dir,"/LUH2_bioenergy.nc"))){
bio_hr_shr <- convertLUH2(bio_hr_shr)
gc()
write.magpie(bio_hr_shr,paste0(out_dir,"/LUH2_bioenergy.nc"),comment = "unit: fraction of crop type area occupied by biofuel crops")
rm(bio_hr_shr,d)
gc()
}

#Croparea from LUH to avoid re-mapping LUH and magpie
crop_threshold <- 0.0001
crop<- crop_hr_LUH
crop_hr<-dimSums(crop,dim=3.2)
crop_hr_shr <- dimSums(crop_hr_shr_LUH2_FAO,dim=3.2)

crop_hr_rf <- collapseNames(crop[,,"rainfed"],collapsedim = 3.2)
crop_hr_rf_shr <- collapseNames(crop_hr_shr_LUH2_FAO[,,"rainfed"])

crop_hr_ir <- collapseNames(crop[,,"irrigated"],collapsedim = 3.2)
crop_hr_ir_shr <- collapseNames(crop_hr_shr_LUH2_FAO[,,"irrigated"])

#### Nitrogen budget

if(file.exists(paste0(outputdir,"/NitrogenBudget.rds")) & file.exists(paste0(outputdir,"/NitrogenBudgetWeight.rds"))) {
  a <- readRDS(paste0(outputdir,"/NitrogenBudget.rds"))
  weight_kr <- readRDS(paste0(outputdir,"/NitrogenBudgetWeight.rds"))
} else {
  #read-in NR budget in mio t N
  a <- NitrogenBudget(gdx,level="grid",dir = outputdir)
  saveRDS(a,paste0(outputdir,"/NitrogenBudget.rds"))
  #read-in crop specific weight
  weight_kr <- NitrogenBudgetWithdrawals(gdx,kcr="kcr",level="grid",net=TRUE,dir=outputdir)
  saveRDS(weight_kr,paste0(outputdir,"/NitrogenBudgetWeight.rds"))
}

#Rename and aggregate crop types in weight from MAgPIE to LUH2
weight_kr_luh<-weight_kr*map_LUHMAg_grid
rm(weight_kr)
names<-unique(getNames(dimSums(map_LUHMAg_grid,dim=3.2)))
weight<-new.magpie(cells_and_regions=getCells(weight_kr_luh),years=getYears(weight_kr_luh),names=names)

for(n in names){
weight[,,n]<-dimSums(weight_kr_luh[,,n],dim=3.1)
}

#subset
a <- a[,,c("fertilizer","manure","surplus")]
a[a<0] <- 0
#make it crop specific
a <- ((a * weight) / dimSums(weight,dim=3,na.rm = TRUE))
#filter
a[crop_hr<crop_threshold] <- NA

#divide by croparea -> tN/ha; convert from tN/ha to kgN/ha: tN/ha*1000kg/t = 1000 kgN/ha

a <- (a/crop_hr)*1000

if(!file.exists(paste0(out_dir,"/LUH2_Nitrogen_fertilizer.nc"))){
x <- convertLUH2(clean_magpie(collapseNames(a[,,"fertilizer"],collapsedim = 3.1)))
gc()
write.magpie(x,paste0(out_dir,"/LUH2_Nitrogen_fertilizer.nc"),comment = "unit: kgN-per-ha")
}

if(!file.exists(paste0(out_dir,"/LUH2_Nitrogen_manure.nc"))){
x <- convertLUH2(clean_magpie(collapseNames(a[,,"manure"],collapsedim = 3.1)))
gc()
write.magpie(x,paste0(out_dir,"/LUH2_Nitrogen_manure.nc"),comment = "unit: kgN-per-ha")
}

if(!file.exists(paste0(out_dir,"/LUH2_Nitrogen_surplus.nc"))){
x <- convertLUH2(clean_magpie(collapseNames(a[,,"surplus"],collapsedim = 3.1)))
gc()
write.magpie(x,paste0(out_dir,"/LUH2_Nitrogen_surplus.nc"),comment = "unit: kgN-per-ha")
}

rm(a,x,weight)
gc()

#### Yields DM
yield_kr <- collapseNames(yields(gdx,level="cell",products = "kcr",product_aggr = FALSE,water_aggr = TRUE,attributes = "dm"))
yield_kr <-gdxAggregate(gdx,yield_kr,weight=NULL, absolute=FALSE,to="grid",dir=outputdir)
yield_kr_su <- yield_kr*map_LUHMAg_grid

a<-new.magpie(cells_and_regions=getCells(yield_kr_su),years=getYears(yield_kr_su),
                                              names=unique(getNames(collapseNames(yield_kr_su[,,"tece"]))))
for(n in names){
a[,,n]<-dimSums(yield_kr_su[,,n],dim=3)/dimSums(map_LUHMAg_grid[,,n],dim=3)
}

if(!file.exists(paste0(out_dir,"/LUH2_Yield_DM.nc"))){
a <- convertLUH2(a)
gc()
write.magpie(a,paste0(out_dir,"/LUH2_Yield_DM.nc"),comment = "unit: tDM-per-ha")
rm(a,yield_kr,yield_kr_su)
gc()
}

#### Yields DM rainfed
#read-in production in mio tDM
yield_kr <- collapseNames(yields(gdx,level="cell",products = "kcr",product_aggr = FALSE,water_aggr = FALSE,attributes = "dm")[,,"rainfed"])
yield_kr <-gdxAggregate(gdx,yield_kr,weight=NULL, absolute=FALSE,to="grid",dir=outputdir)
yield_kr_su <- yield_kr*map_LUHMAg_grid
a<-new.magpie(cells_and_regions=getCells(yield_kr_su),years=getYears(yield_kr_su),
                                              names=unique(getNames(collapseNames(yield_kr_su[,,"tece"]))))
for(n in names){
a[,,n]<-dimSums(yield_kr_su[,,n],dim=3)/dimSums(map_LUHMAg_grid[,,n],dim=3)
}

if(!file.exists(paste0(out_dir,"/LUH2_Yield_DM_rainfed.nc"))){
a <- convertLUH2(a)
gc()
write.magpie(a,paste0(out_dir,"/LUH2_Yield_DM_rainfed.nc"),comment = "unit: tDM-per-ha")
rm(a,yield_kr,yield_kr_su)
gc()
}

#### Yields DM irrigated
#read-in production in mio tDM
yield_kr <- collapseNames(yields(gdx,level="cell",products = "kcr",product_aggr = FALSE,water_aggr = FALSE,attributes = "dm")[,,"irrigated"])
yield_kr <-gdxAggregate(gdx,yield_kr,weight=NULL, absolute=FALSE,to="grid",dir=outputdir)
yield_kr_su <- yield_kr*map_LUHMAg_grid
a<-new.magpie(cells_and_regions=getCells(yield_kr_su),years=getYears(yield_kr_su),
                                              names=unique(getNames(collapseNames(yield_kr_su[,,"tece"]))))
for(n in names){
a[,,n]<-dimSums(yield_kr_su[,,n],dim=3)/dimSums(map_LUHMAg_grid[,,n],dim=3)
}

if(!file.exists(paste0(out_dir,"/LUH2_Yield_DM_irrigated.nc"))){
a <- convertLUH2(a)
gc()
write.magpie(a,paste0(out_dir,"/LUH2_Yield_DM_irrigated.nc"),comment = "unit: tDM-per-ha")
rm(a,yield_kr,yield_kr_su)
gc()
}

#### Yields Nr
#read-in production in mio tN
yield_kr <- collapseNames(yields(gdx,level="cell",products = "kcr",product_aggr = FALSE,water_aggr = TRUE,attributes = "nr"))*1000
yield_kr <-gdxAggregate(gdx,yield_kr,weight=NULL, absolute=FALSE,to="grid",dir=outputdir)
yield_kr_su <- yield_kr*map_LUHMAg_grid

a<-new.magpie(cells_and_regions=getCells(yield_kr_su),years=getYears(yield_kr_su),
                                              names=unique(getNames(collapseNames(yield_kr_su[,,"tece"]))))
for(n in names){
a[,,n]<-dimSums(yield_kr_su[,,n],dim=3)/dimSums(map_LUHMAg_grid[,,n],dim=3)
}
if(!file.exists(paste0(out_dir,"/LUH2_Yield_Nr.nc"))){
a <- convertLUH2(a)
gc()
write.magpie(a,paste0(out_dir,"/LUH2_Yield_Nr.nc"),comment = "unit: kgN-per-ha")
rm(a,yield_kr,yield_kr_su)
gc()
}
