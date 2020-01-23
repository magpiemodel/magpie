# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

#########################
#### check modelstat ####
#########################
# Version 1.0, Abhi
#
library(lucode)
library(magclass)
library(luplot)
library(quitte)
library(magpie4)
library(ggplot2)

options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdirs <- path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  readArgs("outputdirs")
}
###############################################################################
cat("\nStarting output generation\n")

cumulative <- NULL
missing <- NULL

for (i in 1:length(outputdirs)) {
  print(paste("Processing",outputdirs[i]))
  #gdx file
  rep<-path(outputdirs[i],"fulldata.gdx")
  if(file.exists(rep)) {
    #get scenario name
    load(path(outputdirs[i],"config.Rdata"))
    scen <- cfg$title
    #read-in reporting file
    emissions <- reportEmissions(rep)["GLO",,"Emissions|CO2|Land|Cumulative (Gt CO2)"]
    getNames(emissions) <- scen
    cumulative <- mbind(cumulative,emissions)
  } else missing <- c(missing,outputdirs[i])
}
if (!is.null(missing)) {
  cat("\nList of folders with missing report.mif\n")
  print(missing)
}

cumulative <- as.ggplot(cumulative)
p <- ggplot(cumulative, aes(x=Year,y=Value)) + geom_line(aes(color = Data1, linetype = Data1)) + theme(legend.position="bottom")
ggsave(p,file="output/cumulative_emissions.pdf")
# plotmap2(defor[,2050,],"defor_2050_area.pdf",ncol=6,legend_range = c(-0.5,0.5),title = "Diff 2050",midpoint = 0,lowcol = "darkred",midcol = "grey95",highcol = "darkgreen",plot_height=10,plot_width=30,legend_height = NULL)
# plotmap2(defor[,2100,],"defor_2100_area.pdf",ncol=6,legend_range = c(-0.5,0.5),title = "Diff 2100",midpoint = 0,lowcol = "darkred",midcol = "grey95",highcol = "darkgreen",plot_height=10,plot_width=30,legend_height = NULL)
