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

options(error=function()traceback(2))

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

for (i in 1:length(outputdir)) {
  print(paste("Processing",outputdir[i]))
  cfg <- gms::loadConfig(file.path(outputdir[i], "config.yml"))
  title <- cfg$title

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
  y <- NULL
  years <- c(2020,2050)

  ## BII
  nc_file <- file.path(outputdir[i], "cell.bii_0.5.mz")
  if(file.exists(nc_file)) {
    a <- read.magpie(nc_file)[,years,]
    a <- add_dimension(a, dim = 3.1, add = "variable", nm = "BII (index)")
    y <- mbind(y,a)
  } else missing <- c(missing,outputdir[i])

  ## land patterns Mha
  nc_file <- file.path(outputdir[i], "cell.land_0.5.mz")
  if(file.exists(nc_file)) {
    a <- read.magpie(nc_file)[,years,]
    getNames(a) <- paste0(getNames(a)," (Mha)")
    getSets(a,fulldim = F)[3] <- "variable"
    y <- mbind(y,a)
  } else missing <- c(missing,outputdir[i])

  ## land patterns share
  nc_file <- file.path(outputdir[i], "cell.land_0.5_share.mz")
  if(file.exists(nc_file)) {
    a <- read.magpie(nc_file)[,years,]
    getNames(a) <- paste0(getNames(a)," (area share)")
    getSets(a,fulldim = F)[3] <- "variable"
    y <- mbind(y,a)
  } else missing <- c(missing,outputdir[i])

  #add dimensions
  y <- add_dimension(y, dim = 3.1, add = "scenario", nm = gsub(".", "_", title, fixed = TRUE))
  y <- add_dimension(y, dim = 3.1, add = "model", nm = "MAgPIE")
  getSets(y,fulldim = F)[2] <- "period"

  #bind together
  grid <- mbind(grid,y)

}

if (!is.null(missing)) {
  cat("\nList of folders with missing report files\n")
  print(missing)
}

saveRDS(reg,file = "output/FSDP_reg.rds", version = 2,compress = "xz")
saveRDS(iso,file = "output/FSDP_iso.rds", version = 2,compress = "xz")

#add coordinates
grid <- addLocation(grid)

message("Processing and saving...")

#save as data.frame with xy coordinates
grid <- as.data.table(as.data.frame(grid,rev=3))
saveRDS(grid,file = "output/FSDP_grid.rds", version = 2,compress = "xz")
