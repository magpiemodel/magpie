# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: India subnational validation 
# comparison script: FALSE
# ---------------------------------------------------------------

#Version 1.00 - Miodrag Stevanovic, Prantika Das
# 1.00: first working version

library(lucode2)
library(magpie4)
library(madrat)
library(mrfable)
library(mip)
library(mrvalidation)
library(magpiesets)
library(lusweave)

print("Start India state level validation output runscript")

############################# BASIC CONFIGURATION #######################################

if(!exists("source_include")) {
  
  outputdir <- "output/v4p77/h12_2022-12-15_22.09.46"
  
  ###Define arguments that can be read from command line
  readArgs("outputdir")
}
file    <- file.path(outputdir,paste0("India_subnational_validation_",format(Sys.time(), "%Y%H%M%S"),".pdf"))
#########################################################################################

print(paste0("Script started for output directory: ",outputdir))

# Determine cells for India
mapping <- toolGetMapping("scripts/npi_ndc/policies/country2cell.rds")
mapping$iso_mag <- paste(mapping$iso,mapping$cell,sep=".")
# load Indian states
indStates <- toolGetMapping(system.file("extdata", "regional/india_state_code.csv", package = "mrfable"))
indCells <- which(mapping$ind %in% indStates$State_code)

# Subnational validation data of specific crops
landHr <- read.magpie(file.path(outputdir,"cell.land_0.5.mz"))[indCells,,]
cropareaHrShare <- read.magpie(file.path(outputdir,"cell.croparea_0.5_share.mz"))[indCells,,]
cellHr <- dimSums(landHr, dim=3)
cropareaHr <- cropareaHrShare[,,]*setItems(cell_hr[,1,], dim=2, NULL)
cropareaHr <- dimSums(cropareaHr, dim=3.2)

# aggregate land from grid to state level
mappingInd <- mapping[indCells,]
cropareaState <- toolAggregate(cropareaHr, rel=mappingInd, from="iso_mag", to="ind")

# Observed data from mrfable
setConfig(extramappings = "mappingIndiaAPY.csv")
indApyMapping <- toolGetMapping(system.file("extdata", "regional/mappingIndiaAPY.csv", package = "mrfable"))
h <- calcOutput("IndiaFoodcrop", subtype = "Area", aggregate = "Region")
# Data cleaning:
h <- h[indStates$State_code,,]
h <- collapseNames(h)
h <- collapseNames(h[,,"total"])
h <- h/1000
# Crops in the APY database:
mappingCropsAPY <- as.matrix(data.frame(APYcrop=c("Bajra", "Barley", "Gram",
                                                  "Jowar",  "Tur", "Maize",
                                                  "Wheat", "Ragi", "Rice"), 
                                              k=c("trce", "tece", "puls_pro", 
                                                  "trce", "puls_pro", "maiz",
                                                  "tece", "trce", "rice_pro")))
# Aggregate to magpie crops:
h <- toolAggregate(h, rel=mappingCropsAPY, from="APYcrop", to="k", dim=3)
h <- add_dimension(h, dim=3.1, add="scenario", nm="historical")
h <- add_dimension(h, dim=3.2, add="model", nm="APY")
h <- setItems(h, dim=3.3, reportingnames(getItems(h,dim=3.3)))

cropareaState <- cropareaState[,,unique(mappingCropsAPY[,"k"])]
names(dimnames(cropareaState)) <- c("state","year","crop")
cropareaState <- add_dimension(cropareaState, dim=3.1, add="scenario", nm="")
cropareaState <- add_dimension(cropareaState, dim=3.2, add="model", nm="MAgPIE")
cropareaState <- setItems(cropareaState, dim=3.3, reportingnames(getItems(cropareaState,dim=3.3)))

sw <- swopen(file)
swlatex(sw,"\\huge")
swlatex(sw,"\\textbf{MAgPIE state level croparea comparison for India}\\newline")
swlatex(sw,"\\normalsize")
swlatex(sw,"\\newline")
swlatex(sw,"\\tableofcontents")

for(k in getItems(h, dim=3.3)){
  for(state in getItems(h, dim=1)){
    swlatex(sw,"\\newpage")
    swlatex(sw,paste0("\\section{Croparea ",k," in ",indStates[which(indStates$State_code==state),"State_name"],"}"))
    swfigure(sw, print, mipLineHistorical(cropareaState[state,,k],h[state,,k],ylab="Mha"))
  }
}

swclose(sw,clean_output=TRUE)


