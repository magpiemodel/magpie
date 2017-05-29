### calcNPI  
## calculates input for MAgPIE NPI runs based on MAgPIE BAU runs and NPI documents

library(magpie)
library(lucode)
source("calcINDCfunctions.R")
mapping_file <- "mappings/cell/CountryToCellMapping.csv"
mapping<-read.csv(mapping_file, as.is=TRUE, sep=";")
countries<-unique(mapping$CountryCode)

### resolution
if(exists("cfg")) res <- cfg$low_res else res <- "n600"
if(!file.exists(res)) dir.create(res)

### BAU directory
# bau_dir <- "BAU"
bau_dir <- paste0("Base","_",res)

### Read in data from MAgPIE BAU run (0.5 degree)
gdx <- path(bau_dir, "fulldata.gdx")
im_years <- readGDX(gdx,"im_years")
y <- getYears(im_years,as.integer = TRUE)


### create NPI input files

## BEGIN reduce deforestation
## minimum forest stock based on NPI documents

#read in forest cover (stock) from BAU
magpie_bau_land <- read.magpie(path(bau_dir,"cell.land_0.5.mz"))[,-1,]
#calc deforestation rate (flow)
magpie_bau_forest <- setNames(magpie_bau_land[,,"forest"],NULL)
getCells(magpie_bau_forest) <- mapping$CountryCell

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
magpie_npi_forest <- calc_indc(npi_pol_deforest,magpie_bau_forest,affore=FALSE,im_years=im_years)
# aggregate to cluster level
magpie_npi_forest <- speed_aggregate(magpie_npi_forest,rel = paste0(bau_dir,"/0.5-to-",res,"_sum.spam"))

# write file
write.magpie(magpie_npi_forest,file_name = paste0(res,"/npi_forest.cs2"))
file.copy(paste0(res,"/npi_forest.cs2"),"../../modules/33_forest/input/f33_npi_forest.cs2",overwrite = TRUE)

## END reduce deforestation


## BEGIN afforestation
## minimum forestry stock based on NPI documents

#read in forest cover (stock) from BAU
magpie_bau_land <- read.magpie(paste0(bau_dir,"/cell.land_0.5.mz"))[,-1,]
#add country mapping
getCells(magpie_bau_land) <- mapping$CountryCell

#create npi_pol_afforest object
npi_pol_afforest <- create_indc()

#set afforestation targets at country level in Mha

#Australia
npi_pol_afforest["AUS",1,] <- c(1,1,2010,2020,0.02) #20,000 hectares afforestation by 2020
#Brazil
npi_pol_afforest["BRA",1,] <- c(1,1,2005,2030,12) #Reforestation of 12 mn ha by 2030
#China
tmp <- dimSums(magpie_bau_land["CHN",2005,],dim=c(1,3))*0.2304 - dimSums(magpie_bau_land["CHN",2005,c("forest","forestry")],dim=c(1,3))
npi_pol_afforest["CHN",1,] <- c(1,1,2005,2020,tmp) #23.04% forest coverage by 2020 --> 50 Mha afforestation is needed
#India
npi_pol_afforest["IND",1,] <- c(1,1,2005,2030,5) #Forest coverage (area) | Increase	5.00E+06	ha	from 2005 to 2030

#restore magpie cellular mapping
getCells(magpie_bau_land) <- mapping$X 

# Calc minimum forestry stock in NPI scenario; result is in 0.5 degree resolution; Unit is Mha
magpie_npi_aff <- calc_indc(npi_pol_afforest,magpie_bau_land,affore=TRUE,im_years=im_years)
# aggregate to cluster level
magpie_npi_aff <- speed_aggregate(magpie_npi_aff,rel = paste0(bau_dir,"/0.5-to-",res,"_sum.spam"))

# write file
write.magpie(magpie_npi_aff,file_name = paste0(res,"/npi_aff.cs2"))
file.copy(paste0(res,"/npi_aff.cs2"),"../../modules/32_forestry/input/f32_npi_aff.cs2",overwrite = TRUE)

## END afforestation

## BEGIN LUC CO2 emission reduction
## minimum carbon stock based on NPI documents

#read in forest carbon stock
magpie_bau_cstock <- dimSums(readGDX(gdx,"ov_carbon_stock",select=list(type="level"))[,,"forest"],dim=3)
magpie_bau_cstock <- speed_aggregate(magpie_bau_cstock, rel=paste0(bau_dir,"/0.5-to-",res,"_area_weighted_mean.spam"))

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
magpie_npi_cstock <- calc_indc(npi_pol_emis,magpie_bau_cstock,affore=FALSE,im_years=im_years)

#aggregate to cluster level
magpie_npi_cstock <- speed_aggregate(magpie_npi_cstock,rel = paste0(bau_dir,"/0.5-to-",res,"_sum.spam"))

#write file
write.magpie(magpie_npi_cstock,file_name = paste0(res,"/npi_cstock.cs2"))
file.copy(paste0(res,"/npi_cstock.cs2"),"../../modules/33_forest/input/f33_npi_cstock.cs2",overwrite = TRUE)

## END LUC CO2 emission reduction

### save data as R object ###
save("npi_pol_deforest","npi_pol_afforest","npi_pol_emis",file = "npi_all.RData")