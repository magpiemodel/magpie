# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de

#########################
#### check modelstat ####
#########################
# Version 1.0, Florian Humpenoeder
#
library(lucode)
library(magpie4)
library(luscale)

options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdirs <- path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  readArgs("outputdirs")
}
###############################################################################
cat("\nStarting output generation\n")

all <- NULL

x <- list()
x$LandCover <- NULL
x$PeatlandArea <- NULL
x$EmissionCO2 <- NULL
x$PeatlandEmission <- NULL
x$fprice_index <- NULL
x$income <- NULL
x$kcal <- NULL
x$tau <- NULL
x$demand_bioen <- NULL
x$c_price <- NULL
x$cost <- NULL

missing <- NULL

for (i in 1:length(outputdirs)) {
  print(paste("Processing",outputdirs[i]))
  gdx<-path(outputdirs[i],"fulldata.gdx")
  rep<-path(outputdirs[i],"report.rds")
  if(file.exists(gdx)) {
    load(path(outputdirs[i],"config.Rdata"))
    scen <- cfg$title
    
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
    a <- collapseNames(PeatlandEmissions(gdx,level="climate",unit="gas"))
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
    
    #tau
    a <- collapseNames(tau(gdx,level="glo"))
    a <- collapseNames(add_dimension(a,dim = 3.1,add = "scenario",nm = scen),collapsedim = "type")
    x$tau <- mbind(x$tau,a)
    
    #bioen
    a <- demandBioenergy(gdx,level="reg")
    a <- add_dimension(a,dim = 3.1,add = "scenario",nm = scen)
    x$demand_bioen <- mbind(x$demand_bioen,a)
    
    #ghg price
    a <- PriceGHG(gdx,level="glo")
    a <- add_dimension(a,dim = 3.1,add = "scenario",nm = scen)
    x$c_price <- mbind(x$c_price,a)
    
    #costs
    a <- collapseNames(readGDX(gdx,"ov11_cost_reg",select = list(type="level")))
    b <- collapseNames(superAggregate(readGDX(gdx,"ov_peatland_emis_cost",select = list(type="level")),level="reg",aggr_type = "sum"))
    a <- a-b
    a <- collapseNames(add_dimension(a,dim = 3.1,add = "scenario",nm = scen),collapsedim = "data")
    x$cost <- mbind(x$cost,a)
    
  } else missing <- c(missing,outputdirs[i])
  a <- readRDS(rep)
  all <- rbind(all,a)
}
all <- as.data.table(all)
saveRDS(all,"output/report.rds")

map_clim <- readGDX(gdx,"clcl_mapping")
saveRDS(map_clim,"output/map_clim.rds")

#remove 1995
x <- lapply(x, function(x) {x[,getYears(x,as.integer = T)>=2015,]})

x$LandCoverChange <- x$LandCover-setYears(x$LandCover[,1,],NULL)
x$PeatlandAreaChange <- x$PeatlandArea-setYears(x$PeatlandArea[,1,],NULL)

files <- list.files(path="output", pattern="*.RData")
nums <- as.numeric(gsub(paste("peatland_", ".RData", sep="|"), "", files))
if(length(nums)==0 | is.na(nums)) last=0 else last <- max(nums)
newFile <- paste0("output/peatland_", sprintf("%02d", last + 1), ".RData")
save(x,file = newFile,compress = "xz")
#saveRDS(x,file = sub(".RData",".rds",newFile),compress = "xz")

if (!is.null(missing)) {
  cat("\nList of folders with missing fulldata.gdx\n")
  print(missing)
}
