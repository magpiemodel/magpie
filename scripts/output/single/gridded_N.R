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

library(lucode)
library(luscale)
library(magpie)
library(ludata)

############################# BASIC CONFIGURATION #######################################
if(!exists("source_include")) {
  sum_spam_file    <- "0.5-to-h600_sum.spam"
  outputdir       <- "output/h600/REF-noCC/"
  title       <- "REF-noCC"

  ###Define arguments that can be read from command line
  readArgs("sum_spam_file","outputdir","title")
}
#########################################################################################
if(!file.exists(path(outputdir,"cell.land_0.5.mz"))) stop(paste("cell.land_0.5.mz does not exist. Run interpolation script first."))

gdx<-path(outputdir,"fulldata.gdx")
cfg<-path(outputdir,"config.Rdata")

#t_lim <- c(2005,2100)
years <- getYears(modelstat(gdx),as.integer = TRUE)
if (exists("t_lim")) years <- years[c(head(which(years>=t_lim[1]),n=1):tail(which(years<=t_lim[2]),n=1))]

sourceDir <- function(path, trace = TRUE, ...) {
  for (nm in list.files(path, pattern = "\\.[RrSsQq]$")) {
    if(trace) cat(nm,":")           
    source(file.path(path, nm), ...)
    if(trace) cat("\n")
  }
}

sourceDir("/p/projects/landuse/users/florianh/magpie/libraries/nitrogen/R")

cell_area_mag <- setYears(dimSums(read.magpie(path(outputdir,"cell.land_0.5.mz"))[,1,],dim=3.1),NULL)
cropland_mag <- collapseNames(read.magpie(path(outputdir,"cell.land_0.5.mz"))[,years,"crop"])

#### N fertlizer ####
N_use <- nr_fertilizer_gridded(gdx)[,years,]
print("N fertlizer")
print(dimSums(N_use,dim=1))

### gridcell area
#use cropland_mag (0.5 degree) for disaggreagation of N_use (600 clusters)
#divide N_use (0.5 degree) by total grid cell area to obain kg-per-ha-of-gridcell-area values
N_use_ha_hr <- NULL
for (y in years) {
  spam <- create_spam(cropland_mag[,y,],read.spam(path(outputdir,sum_spam_file)))
  tmp <- speed_aggregate(N_use[,y,],spam)/cell_area_mag*1000 #N_use in mio tN, cropland in mio ha -> tN/ha ~ 1000 kgN/ha
  tmp[is.na(tmp)|is.infinite(tmp)] <- 0
  getNames(tmp) <- "organic and inorganic N fertilizer (kg-per-ha-of-gridcell-area)"
  N_use_ha_hr <- mbind2(N_use_ha_hr,tmp)
} 

#tN = 10^6 gN, ha = 10^4 m^2 -> tN/ha * 100 = gN/m^2
#kg/ha * 0.1 = gN/m^2

write.magpie(N_use_ha_hr,file_name = path(outputdir,paste0(title,"_N_fert_gridcell.mz")))
write.magpie(N_use_ha_hr,file_name = path(outputdir,paste0(title,"_N_fert_gridcell.nc")))

### cropland area
#use cropland_mag (0.5 degree) for disaggreagation of N_use (600 clusters)
#divide N_use (0.5 degree) by total grid cell area to obain kg-per-ha-of-gridcell-area values
N_use_ha_hr <- NULL
for (y in years) {
  spam <- create_spam(cropland_mag[,y,],read.spam(path(outputdir,sum_spam_file)))
  tmp <- speed_aggregate(N_use[,y,],spam)/cropland_mag[,y,]*1000 #N_use in mio tN, cropland in mio ha -> tN/ha ~ 1000 kgN/ha
  tmp[is.na(tmp)|is.infinite(tmp)] <- 0
  getNames(tmp) <- "organic and inorganic N fertilizer (kg-per-ha-of-cropland-area)"
  N_use_ha_hr <- mbind2(N_use_ha_hr,tmp)
} 

#tN = 10^6 gN, ha = 10^4 m^2 -> tN/ha * 100 = gN/m^2
#kg/ha * 0.1 = gN/m^2

write.magpie(N_use_ha_hr,file_name = path(outputdir,paste0(title,"_N_fert_cropland.mz")))
write.magpie(N_use_ha_hr,file_name = path(outputdir,paste0(title,"_N_fert_cropland.nc")))

#### N losses ####
N_losses <- nr_losses_gridded(gdx)[,years,]
print("N losses")
print(dimSums(N_losses,dim=1))

### gridcell area
#use cropland_mag (0.5 degree) for disaggreagation of N_losses (600 clusters)
#divide N_losses (0.5 degree) by total grid cell area to obain kg-per-ha-of-gridcell-area values
N_losses_ha_hr <- NULL
for (y in years) {
  spam <- create_spam(cropland_mag[,y,],read.spam(path(outputdir,sum_spam_file)))
  tmp <- speed_aggregate(N_losses[,y,],spam)/cell_area_mag*1000 #N_losses in mio tN, cropland in mio ha -> tN/ha ~ 1000 kgN/ha
  tmp[is.na(tmp)|is.infinite(tmp)] <- 0
  getNames(tmp) <- "organic and inorganic N fertilizer (kg-per-ha-of-gridcell-area)"
  N_losses_ha_hr <- mbind2(N_losses_ha_hr,tmp)
} 

#tN = 10^6 gN, ha = 10^4 m^2 -> tN/ha * 100 = gN/m^2
#kg/ha * 0.1 = gN/m^2

write.magpie(N_losses_ha_hr,file_name = path(outputdir,paste0(title,"_N_losses_gridcell.mz")))
write.magpie(N_losses_ha_hr,file_name = path(outputdir,paste0(title,"_N_losses_gridcell.nc")))

### cropland area
#use cropland_mag (0.5 degree) for disaggreagation of N_losses (600 clusters)
#divide N_losses (0.5 degree) by total grid cell area to obain kg-per-ha-of-gridcell-area values
N_losses_ha_hr <- NULL
for (y in years) {
  spam <- create_spam(cropland_mag[,y,],read.spam(path(outputdir,sum_spam_file)))
  tmp <- speed_aggregate(N_losses[,y,],spam)/cropland_mag[,y,]*1000 #N_losses in mio tN, cropland in mio ha -> tN/ha ~ 1000 kgN/ha
  tmp[is.na(tmp)|is.infinite(tmp)] <- 0
  getNames(tmp) <- "organic and inorganic N fertilizer (kg-per-ha-of-cropland-area)"
  N_losses_ha_hr <- mbind2(N_losses_ha_hr,tmp)
} 

#tN = 10^6 gN, ha = 10^4 m^2 -> tN/ha * 100 = gN/m^2
#kg/ha * 0.1 = gN/m^2

write.magpie(N_losses_ha_hr,file_name = path(outputdir,paste0(title,"_N_losses_cropland.mz")))
write.magpie(N_losses_ha_hr,file_name = path(outputdir,paste0(title,"_N_losses_cropland.nc")))
