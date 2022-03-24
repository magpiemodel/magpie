# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Interpolates MAgPIE results to 0.5 degree resolution in LUH2 format
# comparison script: FALSE
# ---------------------------------------------------------------

library(lucode2)
library(magpie4)
library(luscale)
library(madrat)
library(gms)

############################# BASIC CONFIGURATION ##############################
if(!exists("source_include")) {
  outputdir <- "output/HR_LAMA86_Sustainability"
  readArgs("outputdir")
}
map_file                   <- Sys.glob(file.path(outputdir, "clustermap_*.rds"))
gdx                        <- file.path(outputdir,"fulldata.gdx")
land_hr_file               <- file.path(outputdir,"avl_land_full_t_0.5.mz")
urban_land_hr_file         <- file.path(outputdir,"f34_urbanland_0.5.mz")

cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
################################################################################

sizelimit <- getOption("magclass_sizeLimit")
options(magclass_sizeLimit = 1e+12)
on.exit(options(magclass_sizeLimit = sizelimit))

if(length(map_file)==0) stop("Could not find map file!")
if(length(map_file)>1) {
  warning("More than one map file found. First occurrence will be used!")
  map_file <- map_file[1]
}

mapping <- readRDS(map_file)


# Load input data
land_ini_lr  <- readGDX(gdx,"f10_land","f_land", format="first_found")[,"y1995",]
land_lr      <- land(gdx,sum=FALSE,level="cell")
land_ini_hr  <- read.magpie(land_hr_file)[,"y1995",]
magpie2luh2 <- data.frame(matrix(nrow=4,ncol=2))
names(magpie2luh2) <- c("MAgPIE","LUH2")
magpie2luh2[1,] <- c("crop","crop")
magpie2luh2[2,] <- c("past","past")
magpie2luh2[3,] <- c("past","range")
magpie2luh2[4,] <- c("urban","urban")
magpie2luh2[5,] <- c("primforest","primforest")
magpie2luh2[6,] <- c("secdforest","secdforest")
magpie2luh2[7,] <- c("forestry","forestry")
magpie2luh2[8,] <- c("other","primother")
magpie2luh2[9,] <- c("other","secdother")
land_ini_hr <- madrat::toolAggregate(land_ini_hr, magpie2luh2, from="LUH2", to="MAgPIE",dim = 3.1)
land_ini_hr  <- land_ini_hr[,,getNames(land_lr)]
if(any(land_ini_hr < 0)) {
  warning(paste0("Negative values in inital high resolution dataset detected and set to 0. Check the file ",land_hr_file))
  land_ini_hr[which(land_ini_hr < 0,arr.ind = T)] <- 0
}

#read in hr urban land
if (cfg$gms$urban == "exo_nov21" ) {
  urban_land_hr  <- read.magpie(urban_land_hr_file)
  ssp <- cfg$gms$c34_urban_scenario
  urban_land_hr <- urban_land_hr[,,ssp]
  getNames(urban_land_hr) <- "urban"
} else if (cfg$gms$urban == "static"){
  urban_land_hr <- "static"
}

# account for country-specific set-aside shares in post-processing
iso <- readGDX(gdx, "iso")
set_aside_iso <- readGDX(gdx,"policy_countries30")
set_aside_select <- readGDX(gdx, "s30_set_aside_shr")
set_aside_noselect <- readGDX(gdx, "s30_set_aside_shr_noselect")
set_aside_shr <- new.magpie(iso, fill = set_aside_noselect)
set_aside_shr[set_aside_iso,,] <- set_aside_select

avl_cropland_hr <- file.path(outputdir, "avl_cropland_0.5.mz")       # available cropland (at high resolution)
marginal_land <- cfg$gms$c30_marginal_land                      # marginal land scenario
target_year <- cfg$gms$c30_set_aside_target                     # target year of set aside policy (default: "none")
set_aside_fader  <- readGDX(gdx,"f30_set_aside_fader", format="first_found")[,,target_year]

# Start interpolation (use interpolateAvlCroplandWeighted from luscale)
message("Disaggregation Land use types")
land_hr <- interpolateAvlCroplandWeighted(x          = land_lr,
                                          x_ini_lr   = land_ini_lr,
                                          x_ini_hr   = land_ini_hr,
                                          avl_cropland_hr = avl_cropland_hr,
                                          map        = map_file,
                                          marginal_land = marginal_land,
                                          set_aside_shr = set_aside_shr,
                                          set_aside_fader = set_aside_fader,
                                          urban_land_hr = urban_land_hr)

