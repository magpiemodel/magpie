# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


library(gdx)
library(magclass)
library(magpie4)
library(lucode)
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {

  gdx    <-'fulldata.gdx'
  output_folder        <- 'output/SSP5_Baseline'
  output_folder        <- 'output/ssp5_sugar_cons__2016-01-28_18.39.43'
  gdx<-path(output_folder,"fulldata.gdx")
  title <- "TEST"

  #Define arguments that can be read from command line
  readArgs("gdx_file","output_folder","title")
} else{
  output_folder<-outputdir
  gdx<-path(outputdir,"fulldata.gdx")
}
print("---")
print(paste0("Starting SCP report for ",title))
###############################################################################

sourceDir <- function(path, trace = TRUE, ...) {
  for (nm in list.files(path, pattern = "\\.[RrSsQq]$")) {
    if(trace) cat(nm,":")
    source(file.path(path, nm), ...)
    if(trace) cat("\n")
  }
}

sourceDir("/p/projects/landuse/users/florianh/magpie/libraries/nitrogen/R")

#function to generate SSP variables based on MIF variables
MIF2SSP <- function(x) {
  new <- NULL

  ### Land cover
  ssp_name <- "Land Cover (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Cropland (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover|Cropland (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Cropland|Energy Crops (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover|Cropland|Energy Crops (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Forest (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover|Forest (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Forest|Forestry (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover|Forest|Managed (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Forest|Natural Forest (million ha)"
  new <- mbind(new,setNames(new[,,"Land Cover|Forest (million ha)"],ssp_name) - setNames(x[,,"Land Cover|Forest|Managed (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Other Natural Land (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover|Other Arable Land (million Ha/yr)"],ssp_name) + setNames(x[,,"Land Cover|Other Land (million Ha/yr)"],ssp_name) - setNames(x[,,"Land Cover|Other Land|Urban (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Pasture (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover|Pasture (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Built-up Area (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover|Other Land|Urban (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Cropland|Irrigated (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover|Cropland|Irrigated (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Cropland|Energy Crops|Irrigated (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover|Cropland|Energy Crops|Irrigated (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Cropland|Cereals (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover|Cropland|Cereals (million Ha/yr)"],ssp_name))

  #Emissions
  ssp_name <- "Emissions|CO2|Land Use (Mt CO2/yr)"
  tmp1<-x[,"y1995","Emissions|CO2|Land Use (Mt CO2/yr)"]
  tmp2<-setNames(lowpass(x[,2:length(getYears(x)),"Emissions|CO2|Land Use (Mt CO2/yr)"],i=1,fix=NULL),ssp_name)
  tmp3<-mbind(tmp1,tmp2)
  new <- mbind(new,tmp3)

  ssp_name <- "Emissions|CH4|Land Use|Agriculture (Mt CH4/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|CH4|Land Use (Mt CH4/yr)"],ssp_name))
  ssp_name <- "Emissions|CH4|Land Use|Agriculture|Rice (Mt CH4/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|CH4|Land Use|Rice (Mt CH4/yr)"],ssp_name))
  ssp_name <- "Emissions|CH4|Land Use|Agriculture|AWM (Mt CH4/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|CH4|Land Use|AWM (Mt CH4/yr)"],ssp_name))
  ssp_name <- "Emissions|CH4|Land Use|Agriculture|Enteric Fermentation (Mt CH4/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|CH4|Land Use|Enteric Fermentation (Mt CH4/yr)"],ssp_name))

  ssp_name <- "Emissions|N2O|Land Use|Agriculture (kt N2O/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|N2O|Land Use (kt N2O/yr)"],ssp_name))
  ssp_name <- "Emissions|N2O|Land Use|Agriculture|AWM (kt N2O/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|N2O|Land Use|AWM (kt N2O/yr)"],ssp_name))
  ssp_name <- "Emissions|N2O|Land Use|Agriculture|Cropland Soils (kt N2O/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|N2O|Land Use|Cropland Soils (kt N2O/yr)"],ssp_name))
  ssp_name <- "Emissions|N2O|Land Use|Agriculture|Pasture (kt N2O/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|N2O|Land Use|Pasture (kt N2O/yr)"],ssp_name))

  #Prices
  new <- mbind(new,x[,,c("Price|Primary Energy|Biomass (US$2005/GJ)","Price|Agriculture|Non-Energy Crops|Index (Index (2005 = 1))","Price|Agriculture|Non-Energy Crops and Livestock|Index (Index (2005 = 1))")])

  #Yields
  ssp_name <- c("Yield|Cereal (t DM/ha/yr)","Yield|Oilcrops (t DM/ha/yr)","Yield|Sugarcrops (t DM/ha/yr)")
  new <- mbind(new,setNames(x[,,c("Yield|Cereal (tDM/ha/yr)","Yield|Oilcrops (tDM/ha/yr)","Yield|Sugarcrops (tDM/ha/yr)")],ssp_name))

  #Water
  new <- mbind(new,x[,,c("Water|Withdrawal|Irrigation (million m3/yr)")])

  #Fertilizer use
  ssp_name <- "Fertilizer Use|Nitrogen (Tg N/yr)"
  new <- mbind(new,setNames(x[,,"Fertilizer Use|Nitrogen (Tg Nr/yr)"],ssp_name))

  #Food Demand (EJ/yr)
  new <- mbind(new,x[,,"Food Energy Demand (EJ/yr)"])
  new <- mbind(new,x[,,"Food Energy Demand|Livestock (EJ/yr)"])

  #Food Demand (kcal/cap/day)
  new <- mbind(new,setNames((x[,,"Food Energy Demand (EJ/yr)"] / setNames(x[,,"Population (million cap)"],NULL)) * 10^9 * 1/4.1868 / 365.25,"Food Demand (kcal/cap/day)"))
  new <- mbind(new,setNames((x[,,"Food Energy Demand|Livestock (EJ/yr)"] / setNames(x[,,"Population (million cap)"],NULL)) * 10^9 * 1/4.1868 / 365.25,"Food Demand|Livestock (kcal/cap/day)"))
  new <- mbind(new,setNames(new[,,"Food Demand (kcal/cap/day)"] - setNames(new[,,"Food Demand|Livestock (kcal/cap/day)"],NULL),"Food Demand|Crops (kcal/cap/day)"))

  #Agricultural Demand
  new <- mbind(new,x[,,c("Agricultural Demand (million t DM/yr)",
                         "Agricultural Demand|Food (million t DM/yr)",
                         "Agricultural Demand|Food|Crops (million t DM/yr)",
                         "Agricultural Demand|Food|Livestock (million t DM/yr)",
                         "Agricultural Demand|Non-Food (million t DM/yr)",
                         "Agricultural Demand|Non-Food|Crops (million t DM/yr)",
                         "Agricultural Demand|Non-Food|Livestock (million t DM/yr)",
                         "Agricultural Demand|Feed (million t DM/yr)",
                         "Agricultural Demand|Feed|Crops (million t DM/yr)",
                         "Agricultural Demand|Feed|Livestock (million t DM/yr)",
                         "Agricultural Demand|Bioenergy (million t DM/yr)",
                         "Agricultural Demand|Bioenergy|1st generation (million t DM/yr)",
                         "Agricultural Demand|Bioenergy|2nd generation (million t DM/yr)")])

  #Agricultural Production
  new <- mbind(new,x[,,c("Agricultural Production (million t DM/yr)","Agricultural Production|Livestock (million t DM/yr)","Agricultural Production|Non-Energy Crops (million t DM/yr)","Agricultural Production|Non-Energy Crops|Cereals (million t DM/yr)","Agricultural Production|Energy Crops (million t DM/yr)")])

  ssp_name <- "Primary Energy|Biomass|1st Generation (EJ/yr)"
  reg <- bioenergy(gdx,level = "reg",unit = "EJ")[,,"1st generation bioenergy"]
  glo <- bioenergy(gdx,level = "glo",unit = "EJ")[,,"1st generation bioenergy"]
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))

  ssp_name <- "Primary Energy|Biomass|Energy Crops (EJ/yr)"
  reg <- production(gdx,level = "reg",unit = "EJ",crops=c("begr","betr"),crop_aggr = TRUE)
  glo <- production(gdx,level = "glo",unit = "EJ",crops=c("begr","betr"),crop_aggr = TRUE)
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))

  #cumulative CO2 emissions
  ssp_name <- "Emissions|CO2|Land Use|cumulative (Mt CO2 cumulative)"
  reg <- emissions(gdx,  cumulative=T, type="co2_c",level="reg",y1995=T)* 44/12
  glo <- emissions(gdx,  cumulative=T, type="co2_c",level="glo",y1995=T)* 44/12
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))

  #cumulative CH4 emissions
  ssp_name <- "Emissions|CH4|Land Use|cumulative (Mt CH4 cumulative)"
  reg <- emissions(gdx,  cumulative=T, type="ch4",level="reg",y1995=T)
  glo <- emissions(gdx,  cumulative=T, type="ch4",level="glo",y1995=T)
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))

  #cumulative N2O emissions
  ssp_name <- "Emissions|N2O|Land Use|cumulative (Mt N2O cumulative)"
  reg <- emissions(gdx,  cumulative=T, type="n2o_n",level="reg",y1995=T) * 44/28
  glo <- emissions(gdx,  cumulative=T, type="n2o_n",level="glo",y1995=T) * 44/28
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))

  return(new)
}

