### calcNPI  
## calculates input for MAgPIE NPI runs based on MAgPIE BAU runs and NPI documents

library(magpie4)
#library(lucode)
library(madrat)
library(luscale)
source("calcFunctions.R")

### base_run directory
base_run <- "base_run"

#low_res
res  <- get_info(paste0(base_run,"/info.txt"),"^\\* Output ?resolution:",": ")

#spatial_header
load(paste0(base_run,"/spatial_header.rda"))

#read in dummy files
ad_pol <- read.magpie("input/indc_ad_pol_0.5.mz")
aff_pol <- read.magpie("input/indc_aff_pol_0.5.mz")
emis_pol <- read.magpie("input/indc_emis_pol_0.5.mz")
getCells(ad_pol) <- spatial_header
getCells(aff_pol) <- spatial_header
getCells(emis_pol) <- spatial_header

### Read in data from MAgPIE BAU run (0.5 degree)
gdx <- paste0(base_run, "/fulldata.gdx")
y <- getYears(land(gdx),as.integer = TRUE)
im_years <- c(0,diff(y))
names(im_years) <- y
im_years <- as.magpie(im_years)

#read in land cover (stock) from BAU
magpie_bau_land <- read.magpie(paste0(base_run,"/cell.land_0.5.mz"))[,-1,]
#add country mapping
getCells(magpie_bau_land) <- mapping$celliso

#calc deforestation rate (flow)
magpie_bau_forest <- dimSums(magpie_bau_land[,,c("primforest","secdforest")],dim=3)
getCells(magpie_bau_forest) <- mapping$celliso

#read in forest carbon stock
#magpie_bau_cstock <- dimSums(readGDX(gdx,"ov_carbon_stock",select=list(type="level"))[,,c("primforest","secdforest")],dim=3)
#magpie_bau_cstock <- speed_aggregate(magpie_bau_cstock, rel=paste0(base_run,"/0.5-to-",res,"_area_weighted_mean.spam"))
magpie_bau_cstock <- magpie_bau_forest
magpie_bau_cstock[,,] <- 0
getCells(magpie_bau_cstock) <- mapping$celliso


### create NPI input files

## BEGIN reduce deforestation
## minimum forest stock based on NPI documents

#create npi_pol_deforest object
npi_pol_deforest <- create_indc()

#set reduction targets at country level
#percentage: 0 = no reduction, 1 = full reduction of deforestation 

#Australia
npi_pol_deforest["AUS",1,] <- c(1,1,2010,2010,1) #increase 20,000 hectares afforestation by 2020 -> zero deforestation 
#Brazil 
npi_pol_deforest["BRA",1,] <- c(1,1,2005,2030,1) #Reforestation of 12 mn ha by 2030 -> zero deforestation 
#China
npi_pol_deforest["CHN",1,] <- c(1,2,2005,2005,1) #23.04% forest coverage by 2020 -> assume no deforestation
#India
npi_pol_deforest["IND",1,] <- c(1,2,2005,2005,1) #+ 5 million ha (2005-2030) -> assume no deforestation
#Mexico
# tmp <- dimSums(magpie_bau_emis["MEX",2020,], dim=1)*44/12
npi_pol_deforest["MEX",1,] <- c(1,1,2005,2030,1) # 8.75 MtCO2e reduction in 2018 below BAU from deforestation and forest degradation --> 0

#Calc minimum forest stock in NPI scenario; result is in 0.5 degree resolution; Unit is Mha
ad_pol_npi <- calc_indc(npi_pol_deforest,magpie_bau_forest,affore=FALSE,im_years=im_years)
ad_pol[,getYears(ad_pol_npi),"npi"] <- ad_pol_npi

## END reduce deforestation


## BEGIN afforestation
## minimum forestry stock based on NPI documents

#create npi_pol_afforest object
npi_pol_afforest <- create_indc()

#set afforestation targets at country level in Mha

