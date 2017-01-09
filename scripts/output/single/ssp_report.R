# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de


library(gdx)
library(magclass)
library(magpie)
library(lucode)
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  
  gdx    <-'fulldata.gdx' 
  output_folder        <- '/scratch/01/dklein/magpie_7702_1st/output/rem4850_SSP1-ref-mag-8/' 
  gdx<-path(output_folder,"fulldata.gdx")
  #setwd("/Users/flo/Documents/PIK/MAgPIE/6383")
  title <- "TEST" 
  
  #Define arguments that can be read from command line
  readArgs("gdx_file","output_folder","title")
} else{
  output_folder<-outputdir
  gdx<-path(outputdir,"fulldata.gdx")
}
print("---")
print(paste0("Starting SSP report for ",title))
###############################################################################

#function to generate SSP variables based on MIF variables
MIF2SSP <- function(x) {  
  x <- x[,-1,]
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
  new <- mbind(new,setNames(lowpass(x[,,"Emissions|CO2|Land Use (Mt CO2/yr)"],i=1,fix="start"),ssp_name))
  
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
  
  
  #Aerosols 
  ssp_name <- "Emissions|BC|Land Use|Agricultural Waste Burning (Mt BC/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|bc|Land Use|Agricultural Waste Burning (Tg bc/yr)"],ssp_name))   
  ssp_name <- "Emissions|BC|Land Use|Forest Burning (Mt BC/yr)"   
  new <- mbind(new,setNames(x[,,"Emissions|bc|Land Use|Forest Burning (Tg bc/yr)"],ssp_name))            
  ssp_name <- "Emissions|BC|Land Use|Savannah Burning (Mt BC/yr)"             
  new <- mbind(new,setNames(x[,,"Emissions|bc|Land Use|Savannah Burning (Tg bc/yr)"],ssp_name)) 
  
  ssp_name <- "Emissions|CO|Land Use|Agricultural Waste Burning (Mt CO/yr)" 
  new <- mbind(new,setNames(x[,,"Emissions|co|Land Use|Agricultural Waste Burning (Tg co/yr)"],ssp_name))       
  ssp_name <- "Emissions|CO|Land Use|Forest Burning (Mt CO/yr)"   
  new <- mbind(new,setNames(x[,,"Emissions|co|Land Use|Forest Burning (Tg co/yr)"],ssp_name))       
  ssp_name <- "Emissions|CO|Land Use|Savannah Burning (Mt CO/yr)"     
  new <- mbind(new,setNames(x[,,"Emissions|co|Land Use|Savannah Burning (Tg co/yr)"],ssp_name))        
  
  ssp_name <- "Emissions|NH3|Land Use|Agricultural Waste Burning (Mt NH3/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|nh3|Land Use|Agricultural Waste Burning (Tg nh3/yr)"],ssp_name))
  ssp_name <- "Emissions|NH3|Land Use|Agriculture (Mt NH3/yr)"           
  new <- mbind(new,setNames(x[,,"Emissions|nh3|Land Use|Agriculture (Tg nh3/yr)"],ssp_name))
  ssp_name <- "Emissions|NH3|Land Use|Forest Burning (Mt NH3/yr)"     
  new <- mbind(new,setNames(x[,,"Emissions|nh3|Land Use|Forest Burning (Tg nh3/yr)"],ssp_name))        
  ssp_name <- "Emissions|NH3|Land Use|Savannah Burning (Mt NH3/yr)"       
  new <- mbind(new,setNames(x[,,"Emissions|nh3|Land Use|Savannah Burning (Tg nh3/yr)"],ssp_name))
  
  ssp_name <- "Emissions|NOx|Land Use|Agricultural Waste Burning (Mt NOx/yr)" 
  new <- mbind(new,setNames(x[,,"Emissions|no2|Land Use|Agricultural Waste Burning (Tg no2/yr)"],ssp_name)) 
  ssp_name <- "Emissions|NOx|Land Use|Agriculture (Mt NOx/yr)"          
  new <- mbind(new,setNames(x[,,"Emissions|no2|Land Use|Agriculture (Tg no2/yr)"],ssp_name))       
  ssp_name <- "Emissions|NOx|Land Use|Forest Burning (Mt NOx/yr)"    
  new <- mbind(new,setNames(x[,,"Emissions|no2|Land Use|Forest Burning (Tg no2/yr)"],ssp_name))          
  ssp_name <- "Emissions|NOx|Land Use|Savannah Burning (Mt NOx/yr)"      
  new <- mbind(new,setNames(x[,,"Emissions|no2|Land Use|Savannah Burning (Tg no2/yr)"],ssp_name))        
  
  ssp_name <- "Emissions|OC|Land Use|Agricultural Waste Burning (Mt OC/yr)"  
  new <- mbind(new,setNames(x[,,"Emissions|oc|Land Use|Agricultural Waste Burning (Tg oc/yr)"],ssp_name))          
  ssp_name <- "Emissions|OC|Land Use|Forest Burning (Mt OC/yr)"   
  new <- mbind(new,setNames(x[,,"Emissions|oc|Land Use|Forest Burning (Tg oc/yr)"],ssp_name))              
  ssp_name <- "Emissions|OC|Land Use|Savannah Burning (Mt OC/yr)"       
  new <- mbind(new,setNames(x[,,"Emissions|oc|Land Use|Savannah Burning (Tg oc/yr)"],ssp_name))          
  
  ssp_name <- "Emissions|Sulfur|Land Use|Agricultural Waste Burning (Mt SO2/yr)"   
  new <- mbind(new,setNames(x[,,"Emissions|so2|Land Use|Agricultural Waste Burning (Tg so2/yr)"],ssp_name))     
  ssp_name <- "Emissions|Sulfur|Land Use|Forest Burning (Mt SO2/yr)" 
  new <- mbind(new,setNames(x[,,"Emissions|so2|Land Use|Forest Burning (Tg so2/yr)"],ssp_name))           
  ssp_name <- "Emissions|Sulfur|Land Use|Savannah Burning (Mt SO2/yr)"   
  new <- mbind(new,setNames(x[,,"Emissions|so2|Land Use|Savannah Burning (Tg so2/yr)"],ssp_name))      
  
  ssp_name <- "Emissions|VOC|Land Use|Agricultural Waste Burning (Mt VOC/yr)"  
  new <- mbind(new,setNames(x[,,"Emissions|nmhc|Land Use|Agricultural Waste Burning (Tg nmhc/yr)"],ssp_name)) 
  ssp_name <- "Emissions|VOC|Land Use|Forest Burning (Mt VOC/yr)"      
  new <- mbind(new,setNames(x[,,"Emissions|nmhc|Land Use|Forest Burning (Tg nmhc/yr)"],ssp_name))          
  ssp_name <- "Emissions|VOC|Land Use|Savannah Burning (Mt VOC/yr)"
  new <- mbind(new,setNames(x[,,"Emissions|nmhc|Land Use|Savannah Burning (Tg nmhc/yr)"],ssp_name)) 

  
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
  #  new <- mbind(new,x[,,c("Fertilizer Use|Phosphorus (Tg P/yr)")])
  
  #Food Demand (EJ/yr)
  ssp_name <- "Food Energy Supply (EJ/yr)"
  new <- mbind(new,setNames(x[,,"Food Energy Demand (EJ/yr)"],ssp_name))
  ssp_name <- "Food Energy Supply|Livestock (EJ/yr)"
  new <- mbind(new,setNames(x[,,"Food Energy Demand|Livestock (EJ/yr)"],ssp_name))
  
  #Food Demand (kcal/cap/day)
  new <- mbind(new,setNames((x[,,"Food Energy Demand (EJ/yr)"] / setNames(x[,,"Population (million cap)"],NULL)) * 10^9 * 1/4.1868 / 365.25,"Food Energy Supply|Per Capita (kcal/cap/day)"))
  new <- mbind(new,setNames((x[,,"Food Energy Demand|Livestock (EJ/yr)"] / setNames(x[,,"Population (million cap)"],NULL)) * 10^9 * 1/4.1868 / 365.25,"Food Energy Supply|Livestock|Per Capita (kcal/cap/day)"))
  new <- mbind(new,setNames(new[,,"Food Energy Supply|Per Capita (kcal/cap/day)"] - setNames(new[,,"Food Energy Supply|Livestock|Per Capita (kcal/cap/day)"],NULL),"Food Energy Supply|Crops|Per Capita (kcal/cap/day)"))
  
  #Agricultural Demand
  ssp_name <- "Agricultural Demand|Crops|Feed (million t DM/yr)"
  new <- mbind(new,setNames(x[,,"Agricultural Demand|Feed|Crops (million t DM/yr)"],ssp_name))
  ssp_name <- "Agricultural Demand|Livestock|Feed (million t DM/yr)"
  new <- mbind(new,setNames(x[,,"Agricultural Demand|Feed|Livestock (million t DM/yr)"],ssp_name))
  ssp_name <- "Agricultural Demand|Crops|Food (million t DM/yr)"
  new <- mbind(new,setNames(x[,,"Agricultural Demand|Food|Crops (million t DM/yr)"],ssp_name))
  ssp_name <- "Agricultural Demand|Livestock|Food (million t DM/yr)"
  new <- mbind(new,setNames(x[,,"Agricultural Demand|Food|Livestock (million t DM/yr)"],ssp_name))
  ssp_name <- "Agricultural Demand|Other (million t DM/yr)"
  new <- mbind(new,setNames(x[,,"Agricultural Demand|Non-Food (million t DM/yr)"],ssp_name))
  ssp_name <- "Agricultural Demand|Crops|Other (million t DM/yr)"
  new <- mbind(new,setNames(x[,,"Agricultural Demand|Non-Food|Crops (million t DM/yr)"],ssp_name))
  ssp_name <- "Agricultural Demand|Livestock|Other (million t DM/yr)"
  new <- mbind(new,setNames(x[,,"Agricultural Demand|Non-Food|Livestock (million t DM/yr)"],ssp_name))
  
  new <- mbind(new,x[,,c("Agricultural Demand (million t DM/yr)",
                         "Agricultural Demand|Food (million t DM/yr)",
                         "Agricultural Demand|Feed (million t DM/yr)",
                         "Agricultural Demand|Bioenergy (million t DM/yr)",
                         "Agricultural Demand|Bioenergy|1st generation (million t DM/yr)",
                         "Agricultural Demand|Bioenergy|2nd generation (million t DM/yr)")])
  
  #Agricultural Production
  ssp_name <- "Agricultural Production|Crops|Energy (million t DM/yr)"
  new <- mbind(new,setNames(x[,,"Agricultural Production|Energy Crops (million t DM/yr)"],ssp_name))
  ssp_name <- "Agricultural Production|Crops|Non-Energy (million t DM/yr)"
  new <- mbind(new,setNames(x[,,"Agricultural Production|Non-Energy Crops (million t DM/yr)"],ssp_name))
  ssp_name <- "Agricultural Production|Crops|Non-Energy|Cereals (million t DM/yr)"
  new <- mbind(new,setNames(x[,,"Agricultural Production|Non-Energy Crops|Cereals (million t DM/yr)"],ssp_name))
  
  new <- mbind(new,x[,,c("Agricultural Production (million t DM/yr)","Agricultural Production|Livestock (million t DM/yr)")])
  
  #ag. production costs presolve (not for reporting)
  new <- mbind(new,x[,,"Production Cost|Agriculture w/o Bioenergy (billion US$2005/yr)"])

  #MAC costs presolve (not for reporting)
  new <- mbind(new,x[,,"Production Cost|Agriculture w/o Bioenergy|Non-CO2 Emission Abatement (billion US$2005/yr)"])
  
  return(new)
}

