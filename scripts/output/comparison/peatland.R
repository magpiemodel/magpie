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

x <- list()
x$emis_co2_clim_annual <- NULL
x$emis_all_glo_annual <- NULL
x$emis_p_glo <- NULL
x$area_pman_clim_detail <- NULL
x$area_p_clim <- NULL
x$area_p_clim_detail <- NULL
x$area_p_cell <- NULL
x$area_p_map <- NULL
x$area_p_map_ratio <- NULL
x$land_clim <- NULL
x$fprice_index <- NULL
x$fprices <- NULL
x$income <- NULL
x$fexpshare <- NULL
x$kcal <- NULL
x$tau <- NULL
x$demand_food <- NULL
x$demand_bioen <- NULL
x$c_price <- NULL
x$cost <- NULL
x$cost_wo_peatlandemis <- NULL
x$cost_wo_peatlandreward <- NULL

missing <- NULL

calcEmisCum <- function(a) {
  im_years <- getYears(a,as.integer = T)
  im_years <- c(0,diff(im_years))
  im_years <- as.magpie(im_years,temporal=1)
  getYears(im_years) <- getYears(a)
  a[,im_years[1],] <- 0
  a <- a*im_years[,getYears(a),]
  a <- as.magpie(apply(a,c(1,3),cumsum),spatial=2,temporal=1)
  return(a)
}