land_hr <- land_hr[,-1,]

# calculates grid cell area of the earths sphere
cal_area <- function(ix,iy,res=0.5,mha=1) { # pixelarea in m2, mha as factor
  mha*(111.263*1000*res)*(111.263*1000*res)*cos(iy*pi/180.)
}

# grid cell area as magclass object
coord <- mrcommons:::magpie_coord
# grarea <- new.magpie(cells_and_regions=mapping$cell,
#                      years=2005,
#                      names="Grid-cell aera (Mha)",
#                      fill=cal_area(coord[,"lon"],coord[,"lat"], mha=10^-10))
grarea <- new.magpie(cells_and_regions=mapping$cell,
                     fill=cal_area(coord[,"lon"],coord[,"lat"], mha=10^-10))
#grarea <- round(grarea,6)

# adjust total grid land area so that it is smaller than the gridcell area (some cells have a larger area acually; should be investigated)
frac <- grarea/dimSums(land_hr, dim=3)
frac[frac>1] <- 1
land_hr <- land_hr*frac

land_hr_shr <- land_hr/dimSums(land_hr, dim=3)
land_hr_shr[is.na(land_hr_shr)] <- 0

map_crops <- data.frame(matrix(nrow=19,ncol=2))
names(map_crops) <- c("LUH2","MAgPIE")
map_crops[1,] <- c("c3ann","tece")
map_crops[2,] <- c("c3ann","rice_pro")
map_crops[3,] <- c("c3ann","rapeseed")
map_crops[4,] <- c("c3ann","sunflower")
map_crops[5,] <- c("c3ann","potato")
map_crops[6,] <- c("c3ann","cassav_sp")
map_crops[7,] <- c("c3ann","sugr_beet")
map_crops[8,] <- c("c3ann","others")
map_crops[9,] <- c("c3ann","cottn_pro")
map_crops[10,] <- c("c3ann","foddr")
map_crops[11,] <- c("c4ann","maiz")
map_crops[12,] <- c("c4ann","trce")
map_crops[13,] <- c("c3per","oilpalm")
map_crops[14,] <- c("c3per","betr")
map_crops[15,] <- c("c4per","sugr_cane")
map_crops[16,] <- c("c4per","begr")
map_crops[17,] <- c("c3nfx","soybean")
map_crops[18,] <- c("c3nfx","groundnut")
map_crops[19,] <- c("c3nfx","puls_pro")


### Disaggregation crop types
crop_hr_shr <- land_hr_shr[,,"crop"]
.dissagCrop <- function(gdx, crop_hr_shr, map, water_aggr=TRUE,map2crops=map_crops) {
  message("Disaggregation crop types")
  area     <- croparea(gdx, level="cell", products="kcr",
                       product_aggr=FALSE,water_aggr = water_aggr)
  area_shr <- area/(dimSums(area,dim=3) + 10^-10)

  #Rename and aggregate crop types from MAgPIE to LUH2
  if (!is.null(map2crops)) area_shr <- madrat::toolAggregate(area_shr, map2crops, from="MAgPIE", to="LUH2",dim = 3.1)

  # calculate crop area as share of total cell area
  crop_hr_shr <- crop_hr_shr[,getYears(area_shr),]
  area_shr_hr <- madrat::toolAggregate(area_shr, map, to="cell") * setNames(crop_hr_shr,NULL)

  #check
  if (abs(sum(dimSums(area_shr_hr,dim=3)-crop_hr_shr,na.rm=T)) > 0.1) warning("large Difference in crop disaggregation detected!")

  return(area_shr_hr)
}
crop_hr_shr <- .dissagCrop(gdx, crop_hr_shr, map=map_file)


### Disaggregation Forestry
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

avl_land_full <- setYears(read.magpie(land_hr_file)[,1995,],NULL)

### Split pasture into pasture and rangeland
past_range <- c("past","range")
past_range_hr_shr <- avl_land_full[,,past_range]/dimSums(avl_land_full[,,past_range],dim=3)
past_range_hr_shr[is.na(past_range_hr_shr)] <- 0.5
past_range_hr_shr <- past_range_hr_shr * setNames(land_hr_shr[,,"past"],NULL)

### Split other land into primary and secondary other land
other <- c("primother","secdother")
other_hr_shr <- avl_land_full[,,other]/dimSums(avl_land_full[,,other],dim=3)
other_hr_shr[is.na(other_hr_shr)] <- 0.5
other_hr_shr <- other_hr_shr * setNames(land_hr_shr[,,"other"],NULL)