emis_types <- matrix(NA,10,2)
emis_types[1,] <- c("CO2","(Mt CO2/yr)")
emis_types[2,] <- c("CH4","(Mt CH4/yr)")
emis_types[3,] <- c("N2O","(kt N2O/yr)")
emis_types[4,] <- c("BC","(Mt BC/yr)")
emis_types[5,] <- c("CO","(Mt CO/yr)")
emis_types[6,] <- c("NOx","(Mt NOx/yr)")
emis_types[7,] <- c("OC","(Mt OC/yr)")
emis_types[8,] <- c("Sulfur","(Mt SO2/yr)")
emis_types[9,] <- c("NH3","(Mt NH3/yr)")
emis_types[10,] <- c("VOC","(Mt VOC/yr)")

emis_cat <- c("Agricultural Waste Burning","Agriculture","Forest Burning","Savannah Burning")

#Get report from MAgPIE run
rep_magpie <- getReport(gdx,scenario=title)

#Convert report format from MAgPIE to REMIND
rep_magpie <- convert.report(rep_magpie,inmodel="MAgPIE",outmodel="REMIND")[[title]]$REMIND

#set JPN to 0, otherwise remind emissions for JPN get lost
rep_magpie["JPN",,] <- 0

#generate SSP variables based on MIF variables
rep_magpie <- MIF2SSP(rep_magpie)