#Get report from MAgPIE run
rep_magpie <- getReport(gdx)

#generate SSP variables based on MIF variables
rep_magpie <- MIF2SSP(rep_magpie)

kcr <- readGDX(gdx,"kcr")

#add nitrogen variables
reg <- nr_cropland_budget(gdx)
reg <- setNames(reg,paste0("Nitrogen Budget|",getNames(reg)," (Tg Nr)"))
glo <- dimSums(reg,dim=1)
rep_magpie <- mbind(rep_magpie,mbind(reg,glo))

reg <- dimSums(nr_cropland_budget(gdx),dim=3)
getNames(reg) <- "Nitrogen Budget|Cropland Losses (Tg Nr)"
glo <- dimSums(reg,dim=1)
rep_magpie <- mbind(rep_magpie,mbind(reg,glo))

reg <- dimSums(readGDX(gdx,"ov_dem_convby_substitutes")[,,"level"],dim=3)
getNames(reg) <- "Benni|Conversion byproduct substitutes in DM (Tg DM)"
glo <- dimSums(reg,dim=1)
rep_magpie <- mbind(rep_magpie,mbind(reg,glo))

reg <- dimSums(readGDX(gdx,"ov_dem_scp")[,,"level"],dim=3)
getNames(reg) <- "Benni|MP substrate in DM (Mt DM)"
glo <- dimSums(reg,dim=1)
rep_magpie <- mbind(rep_magpie,mbind(reg,glo))

