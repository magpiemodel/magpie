### calcNPI  
## calculates input for MAgPIE NPI runs based on MAgPIE BAU runs and NPI documents

library(magpie4)
#library(lucode)
library(madrat)
library(luscale)

### base_run directory
base_run <- "base_run"

source("calcFunctions.R")



#low_res
res  <- get_info(paste0(base_run,"/info.txt"),"^\\* Output ?resolution:",": ")

#read in dummy files
ad_pol <- read.magpie("data_in/indc_ad_pol_0.5.mz")
aff_pol <- read.magpie("data_in/indc_aff_pol_0.5.mz")
emis_pol <- read.magpie("data_in/indc_emis_pol_0.5.mz")
getCells(ad_pol) <- spatial_header
getCells(aff_pol) <- spatial_header
getCells(emis_pol) <- spatial_header

### Read in data from MAgPIE BAU run (0.5 degree)
gdx <- paste0(base_run, "/fulldata.gdx")
y <- getYears(land(gdx),as.integer = TRUE)
im_years <- c(0,diff(y))
names(im_years) <- y
im_years <- as.magpie(im_years)

#defining mapping object for land cover stock,  def rate and  forest carbon stock
mapping<-toolMappingFile(type="cell",name="CountryToCellMapping_BRA.csv",readcsv=TRUE)

#read in land cover (stock) from BAU
magpie_bau_land <- read.magpie(paste0(base_run,"/cell.land_0.5.mz"))[,-1,]
#add country mapping
getCells(magpie_bau_land) <- mapping$celliso

#calc deforestation rate (flow)
magpie_bau_forest <- dimSums(magpie_bau_land[,,c("primforest","secdforest")],dim=3)
getCells(magpie_bau_forest) <- mapping$celliso

#read in forest carbon stock
magpie_bau_cstock <- dimSums(readGDX(gdx,"ov_carbon_stock",select=list(type="level"))[,,c("primforest","secdforest")],dim=3)
magpie_bau_cstock <- speed_aggregate(magpie_bau_cstock, rel=paste0(base_run,"/0.5-to-",res,"_area_weighted_mean.spam"))
getCells(magpie_bau_cstock) <- mapping$celliso


source("gen_csv_npi_indc_pol_hastags.R")


print("NPI input data preparation")
### create NPI input files

print("NPI AD policy")
## BEGIN reduce deforestation
## minimum forest stock based on NPI documents

#create npi_pol_deforest object
npi_pol_deforest <- create_indc()

npi_pol_deforest <- read.magpie("npi_pol_deforest.csv")

#Calc minimum forest stock in NPI scenario; result is in 0.5 degree resolution; Unit is Mha
ad_pol_npi <- calc_indc(npi_pol_deforest,magpie_bau_forest,affore=FALSE,im_years=im_years)
ad_pol[,getYears(ad_pol_npi),"npi"] <- ad_pol_npi

## END reduce deforestation


print("NPI AFF policy")
## BEGIN afforestation
## minimum forestry stock based on NPI documents

#create npi_pol_afforest object
npi_pol_afforest <- create_indc()

npi_pol_afforest <- read.magpie("npi_pol_afforest.csv")

# Calc minimum forestry stock in NPI scenario; result is in 0.5 degree resolution; Unit is Mha
aff_pol_npi <- calc_indc(npi_pol_afforest,magpie_bau_land,affore=TRUE,im_years=im_years)
aff_pol[,getYears(aff_pol_npi),"npi"] <- aff_pol_npi

## END afforestation

print("NPI EMIS policy")
## BEGIN LUC CO2 emission reduction
## minimum carbon stock based on NPI documents

#create npi_pol_emis object
npi_pol_emis <- create_indc()

npi_pol_emis <- read.magpie("npi_pol_emis.csv")

# Calc minimum carbon stock in NPI scenario; result is in 0.5 degree resolution; Unit is MtC
emis_pol_npi <- calc_indc(npi_pol_emis,magpie_bau_cstock,affore=FALSE,im_years=im_years)
emis_pol[,getYears(emis_pol_npi),"npi"] <- emis_pol_npi

## END LUC CO2 emission reduction

### END create NPI input files

#--------------------------------#

print("INDC input data preparation")
### create INDC input files

