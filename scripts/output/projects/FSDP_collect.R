# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Collect reg, iso and grid level data from multiple FSDP runs
# comparison script: TRUE
# ---------------------------------------------------------------

# Version 1.0, Florian Humpenoeder
#
library(lucode2)
library(magclass)
library(gms)
library(magpiesets)
library(data.table)
library(gdx)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- file.path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  lucode2::readArgs("outputdir")
}
###############################################################################
cat("\nStarting output generation\n")

reg <- NULL
iso <- NULL
grid <- NULL
missing <- NULL

saveRDS(outputdir,"outputdir.rds")
#get revision
x <- unlist(lapply(strsplit(basename(outputdir),"_"),function(x) x[1]))
if (length(unique(x)) == 1) rev <- unique(x) else stop("version prefix is not identical. Check your selection of runs")

#filter out calibration run
x <- unlist(lapply(strsplit(basename(outputdir),"_"),function(x) x[2]))
outputdir <- outputdir[which(x=="FSEC")]

for (i in 1:length(outputdir)) {
  print(paste("Processing",outputdir[i]))
  cfg <- gms::loadConfig(file.path(outputdir[i], "config.yml"))

  ### regional level outputs
  rep<-file.path(outputdir[i],"report.rds")
  if(file.exists(rep)) {
    reg <- rbind(reg,as.data.table(readRDS(rep)))
  } else missing <- c(missing,outputdir[i])

  ### ISO level outputs
  rep<-file.path(outputdir[i],"report_iso.rds")
  if(file.exists(rep)) {
    iso <- rbind(iso,as.data.table(readRDS(rep)))
  } else missing <- c(missing,outputdir[i])

  ### Grid level outputs
  ## only for BAU and SDP to save time and storage
  scen <- c("BAU","SDP")
  if(unlist(strsplit(cfg$title,"_"))[3] %in% scen) {
    y <- NULL
    years <- c(2020,2050)

    ## BII
    nc_file <- file.path(outputdir[i], "cell.bii_0.5.nc")
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      getNames(a) <- "BII (index)"
      getSets(a,fulldim = F)[3] <- "variable"
      a <- addLocation(a)
      y <- mbind(y,a)
    } else missing <- c(missing,outputdir[i])

    ## land patterns Mha
    nc_file <- file.path(outputdir[i], "cell.land_0.5.nc")
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      getNames(a) <- paste0(getNames(a)," (Mha)")
      getSets(a,fulldim = F)[3] <- "variable"
      a <- addLocation(a)
      y <- mbind(y,a)
    } else missing <- c(missing,outputdir[i])

    ## land patterns share
    nc_file <- file.path(outputdir[i], "cell.land_0.5_share.nc")
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      getNames(a) <- paste0(getNames(a)," (area share)")
      getSets(a,fulldim = F)[3] <- "variable"
      a <- addLocation(a)
      y <- mbind(y,a)
    } else missing <- c(missing,outputdir[i])

    ## Nitrogen
    nc_file <- file.path(outputdir[i], paste(cfg$title,"nutrientSurplus_anthropogenic_unaggregated.nc",sep="-"))
    if(file.exists(nc_file)) {
      a <- read.magpie(nc_file)[,years,]
      getNames(a) <- "nutrientSurplus (kg N per ha)"
      getSets(a,fulldim = F)[3] <- "variable"
      a <- addLocation(a)
      y <- mbind(y,a)
    } else missing <- c(missing,outputdir[i])

    #add dimensions
    y <- add_dimension(y, dim = 3.1, add = "scenario", nm = gsub(".", "_", cfg$title, fixed = TRUE))
    y <- add_dimension(y, dim = 3.1, add = "model", nm = "MAgPIE")
    getSets(y,fulldim = F)[2] <- "period"

    #save as data.frame with xy coordinates
    y <- as.data.table(as.data.frame(y,rev=3))

    #bind together
    grid <- rbind(grid,y)

  }
}

if (!is.null(missing)) {
  cat("\nList of folders with missing report files\n")
  print(missing)
}

message("Saving rds files ...")

saveRDS(reg,file = file.path("output",paste(rev,"FSDP_reg.rds",sep="_")), version = 2,compress = "xz")
saveRDS(iso,file = file.path("output",paste(rev,"FSDP_iso.rds",sep="_")), version = 2,compress = "xz")
saveRDS(grid,file = file.path("output",paste(rev,"FSDP_grid.rds",sep="_")), version = 2,compress = "xz")

#save i_to_iso mapping
gdx <- file.path(outputdir[1], "fulldata.gdx")
reg2iso <- readGDX(gdx,"i_to_iso")
names(reg2iso) <- c("region","iso_a3")
write.csv(reg2iso,"output/reg2iso.csv")

message("Plotting figures ...")
library(m4fsdp)
heatmapFSDP(reg,file=file.path("output",paste(rev,"FSDP_heatmap.jpg",sep="_")))
spatialMapsFSDP(reg,iso,grid,reg2iso,file = file.path("output",paste(rev,"FSDP_spatialMaps.jpg",sep="_")))