#add emissions|land_use totals to rep_magpie
for (i in 1:length(emis_types[,1])) {
  top <- paste0("Emissions|",emis_types[i,1]," ",emis_types[i,2])
  sub <- paste0("Emissions|",emis_types[i,1],"|Land Use ",emis_types[i,2])
  subsub <- intersect(getNames(rep_magpie),paste0("Emissions|",emis_types[i,1],"|Land Use|",emis_cat," ",emis_types[i,2]))
  if (length(subsub) != 0) {
    rep_magpie <- mbind(rep_magpie,setNames(dimSums(rep_magpie[,,subsub],dim=3.1),sub))
    print(paste0("Added ",sub," to rep_magpie"))    
  }
}
#Report from remind
rep_remind <- read.report("output/full_ts10_in.mif")[[title]]$REMIND

# Subtract land-use emissions from emission totals in rep_remind and remove them
for (i in 1:length(emis_types[,1])) {
  top <- paste0("Emissions|",emis_types[i,1]," ",emis_types[i,2])
  sub <- paste0("Emissions|",emis_types[i,1],"|Land Use ",emis_types[i,2])
  if (length(intersect(getNames(rep_remind),top)) == 0) rep_remind <- mbind(rep_remind,new.magpie(getCells(rep_remind),getYears(rep_remind),top,0))
  if (length(intersect(getNames(rep_remind),sub)) == 0) rep_remind <- mbind(rep_remind,new.magpie(getCells(rep_remind),getYears(rep_remind),sub,0))
  del <- c(sub,grep(paste0("Emissions|",emis_types[i,1],"|Land Use|"),getNames(rep_remind),value=TRUE,fixed=TRUE))
  keep <- setdiff(getNames(rep_remind),del)
  rep_remind[,,top] <- rep_remind[,,top] - rep_remind[,,sub]
  print(paste0("Subtracted ",sub," from ",top))
  rep_remind <- rep_remind[,,keep]
  print(paste0("Removed ",del," from rep_remind"))
}