states <- mbind(crop_hr_shr,
                setNames(past_range_hr_shr[,,"past"],"pastr"),
                setNames(past_range_hr_shr[,,"range"],"range"),
                setNames(land_hr_shr[,,"primforest"],"primf"),
                setNames(forestry_hr_shr[,,"plant"],"timber"),
                setNames(land_hr_shr[,,"secdforest"]+forestry_hr_shr[,,"ndc"]+forestry_hr_shr[,,"aff"],"secdf"),
                setNames(other_hr_shr[,,"primother"],"primn"),
                setNames(other_hr_shr[,,"secdother"],"secdn"),
                setNames(land_hr_shr[,,"urban"],"urban")
)

write.magpie(states,file.path(outputdir,"LUH2_states.nc"),comment = "unit: fraction of grid-cell area")
rm(avl_land_full,states,past_range_hr_shr,forestry_hr_shr,other_hr_shr)
gc()

### Wood: Harvested Biomass
a <- TimberProductionVolumetric(gdx,level = "cell",sumSource = FALSE,sumProduct = TRUE)
b <- gdxAggregate(gdx,a,weight = land_hr[,,getNames(a,dim=1)],to="grid",absolute = TRUE,dir=outputdir)
d <- dimSums(a,dim=c(1))-dimSums(b,dim=c(1))
if (any(abs(d) > 0.1 & !Inf)) message(paste0("Difference between cluster and grid cell production > 0.1 detected!"))
luh2 <- data.frame(matrix(nrow=4,ncol=2))
names(luh2) <- c("LUH2","MAgPIE")
luh2[1,] <- c("timber_bioh","forestry")
luh2[2,] <- c("primf_bioh","primforest")
luh2[3,] <- c("secdf_bioh","secdforest")
luh2[4,] <- c("primn_secdn_bioh","other")
b <- madrat::toolAggregate(b, luh2, from="MAgPIE", to="LUH2",dim = 3)
write.magpie(b,file.path(outputdir,"LUH2_wood_harvest_biomass.nc"),comment = "unit: mio. m3 per year")
rm(a,b,d)
gc()


### Wood: Harvested Biomass Product Split
a <- TimberProductionVolumetric(gdx,level = "cell",sumSource = FALSE,sumProduct = FALSE)
b <- gdxAggregate(gdx,a,weight = land_hr[,,getNames(a,dim=1)],to="grid",absolute = TRUE,dir=outputdir)
d <- dimSums(a,dim=c(1))-dimSums(b,dim=c(1))
if (any(abs(d) > 0.1 & !Inf)) message(paste0("Difference between cluster and grid cell production > 0.1 detected!"))
b <- dimSums(b,dim=3.1)
b <- b/dimSums(b,dim=3)
getNames(b) <- c("rndwd","fulwd")
write.magpie(b,file.path(outputdir,"LUH2_wood_harvest_biomass_split.nc"),comment = "unit: fraction of wood harvest biomass")
rm(a,b,d)
gc()


### Wood: Harvested Area
a <- harvested_area_timber(gdx,level = "cell")
getNames(a) <- c("forestry","secdforest","primforest","other")
b <- gdxAggregate(gdx,a,weight = land_hr[,,getNames(a)],to="grid",absolute = TRUE,dir=outputdir)
d <- dimSums(a,dim=c(1))-dimSums(b,dim=c(1))
if (any(abs(d) > 0.1 & !Inf)) message(paste0("Difference between cluster and grid cell production > 0.1 detected!"))
luh2 <- data.frame(matrix(nrow=4,ncol=2))
names(luh2) <- c("LUH2","MAgPIE")
luh2[1,] <- c("timber_harv","forestry")
luh2[2,] <- c("primf_harv","primforest")
luh2[3,] <- c("secdf_harv","secdforest")
luh2[4,] <- c("primn_secdn_harv","other")
b <- madrat::toolAggregate(b, luh2, from="MAgPIE", to="LUH2",dim = 3)
write.magpie(b,file.path(outputdir,"LUH2_wood_harvest_area.nc"),comment = "unit: fraction of grid-cell area per year")
rm(a,b,d)
gc()


