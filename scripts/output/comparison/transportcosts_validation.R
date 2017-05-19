# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

####################################
#### transport costs validation ####
####################################
# Version 1.0, Florian Humpenoeder

library(magpie4)
library(ludata)
library(luplot)
library(ggplot2)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdirs <- "./output/static_irrigation_2012-09-07_12.17.06"
  #Define arguments that can be read from command line
  readArgs("outputdirs")
}
###############################################################################
title_list <- list()
all_costs <- list()

MAgPIE2GTAP <- function(gdx,gtap=F) {
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
  if (gtap) {
    gtap <- read.magpie("scripts/output/comparison/transport.gtap.csv")
    gtap <- gtap[,,names(cft.rel)]
    gtap <- as.magpie(gtap/10^3)
    dimnames(gtap)[[2]] <- "y2004"
    return(gtap)
  } else {
    x <- readGDX(gdx,"ov_cost_transp",format="first_found",select=list(type="level"))
    x_glo <- superAggregate(x,level="glo",aggr_type="sum")
    x_glo_gtap <- new.magpie("GLO",getYears(x_glo),names(cft.rel))
    for(i in getNames(x_glo_gtap)) {
      for (y in getYears(x_glo)) {
        x_glo_gtap[,y,i] <- dimSums(x_glo[,y,cft.rel[[i]]],dims=3)
      }
    }
    x_glo_gtap <- as.magpie(x_glo_gtap/10^3)[,c("y1995","y2005"),]
    x_glo_gtap <- time_interpolate(x_glo_gtap,"y2004")
    return(x_glo_gtap)
  }
}
all_costs[["GTAP"]] <- MAgPIE2GTAP(gdx,gtap=T)

for (i in 1:length(outputdirs)) {
  #title of the run
  if(file.exists(path(outputdirs[i],"config.Rdata"))) {
    load(path(outputdirs[i],"config.Rdata"))
    title <- cfg$title
    gms      <- cfg$gms
    title_list[[title]] <- title
  } else {
    config <- grep("\\.cfg$",list.files(outputdirs[i]), value=TRUE)
    l<-readLines(path(outputdirs[i],config))
    title <- strsplit(grep("title +<-",l,value=TRUE),"\"")[[1]][2]
    gms <- list()
    gms$scenarios <- strsplit(grep("(cfg\\$|)gms\\$scenarios +<-",l,value=TRUE),"\"")[[1]][2]
    title_list[[title]] <- title
  }

  #gdx file
  gdx<-path(outputdirs[i],"fulldata.gdx")

  #transport costs
  all_costs[[title]] <- MAgPIE2GTAP(gdx,gtap=F)
}

all_costs <- as.ggplot(all_costs,asDate=F)
all_costs <- ggplot(all_costs,aes(x=Scenario,y=Value,fill=Data1,group = interaction(Scenario, Data1))) + geom_bar() + facet_grid(~Year) + labs(y = "Total transport costs [Billion US Dollar]")
ggsave(filename="output/transportcosts_validation.pdf",plot=all_costs)
