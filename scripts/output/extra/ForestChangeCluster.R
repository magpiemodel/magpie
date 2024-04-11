# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Compares Forest Area Change at Cluster Level
# comparison script: TRUE
# ---------------------------------------------------------------

# Version 1.0, Florian Humpenoeder
#
library(lucode2)
library(magclass)
library(luplot)
library(magpie4)
library(ggplot2)
library(gms)
library(dplyr)

options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- file.path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  lucode2::readArgs("outputdir")
}
###############################################################################
cat("\nStarting output generation\n")

forest <- NULL
missing <- NULL

for (i in 1:length(outputdir)) {
  print(paste("Processing",outputdir[i]))
  #gdx file
  gdx<-file.path(outputdir[i],"fulldata.gdx")
  if(file.exists(gdx)) {
    #get scenario name
    cfg <- gms::loadConfig(file.path(outputdir[i], "config.yml"))
    scen <- cfg$title
    #read-in reporting file
    x <- dimSums(land(gdx,level="cell")[,,c("forestry","primforest","secdforest")],dim=3)
    x <- x-setYears(x[,2020,],NULL)
    x <- x[,getYears(x,as.integer = T)>=2020 & getYears(x,as.integer = T)<=2100,]
    getNames(x) <- scen
    forest <- mbind(forest,x)
  } else missing <- c(missing,outputdir[i])
}
if (!is.null(missing)) {
  cat("\nList of folders with missing fulldata.gdx\n")
  print(missing)
}

forest <- as.data.frame(forest)
saveRDS(forest,"output/ForestChangeCluster.rds")
write.csv(forest, "output/ForestChangeCluster.csv",quote=F, row.names=F)

p <- ggplot(forest,aes(x=Year,y=Value)) + geom_line(aes(color=Cell,group=Cell)) + facet_wrap(vars(Data1),ncol = 4) + scale_color_viridis_c() + ggtitle("Forest Cover Change") + ylab("Mha compared to 2020") + theme_bw() + theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5))
ggsave("output/ForestChangeCluster.pdf",p,bg = "white",width = 12,height = 5)
ggsave("output/ForestChangeCluster.png",p,bg = "white",width = 12,height = 5)