#Years in both datasets
years <- intersect(getYears(rep_remind),getYears(rep_magpie))
rep_remind <- rep_remind[,years,]
rep_magpie <- rep_magpie[,years,]

# #JUST for testing
# rep_remind <- mbind(rep_remind,setNames(rep_remind[,,"Consumption (billion US$2005/yr)"],"Consumption|Non-Agriculture (billion US$2005/yr)") - setNames(rep_magpie[,,"Production Cost|Agriculture w/o Bioenergy (billion US$2005/yr)"],"Consumption|Non-Agriculture (billion US$2005/yr)"))
# print("Added Consumption|Non-Agriculture (billion US$2005/yr)")

#subtract mac costs from ReMIND consumption
rep_remind[,,"Consumption (billion US$2005/yr)"] <- rep_remind[,,"Consumption (billion US$2005/yr)"] - setNames(rep_magpie[,,"Production Cost|Agriculture w/o Bioenergy|Non-CO2 Emission Abatement (billion US$2005/yr)"],"Consumption (billion US$2005/yr)")
print("Subtracted Production Cost|Agriculture w/o Bioenergy|Non-CO2 Emission Abatement (billion US$2005/yr) (MAgPIE) from Consumption (REMIND)")
  
#rep_magpie <- rep_magpie[,,setdiff(getNames(rep_magpie),c("Production Cost|Agriculture w/o Bioenergy|Non-CO2 Emission Abatement (billion US$2005/yr)","Production Cost|Agriculture w/o Bioenergy (billion US$2005/yr)"))]

#Combine data sets
rep_out <- mbind(rep_remind,rep_magpie)
print("Combined REMIND and MAgPIE Datasets")

#recalculate emission totals in rep_out
for (i in 1:length(emis_types[,1])) {
  top <- paste0("Emissions|",emis_types[i,1]," ",emis_types[i,2])
  sub <- paste0("Emissions|",emis_types[i,1],"|Land Use ",emis_types[i,2])
  rep_out[,,top] <- rep_out[,,top] + setNames(rep_out[,,sub],top)
  print(paste0("Recalculated ",top," in rep_out"))
}

