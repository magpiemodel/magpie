# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Output script for peatland paper (might be useful as template for other papers)
# comparison script: TRUE
# ---------------------------------------------------------------

#########################
#### check modelstat ####
#########################
# Version 1.0, Florian Humpenoeder
#
library(lucode2)
library(magpie4)
library(luscale)
library(gdx2)
library(luplot)
library(ggplot2)
library(luscale)
library(data.table)
library(ggrepel)
library(patchwork)
library(quitte)
library(gms)

options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- file.path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  readArgs("outputdir")
}
###############################################################################
cat("\nStarting output generation\n")

vars <- c("Population","Income","Demand|+|Food","Demand|Food|+|Crops","Demand|Food|+|Livestock products","Trade|Net-Trade|+|Crops","Productivity|Yield|Crops|+|Cereals")

all <- NULL

x <- list()
x$LandCover <- NULL
x$PeatlandArea <- NULL
x$PeatlandAreaReg <- NULL
x$EmissionCO2 <- NULL
x$PeatlandEmission <- NULL
x$fprice_index <- NULL
x$income <- NULL
x$kcal <- NULL
x$demand_bioen <- NULL
x$c_price <- NULL
x$cost <- NULL

missing <- NULL

for (i in 1:length(outputdir)) {
  print(paste("Processing",outputdir[i]))
  gdx<-file.path(outputdir[i],"fulldata.gdx")
  rep<-file.path(outputdir[i],"report.rds")
  if(file.exists(gdx)) {
    cfg <- gms::loadConfig(file.path(outputdir[i], "config.yml"))
    scen <- cfg$title
    prefix <- substring(scen, 1, 4)

    map_cell_clim <- readGDX(gdx,"p58_mapping_cell_climate")

    #LandCover
    a <- land(gdx,level="glo")
    forest <- setNames(dimSums(a[,,c("forestry","primforest","secdforest")],dim=3),"forest")
    bio <- setNames(croparea(gdx,level="glo",products = c("betr","begr"),product_aggr = TRUE),"bio")
    a <- mbind(a,bio,forest)
    a[,,"crop"] <- a[,,"crop"]-setNames(a[,,"bio"],"crop")
    a <- a[,,c("crop","bio","past","forest","other","urban")]
    a <- add_dimension(a,dim = 3.1,add = "scenario",nm = scen)
    x$LandCover <- mbind(x$LandCover,a)

    #PeatlandArea
    a <- PeatlandArea(gdx,level="climate")
    a <- add_dimension(a,dim = 3.1,add = "scenario",nm = scen)
    x$PeatlandArea <- mbind(x$PeatlandArea,a)

    #PeatlandAreaReg
    a <- PeatlandArea(gdx,level="reg")
    a <- add_dimension(a,dim = 3.1,add = "scenario",nm = scen)
    x$PeatlandAreaReg <- mbind(x$PeatlandAreaReg,a)

    #EmissionCO2
    a <- collapseNames(emisCO2(gdx,level = "cell",unit="gas"))
    a <- dimSums(a*map_cell_clim,dim=1)
    names(dimnames(a))[3] <- names(dimnames(map_cell_clim))[3]
    a <- add_dimension(a,dim = 3.2,add = "GHG emission","Vegetation")
    b <- collapseNames(PeatlandEmissions(gdx,level="climate")[,,"co2"])
    b <- add_dimension(b,dim = 3.2,add = "GHG emission","Peatland")
    a <- mbind(a,b)/1000
    a <- add_dimension(a,dim = 3.1,add = "scenario",nm = scen)
    x$EmissionCO2 <- mbind(x$EmissionCO2,a)

    #PeatlandEmission
    a <- collapseNames(PeatlandEmissions(gdx,level="climate"))
    a <- add_dimension(a,dim = 3.1,add = "scenario",nm = scen)
    x$PeatlandEmission <- mbind(x$PeatlandEmission,a)

    #fprice_index
    a <- priceIndex(gdx,level="regglo", products="kfo", baseyear = "y2015")
    a <- collapseNames(add_dimension(a,dim = 3.1,add = "scenario",nm = scen),collapsedim = "data")
    x$fprice_index <- mbind(x$fprice_index,a)

    #income
    a <- collapseNames(income(gdx,level="reg",per_capita = FALSE,type = "mer"))
    a <- collapseNames(add_dimension(a,dim = 3.1,add = "scenario",nm = scen),collapsedim = "data")
    x$income <- mbind(x$income,a)

    #kcal
    a <- collapseNames(Kcal(gdx, level = "glo"))
    a <- collapseNames(add_dimension(a,dim = 3.1,add = "scenario",nm = scen),collapsedim = "data")
    x$kcal <- mbind(x$kcal,a)

    #bioen
    a <- demandBioenergy(gdx,level="reg")
    a <- add_dimension(a,dim = 3.1,add = "scenario",nm = scen)
    x$demand_bioen <- mbind(x$demand_bioen,a)

    #ghg price
    a <- PriceGHG(gdx,level="glo",aggr="weight")
    a <- add_dimension(a,dim = 3.1,add = "scenario",nm = scen)
    x$c_price <- mbind(x$c_price,a)

    #costs
    a <- collapseNames(readGDX(gdx,"ov11_cost_reg",select = list(type="level")))
    b <- collapseNames(superAggregate(readGDX(gdx,"ov_peatland_emis_cost",select = list(type="level")),level="reg",aggr_type = "sum"))
    a <- a-b
    a <- collapseNames(add_dimension(a,dim = 3.1,add = "scenario",nm = scen),collapsedim = "data")
    x$cost <- mbind(x$cost,a)

  } else missing <- c(missing,outputdir[i])
  a <- as.data.table(readRDS(rep))
  a <- a[variable %in% vars,]
  all <- rbind(all,a)
}
#remove 1995
x <- lapply(x, function(x) {x[,getYears(x,as.integer = T)>=2015,]})

x$LandCoverChange <- x$LandCover-setYears(x$LandCover[,1,],NULL)
x$PeatlandAreaChange <- x$PeatlandArea-setYears(x$PeatlandArea[,1,],NULL)

# files <- list.files(path="output", pattern="^(peatland)_.*(.rds)$")
# nums <- as.numeric(gsub(paste("peatland_", ".rds", sep="|"), "", files))
# if(length(nums)==0) last=0 else last <- max(nums)
# newFile <- paste0("output/peatland_", sprintf("%02d", last + 1), ".rds")

saveRDS(x,file = paste0("output/peatland_",prefix,".rds"),compress = "xz")

saveRDS(all,paste0("output/report_",prefix,".rds"))

if(!file.exists(paste0("output/validation_",prefix,".rds"))) {
  val <- as.data.table(read.quitte("input/validation.mif"))
  val <- val[variable %in% vars,]
  saveRDS(val,paste0("output/validation_",prefix,".rds"))
}

map_clim <- readGDX(gdx,"clcl_mapping")
saveRDS(map_clim,"output/map_clim.rds")



if (!is.null(missing)) {
  cat("\nList of folders with missing fulldata.gdx\n")
  print(missing)
}
