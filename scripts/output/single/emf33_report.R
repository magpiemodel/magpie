# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

options("magclass.verbosity" = 1)

library(gdx)
library(magclass)
library(magpie4)
library(lucode)

#delivered prices = prices()
#farmgate prices = prices() - transport costs

farmgate_price <- function(gdx, file=NULL, level="reg", crops=NULL, crop_aggr=FALSE, unit="DM") {
  bio_transp_cost <- dimSums(costs(gdx,type = "transport",level=level)[,,crops],dim=3) #mio us Dollar
  bio_prod <- supply(gdx,level=level, crops=crops, crop_aggr=crop_aggr, unit="EJ",water = "sum")*10^3 #mio GJ
  p <- prices(gdx,level=level, crops=crops, crop_aggr=crop_aggr, unit=unit) - bio_transp_cost/bio_prod
  out(p,file)
}


#function to generate SSP variables based on MIF variables
MIF2SSP <- function(x,gdx) {  
  new <- NULL
  
  t <- readGDX(gdx,"t")

  ### Land cover
  ssp_name <- "Land Cover (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Cropland (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover|Cropland (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Cropland|Energy Crops (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover|Cropland|Energy Crops (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Forest (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover|Forest (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Forest|Managed (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover|Forest|Managed|Forestry (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Forest|Afforestation and Reforestation (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover|Forest|Managed|Afforestation (million Ha/yr)"],ssp_name))
  ssp_name <- "Land Cover|Forest|Natural Forest (million ha)"
  new <- mbind(new,setNames(x[,,"Land Cover|Forest|Unmanaged (million Ha/yr)"],ssp_name))
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
  
  #Native land cover
  reg <- land(gdx,level="reg")
  glo <- land(gdx,level="glo")
  native_land <- mbind(reg,glo)
  ssp_name <- "Land Cover|Native category 1 (million ha)"
  new <- mbind(new,setNames(native_land[,,"crop"],ssp_name))
  ssp_name <- "Land Cover|Native category 2 (million ha)"
  new <- mbind(new,setNames(native_land[,,"past"],ssp_name))
  ssp_name <- "Land Cover|Native category 3 (million ha)"
  new <- mbind(new,setNames(native_land[,,"forestry"],ssp_name))
  ssp_name <- "Land Cover|Native category 4 (million ha)"
  new <- mbind(new,setNames(native_land[,,"forest"],ssp_name))
  ssp_name <- "Land Cover|Native category 5 (million ha)"
  new <- mbind(new,setNames(native_land[,,"urban"],ssp_name))
  ssp_name <- "Land Cover|Native category 6 (million ha)"
  new <- mbind(new,setNames(native_land[,,"other"],ssp_name))
  
  #Emissions
  ssp_name <- "Emissions|CO2|Land Use (Mt CO2/yr)"
  new <- mbind(new,setNames(mbind(x[,1,"Emissions|CO2|Land Use (Mt CO2/yr)"],lowpass(x[,-1,"Emissions|CO2|Land Use (Mt CO2/yr)"],i=1,fix=NULL)),ssp_name))
  
  ssp_name <- "Emissions|CH4|Land Use (Mt CH4/yr)"  
  new <- mbind(new,setNames(x[,,"Emissions|CH4|Land Use (Mt CH4/yr)"],ssp_name) + 
                 setNames(x[,,"Emissions|ch4|Land Use|Agricultural Waste Burning (Tg ch4/yr)"],ssp_name) + 
                 setNames(x[,,"Emissions|ch4|Land Use|Savannah Burning (Tg ch4/yr)"],ssp_name) + 
                 setNames(x[,,"Emissions|ch4|Land Use|Forest Burning (Tg ch4/yr)"],ssp_name))
  ssp_name <- "Emissions|CH4|Land Use|Agricultural Waste Burning (Mt CH4/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|ch4|Land Use|Agricultural Waste Burning (Tg ch4/yr)"],ssp_name))
  ssp_name <- "Emissions|CH4|Land Use|Savannah Burning (Mt CH4/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|ch4|Land Use|Savannah Burning (Tg ch4/yr)"],ssp_name))
  ssp_name <- "Emissions|CH4|Land Use|Forest Burning (Mt CH4/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|ch4|Land Use|Forest Burning (Tg ch4/yr)"],ssp_name))
  ssp_name <- "Emissions|CH4|Land Use|Agriculture (Mt CH4/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|CH4|Land Use (Mt CH4/yr)"],ssp_name))
  ssp_name <- "Emissions|CH4|Land Use|Agriculture|Rice (Mt CH4/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|CH4|Land Use|Rice (Mt CH4/yr)"],ssp_name))
  ssp_name <- "Emissions|CH4|Land Use|Agriculture|AWM (Mt CH4/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|CH4|Land Use|AWM (Mt CH4/yr)"],ssp_name))
  ssp_name <- "Emissions|CH4|Land Use|Agriculture|Enteric Fermentation (Mt CH4/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|CH4|Land Use|Enteric Fermentation (Mt CH4/yr)"],ssp_name))
  
  ssp_name <- "Emissions|N2O|Land Use (kt N2O/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|N2O|Land Use (kt N2O/yr)"],ssp_name) + 
                 setNames(x[,,"Emissions|n2o|Land Use|Agricultural Waste Burning (Tg n2o/yr)"]*10^3,ssp_name) + 
                 setNames(x[,,"Emissions|n2o|Land Use|Savannah Burning (Tg n2o/yr)"]*10^3,ssp_name) + 
                 setNames(x[,,"Emissions|n2o|Land Use|Forest Burning (Tg n2o/yr)"]*10^3,ssp_name))
  ssp_name <- "Emissions|N2O|Land Use|Agricultural Waste Burning (kt N2O/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|n2o|Land Use|Agricultural Waste Burning (Tg n2o/yr)"]*10^3,ssp_name))
  ssp_name <- "Emissions|N2O|Land Use|Savannah Burning (kt N2O/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|n2o|Land Use|Savannah Burning (Tg n2o/yr)"]*10^3,ssp_name))
  ssp_name <- "Emissions|N2O|Land Use|Forest Burning (kt N2O/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|n2o|Land Use|Forest Burning (Tg n2o/yr)"]*10^3,ssp_name))
  ssp_name <- "Emissions|N2O|Land Use|Agriculture (kt N2O/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|N2O|Land Use (kt N2O/yr)"],ssp_name))
  ssp_name <- "Emissions|N2O|Land Use|Agriculture|AWM (kt N2O/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|N2O|Land Use|AWM (kt N2O/yr)"],ssp_name))
  ssp_name <- "Emissions|N2O|Land Use|Agriculture|Cropland Soils (kt N2O/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|N2O|Land Use|Cropland Soils (kt N2O/yr)"],ssp_name))
  ssp_name <- "Emissions|N2O|Land Use|Agriculture|Pasture (kt N2O/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|N2O|Land Use|Pasture (kt N2O/yr)"],ssp_name))
  
  #C price
  ssp_name <- "Price|Carbon (US$2005/t CO2)"
  reg <- readGDX(gdx,"i56_ghg_prices", "i57_ghg_prices", format="first_found")[,t,"co2_c"]*12/44
  glo <- setCells(reg[1,,],"GLO")
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))
  
  #Bioenergy price delivered
  ssp_name <- "Price|Primary Energy|Biomass|Delivered (US$2005/GJ)"
  reg <- prices(gdx,unit = "GJ",crops = c("begr","betr"),crop_aggr = TRUE,level="reg")
  glo <- prices(gdx,unit = "GJ",crops = c("begr","betr"),crop_aggr = TRUE,level="glo")
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))
  
  #Bioenergy price farmgate (calculated as delivered - average transport costs)
  ssp_name <- "Price|Primary Energy|Biomass|Farmgate (US$2005/GJ)"
  reg <- farmgate_price(gdx,unit = "GJ",crops = c("begr","betr"),crop_aggr = TRUE,level="reg")
  glo <- farmgate_price(gdx,unit = "GJ",crops = c("begr","betr"),crop_aggr = TRUE,level="glo")
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))
  
  #   
  #   #Bioenergy prices
  #   new <- mbind(new,x[,,c("Price|Primary Energy|Biomass (US$2005/GJ)")])  
  #   ssp_name <- "Price|Primary Energy|Biomass|Marginal (US$2005/GJ)"
  #   new <- mbind(new,setNames(x[,,c("Price|Primary Energy|Biomass (US$2005/GJ)")],ssp_name)) 
  #   #Bioenergy costs
  #   ssp_name <- "Price|Primary Energy|Biomass|Average (mio US$/yr)"
  #   reg <- dimSums((costs(gdx,level = "reg",type = "production",crop_aggr = FALSE) + costs(gdx,level = "reg",type = "transport",crop_aggr = FALSE))[,,c("begr","betr")],dim=3.1)
  #   glo <- dimSums((costs(gdx,level = "glo",type = "production",crop_aggr = FALSE) + costs(gdx,level = "glo",type = "transport",crop_aggr = FALSE))[,,c("begr","betr")],dim=3.1)
  #   new <- mbind(new,setNames(mbind(reg,glo),ssp_name))
  #   
  #Prices Indices
  ssp_name <- "Price|Agriculture|Non-Energy Crops|Index (Index (2005 = 1))"
  new <- mbind(new,setNames(mbind(priceIndex(gdx,crops="kfo",level="reg",baseyear="y2005")/100,priceIndex(gdx,crops="kfo",level="glo",baseyear="y2005")/100),ssp_name)) 
  ssp_name <- "Price|Agriculture|Corn|Index (2005 = 1)"
  new <- mbind(new,setNames(mbind(priceIndex(gdx,crops="maiz",level="reg",baseyear="y2005")/100,priceIndex(gdx,crops="maiz",level="glo",baseyear="y2005")/100),ssp_name)) 
  ssp_name <- "Price|Agriculture|Soybean|Index (2005 = 1)"
  new <- mbind(new,setNames(mbind(priceIndex(gdx,crops="soybean",level="reg",baseyear="y2005")/100,priceIndex(gdx,crops="soybean",level="glo",baseyear="y2005")/100),ssp_name)) 
  ssp_name <- "Price|Agriculture|Wheat|Index (2005 = 1)"
  new <- mbind(new,setNames(mbind(priceIndex(gdx,crops="tece",level="reg",baseyear="y2005")/100,priceIndex(gdx,crops="tece",level="glo",baseyear="y2005")/100),ssp_name)) 
  
  #   #Water
  #   new <- mbind(new,x[,,c("Water|Withdrawal|Irrigation (million m3/yr)")])
  
  #Fertilizer use
  ssp_name <- "Fertilizer Use|Nitrogen (Tg N/yr)"
  new <- mbind(new,setNames(x[,,"Fertilizer Use|Nitrogen (Tg Nr/yr)"],ssp_name))
  #  new <- mbind(new,x[,,c("Fertilizer Use|Phosphorus (Tg P/yr)")])
  
  #   #Food Demand (EJ/yr)
  #   new <- mbind(new,x[,,"Food Energy Demand (EJ/yr)"])
  #   new <- mbind(new,x[,,"Food Energy Demand|Livestock (EJ/yr)"])
  
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
                         "Agricultural Demand|Feed (million t DM/yr)",
                         "Agricultural Demand|Bioenergy (million t DM/yr)",
                         "Agricultural Demand|Bioenergy|1st generation (million t DM/yr)",
                         "Agricultural Demand|Bioenergy|2nd generation (million t DM/yr)")])
  
  #Agricultural Production
  new <- mbind(new,x[,,c("Agricultural Production (million t DM/yr)","Agricultural Production|Livestock (million t DM/yr)","Agricultural Production|Non-Energy Crops (million t DM/yr)","Agricultural Production|Energy Crops (million t DM/yr)")])
  
  ssp_name <- "Primary Energy|Biomass (EJ/yr)"
  reg <- supply(gdx,level = "reg",unit = "EJ",crops=c("begr","betr"),crop_aggr = TRUE)
  glo <- supply(gdx,level = "glo",unit = "EJ",crops=c("begr","betr"),crop_aggr = TRUE)
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))
  
  ssp_name <- "Primary Energy|Biomass|Modern (EJ/yr)"
  reg <- supply(gdx,level = "reg",unit = "EJ",crops=c("begr","betr"),crop_aggr = TRUE)
  glo <- supply(gdx,level = "glo",unit = "EJ",crops=c("begr","betr"),crop_aggr = TRUE)
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))
  
  ssp_name <- "Primary Energy|Biomass|Modern2nd (EJ/yr)"
  reg <- supply(gdx,level = "reg",unit = "EJ",crops=c("begr","betr"),crop_aggr = TRUE)
  glo <- supply(gdx,level = "glo",unit = "EJ",crops=c("begr","betr"),crop_aggr = TRUE)
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))

    ssp_name <- "Primary Energy|Biomass|1st Generation (EJ/yr)"
  reg <- bioenergy(gdx,level = "reg",unit = "EJ")[,,"1st generation bioenergy"]
  glo <- bioenergy(gdx,level = "glo",unit = "EJ")[,,"1st generation bioenergy"]
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))
  
  ssp_name <- "Primary Energy|Biomass|Energy Crops (EJ/yr)"
  reg <- supply(gdx,level = "reg",unit = "EJ",crops=c("begr","betr"),crop_aggr = TRUE)
  glo <- supply(gdx,level = "glo",unit = "EJ",crops=c("begr","betr"),crop_aggr = TRUE)
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))
  
  ssp_name <- "Primary Energy|Biomass|Native category 1 (EJ/yr)"
  reg <- supply(gdx,level = "reg",unit = "EJ",crops=c("begr"),crop_aggr = TRUE)
  glo <- supply(gdx,level = "glo",unit = "EJ",crops=c("begr"),crop_aggr = TRUE)
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))
  
  ssp_name <- "Primary Energy|Biomass|Native category 2 (EJ/yr)"
  reg <- supply(gdx,level = "reg",unit = "EJ",crops=c("betr"),crop_aggr = TRUE)
  glo <- supply(gdx,level = "glo",unit = "EJ",crops=c("betr"),crop_aggr = TRUE)
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))
  
  ssp_name <- "Primary Energy|Biomass|Native category 3 (EJ/yr)"
  reg <- bioenergy(gdx,level = "reg",unit = "EJ")[,,"1st generation bioenergy"]
  glo <- bioenergy(gdx,level = "glo",unit = "EJ")[,,"1st generation bioenergy"]
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))
  
  #ton DM
  ssp_name <- "Primary Energy|Biomass|Tons (tDM/yr)"
  reg <- supply(gdx,level = "reg",unit = "DM",crops=c("begr","betr"),crop_aggr = TRUE)
  glo <- supply(gdx,level = "glo",unit = "DM",crops=c("begr","betr"),crop_aggr = TRUE)
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))
  
  ssp_name <- "Primary Energy|Biomass|Modern|Tons (tDM/yr)"
  reg <- supply(gdx,level = "reg",unit = "DM",crops=c("begr","betr"),crop_aggr = TRUE)
  glo <- supply(gdx,level = "glo",unit = "DM",crops=c("begr","betr"),crop_aggr = TRUE)
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))
  
  ssp_name <- "Primary Energy|Biomass|Modern2nd|Tons (tDM/yr)"
  reg <- supply(gdx,level = "reg",unit = "DM",crops=c("begr","betr"),crop_aggr = TRUE)
  glo <- supply(gdx,level = "glo",unit = "DM",crops=c("begr","betr"),crop_aggr = TRUE)
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))
  
  ssp_name <- "Primary Energy|Biomass|1st Generation|Tons (tDM/yr)"
  reg <- bioenergy(gdx,level = "reg",unit = "DM")[,,"1st generation bioenergy"]
  glo <- bioenergy(gdx,level = "glo",unit = "DM")[,,"1st generation bioenergy"]
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))
  
  ssp_name <- "Primary Energy|Biomass|Energy Crops|Tons (tDM/yr)"
  reg <- supply(gdx,level = "reg",unit = "DM",crops=c("begr","betr"),crop_aggr = TRUE)
  glo <- supply(gdx,level = "glo",unit = "DM",crops=c("begr","betr"),crop_aggr = TRUE)
  new <- mbind(new,setNames(mbind(reg,glo),ssp_name))
  
  #Yields
  tmp <- setNames(new[,,"Agricultural Production|Non-Energy Crops (million t DM/yr)"],NULL)/(setNames(new[,,"Land Cover|Cropland (million ha)"],NULL) - setNames(new[,,"Land Cover|Cropland|Energy Crops (million ha)"],NULL))
  getNames(tmp) <- "Agriculture|Yield|Non-Energy Crops (tDM/ha)"
  new <- mbind(new,tmp)
  
  tmp <- setNames(new[,,"Agricultural Production|Energy Crops (million t DM/yr)"],NULL)/setNames(new[,,"Land Cover|Cropland|Energy Crops (million ha)"],NULL)
  getNames(tmp) <- "Agriculture|Yield|Energy Crops (tDM/ha)"
  new <- mbind(new,tmp)
  
  ssp_name <- "Yield|cereal (t DM/ha/yr)"
  new <- mbind(new,setNames(x[,,"Yield|Cereal (tDM/ha/yr)"],ssp_name))
  
  #Population
  ssp_name <- "Population (million)"
  new <- mbind(new,setNames(x[,,"Population (million cap)"],ssp_name))
    
  return(new)
}

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  
  gdx_file <- "fulldata.gdx"
  output_folder <- "output/R3B0"
  gdx<-path(output_folder,gdx_file)
  title <- "R3B0"
  #setwd("/Users/flo/Documents/PIK/MAgPIE/6383")
  
  #Define arguments that can be read from command line
  readArgs("gdx_file","output_folder")
} else{
  gdx_file <- "fulldata.gdx"
  output_folder<-outputdir
  gdx<-path(outputdir,gdx_file)
}

###############################################################################

#Get report from MAgPIE run
rep_magpie <- getReport(gdx)

#generate SSP variables based on MIF variables
rep_magpie <- MIF2SSP(rep_magpie,gdx)

#select relevant years
rep_magpie <- rep_magpie[,c(2005,2010,2020,2030,2040,2050,2060,2070,2080,2090,2100),]

#write report
write.report(rep_magpie,file=path("output/emf33_round3.csv"),scenario=title,model="MAgPIE",append=TRUE)
