# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

#Script calculates transport costs per ton per minute
#Version 1.02 - Jan Philipp Dietrich, Florian Humpenoder
# 1.01 - added new GTAP categories, but be careful: some crops are missing in
#        mapping!!! Results have to be handled with care, since they are
#        potential overestimations of costs
# 1.02 - transport.gtap is now converted to USD (was before 10^6 USD)
#        changed distance-file from dummy to real data
# 1.03 - new production matrix added (FH)
# 1.04 - converted to MAgPIE output script

library(magpie4)
library(ludata)
library(luplot)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  
  gdx <- "fulldata.gdx"
  outputdir  <- "DIR of the run"
  #Define arguments that can be read from command line
  readArgs("outputdir")
} else {
  gdx<-path(outputdir,"fulldata.gdx")
}
###############################################################################


#load distance matrix, production matrix and gtap transport costs
distance <- readGDX(gdx,"f40_distance", format="first_found")
production <- mbind((production(gdx,level="cell",water="sum",crop_aggr=F)[,"y2005",]*10^6),livestock_production(gdx,level="cell")*10^6)
transport.gtap <- read.csv("scripts/output/single/transport.gtap.csv")
#transform 10^6 USD -> USD
transport.gtap[,2:dim(transport.gtap)[2]] <- transport.gtap[,2:dim(transport.gtap)[2]]*10^6

#map gtap cfts to MAgPIE cfts
cft.rel <- list()
cft.rel[["pdr"]] <- c("rice_pro")
cft.rel[["wht"]] <- c("tece")
cft.rel[["gro"]] <- c("maiz","trce","begr","betr")
cft.rel[["v_f"]] <- c("others","potato","cassav_sp","puls_pro")              
cft.rel[["osd"]] <- c("soybean","oilpalm","rapeseed","sunflower","groundnut")
cft.rel[["c_b"]] <- c("sugr_beet","sugr_cane")
cft.rel[["ocr"]] <- c("foddr")
cft.rel[["ctl"]] <- c("livst_rum","livst_milk")

#calculate transport power (amount * distance)
transport.power <- array(0,dim=c(ncells(distance),1,length(cft.rel)))
dimnames(transport.power)[[1]] <- dimnames(distance)[[1]]
dimnames(transport.power)[[2]] <- "y1995"
dimnames(transport.power)[[3]] <- names(cft.rel)

#calculate average transport costs per ton per distance
transport.per.ton.per.distance <- array(0,dim=c(dim(transport.gtap)[1],0))
dimnames(transport.per.ton.per.distance)[[1]] <- levels(transport.gtap[,1])

for(i in 1:length(cft.rel)) {
  if(length(cft.rel[[i]])>1) {
    transport.power[,1,names(cft.rel)[i]] <- rowSums(production[,1,cft.rel[[i]]])*distance[,1,1]
  } else {
    transport.power[,1,names(cft.rel)[i]] <- production[,1,cft.rel[[i]]]*distance[,1,1]
  }
  transport.per.ton.per.distance <- cbind(transport.per.ton.per.distance,transport.gtap[,names(cft.rel)[i]]/sum(transport.power[,1,names(cft.rel)[i]]))
}

dimnames(transport.per.ton.per.distance)[[2]] <- names(cft.rel)

#write average costs to file (GTAP cft)
write.csv(t(round(transport.per.ton.per.distance,4)),path(outputdir,paste("transport_costs_per_unit_per_distance.csv",sep="")))

#create array with MAgPIE cft
magpie.cft <- unlist(cft.rel)
attributes(magpie.cft) <- NULL
transport.per.ton.per.distance.magpie <- array(0,dim=c(1,length(magpie.cft)))
dimnames(transport.per.ton.per.distance.magpie)[[2]] <- magpie.cft
for(i in dimnames(transport.per.ton.per.distance.magpie)[[2]]) {
  transport.per.ton.per.distance.magpie[1,i] <- as.numeric(transport.per.ton.per.distance[3,names(cft.rel)[grep(i,cft.rel)]])
}

#write average costs to file (MAgPIE cft)
write.table(t(round(transport.per.ton.per.distance.magpie,4)),path(outputdir,paste("transport_costs.csv",sep="")),col.names=F,sep=",")


transport.costs <- array(0,dim=c(ncells(distance),1,length(cft.rel)))
dimnames(transport.costs)[[1]] <- dimnames(distance)[[1]]
dimnames(transport.costs)[[2]] <- "y1995"
dimnames(transport.costs)[[3]] <- names(cft.rel)

for(i in 1:length(cft.rel)) {
  transport.costs[,1,names(cft.rel)[i]] <- distance[,1,1]*as.numeric(transport.per.ton.per.distance[3,names(cft.rel)[i]])
}
write.csv(round(transport.costs,4),path(outputdir,paste("transport_costs_per_unit.csv",sep="")))