### Irrigation
irrig_hr_shr <- .dissagCrop(gdx, land_hr_shr[,,"crop"], map=map_file, water_aggr = FALSE)
irrig_hr_shr <- collapseNames(irrig_hr_shr[,,"irrigated"],collapsedim = 3.2)
getNames(irrig_hr_shr) <- paste("irrig",getNames(irrig_hr_shr),sep="_")
d <- dimSums(irrig_hr_shr*dimSums(land_hr,dim=3),dim=c(1,3))-croparea(gdx,level="glo",product_aggr = T,water_aggr = FALSE)[,,"irrigated"]
if (any(abs(d) > 0.1 & !Inf)) message(paste0("Difference between cluster and grid cell production > 0.1 detected!"))
write.magpie(irrig_hr_shr,file.path(outputdir,"LUH2_irrigation.nc"),comment = "unit: fraction of grid-cell area")
rm(irrig_hr_shr,d)
gc()


### Flood
flooded <- .dissagCrop(gdx, land_hr_shr[,,"crop"], map=map_file, water_aggr = TRUE, map2crops = NULL)
flooded <- flooded[,,"rice_pro"]
getNames(flooded) <- "flood"
d <- dimSums(flooded*dimSums(land_hr,dim=3),dim=c(1,3))-croparea(gdx,level="glo",product_aggr = F,water_aggr = T)[,,"rice_pro"]
if (any(abs(d) > 0.1 & !Inf)) message(paste0("Difference between cluster and grid cell production > 0.1 detected!"))
write.magpie(flooded,file.path(outputdir,"LUH2_flood.nc"),comment = "unit: fraction of grid-cell area")
rm(flooded,d)
gc()

### Bioenergy
bio_hr_shr <- .dissagCrop(gdx, land_hr_shr[,,"crop"], map=map_file, water_aggr = TRUE, map2crops=NULL)
bio_hr_shr <- bio_hr_shr[,,c("begr","betr")]
getNames(bio_hr_shr) <- c("crpbf_c4per","crpbf_c3per")
d <- dimSums(bio_hr_shr*dimSums(land_hr,dim=3),dim=c(1,3))-croparea(gdx,level="glo",products = c("begr","betr"),product_aggr = T)
if (any(abs(d) > 0.1 & !Inf)) message(paste0("Difference between cluster and grid cell production > 0.1 detected!"))
write.magpie(bio_hr_shr,file.path(outputdir,"LUH2_bioenergy.nc"),comment = "unit: fraction of grid-cell area")
rm(bio_hr_shr,d)
gc()

#Croparea
crop_threshold <- 0.0001
crop_hr <- croparea(gdx,level="grid",dir = outputdir,products = "kcr",product_aggr = FALSE,water_aggr = TRUE)
crop_hr <- madrat::toolAggregate(crop_hr, map_crops, from="MAgPIE", to="LUH2",dim = 3.1)
crop_hr_shr <- crop_hr / dimSums(land_hr,dim=3)

crop_hr_rf <- collapseNames(croparea(gdx,level="grid",dir = outputdir,products = "kcr",product_aggr = FALSE,water_aggr = FALSE)[,,"rainfed"],collapsedim = 3.2)
crop_hr_rf <- madrat::toolAggregate(crop_hr_rf, map_crops, from="MAgPIE", to="LUH2",dim = 3.1)
crop_hr_rf_shr <- crop_hr_rf / dimSums(land_hr,dim=3)

crop_hr_ir <- collapseNames(croparea(gdx,level="grid",dir = outputdir,products = "kcr",product_aggr = FALSE,water_aggr = FALSE)[,,"irrigated"],collapsedim = 3.2)
crop_hr_ir <- madrat::toolAggregate(crop_hr_ir, map_crops, from="MAgPIE", to="LUH2",dim = 3.1)
crop_hr_ir_shr <- crop_hr_ir / dimSums(land_hr,dim=3)