save(rep_magpie,rep_out, file = "output/ssp.RData")


### Add agmip variables

source("scripts/output/single/agmip.R")
agmip_report_out <- agmip_report_out[,getYears(rep_magpie),]
save(rep_magpie,rep_out,agmip_report_out, file = "output/ssp.RData")
x <- new.magpie(cells_and_regions = getCells(rep_magpie),years = getYears(rep_magpie),names = getNames(agmip_report_out),fill = NA)
x["AFR",,] <- setCells(agmip_report_out["AFR",,],"AFR")
x["CHN",,] <- setCells(agmip_report_out["CPA",,],"CHN")
x["EUR",,] <- setCells(agmip_report_out["EUR",,],"EUR")
x["IND",,] <- setCells(agmip_report_out["SAS",,],"IND")
x["JPN",,] <- NA
x["LAM",,] <- setCells(agmip_report_out["LAM",,],"LAM")
x["MEA",,] <- setCells(agmip_report_out["MEA",,],"MEA")
x["OAS",,] <- setCells(agmip_report_out["PAS",,],"OAS")
x["ROW",,] <- setCells(agmip_report_out["PAO",,],"ROW")
x["RUS",,] <- setCells(agmip_report_out["FSU",,],"RUS")
x["USA",,] <- setCells(agmip_report_out["NAM",,],"USA")
x["GLO",,] <- setCells(agmip_report_out["GLO",,],"GLO")

new <- NULL

ssp_name <- "AGMIP|PAS|Area (1000 ha)"
new <- mbind(new,setNames(x[,,"AREA.PAS"],ssp_name))
ssp_name <- "AGMIP|PAS|Prod (1000 t)"
new <- mbind(new,setNames(x[,,"PROD.PAS"],ssp_name))
ssp_name <- "AGMIP|PAS|CONS (1000 t)"
new <- mbind(new,setNames(x[,,"CONS.PAS"],ssp_name))
ssp_name <- "AGMIP|PAS|YILD (t/ha)"
new <- mbind(new,setNames(x[,,"YILD.PAS"],ssp_name))

ssp_name <- "AGMIP|ALL|CALO (kcal/cap/day)"
new <- mbind(new,setNames(x[,,"CALO.ALL"],ssp_name))
ssp_name <- "AGMIP|ALL|GDPT (billion US$2005)"
new <- mbind(new,setNames(x[,,"GDPT.ALL"],ssp_name))
ssp_name <- "AGMIP|ALL|POPT (million)"
new <- mbind(new,setNames(x[,,"POPT.ALL"],ssp_name))

ssp_name <- "AGMIP|WHT|Area (1000 ha)"
new <- mbind(new,setNames(x[,,"AREA.WHT"],ssp_name))
ssp_name <- "AGMIP|WHT|Prod (1000 t)"
new <- mbind(new,setNames(x[,,"PROD.WHT"],ssp_name))
ssp_name <- "AGMIP|WHT|Feed (1000 t)"
new <- mbind(new,setNames(x[,,"FEED.WHT"],ssp_name))
ssp_name <- "AGMIP|WHT|food (1000 t)"
new <- mbind(new,setNames(x[,,"FOOD.WHT"],ssp_name))
ssp_name <- "AGMIP|WHT|XPRP (index (2005 = 1))"
new <- mbind(new,setNames(x[,,"XPRP.WHT"],ssp_name))
ssp_name <- "AGMIP|WHT|CONS (1000 t)"
new <- mbind(new,setNames(x[,,"CONS.WHT"],ssp_name))
ssp_name <- "AGMIP|WHT|OTHU (1000 t)"
new <- mbind(new,setNames(x[,,"OTHU.WHT"],ssp_name))
ssp_name <- "AGMIP|WHT|YILD (t/ha)"
new <- mbind(new,setNames(x[,,"YILD.WHT"],ssp_name))
ssp_name <- "AGMIP|WHT|BFSH (Percentage (1=1%))"
new <- mbind(new,setNames(x[,,"BFSH.WHT"],ssp_name))