for (i in 1:length(outputdirs)) {
  print(paste("Processing",outputdirs[i]))
  #gdx file
  gdx<-path(outputdirs[i],"fulldata.gdx")
  if(file.exists(gdx)) {
    #get scenario name
    load(path(outputdirs[i],"config.Rdata"))
    scen <- cfg$title
    
    map_cell_clim <- readGDX(gdx,"p58_mapping_cell_climate")
    
    #area_pman_clim_detail
    a <- readGDX(gdx,"ov58_peatland_man",select=list(type="level"))
    a <- add_dimension(a,dim = 3.1,add = "scenario",nm = scen)
    a <- dimSums(a*map_cell_clim,dim=1)
    x$area_pman_clim_detail <- mbind(x$area_pman_clim_detail,a)

    #area_p_cell
    a <- readGDX(gdx,"ov58_peatland_man",select=list(type="level"))
    a <- dimSums(a,dim=c(3.2))
    a[,,"degrad"] <- a[,,"degrad"] + collapseNames(a[,,"unused"])
    a <- a[,,"unused",invert=TRUE]
    # miss <- readGDX(gdx,"ov58_peatland_missing",select=list(type="level"))
    # a[,,"degrad"] <- a[,,"degrad"]+miss
    b <- readGDX(gdx,"ov58_peatland_intact",select=list(type="level"))
    getNames(b) <- "intact"
    a <- mbind(a,b)
    
    # #interpolate
    # p <- a[,getYears(a,as.integer = T)>=2015,]
    # p_ini_lr <- setYears(p[,1,],NULL)
    # p_ini_hr <- read.magpie("/p/projects/landuse/users/florianh/data/PeatArea_0.5.mz")
    # peat_hr <- interpolate(p,p_ini_lr,p_ini_hr,spam = path(outputdirs[i],"0.5-to-c200_sum.spam"))
    # peat_hr <- add_dimension(peat_hr,dim = 3.1,add = "scenario",nm = scen)
    # x$area_p_map <- mbind(x$area_p_map,peat_hr)
    # 
    # peat_hr_ratio <- collapseNames(peat_hr[,,"degrad"])/dimSums(peat_hr,dim=3.2)
    # x$area_p_map_ratio <- mbind(x$area_p_map_ratio,peat_hr_ratio)
    # 
    
    a <- add_dimension(a,dim = 3.1,add = "scenario",nm = scen)
    x$area_p_cell <- mbind(x$area_p_cell,a)
    
    
    #area_p_clim
    a <- dimSums(a*map_cell_clim,dim=1)
    x$area_p_clim <- mbind(x$area_p_clim,a)
    
    #read land
    a <- land(gdx,level="cell")
    bio <- setNames(croparea(gdx,level="cell",products = c("betr","begr"),product_aggr = TRUE),"bio")
    a <- mbind(bio,a)
    a[,,"crop"] <- a[,,"crop"]-setNames(a[,,"bio"],"crop")
    a <- dimSums(a*map_cell_clim,dim=1)
    a <- add_dimension(a,dim = 3.1,add = "scenario",nm = scen)
    x$land_clim <- mbind(x$land_clim,a)

    #read peatland land detail
    a <- readGDX(gdx,"ov58_peatland_man",select=list(type="level"))
    a <- dimSums(a*map_cell_clim,dim=1)
    a <- add_dimension(a,dim = 3.1,add = "scenario",nm = scen)
    x$area_p_clim_detail <- mbind(x$area_p_clim_detail,a)
    
    
    #emis_p_glo
    emis_p_glo <- readGDX(gdx,"ov58_peatland_emis",select=list(type="level"))
    emis_p_glo <- dimSums(emis_p_glo*map_cell_clim,dim=1)
    emis_p_glo <- add_dimension(emis_p_glo,dim = 3.1,add = "scenario",nm = scen)
    x$emis_p_glo <- mbind(x$emis_p_glo,emis_p_glo)

    emis_p_glo[,,"ch4"] <- emis_p_glo[,,"ch4"]/28
    emis_p_glo[,,"n2o"] <- emis_p_glo[,,"n2o"]/265
    
    #emis_lu_glo
    co2 <- setNames(emisCO2(gdx,level = "glo",unit="gas",cc = TRUE),"co2")
    doc <- setNames(co2,"doc")
    doc[,,] <- NA
    ch4 <- setNames(Emissions(gdx,level="glo",type="ch4",unit="gas"),"ch4")
    n2o <- setNames(Emissions(gdx,level="glo",type="n2o_n",unit="gas"),"n2o")
    emis_lu_glo <- mbind(co2,doc,ch4,n2o)
    emis_lu_glo <- add_dimension(emis_lu_glo,dim = 3.1,add = "scenario",nm = scen)

    lu <- add_dimension(emis_lu_glo,dim = 3.2,add = "GHG emission","Land-use change & Agriculture")
    peat <- add_dimension(dimSums(emis_p_glo,dim=c(3.2)),dim = 3.2,add = "GHG emission","Peatland")
    a <- mbind(lu,peat)
    x$emis_all_glo_annual <- mbind(x$emis_all_glo_annual,a)
    
    #emis_p_cell_co2
    emis_p_clim <- readGDX(gdx,"ov58_peatland_emis",select=list(type="level"))
    emis_p_clim <- dimSums(emis_p_clim[,,c("co2","doc")]*map_cell_clim,dim=c(1,3.1))
    emis_p_clim <- add_dimension(emis_p_clim,dim = 3.1,add = "scenario",nm = scen)
    
    #emis_co2_clim_annual
    emis_lu_clim <- emisCO2(gdx,level = "cell",unit="gas",cc = TRUE)
    emis_lu_clim <- dimSums(emis_lu_clim*map_cell_clim,dim=1)
    emis_lu_clim <- add_dimension(emis_lu_clim,dim = 3.1,add = "scenario",nm = scen)
#    names(dimnames(emis_lu_clim)) <- names(dimnames(emis_p_clim))
    
    lu <- add_dimension(emis_lu_clim,dim = 3.2,add = "GHG emission","Land-use change")
    peat <- add_dimension(emis_p_clim,dim = 3.2,add = "GHG emission","Peatland")
    a <- mbind(lu,peat)
    x$emis_co2_clim_annual <- mbind(x$emis_co2_clim_annual,a)
    
    #read fprice_index
    a <- priceIndex(gdx,level="regglo", products="kfo", baseyear = "y2015")
    a <- collapseNames(add_dimension(a,dim = 3.1,add = "scenario",nm = scen),collapsedim = "data")
    x$fprice_index <- mbind(x$fprice_index,a)

    #read fprice
    a <- collapseNames(prices(gdx,level="regglo", products="kfo",product_aggr = TRUE))
    a <- collapseNames(add_dimension(a,dim = 3.1,add = "scenario",nm = scen),collapsedim = "data")
    x$fprices <- mbind(x$fprices,a)
    
    #read income
    a <- collapseNames(income(gdx,level="reg",per_capita = FALSE,type = "mer"))
    a <- collapseNames(add_dimension(a,dim = 3.1,add = "scenario",nm = scen),collapsedim = "data")
    x$income <- mbind(x$income,a)
    
    #read food exp share
    a <- collapseNames(FoodExpenditureShare(gdx, level = "regglo"))
    a <- collapseNames(add_dimension(a,dim = 3.1,add = "scenario",nm = scen),collapsedim = "data")
    x$fexpshare <- mbind(x$fexpshare,a)
    
    #read kcal
    a <- collapseNames(Kcal(gdx, level = "glo"))
    a <- collapseNames(add_dimension(a,dim = 3.1,add = "scenario",nm = scen),collapsedim = "data")
    x$kcal <- mbind(x$kcal,a)
    
    #read tau
    a <- collapseNames(tau(gdx,level="glo"))
    a <- collapseNames(add_dimension(a,dim = 3.1,add = "scenario",nm = scen),collapsedim = "type")
    x$tau <- mbind(x$tau,a)
    
    #demand food, feed, processed
    kcr <- add_dimension(demand(gdx,level = "reg",product_aggr = TRUE,type = c("food","feed","processed"),products = "kcr"),3.1,"cat","Crops")
    kli <- add_dimension(demand(gdx,level = "reg",product_aggr = TRUE,type = c("food","feed","processed"),products = "kli"),3.1,"cat","Livestock")
    a <- mbind(kcr,kli)
    a <- add_dimension(a,dim = 3.1,add = "scenario",nm = scen)
    x$demand_food <- mbind(x$demand_food,a)
    
    #demand bioen
    a <- demandBioenergy(gdx,level="reg")
    a <- add_dimension(a,dim = 3.1,add = "scenario",nm = scen)
    x$demand_bioen <- mbind(x$demand_bioen,a)
    
    #ghg price
    a <- PriceGHG(gdx,level="glo")
    a <- add_dimension(a,dim = 3.1,add = "scenario",nm = scen)
    x$c_price <- mbind(x$c_price,a)
    
    #cost reg
    a <- collapseNames(readGDX(gdx,"ov11_cost_reg",select = list(type="level")))
    a <- collapseNames(add_dimension(a,dim = 3.1,add = "scenario",nm = scen),collapsedim = "data")
    x$cost <- mbind(x$cost,a)
    
    #cost reg without peatland GHG emis costs
    a <- collapseNames(readGDX(gdx,"ov11_cost_reg",select = list(type="level")))
    b <- collapseNames(superAggregate(readGDX(gdx,"ov_peatland_emis_cost",select = list(type="level")),level="reg",aggr_type = "sum"))
    a <- a-b
    a <- collapseNames(add_dimension(a,dim = 3.1,add = "scenario",nm = scen),collapsedim = "data")
    x$cost_wo_peatlandemis <- mbind(x$cost_wo_peatlandemis,a)
    
  } else missing <- c(missing,outputdirs[i])
}

