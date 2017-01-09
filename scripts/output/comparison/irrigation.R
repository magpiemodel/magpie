# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

##########################################################
#### irrigation paper scenario comparison ####
##########################################################
# Version 1.0, Florian Humpen?der
#

library(lucode)
library(ludata)
library(luplot)
library(lusweave)
library(magpie)
library(ggplot2)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {  
  outputdirs <- "./output/static_irrigation_2012-09-07_12.17.06"
  latexpath <- NA              # Latexpath necessary if swclose is performed in the queue
  #Define arguments that can be read from command line
  readArgs("outputdirs","latexpath")
}
###############################################################################

bio_prod <- list()
bio_costs <- list()
total_costs <- list()
bio_prices <- list()
bio_yields_rf <- list()
bio_yields_ir <- list()
c_emissions <- list()
net_trade_kfo <- list()
water_kfo <- list()
water_kbe <- list()
water_prices <- list()
tc_rates <- list()
food_price_index <- list()
water_int_kfo <- list()
water_int_kbe <- list()
water_prod_kbe <- list()
water_prod_kfo <- list()
food_prod_ir <- list()
bio_prod_ir <- list()
bio_water_usage_shr <- list()

years2plot <- c("y1995", "y2005", "y2015", "y2025", "y2035", "y2045", "y2055", "y2065", "y2075", "y2085", "y2095")
years <- intersect(getYears(modelstat(path(outputdirs[1],"fulldata.gdx"))),years2plot)

print("Starting data preparation")
for (i in 1:length(outputdirs)) {
  #title of the run
  if(file.exists(path(outputdirs[i],"config.Rdata"))) {
    load(path(outputdirs[i],"config.Rdata"))
    title <- cfg$title
  } else {
    config <- grep("\\.cfg$",list.files(outputdirs[i]), value=TRUE)
    l<-readLines(path(outputdirs[i],config))
    title <- strsplit(grep("title +<-",l,value=TRUE),"\"")[[1]][2]
  }
  
  #gdx file
  gdx<-path(outputdirs[i],"fulldata.gdx")
  
  print("bio_prod")
  bio_prod[[title]] <- production(gdx,crops="kbe",water="sum",unit="EJ")[,years,]
  
  print("bio_costs")
  if(!is.null(readGDX(gdx,"o90_cost_reg", format="first_found", react="silent"))) {
    pre_costs <- readGDX(gdx,"o90_cost_reg", format="first_found")
    full_costs <- readGDX(gdx,"ov_cost_reg", format="first_found")[,,"level"]
    bio_costs[[title]] <- as.magpie(round(full_costs - pre_costs)/1000)
  }
  
  print("total_costs")
  total_costs[[title]] <- readGDX(gdx,"ov_cost_glo", format="first_found", select=list(type="level"))/1000
 
  print("bio_prices")
  bio_prices[[title]] <- prices(gdx,level="glo",crops="kbe",crop_aggr=T,unit="GJ")[,years,]
  
  print("bio_yields_rf")
  bio_yields_rf[[title]] <- yields(gdx,crops="begr",water="rf")[,years,]
  
  print("bio_yields_ir")
  bio_yields_ir[[title]] <- yields(gdx,crops="begr",water="ir")[,years,]
  
  print("water_bio_crops")
  water_kbe[[title]] <- as.magpie(water_usage(gdx,users="kbe",sum=T)[,years,]/1000)

  print("water_food_crops")
  water_kfo[[title]] <- as.magpie(water_usage(gdx,users="kfo",sum=T)[,years,]/1000)
  
  print("water_prices")
  water_prices[[title]] <- water_price(gdx)[,years,]
  
  print("net trade food crops")
  net_trade_kfo[[title]] <- as.magpie(dimSums(demand(gdx,commodities="kfo"),dims=3) - production(gdx,crops="kfo",water="sum"))[,years,]
  
  print("c_emissions")
  c_emissions[[title]] <- emissions(gdx,y1995=T)[,years[-1],]
  
  print("tc")
  tc_rates[[title]] <- tc(gdx)[,years[-1],]
  
  print("food_price_index")
  food_price_index[[title]] <- priceIndex(gdx)[,years,]
  
  print("food crop production")
  food_prod_ir[[title]] <- production(gdx,crops="kfo",water="ir",unit="EJ")[,years,]
  
  print("food crop production -ir")
  bio_prod_ir[[title]] <- production(gdx,crops="kbe",water="ir",unit="EJ")[,years,]
  
  print("water intensity")
  water_int_kfo[[title]] <- as.magpie(water_usage(gdx,users="kfo",sum=T)[,years,] / (production(gdx,crops="kfo",water="ir",unit="EJ")[,years,] * 1000))
  water_int_kbe[[title]] <- as.magpie(water_usage(gdx,users="kbe",sum=T)[,years,] / (production(gdx,crops="kbe",water="ir",unit="EJ")[,years,] * 1000))
  
  print("water productivity")
  water_prod_kfo[[title]] <- as.magpie((production(gdx,crops="kfo",water="ir",unit="EJ")[,years,] * 1000) / water_usage(gdx,users="kfo",sum=T)[,years,])
  water_prod_kbe[[title]] <- as.magpie((production(gdx,crops="kbe",water="ir",unit="EJ")[,years,] * 1000) / water_usage(gdx,users="kbe",sum=T)[,years,])
  
  print("bio_water_usage_shr")
  bio_water_usage_shr[[title]] <- as.magpie(water_usage(gdx,users="kbe",sum=T)/water_usage(gdx,users="agriculture",sum=T)*100)[,years,]  
  
}
print("Starting output generation")
sw<-swopen("./output/irrigation_comparison.pdf")
swlatex(sw,"\\huge")
swlatex(sw,"\\textbf{Irrigation comparison}\\newline")
swlatex(sw,"\\normalsize")
swlatex(sw,"\\newline")
swlatex(sw,"\\tableofcontents")