ssp_name <- "AGMIP|CGR|Area (1000 ha)"
new <- mbind(new,setNames(x[,,"AREA.CGR"],ssp_name))
ssp_name <- "AGMIP|CGR|Prod (1000 t)"
new <- mbind(new,setNames(x[,,"PROD.CGR"],ssp_name))
ssp_name <- "AGMIP|CGR|Feed (1000 t)"
new <- mbind(new,setNames(x[,,"FEED.CGR"],ssp_name))
ssp_name <- "AGMIP|CGR|food (1000 t)"
new <- mbind(new,setNames(x[,,"FOOD.CGR"],ssp_name))
ssp_name <- "AGMIP|CGR|XPRP (index (2005 = 1))"
new <- mbind(new,setNames(x[,,"XPRP.CGR"],ssp_name))
ssp_name <- "AGMIP|CGR|CONS (1000 t)"
new <- mbind(new,setNames(x[,,"CONS.CGR"],ssp_name))
ssp_name <- "AGMIP|CGR|OTHU (1000 t)"
new <- mbind(new,setNames(x[,,"OTHU.CGR"],ssp_name))
ssp_name <- "AGMIP|CGR|YILD (t/ha)"
new <- mbind(new,setNames(x[,,"YILD.CGR"],ssp_name))
ssp_name <- "AGMIP|CGR|BFSH (Percentage (1=1%))"
new <- mbind(new,setNames(x[,,"BFSH.CGR"],ssp_name))

ssp_name <- "AGMIP|RIC|Area (1000 ha)"
new <- mbind(new,setNames(x[,,"AREA.RIC"],ssp_name))
ssp_name <- "AGMIP|RIC|Prod (1000 t)"
new <- mbind(new,setNames(x[,,"PROD.RIC"],ssp_name))
ssp_name <- "AGMIP|RIC|Feed (1000 t)"
new <- mbind(new,setNames(x[,,"FEED.RIC"],ssp_name))
ssp_name <- "AGMIP|RIC|food (1000 t)"
new <- mbind(new,setNames(x[,,"FOOD.RIC"],ssp_name))
ssp_name <- "AGMIP|RIC|XPRP (index (2005 = 1))"
new <- mbind(new,setNames(x[,,"XPRP.RIC"],ssp_name))
ssp_name <- "AGMIP|RIC|CONS (1000 t)"
new <- mbind(new,setNames(x[,,"CONS.RIC"],ssp_name))
ssp_name <- "AGMIP|RIC|OTHU (1000 t)"
new <- mbind(new,setNames(x[,,"OTHU.RIC"],ssp_name))
ssp_name <- "AGMIP|RIC|YILD (t/ha)"
new <- mbind(new,setNames(x[,,"YILD.RIC"],ssp_name))
ssp_name <- "AGMIP|RIC|BFSH (Percentage (1=1%))"
new <- mbind(new,setNames(x[,,"BFSH.RIC"],ssp_name))

ssp_name <- "AGMIP|OSD|Area (1000 ha)"
new <- mbind(new,setNames(x[,,"AREA.OSD"],ssp_name))
ssp_name <- "AGMIP|OSD|Prod (1000 t)"
new <- mbind(new,setNames(x[,,"PROD.OSD"],ssp_name))
ssp_name <- "AGMIP|OSD|Feed (1000 t)"
new <- mbind(new,setNames(x[,,"FEED.OSD"],ssp_name))
ssp_name <- "AGMIP|OSD|food (1000 t)"
new <- mbind(new,setNames(x[,,"FOOD.OSD"],ssp_name))
ssp_name <- "AGMIP|OSD|XPRP (index (2005 = 1))"
new <- mbind(new,setNames(x[,,"XPRP.OSD"],ssp_name))
ssp_name <- "AGMIP|OSD|CONS (1000 t)"
new <- mbind(new,setNames(x[,,"CONS.OSD"],ssp_name))
ssp_name <- "AGMIP|OSD|OTHU (1000 t)"
new <- mbind(new,setNames(x[,,"OTHU.OSD"],ssp_name))
ssp_name <- "AGMIP|OSD|YILD (t/ha)"
new <- mbind(new,setNames(x[,,"YILD.OSD"],ssp_name))
ssp_name <- "AGMIP|OSD|BFSH (Percentage (1=1%))"
new <- mbind(new,setNames(x[,,"BFSH.OSD"],ssp_name))