reg <- dimSums(readGDX(gdx,"ov_dem_scp")[,,kcr][,,"level"]*readGDX(gdx,"im_attributes_harvest")[,,"nr"][,,kcr],dim=3)
getNames(reg) <- "Benni|MP substrate in Nr (Mt Nr)"
glo <- dimSums(reg,dim=1)
rep_magpie <- mbind(rep_magpie,mbind(reg,glo))

kli <- readGDX(gdx,"kli")
reg <- dimSums(readGDX(gdx,"ov_dem_feed")[,,"level"][,,kcr],dim=3)
getNames(reg) <- "Benni|Feed DM (Mt DM)"
glo <- dimSums(reg,dim=1)
rep_magpie <- mbind(rep_magpie,mbind(reg,glo))

reg <- dimSums(readGDX(gdx,"ov_dem_feed")[,,"level"][,,"scp"],dim=3)
getNames(reg) <- "Benni|Feed MP DM (Mt DM)"
glo <- dimSums(reg,dim=1)
rep_magpie <- mbind(rep_magpie,mbind(reg,glo))

reg <- dimSums(readGDX(gdx,"ov_dem_feed")[,,"level"][,,kcr]*readGDX(gdx,"im_attributes_harvest")[,,"nr"][,,kcr],dim=3)
getNames(reg) <- "Benni|Feed Nr (Mt Nr)"
glo <- dimSums(reg,dim=1)
rep_magpie <- mbind(rep_magpie,mbind(reg,glo))

reg <- dimSums(readGDX(gdx,"ov_scp_feed")[,,"level"][,,"nr"],dim=3)
getNames(reg) <- "Benni|Feed MP Nr (Mt Nr)"
glo <- dimSums(reg,dim=1)
rep_magpie <- mbind(rep_magpie,mbind(reg,glo))

reg <- dimSums(readGDX(gdx,"ov_dem_feed")[,,"level"][,,"foddr"],dim=3)
getNames(reg) <- "Benni|Feed Forage DM (Mt DM)"
glo <- dimSums(reg,dim=1)
rep_magpie <- mbind(rep_magpie,mbind(reg,glo))

reg <- dimSums(readGDX(gdx,"ov_dem_feed")[,,"level"][,,"foddr"]*readGDX(gdx,"im_attributes_harvest")[,,"nr"][,,"foddr"],dim=3)
getNames(reg) <- "Benni|Feed Forage Nr (Mt Nr)"
glo <- dimSums(reg,dim=1)
rep_magpie <- mbind(rep_magpie,mbind(reg,glo))

kcr <- readGDX(gdx,"kcr")
reg <- dimSums(readGDX(gdx,"ov_dem_convby_substitutes",select = list(type="level"))*collapseNames(readGDX(gdx,"im_attributes_harvest")[,,kcr][,,"nr"]),dim=3)
getNames(reg) <- "Benni|Conversion byproduct substitutes in Nr (Tg Nr)"
glo <- dimSums(reg,dim=1)
rep_magpie <- mbind(rep_magpie,mbind(reg,glo))

reg <- dimSums(collapseNames(readGDX(gdx,"ov20_convby_use",select = list(type="level"))[,,"feed"])*collapseNames(readGDX(gdx,"f20_attributes_convby")[,,"nr"]),dim=3)
getNames(reg) <- "Benni|Conversion byproduct feeduse (Tg Nr)"
glo <- dimSums(reg,dim=1)
rep_magpie <- mbind(rep_magpie,mbind(reg,glo))



rep_magpie <- rep_magpie[,c(2005,2010,2030,2050),]

#write report
write.report(rep_magpie,file=path("output/scp_jun16.csv"),scenario=title,model="MAgPIE",append=TRUE)

print(paste0("Finished SCP report for ",title))
print("---")
