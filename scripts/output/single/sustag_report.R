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
  output_folder        <- '/p/projects/landuse/users/weindl/1SUSTAg/magpie/output/default_2018-05-25_22.29.24'
  gdx<-path(output_folder,"fulldata.gdx")
  title <- "TEST"

  #Define arguments that can be read from command line
  readArgs("gdx_file","output_folder","title")
} else{
  load(paste0(outputdir, "/config.Rdata"))
  gdx            <- path(outputdir,"fulldata.gdx")
  output_folder  <- outputdir
  title          <- cfg$title

}
print("---")
print(paste0("Starting SUSTAg report for ",title))

###############################################################################

#function to generate SUSTAg indicators based on MIF variables
MIF2SUSTAg <- function(x,model="MAgPIE",scenario="default") {
  x <- x[,-1,]
  new <- NULL


  #Emissions
  name <- "Emissions|N2O|Agriculture (Mt N2O/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|N2O|Land|+|Agriculture (Mt N2O/yr)"],paste(model,scenario,name,sep=".")))
  
  name <- "Emissions|CH4|Agriculture (Mt CH4/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|CH4|Land|+|Agriculture (Mt CH4/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Emissions|CO2|AFOLU (Mt CO2/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|CO2|Land (Mt CO2/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Emissions|NH3|Agriculture (Mt NH3/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|NH3|Land|+|Agriculture (Mt NH3/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Emissions|NOx|Agriculture (Mt NO2/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|NOx|Land|+|Agriculture (Mt NOx/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Emissions|NO3-|Agriculture (Mt NO3/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|NO3-|Land|+|Agriculture (Mt NO3-/yr)"],paste(model,scenario,name,sep=".")))




  ### Land cover
  name <- "Land Cover|Cropland (million ha)"
  new <- mbind(new,setNames(x[,,"Resources|Land Cover|+|Cropland (million ha)"],paste(model,scenario,name,sep=".")))

  name <- "Land Cover|Pasture (million ha)"
  new <- mbind(new,setNames(x[,,"Resources|Land Cover|+|Pastures and Rangelands (million ha)"],paste(model,scenario,name,sep=".")))

  name <- "Land Cover|Forest (million ha)"
  new <- mbind(new,setNames(x[,,"Resources|Land Cover|+|Forest (million ha)"],paste(model,scenario,name,sep=".")))

  name <- "Land Cover|Other Land (million ha)"
  new <- mbind(new,setNames(x[,,"Resources|Land Cover|+|Other Land (million ha)"],paste(model,scenario,name,sep=".")))
  
  
  ### Water
  name <- "Land Cover|Cropland|Area actually irrigated (million ha)"
  new <- mbind(new,setNames(x[,,"Resources|Land Cover|Cropland|Area actually irrigated (million ha)"],paste(model,scenario,name,sep=".")))

  name <- "Land Cover|Cropland|Area equipped for irrigation (million ha)"
  new <- mbind(new,setNames(x[,,"Resources|Land Cover|Cropland|Area equipped for irrigation (million ha)"],paste(model,scenario,name,sep=".")))

  name <- "Water|Water Withdrawal|Irrigation (km3/yr)"
  new <- mbind(new,setNames(x[,,"Resources|Water|Withdrawal|Agriculture (km3/yr)"],paste(model,scenario,name,sep=".")))

  #????#
  #????#
  #????#
  #????#
  #????#


  ### Nitrogen
  name <- "Nitrogen|Cropland Budget|Inputs (Mt Nr/yr)"
  new <- mbind(new,setNames(x[,,"Resources|Nitrogen|Cropland Budget|Inputs (Mt Nr/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Nitrogen|Cropland Budget|Inputs|Fertilizer (Mt Nr/yr)"
  new <- mbind(new,setNames(x[,,"Resources|Nitrogen|Cropland Budget|Inputs|+|Fertilizer (Mt Nr/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Nitrogen|Cropland Budget|Inputs|Manure (Mt Nr/yr)"
  new <- mbind(new,setNames(x[,,"Resources|Nitrogen|Cropland Budget|Inputs|+|Manure From Stubble Grazing (Mt Nr/yr)"]
	 + x[,,"Resources|Nitrogen|Cropland Budget|Inputs|+|Manure Recycled from Confinements (Mt Nr/yr)"],paste(model,scenario,name,sep=".")))
 
  name <- "Nitrogen|Cropland Budget|Inputs|Other nitrogen inputs (Mt Nr/yr)"
  new <- mbind(new,setNames(x[,,"Resources|Nitrogen|Cropland Budget|Inputs (Mt Nr/yr)"]
	 - x[,,"Resources|Nitrogen|Cropland Budget|Inputs|+|Fertilizer (Mt Nr/yr)"]
	 - x[,,"Resources|Nitrogen|Cropland Budget|Inputs|+|Manure From Stubble Grazing (Mt Nr/yr)"]
	 - x[,,"Resources|Nitrogen|Cropland Budget|Inputs|+|Manure Recycled from Confinements (Mt Nr/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Nitrogen|Cropland Budget|Withdrawal (Mt Nr/yr)"
  new <- mbind(new,setNames(x[,,"Resources|Nitrogen|Cropland Budget|Withdrawals (Mt Nr/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Nitrogen|Cropland Budget|Withdrawal|Harvested Crops (Mt Nr/yr)"
  new <- mbind(new,setNames(x[,,"Resources|Nitrogen|Cropland Budget|Withdrawals|+|Harvested Crops (Mt Nr/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Nitrogen|Cropland Budget|Surplus (Mt Nr/yr)"
  new <- mbind(new,setNames(x[,,"Resources|Nitrogen|Cropland Budget|Balance|+|Nutrient Surplus (Mt Nr/yr)"],paste(model,scenario,name,sep=".")))

  #!!Benni!# #????# different name ????????????????????????????????????????????????????
  name <- "Nitrogen|Cropland Budget|Balance|Soil Organic Matter Loss (Mt Nr/yr)"
  new <- mbind(new,setNames(x[,,"Resources|Nitrogen|Cropland Budget|Balance|+|Soil Organic Matter Loss (Mt Nr/yr)"],paste(model,scenario,name,sep=".")))
 


#  ### Phosphorus
#  name <- "Phosphorus|Cropland Budget|Inputs (Mt P/yr)"
#  new <- mbind(new,setNames(x[,,"Resources|Phosphorus|Cropland Budget|Inputs (Mt P/yr)"],paste(model,scenario,name,sep=".")))
#
#  name <- "Phosphorus|Cropland Budget|Inputs|Fertilizer (Mt P/yr)"
#  new <- mbind(new,setNames(x[,,"Resources|Phosphorus|Cropland Budget|Inputs|+|Fertilizer (Mt P/yr)"],paste(model,scenario,name,sep=".")))
#
#  name <- "Phosphorus|Cropland Budget|Inputs|Manure (Mt P/yr)"
#  new <- mbind(new,setNames(x[,,"Resources|Phosphorus|Cropland Budget|Inputs|+|Manure From Stubble Grazing (Mt P/yr)"]
#	 + x[,,"Resources|Phosphorus|Cropland Budget|Inputs|+|Manure Recycled from Confinements (Mt P/yr)"],paste(model,scenario,name,sep=".")))
# 
#  name <- "Phosphorus|Cropland Budget|Inputs|Other Phosphorus inputs (Mt P/yr)"
#  new <- mbind(new,setNames(x[,,"Resources|Phosphorus|Cropland Budget|Inputs (Mt P/yr)"]
#	 - x[,,"Resources|Phosphorus|Cropland Budget|Inputs|+|Fertilizer (Mt P/yr)"]
#	 - x[,,"Resources|Phosphorus|Cropland Budget|Inputs|+|Manure From Stubble Grazing (Mt P/yr)"]
#	 - x[,,"Resources|Phosphorus|Cropland Budget|Inputs|+|Manure Recycled from Confinements (Mt P/yr)"],paste(model,scenario,name,sep=".")))
#
#  name <- "Phosphorus|Cropland Budget|Withdrawal (Mt P/yr)"
#  new <- mbind(new,setNames(x[,,"Resources|Phosphorus|Cropland Budget|Withdrawals (Mt P/yr)"],paste(model,scenario,name,sep=".")))
#
#  name <- "Phosphorus|Cropland Budget|Withdrawal|Harvested Crops (Mt P/yr)"
#  new <- mbind(new,setNames(x[,,"Resources|Phosphorus|Cropland Budget|Withdrawals|+|Harvested Crops (Mt P/yr)"],paste(model,scenario,name,sep=".")))
#
#  name <- "Phosphorus|Cropland Budget|Surplus (Mt P/yr)"
#  new <- mbind(new,setNames(x[,,"Resources|Phosphorus|Cropland Budget|Balance|+|Nutrient Surplus (Mt P/yr)"],paste(model,scenario,name,sep=".")))
#
#  #????# different name ????????????????????????????????????????????????????
#  name <- "Phosphorus|Cropland Budget|Balance|Soil Organic Matter Loss (Mt P/yr)"
#  new <- mbind(new,setNames(x[,,"Resources|Phosphorus|Cropland Budget|Balance|+|Soil Organic Matter Loss (Mt P/yr)"],paste(model,scenario,name,sep=".")))
 

  ### Production
  name <- "Production|Bioenergy crops (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Production|+|Bioenergy crops (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Production|Forestry (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Production|+|Forest products (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Production|Crop residues (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Production|+|Crop residues (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Production|Crops (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Production|+|Crops (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Production|Forage (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Production|+|Forage (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Production|Livestock products (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Production|+|Livestock products (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Production|Pasture (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Production|+|Pasture (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Production|Secondary products (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Production|+|Secondary products (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Production|Secondary products|Oil (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Production|Secondary products|+|Oils (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Production|Secondary products|Ethanol (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Production|Secondary products|+|Ethanol (Mt DM/yr)"],paste(model,scenario,name,sep=".")))
 
  name <- "Production|Secondary products|Sugar (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Production|Secondary products|+|Sugar (Mt DM/yr)"],paste(model,scenario,name,sep=".")))
 


  ### Prices
  
  
  #????# aktuell nur aggregiert verfügbar für alle food items ??????????????
  name <- "Prices|Producer Price Index|Food (index relative to 2010)"
  new <- mbind(new,setNames(x[,,"Prices|Food Price Index (Index 2005=100)"],paste(model,scenario,name,sep=".")))

#  #????# Index für food crops fehlt  ??????????????????????????????????????
#  name <- "Prices|Producer Price Index|Crops (index relative to 2010)"
#  new <- mbind(new,setNames(x[,,"Prices|Food Price Index (Index 2005=100)"],paste(model,scenario,name,sep=".")))

#  #????# Index für livestock fehlt ?????????????????????????????????????????
#  name <- "Prices|Producer Price Index|Livestock (index relative to 2010)"
#  new <- mbind(new,setNames(x[,,"Prices|Food Price Index (Index 2005=100)"],paste(model,scenario,name,sep=".")))


  name <- "Prices|Producer Prices|Ethanol (US$05/tDM)"
  new <- mbind(new,setNames(x[,,"Prices|Agriculture|Ethanol (US$05/tDM)"],paste(model,scenario,name,sep=".")))

  name <- "Prices|Producer Prices|Biodiesel (US$05/tDM)"
  new <- mbind(new,setNames(x[,,"Prices|Agriculture|Oils (US$05/tDM)"],paste(model,scenario,name,sep=".")))
 
 
  
  ### Costs

  #crops!!!!!!!!!!!!
  name <- "Costs|Total production costs|Factor costs|Crops (million US$05/yr)"
  new <- mbind(new,setNames(x[,,"Costs|MainSolve|Input Factors (million US$05/yr)"],paste(model,scenario,name,sep=".")))
  
  #???# livestock excl feed!!!!!!!!!!!
  name <- "Costs|Total production costs|Factor costs|Livestock excluding feed (million US$05/yr)"
  new <- mbind(new,setNames(x[,,"Costs|MainSolve|Input Factors (million US$05/yr)"],paste(model,scenario,name,sep=".")))



  ### Demand
  name <- "Demand|Agricultural Supply Chain Loss|Crops (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Demand|Agricultural Supply Chain Loss|+|Crops (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Demand|Feed|Crops (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Demand|Feed|+|Crops (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Demand|Food|Crops (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Demand|Food|+|Crops (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Demand|Material|Crops (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Demand|Material|+|Crops (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Demand|Processing|Crops (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Demand|Processing|+|Crops (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Demand|Seed|Crops (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Demand|Seed|+|Crops (Mt DM/yr)"],paste(model,scenario,name,sep=".")))


  name <- "Demand|Agricultural Supply Chain Loss|Livestock products (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Demand|Agricultural Supply Chain Loss|+|Livestock products (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Demand|Feed|Livestock products (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Demand|Feed|+|Livestock products (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Demand|Food|Livestock products (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Demand|Food|+|Livestock products (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

  name <- "Demand|Material|Livestock products (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Demand|Material|+|Livestock products (Mt DM/yr)"],paste(model,scenario,name,sep=".")))
 
  name <- "Demand|Seed|Livestock products (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Demand|Seed|+|Livestock products (Mt DM/yr)"],paste(model,scenario,name,sep=".")))


  name <- "Demand|Bioenergy|Secondary products|Oil (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Demand|Bioenergy|Secondary products|+|Oils (Mt DM/yr)"],paste(model,scenario,name,sep=".")))
 
  name <- "Demand|Bioenergy|Secondary products|Ethanol (Mt DM/yr)"
  new <- mbind(new,setNames(x[,,"Demand|Bioenergy|Secondary products|+|Ethanol (Mt DM/yr)"],paste(model,scenario,name,sep=".")))

 

  ### Food availability

  name <- "Food availability (kcal/cap/day)"
  reg.foodkcal <- Kcal(gdx,level = "reg",products = "kfo",product_aggr = TRUE,calibrated=TRUE, attributes = "kcal", per_capita = TRUE)
  glo.foodkcal <- Kcal(gdx,level = "glo",products = "kfo",product_aggr = TRUE,calibrated=TRUE, attributes = "kcal", per_capita = TRUE)
  new <- mbind(new,setNames(mbind(reg.foodkcal,glo.foodkcal)[,-1,],paste(model,scenario,name,sep=".")))

 # name <- "Food availability (protein/cap/day)"
 # reg.foodprot <- Kcal(gdx,level = "reg",products = "kfo",product_aggr = TRUE,calibrated=TRUE, attributes = "protein", per_capita = TRUE)
 # glo.foodprot <- Kcal(gdx,level = "glo",products = "kfo",product_aggr = TRUE,calibrated=TRUE, attributes = "protein", per_capita = TRUE)
 # new <- mbind(new,setNames(mbind(reg.foodprot,glo.foodprot)[,-1,],paste(model,scenario,name,sep=".")))
 # Hinweis kcal-Funktion kann bei attributes "proteins" die produkte nicht agregieren