ssp_name <- "AGMIP|SUG|Area (1000 ha)"
new <- mbind(new,setNames(x[,,"AREA.SUG"],ssp_name))
ssp_name <- "AGMIP|SUG|Prod (1000 t)"
new <- mbind(new,setNames(x[,,"PROD.SUG"],ssp_name))
ssp_name <- "AGMIP|SUG|Feed (1000 t)"
new <- mbind(new,setNames(x[,,"FEED.SUG"],ssp_name))
ssp_name <- "AGMIP|SUG|food (1000 t)"
new <- mbind(new,setNames(x[,,"FOOD.SUG"],ssp_name))
ssp_name <- "AGMIP|SUG|XPRP (index (2005 = 1))"
new <- mbind(new,setNames(x[,,"XPRP.SUG"],ssp_name))
ssp_name <- "AGMIP|SUG|CONS (1000 t)"
new <- mbind(new,setNames(x[,,"CONS.SUG"],ssp_name))
ssp_name <- "AGMIP|SUG|OTHU (1000 t)"
new <- mbind(new,setNames(x[,,"OTHU.SUG"],ssp_name))
ssp_name <- "AGMIP|SUG|YILD (t/ha)"
new <- mbind(new,setNames(x[,,"YILD.SUG"],ssp_name))
ssp_name <- "AGMIP|SUG|BFSH (Percentage (1=1%))"
new <- mbind(new,setNames(x[,,"BFSH.SUG"],ssp_name))

ssp_name <- "AGMIP|RUM|Prod (1000 t)"
new <- mbind(new,setNames(x[,,"PROD.RUM"],ssp_name))
ssp_name <- "AGMIP|RUM|food (1000 t)"
new <- mbind(new,setNames(x[,,"FOOD.RUM"],ssp_name))
ssp_name <- "AGMIP|RUM|XPRP (index (2005 = 1))"
new <- mbind(new,setNames(x[,,"XPRP.RUM"],ssp_name))
ssp_name <- "AGMIP|RUM|CONS (1000 t)"
new <- mbind(new,setNames(x[,,"CONS.RUM"],ssp_name))
ssp_name <- "AGMIP|RUM|OTHU (1000 t)"
new <- mbind(new,setNames(x[,,"OTHU.RUM"],ssp_name))

ssp_name <- "AGMIP|NRM|Prod (1000 t)"
new <- mbind(new,setNames(x[,,"PROD.NRM"],ssp_name))
ssp_name <- "AGMIP|NRM|food (1000 t)"
new <- mbind(new,setNames(x[,,"FOOD.NRM"],ssp_name))
ssp_name <- "AGMIP|NRM|XPRP (index (2005 = 1))"
new <- mbind(new,setNames(x[,,"XPRP.NRM"],ssp_name))
ssp_name <- "AGMIP|NRM|CONS (1000 t)"
new <- mbind(new,setNames(x[,,"CONS.NRM"],ssp_name))
ssp_name <- "AGMIP|NRM|OTHU (1000 t)"
new <- mbind(new,setNames(x[,,"OTHU.NRM"],ssp_name))

ssp_name <- "AGMIP|DRY|Prod (1000 t)"
new <- mbind(new,setNames(x[,,"PROD.DRY"],ssp_name))
ssp_name <- "AGMIP|DRY|food (1000 t)"
new <- mbind(new,setNames(x[,,"FOOD.DRY"],ssp_name))
ssp_name <- "AGMIP|DRY|XPRP (index (2005 = 1))"
new <- mbind(new,setNames(x[,,"XPRP.DRY"],ssp_name))
ssp_name <- "AGMIP|DRY|CONS (1000 t)"
new <- mbind(new,setNames(x[,,"CONS.DRY"],ssp_name))
ssp_name <- "AGMIP|DRY|OTHU (1000 t)"
new <- mbind(new,setNames(x[,,"OTHU.DRY"],ssp_name))