print("INDC AD policy")
## BEGIN reduce deforestation
## minimum forest stock based on INDC documents

#create indc_pol_deforest object
indc_pol_deforest <- create_indc()

indc_pol_deforest <- read.magpie("indc_pol_deforest.csv")

#Calc minimum forest stock in indc scenario; result is in 0.5 degree resolution; Unit is Mha
ad_pol_indc <- calc_indc(indc_pol_deforest,magpie_bau_forest,affore=FALSE, im_years=im_years)
ad_pol[,getYears(ad_pol_indc),"indc"] <- ad_pol_indc

#Set all values before 2015 to NPI values; copy the values til 2010 from the NPI data
ad_pol[,c(1995,2005,2010),"indc"] <- ad_pol[,c(1995,2005,2010),"npi"]

## END reduce deforestation


print("INDC AFF policy")
## BEGIN afforestation
## minimum forestry stock based on INDC documents

#create indc_pol_afforest object
indc_pol_afforest <- create_indc()

indc_pol_afforest <- read.magpie("indc_pol_afforest.csv")

# Calc minimum forestry stock in indc scenario; result is in 0.5 degree resolution; Unit is Mha
aff_pol_indc <- calc_indc(indc_pol_afforest,magpie_bau_land,affore=TRUE, im_years=im_years)
aff_pol[,getYears(aff_pol_indc),"indc"] <- aff_pol_indc

#Set all values before 2015 to NPI values; copy the values til 2010 from the NPI data
aff_pol[,c(1995,2005,2010),"indc"] <- aff_pol[,c(1995,2005,2010),"npi"]

## END afforestation

print("INDC EMIS policy")
## BEGIN LUC CO2 emission reduction
## minimum carbon stock based on INDC documents

#create indc_pol_emis object
indc_pol_emis <- create_indc()

indc_pol_emis <- read.magpie("indc_pol_emis.csv")

# Calc minimum carbon stock in indc scenario; result is in 0.5 degree resolution; Unit is MtC
emis_pol_indc <- calc_indc(indc_pol_emis,magpie_bau_cstock, im_years=im_years)
emis_pol[,getYears(emis_pol_indc),"indc"] <- emis_pol_indc

#Set all values before 2015 to NPI values; copy the values til 2010 from the NPI data
emis_pol[,c(1995,2005,2010),"indc"] <- emis_pol[,c(1995,2005,2010),"npi"]

## END LUC CO2 emission constraint

### END create INDC input files

####IT IS WORKING TILL HERE - 04/10/2018 AFTERNOON###

#------------------------------------#

#aggregate to cluster level
ad_pol_lr <- speed_aggregate(ad_pol,rel = paste0(base_run,"/0.5-to-",res,"_sum.spam"))
aff_pol_lr <- speed_aggregate(aff_pol,rel = paste0(base_run,"/0.5-to-",res,"_sum.spam"))
emis_pol_lr <- speed_aggregate(emis_pol,rel = paste0(base_run,"/0.5-to-",res,"_sum.spam"))

#write files
write.magpie(ad_pol_lr,file_name = "data_out/indc_ad_pol.cs3")
write.magpie(aff_pol_lr,file_name = "data_out/indc_aff_pol.cs3")
write.magpie(emis_pol_lr,file_name = "data_out/indc_emis_pol.cs3")

#copy files
file.copy("data_out/indc_ad_pol.cs3","../../modules/35_natveg/input/indc_ad_pol.cs3",overwrite = TRUE)
file.copy("data_out/indc_aff_pol.cs3","../../modules/32_forestry/input/indc_aff_pol.cs3",overwrite = TRUE)
file.copy("data_out/indc_emis_pol.cs3","../../modules/35_natveg/input/indc_emis_pol.cs3",overwrite = TRUE)

### save country data as R object ###

####IT IS WORKING TILL HERE - 04/10/2018 AFTERNOON###
##Falta fazer o teste delogica que eo Jan falou. E acabar de ouvir o audio pra ver se tem masi alguma coisa.
save("npi_pol_deforest","npi_pol_afforest","npi_pol_emis","indc_pol_deforest","indc_pol_afforest","indc_pol_emis",file = "data_out/npi_indc_country.RData")