### Nitrogen fertilizer
if(file.exists(file.path(outputdir,"NitrogenBudget.rds")) & file.exists(file.path(outputdir,"NitrogenBudgetWeight.rds"))) {
  a <- readRDS(file.path(outputdir,"NitrogenBudget.rds"))
  weight <- readRDS(file.path(outputdir,"NitrogenBudgetWeight.rds"))
} else {
  #read-in NR budget in mio t N
  a <- NitrogenBudget(gdx,level="grid",dir = outputdir)
  saveRDS(a,file.path(outputdir,"NitrogenBudget.rds"))
  #read-in crop specific weight
  weight <- NitrogenBudgetWithdrawals(gdx,kcr="kcr",level="grid",net=TRUE,dir=outputdir)
  saveRDS(weight,file.path(outputdir,"NitrogenBudgetWeight.rds"))
}
#Rename and aggregate crop types in weight from MAgPIE to LUH2
weight <- madrat::toolAggregate(weight, map_crops, from="MAgPIE", to="LUH2",dim = 3.1)
#subset
a <- a[,,c("fertilizer","manure","surplus")]
a[a<0] <- 0
#make it crop specific
a <- ((a * weight) / dimSums(weight,dim=3,na.rm = TRUE))
#filter
a[crop_hr_shr<crop_threshold] <- NA
#divide by croparea -> tN/ha; convert from tN/ha to kgN/ha: tN/ha*1000kg/t = 1000 kgN/ha
a <- (a/crop_hr)*1000
write.magpie(clean_magpie(collapseNames(a[,,"fertilizer"],collapsedim = 3.1)),file.path(outputdir,"LUH2_Nitrogen_fertilizer.nc"),comment = "unit: kgN-per-ha")
write.magpie(clean_magpie(collapseNames(a[,,"manure"],collapsedim = 3.1)),file.path(outputdir,"LUH2_Nitrogen_manure.nc"),comment = "unit: kgN-per-ha")
write.magpie(clean_magpie(collapseNames(a[,,"surplus"],collapsedim = 3.1)),file.path(outputdir,"LUH2_Nitrogen_surplus.nc"),comment = "unit: kgN-per-ha")
rm(a,weight)
gc()

### Yields DM
#read-in production in mio tDM
a <- production(gdx,level="grid",dir = outputdir,products = "kcr",product_aggr = FALSE,water_aggr = TRUE,attributes = "dm")
#Rename and aggregate crop types from MAgPIE to LUH2
a <- madrat::toolAggregate(a, map_crops, from="MAgPIE", to="LUH2",dim = 3.1)
#filter
a[crop_hr_shr<crop_threshold] <- NA
#divide by croparea -> tDM/ha
a <- (a/crop_hr)
write.magpie(a,file.path(outputdir,"LUH2_Yield_DM.nc"),comment = "unit: tDM-per-ha")
rm(a)
gc()

### Yields DM rainfed
#read-in production in mio tDM
a <- collapseNames(production(gdx,level="grid",dir = outputdir,products = "kcr",product_aggr = FALSE,water_aggr = FALSE,attributes = "dm")[,,"rainfed"],collapsedim = 3.2)
#Rename and aggregate crop types from MAgPIE to LUH2
a <- madrat::toolAggregate(a, map_crops, from="MAgPIE", to="LUH2",dim = 3.1)
#filter
a[crop_hr_rf_shr<crop_threshold] <- NA
#divide by croparea -> tDM/ha
a <- (a/crop_hr_rf)
write.magpie(a,file.path(outputdir,"LUH2_Yield_DM_rainfed.nc"),comment = "unit: tDM-per-ha")
rm(a)
gc()

### Yields DM irrigated
#read-in production in mio tDM
a <- collapseNames(production(gdx,level="grid",dir = outputdir,products = "kcr",product_aggr = FALSE,water_aggr = FALSE,attributes = "dm")[,,"irrigated"],collapsedim = 3.2)
#Rename and aggregate crop types from MAgPIE to LUH2
a <- madrat::toolAggregate(a, map_crops, from="MAgPIE", to="LUH2",dim = 3.1)
#filter
a[crop_hr_ir_shr<crop_threshold] <- NA
#divide by croparea -> tDM/ha
a <- (a/crop_hr_ir)
write.magpie(a,file.path(outputdir,"LUH2_Yield_DM_irrigated.nc"),comment = "unit: tDM-per-ha")
rm(a)
gc()

### Yields Nr
#read-in production in mio tN
a <- collapseNames(production(gdx,level="grid",dir = outputdir,products = "kcr",product_aggr = FALSE,water_aggr = TRUE,attributes = "nr"),collapsedim = 3.2)
#Rename and aggregate crop types from MAgPIE to LUH2
a <- madrat::toolAggregate(a, map_crops, from="MAgPIE", to="LUH2",dim = 3.1)
#filter
a[crop_hr_shr<crop_threshold] <- NA
#divide by croparea -> tN/ha; convert from tN/ha to kgN/ha: tN/ha*1000kg/t = 1000 kgN/ha
a <- (a/crop_hr)*1000
write.magpie(a,file.path(outputdir,"LUH2_Yield_Nr.nc"),comment = "unit: kgN-per-ha")
rm(a)
gc()
