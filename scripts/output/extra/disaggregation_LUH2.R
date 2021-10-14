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

############################# BASIC CONFIGURATION ##############################
if(!exists("source_include")) {
  outputdir <- "output/LAMA65_Sustainability"
  readArgs("outputdir")
}
map_file                   <- Sys.glob(file.path(outputdir, "clustermap_*.rds"))
gdx                        <- file.path(outputdir,"fulldata.gdx")
land_hr_file               <- file.path(outputdir,"avl_land_t_0.5.mz")
land_full_hr_file          <- file.path(outputdir,"avl_land_full_t_0.5.mz")

load(paste0(outputdir, "/config.Rdata"))
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

if (cfg$gms$crop=="endo_apr21"){

  # Load input data
  land_ini_lr  <- readGDX(gdx,"f10_land","f_land", format="first_found")[,"y1995",]
  land_lr      <- land(gdx,sum=FALSE,level="cell")
  land_ini_hr  <- read.magpie(land_hr_file)[,"y1995",]
  land_ini_hr  <- land_ini_hr[,,getNames(land_lr)]
  if(any(land_ini_hr < 0)) {
    warning(paste0("Negative values in inital high resolution dataset detected and set to 0. Check the file ",land_hr_file))
    land_ini_hr[which(land_ini_hr < 0,arr.ind = T)] <- 0
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
                                            set_aside_fader = set_aside_fader)

}else if (cfg$gms$crop=="endo_jun13") {

  # Load input data
  land_lr   <- land(gdx,sum=FALSE,level="cell")
  land_ini  <- setYears(read.magpie(land_hr_file)[,"y1995",],NULL)
  land_ini  <- land_ini[,,getNames(land_lr)]
  if(any(land_ini < 0)) {
    warning(paste0("Negative values in inital high resolution dataset ",
                   "detected and set to 0. Check the file ",land_hr_file))
    land_ini[which(land_ini < 0,arr.ind = T)] <- 0
  }

  # Start interpolation (use interpolate from luscale)
  message("Disaggregation Land use types")
  land_hr <- luscale::interpolate2(x     = land_lr,
                                   x_ini = land_ini,
                                   map   = map_file)
}

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

### Disaggregation crop types
crop_hr_shr <- land_hr_shr[,,"crop"]
.dissagCrop <- function(gdx, crop_hr_shr, map, water_aggr=TRUE,rename=TRUE) {
  message("Disaggregation crop types")
  area     <- croparea(gdx, level="cell", products="kcr",
                       product_aggr=FALSE,water_aggr = water_aggr)
  area_shr <- area/(dimSums(area,dim=3) + 10^-10)

  luh2 <- data.frame(matrix(nrow=19,ncol=2))
  names(luh2) <- c("LUH2","MAgPIE")
  luh2[1,] <- c("c3ann","tece")
  luh2[2,] <- c("c3ann","rice_pro")
  luh2[3,] <- c("c3ann","rapeseed")
  luh2[4,] <- c("c3ann","sunflower")
  luh2[5,] <- c("c3ann","potato")
  luh2[6,] <- c("c3ann","cassav_sp")
  luh2[7,] <- c("c3ann","sugr_beet")
  luh2[8,] <- c("c3ann","others")
  luh2[9,] <- c("c3ann","cottn_pro")
  luh2[10,] <- c("c3ann","foddr")
  luh2[11,] <- c("c4ann","maiz")
  luh2[12,] <- c("c4ann","trce")
  luh2[13,] <- c("c3per","oilpalm")
  luh2[14,] <- c("c3per","betr")
  luh2[15,] <- c("c4per","sugr_cane")
  luh2[16,] <- c("c4per","begr")
  luh2[17,] <- c("c3nfx","soybean")
  luh2[18,] <- c("c3nfx","groundnut")
  luh2[19,] <- c("c3nfx","puls_pro")
  
  if (rename) area_shr <- madrat::toolAggregate(area_shr, luh2, from="MAgPIE", to="LUH2",dim = 3.1)
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

avl_land_full <- setYears(read.magpie(land_full_hr_file)[,1995,],NULL)

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


### Wood: Harvested Biomass Product Split
a <- TimberProductionVolumetric(gdx,level = "cell",sumSource = FALSE,sumProduct = FALSE)
b <- gdxAggregate(gdx,a,weight = land_hr[,,getNames(a,dim=1)],to="grid",absolute = TRUE,dir=outputdir)
d <- dimSums(a,dim=c(1))-dimSums(b,dim=c(1))
if (any(abs(d) > 0.1 & !Inf)) message(paste0("Difference between cluster and grid cell production > 0.1 detected!"))
b <- dimSums(b,dim=3.1)
b <- b/dimSums(b,dim=3)
getNames(b) <- c("rndwd","fulwd")
write.magpie(b,file.path(outputdir,"LUH2_wood_harvest_biomass_split.nc"),comment = "unit: fraction of wood harvest biomass")


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


### Irrigation
irrig_hr_shr <- .dissagCrop(gdx, land_hr_shr[,,"crop"], map=map_file, water_aggr = FALSE)
irrig_hr_shr <- collapseNames(irrig_hr_shr[,,"irrigated"],collapsedim = 3.2)
getNames(irrig_hr_shr) <- paste("irrig",getNames(irrig_hr_shr),sep="_")
d <- dimSums(irrig_hr_shr*dimSums(land_hr,dim=3),dim=c(1,3))-croparea(gdx,level="glo",product_aggr = T,water_aggr = FALSE)[,,"irrigated"]
if (any(abs(d) > 0.1 & !Inf)) message(paste0("Difference between cluster and grid cell production > 0.1 detected!"))
write.magpie(irrig_hr_shr,file.path(outputdir,"LUH2_irrigation.nc"),comment = "unit: fraction of grid-cell area")


### Flood
flooded <- .dissagCrop(gdx, land_hr_shr[,,"crop"], map=map_file, water_aggr = TRUE,rename = FALSE)
flooded <- flooded[,,"rice_pro"]
getNames(flooded) <- "flood"
d <- dimSums(flooded*dimSums(land_hr,dim=3),dim=c(1,3))-croparea(gdx,level="glo",product_aggr = F,water_aggr = T)[,,"rice_pro"]
if (any(abs(d) > 0.1 & !Inf)) message(paste0("Difference between cluster and grid cell production > 0.1 detected!"))
write.magpie(irrig_hr_shr,file.path(outputdir,"LUH2_flood.nc"),comment = "unit: fraction of grid-cell area")


### Bioenergy
bio_hr_shr <- .dissagCrop(gdx, land_hr_shr[,,"crop"], map=map_file, water_aggr = TRUE,rename=FALSE)
bio_hr_shr <- bio_hr_shr[,,c("begr","betr")]
getNames(bio_hr_shr) <- c("crpbf_c4per","crpbf_c3per")
d <- dimSums(bio_hr_shr*dimSums(land_hr,dim=3),dim=c(1,3))-croparea(gdx,level="glo",products = c("begr","betr"),product_aggr = T)
if (any(abs(d) > 0.1 & !Inf)) message(paste0("Difference between cluster and grid cell production > 0.1 detected!"))
write.magpie(bio_hr_shr,file.path(outputdir,"LUH2_bioenergy.nc"),comment = "unit: fraction of grid-cell area")


# ## Nitrogen Fertilizer
# a <- NitrogenBudget(gdx,level="grid",dir = outputdir)
# a[,,"fertilizer"]
# 