#Australia
npi_pol_afforest["AUS",1,] <- c(1,1,2010,2020,0.02) #20,000 hectares afforestation by 2020
#Brazil
npi_pol_afforest["BRA",1,] <- c(1,1,2005,2030,12) #Reforestation of 12 mn ha by 2030
#China
tmp <- dimSums(magpie_bau_land["CHN",2005,],dim=c(1,3))*0.2304 - dimSums(magpie_bau_land["CHN",2005,c("primforest","secdforest","forestry")],dim=c(1,3))
tmp[tmp<0] <- 0
npi_pol_afforest["CHN",1,] <- c(1,1,2005,2020,tmp) #23.04% forest coverage by 2020 --> 50 Mha afforestation is needed
#India
npi_pol_afforest["IND",1,] <- c(1,1,2005,2030,5) #Forest coverage (area) | Increase	5.00E+06	ha	from 2005 to 2030


# Calc minimum forestry stock in NPI scenario; result is in 0.5 degree resolution; Unit is Mha
aff_pol_npi <- calc_indc(npi_pol_afforest,magpie_bau_land,affore=TRUE,im_years=im_years)
aff_pol[,getYears(aff_pol_npi),"npi"] <- aff_pol_npi

## END afforestation

## BEGIN LUC CO2 emission reduction
## minimum carbon stock based on NPI documents

#create npi_pol_emis object
npi_pol_emis <- create_indc()