######################################################

  ### Food Intake
  name <- "Food Intake (kcal/cap/day)"
  reg.intake <- Intake(gdx,level = "reg",calibrated=TRUE, pregnancy = TRUE, per_capita = TRUE, age_groups = FALSE)
  glo.intake <- Intake(gdx,level = "glo",calibrated=TRUE, pregnancy = TRUE, per_capita = TRUE, age_groups = FALSE)
  new <- mbind(new,setNames(mbind(reg.intake,glo.intake)[,-1,],paste(model,scenario,name,sep=".")))

  name <- "Food Intake|Staple products (kcal/cap/day)"
  reg <- (Kcal(gdx,level = "reg",products = "kfo_st",product_aggr = TRUE,attributes = "kcal")/reg.foodkcal)*reg.intake
  glo <- (Kcal(gdx,level = "glo",products = "kfo_st",product_aggr = TRUE,attributes = "kcal")/glo.foodkcal)*glo.intake
  new <- mbind(new,setNames(mbind(reg,glo)[,-1,],paste(model,scenario,name,sep=".")))

  name <- "Food Intake|Crops|Fruits, Vegetables & Nuts (kcal/cap/day)"
  reg <- (Kcal(gdx,level = "reg",products = "others",product_aggr = FALSE,attributes = "kcal")/reg.foodkcal)*reg.intake
  glo <- (Kcal(gdx,level = "glo",products = "others",product_aggr = FALSE,attributes = "kcal")/glo.foodkcal)*glo.intake
  new <- mbind(new,setNames(mbind(reg,glo)[,-1,],paste(model,scenario,name,sep=".")))

  name <- "Food Intake|Livestock products (kcal/cap/day)"
  reg <- (Kcal(gdx,level = "reg",products = "kfo_ap",product_aggr = TRUE,attributes = "kcal")/reg.foodkcal)*reg.intake
  glo <- (Kcal(gdx,level = "glo",products = "kfo_ap",product_aggr = TRUE,attributes = "kcal")/glo.foodkcal)*glo.intake
  new <- mbind(new,setNames(mbind(reg,glo)[,-1,],paste(model,scenario,name,sep=".")))

  name <- "Food Intake|Empty calories (kcal/cap/day)"
  reg <- (Kcal(gdx,level = "reg",products = "kfo_pf",product_aggr = TRUE,attributes = "kcal")/reg.foodkcal)*reg.intake
  glo <- (Kcal(gdx,level = "glo",products = "kfo_pf",product_aggr = TRUE,attributes = "kcal")/glo.foodkcal)*glo.intake
  new <- mbind(new,setNames(mbind(reg,glo)[,-1,],paste(model,scenario,name,sep=".")))


  ### Food Expenditure
  name <- "Food Expenditure (US$05/cap/yr)"
  reg <- FoodExpenditure(gdx,level = "reg",products = "kfo",product_aggr = TRUE, per_capita = TRUE)
  glo <- FoodExpenditure(gdx,level = "glo",products = "kfo",product_aggr = TRUE, per_capita = TRUE)
  new <- mbind(new,setNames(mbind(reg,glo)[,-1,],paste(model,scenario,name,sep=".")))


  
  return(new)
}

#Get report from MAgPIE run
rep_magpie_raw <- getReport(gdx,scenario=title)
write.report2(rep_magpie_raw,file=path(outputdir,"report_magpie.csv"),scenario=title,model="MAgPIE",append=F)


#generate SUSTAg indicators based on MIF variables
rep_magpie <- MIF2SUSTAg(rep_magpie_raw,scenario=title)



#rep_magpie <- rep_magpie[,c(2005,2010,2015,2020,2030,2040,2050,2060,2070,2080,2090,2100),]
rep_magpie <- rep_magpie[,c(2000,2010,2020,2030,2040,2050,2060,2070,2080),]


#set infinite values to NA
rep_magpie[is.infinite(rep_magpie)] <- NA


#write report
write.report2(rep_magpie,file=path(outputdir,"sustag.csv"),scenario=title,model="MAgPIE",append=F)

print(paste0("Finished SUSTAg report for ",title))
print("---")
