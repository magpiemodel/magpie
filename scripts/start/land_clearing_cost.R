# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
cfg$results_folder <- "output/:title:"

cfg$recalibrate <- TRUE

for(low in c(1,2,4,8,10,15,20,25,30)) {
  for (high in c(100,200,400,500,600,700,800,900,1000,1500)) {
    cfg$title <- paste("LC",low,high,sep="_")
    a <- read.magpie("modules/39_landconversion/gdp_vegc_may18/input/f39_landclear_gdp.csv")
    a[,,"low_gdp"] <- low
    a[,,"high_gdp"] <- high
    write.magpie(a,"modules/39_landconversion/gdp_vegc_may18/input/f39_landclear_gdp.cs3")
    file.rename("modules/39_landconversion/gdp_vegc_may18/input/f39_landclear_gdp.cs3","modules/39_landconversion/gdp_vegc_may18/input/f39_landclear_gdp.csv")
    start_run(cfg,codeCheck=FALSE)
    cfg$recalc_npi_ndc <- FALSE
  }
}