print("Bioenergy production")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Bioenergy production (kbe)}")
swfigure(sw,print,magpie2ggplot(data=bio_prod,ylab="EJ",text_size=16),sw_option="width=10")

print("Global total production costs")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Global total production costs}")
swfigure(sw,print,magpie2ggplot(data=total_costs,ylab="bil. US Dollar",text_size=16),sw_option="width=10")

print("Bioenergy costs")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Bioenergy costs}")
swfigure(sw,print,magpie2ggplot(data=bio_costs,ylab="bil. US Dollar",text_size=16),sw_option="width=10")

print("Bioenergy prices")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Bioenergy prices}")
swfigure(sw,print,magpie2ggplot(data=bio_prices,ylab="US$ / GJ",text_size=16),sw_option="width=10")

print("Food crop production -ir")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Food crop production irrigated (kfo)}")
swfigure(sw,print,magpie2ggplot(data=food_prod_ir,ylab="EJ",text_size=16),sw_option="width=10")

print("Bioenergy production - ir")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Bioenergy production irrigated (kbe)}")
swfigure(sw,print,magpie2ggplot(data=bio_prod_ir,ylab="EJ",text_size=16),sw_option="width=10")

print("Water usage food crops")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Water usage food crops (kfo)}")
swfigure(sw,print,magpie2ggplot(data=water_kfo,ylab="bil. cubic metre / yr",text_size=16),sw_option="width=10")

print("Water usage 2nd gen. bioenergy crops")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Water usage 2nd gen. bioenergy crops (kbe)}")
swfigure(sw,print,magpie2ggplot(data=water_kbe,ylab="bil. cubic metre / yr",text_size=16),sw_option="width=10")

print("Water intensity")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Water intensity of food crop production (kfo)}")
swfigure(sw,print,magpie2ggplot(data=water_int_kfo,ylab="cubic metre / GJ",text_size=16),sw_option="width=10")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Water intensity of 2nd gen. bioenergy production (kbe)}")
swfigure(sw,print,magpie2ggplot(data=water_int_kbe,ylab="cubic metre / GJ",text_size=16),sw_option="width=10")

print("Water productivity")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Water productivity in food crop production (kfo)}")
swfigure(sw,print,magpie2ggplot(data=water_prod_kfo,ylab="GJ / cubic metre",text_size=16),sw_option="width=10")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Water productivity in 2nd gen. bioenergy production (kbe)}")
swfigure(sw,print,magpie2ggplot(data=water_prod_kbe,ylab="GJ / cubic metre",text_size=16),sw_option="width=10")

print("Bioenergy water usage share")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Bioenergy water usage share}")
swlatex(sw,"Expressed in terms of total agricultural water usage")
swfigure(sw,print,magpie2ggplot(data=bio_water_usage_shr,ylab="%",text_size=16),sw_option="width=10")

print("Water shadow price")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Water shadow price}")
swfigure(sw,print,magpie2ggplot(data=water_prices,ylab="US$ / cubic metre",text_size=16),sw_option="width=10")

print("Net trade food crops")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Net trade food crops (kfo)}")
swlatex(sw,"Net trade = demand - production\\newline Net trade > 0: Import\\newline Net trade < 0: Export")
swfigure(sw,print,magpie2ggplot(data=net_trade_kfo,ylab="mil. tons DM",hline=0,text_size=16),sw_option="width=10")

print("Bioenergy yields - rf")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Bioenergy yields rainfed (begr)}")
swfigure(sw,print,magpie2ggplot(data=bio_yields_rf,ylab="t DM / ha",text_size=16),sw_option="width=10")

print("Bioenergy yields - ir")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Bioenergy yields irrigated (begr)}")
swfigure(sw,print,magpie2ggplot(data=bio_yields_ir,ylab="t DM / ha",text_size=16),sw_option="width=10")

print("TC")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{TC}")
swfigure(sw,print,magpie2ggplot(data=tc_rates,ylab="Annual TC rates",text_size=16),sw_option="width=10")

print("Emissions")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{C emissions}")
swfigure(sw,print,magpie2ggplot(data=c_emissions,ylab="Mt C",text_size=16),sw_option="width=10")

print("Food price index")
swlatex(sw,"\\newpage")
swlatex(sw,"\\section{Food Price Index (kfo)}")
swfigure(sw,print,magpie2ggplot(data=food_price_index,ylab="1995=100",text_size=16),sw_option="width=10")

if(!is.na(latexpath)){
  swclose(sw,latexpath=latexpath)
} else{
  swclose(sw)
}