#remove 1995
x <- lapply(x, function(x) {x[,getYears(x,as.integer = T)>=2015,]})

#read emis factors (same for all scenarios)
x$emis_fac <- readGDX(gdx,"f58_ipcc_wetland_ef")
x$map_cell_clim <- readGDX(gdx,"p58_mapping_cell_climate")
x$map_clim <- readGDX(gdx,"clcl_mapping")

x$emis_co2_clim_cum <- calcEmisCum(x$emis_co2_clim_annual)

x$area_p_clim_change <- x$area_p_clim-setYears(x$area_p_clim[,1,],NULL)

# write.magpie(x$area_p_map_ratio,"output/map_degrad_ratio.nc",comment = "unit: Degradation Ratio")
# 
# x$area_p_map_ratio_change <- x$area_p_map_ratio-setYears(x$area_p_map_ratio[,1,],NULL)
# write.magpie(x$area_p_map_ratio_change,"output/map_degrad_ratio_change.nc",comment = "unit: Change of Degradation Ratio")

x$land_clim_change <- x$land_clim-setYears(x$land_clim[,1,],NULL)

files <- list.files(path="output", pattern="*.RData")
nums <- as.numeric(gsub(paste("peatland_", ".RData", sep="|"), "", files))
if(length(nums)==0) last=0 else last <- max(nums)
newFile <- paste0("output/peatland_", sprintf("%02d", last + 1), ".RData")
save(x,file = newFile,compress = "xz")
saveRDS(x,file = sub(".RData",".rds",newFile),compress = "xz")

if (!is.null(missing)) {
  cat("\nList of folders with missing fulldata.gdx\n")
  print(missing)
}