#set reduction targets at country level
#percentage: 0 = no reduction, 1 = full reduction of LUC emissions 
#Japan
npi_pol_emis["JPN",,] <- c(1,1,2005,2020,0.028)
#EU28 economy-wide target: 20% reduction by 2020 compared to 1990
npi_pol_emis["AUT",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["BEL",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["BGR",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["HRV",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["CYP",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["CZE",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["DNK",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["EST",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["FIN",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["FRA",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["DEU",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["GRC",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["HUN",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["IRL",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["ITA",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["LVA",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["LTU",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["LUX",,] <- c(1,1,2005,2020,0.2)
#npi_pol_emis["MLT",,] <- c(1,1,2005,2020,0.2) - doesnt't exist in MAgPIE country set
npi_pol_emis["NLD",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["POL",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["PRT",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["ROU",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["SVK",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["SVN",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["ESP",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["SWE",,] <- c(1,1,2005,2020,0.2)
npi_pol_emis["GBR",,] <- c(1,1,2005,2020,0.2)

# Calc minimum carbon stock in NPI scenario; result is in 0.5 degree resolution; Unit is MtC
emis_pol_npi <- calc_indc(npi_pol_emis,magpie_bau_cstock,affore=FALSE,im_years=im_years)
emis_pol[,getYears(emis_pol_npi),"npi"] <- emis_pol_npi

## END LUC CO2 emission reduction

### END create NPI input files


#--------------------------------#


### create INDC input files

## BEGIN reduce deforestation
## minimum forest stock based on INDC documents

#create indc_pol_deforest object
indc_pol_deforest <- create_indc()

#set reduction targets at country level
#percentage: 0 = no reduction, 1 = full reduction of deforestation 

#Australia
indc_pol_deforest["AUS",,] <- c(1,1,2010,2010,1) #increase 20,000 hectares afforestation by 2020 -> zero deforestation 
#Brazil
indc_pol_deforest["BRA",,] <- c(1,1,2005,2030,1) #zero illegal deforestation in 2030
#China
indc_pol_deforest["CHN",,] <- c(1,2,2005,2005,1) #23.04% forest coverage by 2020 -> assume no deforestation
#India
indc_pol_deforest["IND",,] <- c(1,2,2005,2005,1) #long term goal is to bring 33% of its geographical area under forest cover eventually -> assume no deforestation
#Mexico
indc_pol_deforest["MEX",,] <- c(1,1,2005,2030,1) #phase-out deforestation by 2030
#Cambodia
indc_pol_deforest["KHM",,] <- c(1,2,2005,2005,1) #increasse forest cover to 60% of national land area by 2030 and maintain afterwards -> assume no deforestation
#Chile
indc_pol_deforest["CHL",,] <- c(1,2,2005,2005,1) #reforest 100,000 hectares by 2030 -> assume no deforestation
#Ecuador
indc_pol_deforest["ECU",,] <- c(1,2,2005,2005,1) #restore 500,000 additional hectares until 2017 and increase this total by 100,000 hectares per year until 2025 -> assume no deforestation
#Guyana, extremely low historic deforestation rates (0.06%)
#Lao People's Democratic Republic
indc_pol_deforest["LAO",,] <- c(1,2,2005,2005,1) #increasing forest cover to a total of 70% of land area by 2020, and maintaining it at that level going forward -> assume no deforestation
#Mali?

#Calc minimum forest stock in indc scenario; result is in 0.5 degree resolution; Unit is Mha
ad_pol_indc <- calc_indc(indc_pol_deforest,magpie_bau_forest,affore=FALSE, im_years=im_years)
ad_pol[,getYears(ad_pol_indc),"indc"] <- ad_pol_indc

#Set all values before 2015 to NPI values; copy the values til 2010 from the NPI data
ad_pol[,c(1995,2005,2010),"indc"] <- ad_pol[,c(1995,2005,2010),"npi"]

## END reduce deforestation


## BEGIN afforestation
## minimum forestry stock based on INDC documents

#create indc_pol_afforest object
indc_pol_afforest <- create_indc()

#Australia
indc_pol_afforest["AUS",1,] <- c(1,1,2010,2020,0.02) #20,000 hectares afforestation by 2020
#Brazil
indc_pol_afforest["BRA",1,] <- c(1,1,2005,2030,12) #Reforestation of 12 mn ha by 2030
#China
tmp <- dimSums(magpie_bau_land["CHN",2005,],dim=c(1,3))*0.2304 - dimSums(magpie_bau_land["CHN",2005,c("primforest","secdforest","forestry")],dim=c(1,3))
tmp[tmp<0] <- 0
indc_pol_afforest["CHN",,] <- c(1,1,2005,2020,tmp) #23.04% forest coverage by 2020 --> 50 Mha afforestation is needed
#India
tmp <- dimSums(magpie_bau_land["IND",2005,],dim=c(1,3))*0.33 - dimSums(magpie_bau_land["IND",2005,c("primforest","secdforest","forestry")],dim=c(1,3))
tmp[tmp<0] <- 0
indc_pol_afforest["IND",,] <- c(1,1,2005,2030,tmp) #long term goal (2030) is to bring 33% of its geographical area under forest cover eventually -> 41 Mha
#Cambodia
tmp <- dimSums(magpie_bau_land["KHM",2005,],dim=c(1,3))*0.6 - dimSums(magpie_bau_land["KHM",2005,c("primforest","secdforest","forestry")],dim=c(1,3))
tmp[tmp<0] <- 0
indc_pol_afforest["KHM",,] <- c(1,1,2005,2030,tmp) #increasse forest cover to 60% of national land area by 2030 and maintain afterwards -> add 1.8 Mha by 2030
#Chile
indc_pol_afforest["CHL",,] <- c(1,1,2005,2030,0.1) #reforest 100,000 hectares by 2030
#Ecuador
indc_pol_afforest["ECU",,] <- c(1,1,2005,2025,1.3) #restore 500,000 additional hectares until 2017 and increase this total by 100,000 hectares per year until 2025
#Lao People's Democratic Republic
tmp <- dimSums(magpie_bau_land["LAO",2005,],dim=c(1,3))*0.7 - dimSums(magpie_bau_land["LAO",2005,c("primforest","secdforest","forestry")],dim=c(1,3))
tmp[tmp<0] <- 0
indc_pol_afforest["LAO",,] <- c(1,1,2005,2020,tmp) #increasing forest cover to a total of 70% of land area by 2020, and maintaining it at that level going forward.

# Calc minimum forestry stock in indc scenario; result is in 0.5 degree resolution; Unit is Mha
aff_pol_indc <- calc_indc(indc_pol_afforest,magpie_bau_land,affore=TRUE, im_years=im_years)
aff_pol[,getYears(aff_pol_indc),"indc"] <- aff_pol_indc

#Set all values before 2015 to NPI values; copy the values til 2010 from the NPI data
aff_pol[,c(1995,2005,2010),"indc"] <- aff_pol[,c(1995,2005,2010),"npi"]

## END afforestation

## BEGIN LUC CO2 emission reduction
## minimum carbon stock based on INDC documents

#create indc_pol_emis object
indc_pol_emis <- create_indc()

#set reduction targets at country level
#percentage: 0 = no reduction, 1 = full reduction of LUC emissions 

#Argentina
indc_pol_emis["ARG",,] <- c(1,2,2005,2030,0.15) #economy-wide target: 15% reduction by 2030 compared to BAU
#Angola
indc_pol_emis["AGO",,] <- c(1,2,2005,2030,0.35) #economy-wide target: 35% reduction by 2030 compared to BAU
#Australia
# indc_pol_emis["AUS",,] <- c(1,1,2005,2030,0.26) #economy-wide target: 26% reduction by 2030 compared to 2005
#Benin
indc_pol_emis["BEN",,] <- c(1,2,2005,2030,0.07) #economy-wide target: 7% reduction by 2030 compared to BAU
#Brazil
# indc_pol_emis["BRA",,] <- c(1,1,2005,2030,0.37) #economy-wide target: 37% reduction by 2030 compared to 2005
#Cambodia, LULUCF not included in economy-wide target
#Canada
indc_pol_emis["CAN",,] <- c(1,1,2005,2030,0.3) #economy-wide target: 30% reduction by 2030 compared to 2005
#Central African Republic
indc_pol_emis["CAF",,] <- c(1,2,2005,2030,0.03) #economy-wide target: 3% reduction by 2030 compared to BAU
#Chad
indc_pol_emis["TCD",,] <- c(1,2,2005,2030,0.18) #economy-wide target: 18% reduction by 2030 compared to BAU
#Chile, LULUCF not included in economy-wide target
#China
#indc_pol_emis["CHN",,] <- c(1,2,2005,2005,1) #economy-wide target: 60-65% CO2 emission intensity reduction -> limit CO2 emissions to BAU scenario
#Colombia
indc_pol_emis["COL",,] <- c(1,2,2005,2030,0.2) #economy-wide target: 20% reduction by 2030 compared to BAU
#Congo
indc_pol_emis["COG",,] <- c(1,2,2005,2030,0.48) #economy-wide target: 48% reduction by 2025/2035 compared to BAU
#Democratic Republic of Congo
indc_pol_emis["COD",,] <- c(1,2,2005,2030,0.17) #economy-wide target: 48% reduction by 2025/2035 compared to BAU
#Ecuador, LULUCF not included in economy-wide target
#Ethiopia
indc_pol_emis["ETH",,] <- c(1,2,2005,2030,0.64) #economy-wide target: 64% reduction by 2030 compared to BAU
#Gabon
indc_pol_emis["GAB",,] <- c(1,2,2005,2025,0.62) #economy-wide target: 62% reduction by 2025 compared to BAU
#Ghana
indc_pol_emis["GHA",,] <- c(1,2,2005,2030,0.15) #economy-wide target: 15% reduction by 2030 compared to BAU
#India
#indc_pol_emis["IND",,] <- c(1,2,2005,2005,1) #economy-wide target: 33-35% CO2 emission intensity reduction -> limit CO2 emissions to BAU scenario
#Indonesia
indc_pol_emis["IDN",,] <- c(1,2,2005,2030,0.29) #economy-wide target: 29% reduction by 2030 compared to BAU
#Japan
indc_pol_emis["JPN",,] <- c(1,1,2010,2030,0.26) #economy-wide target: 26% reduction by 2030 compared to 2013
#Laos, LULUCF not included in economy-wide target
#Kazakhstan
indc_pol_emis["KAZ",,] <- c(1,1,2005,2030,0.15) #economy-wide target: 15% reduction by 2030 compared to 1990
#Kenia
indc_pol_emis["KEN",,] <- c(1,2,2005,2030,0.3) #economy-wide target: 30% reduction by 2030 compared to BAU
#Madagascar
indc_pol_emis["MDG",,] <- c(1,2,2005,2030,0.42) #economy-wide target: 42% reduction by 2030 compared to BAU
#Malawi
indc_pol_emis["MWI",,] <- c(1,2,2005,2030,0.4) #economy-wide target: 40% reduction by 2030 compared to BAU
#Mali, LULUCF not included in economy-wide target
#Mexico
indc_pol_emis["MEX",,] <- c(1,2,2005,2030,0.22) #economy-wide target: 22% reduction by 2030 compared to BAU
#Morocco
indc_pol_emis["MAR",,] <- c(1,2,2005,2030,0.13) #economy-wide target: 13% reduction by 2030 compared to BAU
#Namibia
indc_pol_emis["NAM",,] <- c(1,2,2005,2030,0.89) #economy-wide target: 89% reduction by 2030 compared to BAU
#New Zealand
indc_pol_emis["NZL",,] <- c(1,1,2005,2030,0.3) #economy-wide target: 30% reduction by 2030 compared to 2005
#Norway
indc_pol_emis["NOR",,] <- c(1,1,2005,2030,0.4) #economy-wide target: 40% reduction by 2030 compared to 2005 #check
#Russia
indc_pol_emis["RUS",,] <- c(1,1,2005,2030,0.25) #economy-wide target: 25% reduction by 2030 compared to 1990
#Senegal
indc_pol_emis["SEN",,] <- c(1,2,2005,2030,0.05) #economy-wide target: 5% reduction by 2030 compared to BAU
#Switzerland
indc_pol_emis["CHE",,] <- c(1,1,2005,2030,0.5) #economy-wide target: 50% reduction by 2030 compared to 1990
#Turkey
indc_pol_emis["TUR",,] <- c(1,2,2005,2030,0.21) #economy-wide target: 21% reduction by 2030 compared to BAU
#Uganda
indc_pol_emis["UGA",,] <- c(1,2,2005,2030,0.22) #economy-wide target: 22% reduction by 2030 compared to BAU
#Ukraine
indc_pol_emis["UKR",,] <- c(1,1,2005,2030,0.4) #economy-wide target: 40% reduction by 2030 compared to 1990
#USA
indc_pol_emis["USA",,] <- c(1,1,2005,2025,0.26) #economy-wide target: 26% reduction by 2030 compared to 2005
#Zambia
indc_pol_emis["ZMB",,] <- c(1,2,2005,2030,0.47) #economy-wide target: 47% reduction by 2030 compared to BAU
#EU28 economy-wide target: 40% reduction by 2030 compared to 1990
indc_pol_emis["AUT",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["BEL",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["BGR",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["HRV",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["CYP",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["CZE",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["DNK",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["EST",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["FIN",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["FRA",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["DEU",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["GRC",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["HUN",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["IRL",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["ITA",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["LVA",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["LTU",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["LUX",,] <- c(1,1,2005,2030,0.4)
#indc_pol_emis["MLT",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["NLD",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["POL",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["PRT",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["ROU",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["SVK",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["SVN",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["ESP",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["SWE",,] <- c(1,1,2005,2030,0.4)
indc_pol_emis["GBR",,] <- c(1,1,2005,2030,0.4)

# Calc minimum carbon stock in indc scenario; result is in 0.5 degree resolution; Unit is MtC
emis_pol_indc <- calc_indc(indc_pol_emis,magpie_bau_cstock, im_years=im_years)
emis_pol[,getYears(emis_pol_indc),"indc"] <- emis_pol_indc

#Set all values before 2015 to NPI values; copy the values til 2010 from the NPI data
emis_pol[,c(1995,2005,2010),"indc"] <- emis_pol[,c(1995,2005,2010),"npi"]

## END LUC CO2 emission constraint

### END create INDC input files

#------------------------------------#

#aggregate to cluster level
ad_pol_lr <- speed_aggregate(ad_pol,rel = paste0(base_run,"/0.5-to-",res,"_sum.spam"))
aff_pol_lr <- speed_aggregate(aff_pol,rel = paste0(base_run,"/0.5-to-",res,"_sum.spam"))
emis_pol_lr <- speed_aggregate(emis_pol,rel = paste0(base_run,"/0.5-to-",res,"_sum.spam"))

#write files
write.magpie(ad_pol_lr,file_name = "output/indc_ad_pol.cs3")
write.magpie(aff_pol_lr,file_name = "output/indc_aff_pol.cs3")
write.magpie(emis_pol_lr,file_name = "output/indc_emis_pol.cs3")

#copy files
file.copy("output/indc_ad_pol.cs3","../../modules/35_natveg/input/indc_ad_pol.cs3",overwrite = TRUE)
file.copy("output/indc_aff_pol.cs3","../../modules/32_forestry/input/indc_aff_pol.cs3",overwrite = TRUE)
file.copy("output/indc_emis_pol.cs3","../../modules/35_natveg/input/indc_emis_pol.cs3",overwrite = TRUE)

### save country data as R object ###
save("npi_pol_deforest","npi_pol_afforest","npi_pol_emis","indc_pol_deforest","indc_pol_afforest","indc_pol_emis",file = "output/npi_indc_country.RData")