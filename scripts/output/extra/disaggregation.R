# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Interpolates land pools to 0.5 degree resolution
# comparison script: FALSE
# ---------------------------------------------------------------

library(lucode2)
library(magpie4)
library(luscale)
library(madrat)

############################# BASIC CONFIGURATION ##############################
if(!exists("source_include")) {
  outputdir <- "output/SSP2_Ref_c200"
  readArgs("outputdir")
}
map_file                   <- Sys.glob(path(outputdir, "clustermap_*.rds"))
gdx                        <- path(outputdir,"fulldata.gdx")
land_hr_file               <- path(outputdir,"avl_land_t_0.5.mz")
land_hr_out_file           <- path(outputdir,"cell.land_0.5.mz")
land_hr_share_out_file     <- path(outputdir,"cell.land_0.5_share.mz")
croparea_hr_share_out_file <- path(outputdir,"cell.croparea_0.5_share.mz")
land_hr_split_file         <- path(outputdir,"cell.land_split_0.5.mz")
land_hr_shr_split_file     <- path(outputdir,"cell.land_split_0.5_share.mz")
################################################################################

if(length(map_file)==0) stop("Could not find map file!")
if(length(map_file)>1) {
  warning("More than one map file found. First occurrence will be used!")
  map_file <- map_file[1]
}

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
message("Disaggregation")
land_hr <- luscale::interpolate2(x     = land_lr,
                                 x_ini = land_ini,
                                 map   = map_file)


# Write outputs

.dissagcrop <- function(gdx, land_hr, map) {
  message("Disaggregation crop types")
  area     <- croparea(gdx, level="cell", products="kcr",
                       product_aggr=FALSE,water_aggr = FALSE)
  area_shr <- area/(dimSums(area,dim=3) + 10^-10)

  # calculate share of crop land on total cell area
  crop_shr <- land_hr/dimSums(land_hr, dim=3)
  crop_shr <- setNames(crop_shr[,getYears(area_shr),"crop"],NULL)
  # calculate crop area as share of total cell area
  area_shr_hr <- madrat::toolAggregate(area_shr, map, to="cell") * crop_shr
  return(area_shr_hr)
}

.tmpwrite <- function(x,file,comment,message) {
  write.magpie(x, file, comment=comment)
  write.magpie(x, sub(".mz",".nc",file), comment=comment, verbose=FALSE)
}

.tmpwrite(land_hr, land_hr_out_file, comment="unit: Mha per grid-cell",
          message="Write outputs cell.land")
.tmpwrite(land_hr/dimSums(land_hr,dim=3.1), land_hr_share_out_file,
          comment="unit: grid-cell land area fraction",
          message="Write outputs cell.land_share")

area_shr_hr <- .dissagcrop(gdx, land_hr, map=map_file)

.tmpwrite(area_shr_hr, croparea_hr_share_out_file,
          comment="unit: grid-cell land area fraction",
          message="Write outputs cell.cropara_share")


.cropsplit <- function(area_shr_hr, land_hr, land_hr_split_file,
                       land_hr_shr_split_file) {
  land_hr <- land_hr[,getYears(area_shr_hr),]
  area_hr <- area_shr_hr*dimSums(land_hr, dim=3)

  # replace crop in land_hr in with crop_kfo_rf, crop_kfo_ir, crop_kbe_rf
  # and crop_kbe_ir
  kbe <- c("betr","begr")
  kfo <- setdiff(getNames(area_hr,dim=1),kbe)
  crop_kfo_rf <- setNames(dimSums(area_hr[,,kfo][,,"rainfed"],dim=3),
                          "crop_kfo_rf")
  crop_kfo_ir <- setNames(dimSums(area_hr[,,kfo][,,"irrigated"],dim=3),
                          "crop_kfo_ir")
  crop_kbe_rf <- setNames(dimSums(area_hr[,,kbe][,,"rainfed"],dim=3),
                          "crop_kbe_rf")
  crop_kbe_ir <- setNames(dimSums(area_hr[,,kbe][,,"irrigated"],dim=3),
                          "crop_kbe_ir")
  crop_hr <- mbind(crop_kfo_rf,crop_kfo_ir,crop_kbe_rf,crop_kbe_ir)
  #drop crop
  land_hr <- land_hr[,,"crop",invert=TRUE]
  #combine land_hr with crop_hr.
  land_hr <- mbind(crop_hr,land_hr)
  #write landpool
  .tmpwrite(land_hr, land_hr_split_file,
            comment="unit: Mha per grid-cell",
            message="Write cropsplit land area")

  .tmpwrite(land_hr/dimSums(land_hr,dim=3), land_hr_shr_split_file,
            comment="unit: grid-cell land area fraction",
            message="Write cropsplit land area share")
}

.cropsplit(area_shr_hr, land_hr, land_hr_split_file,land_hr_shr_split_file)