ssp_name <- "AGMIP|CR5|Area (1000 ha)"
new <- mbind(new,setNames(x[,,"AREA.CR5"],ssp_name))
ssp_name <- "AGMIP|CR5|Prod (1000 t)"
new <- mbind(new,setNames(x[,,"PROD.CR5"],ssp_name))
ssp_name <- "AGMIP|CR5|Feed (1000 t)"
new <- mbind(new,setNames(x[,,"FEED.CR5"],ssp_name))
ssp_name <- "AGMIP|CR5|food (1000 t)"
new <- mbind(new,setNames(x[,,"FOOD.CR5"],ssp_name))
ssp_name <- "AGMIP|CR5|XPRP (index (2005 = 1))"
new <- mbind(new,setNames(x[,,"XPRP.CR5"],ssp_name))
ssp_name <- "AGMIP|CR5|CONS (1000 t)"
new <- mbind(new,setNames(x[,,"CONS.CR5"],ssp_name))
ssp_name <- "AGMIP|CR5|OTHU (1000 t)"
new <- mbind(new,setNames(x[,,"OTHU.CR5"],ssp_name))
ssp_name <- "AGMIP|CR5|YILD (t/ha)"
new <- mbind(new,setNames(x[,,"YILD.CR5"],ssp_name))
ssp_name <- "AGMIP|CR5|BFSH (Percentage (1=1%))"
new <- mbind(new,setNames(x[,,"BFSH.CR5"],ssp_name))

ssp_name <- "AGMIP|CRP|Area (1000 ha)"
new <- mbind(new,setNames(x[,,"AREA.CRP"],ssp_name))
ssp_name <- "AGMIP|CRP|Prod (1000 t)"
new <- mbind(new,setNames(x[,,"PROD.CRP"],ssp_name))
ssp_name <- "AGMIP|CRP|Feed (1000 t)"
new <- mbind(new,setNames(x[,,"FEED.CRP"],ssp_name))
ssp_name <- "AGMIP|CRP|food (1000 t)"
new <- mbind(new,setNames(x[,,"FOOD.CRP"],ssp_name))
ssp_name <- "AGMIP|CRP|XPRP (index (2005 = 1))"
new <- mbind(new,setNames(x[,,"XPRP.CRP"],ssp_name))
ssp_name <- "AGMIP|CRP|CONS (1000 t)"
new <- mbind(new,setNames(x[,,"CONS.CRP"],ssp_name))
ssp_name <- "AGMIP|CRP|OTHU (1000 t)"
new <- mbind(new,setNames(x[,,"OTHU.CRP"],ssp_name))
ssp_name <- "AGMIP|CRP|YILD (t/ha)"
new <- mbind(new,setNames(x[,,"YILD.CRP"],ssp_name))
ssp_name <- "AGMIP|CRP|BFSH (Percentage (1=1%))"
new <- mbind(new,setNames(x[,,"BFSH.CRP"],ssp_name))

ssp_name <- "AGMIP|AGR|Area (1000 ha)"
new <- mbind(new,setNames(x[,,"AREA.AGR"],ssp_name))
ssp_name <- "AGMIP|AGR|Prod (1000 t)"
new <- mbind(new,setNames(x[,,"PROD.AGR"],ssp_name))
ssp_name <- "AGMIP|AGR|Feed (1000 t)"
new <- mbind(new,setNames(x[,,"FEED.AGR"],ssp_name))
ssp_name <- "AGMIP|AGR|food (1000 t)"
new <- mbind(new,setNames(x[,,"FOOD.AGR"],ssp_name))
ssp_name <- "AGMIP|AGR|XPRP (index (2005 = 1))"
new <- mbind(new,setNames(x[,,"XPRP.AGR"],ssp_name))
ssp_name <- "AGMIP|AGR|CONS (1000 t)"
new <- mbind(new,setNames(x[,,"CONS.AGR"],ssp_name))
ssp_name <- "AGMIP|AGR|OTHU (1000 t)"
new <- mbind(new,setNames(x[,,"OTHU.AGR"],ssp_name))
ssp_name <- "AGMIP|AGR|YILD (t/ha)"
new <- mbind(new,setNames(x[,,"YILD.AGR"],ssp_name))
ssp_name <- "AGMIP|AGR|BFSH (Percentage (1=1%))"
new <- mbind(new,setNames(x[,,"BFSH.AGR"],ssp_name))

rep_out <- mbind(rep_out,new)
print("Added AGMIP variables")

#set infinite values to NA
rep_out[is.infinite(rep_out)] <- NA

save(rep_magpie,rep_out,agmip_report_out, file = "output/ssp.RData")

#write report
#write.report(rep_out,file=path(output_folder,paste("report_out_",title,".mif",sep="")),scenario=title)
write.report(rep_out,file=path("output/full_ts10_out.mif"),scenario=title,model="REMIND-MAGPIE",append=TRUE)

print(paste0("Finished SSP report for ",title))
print("---")
