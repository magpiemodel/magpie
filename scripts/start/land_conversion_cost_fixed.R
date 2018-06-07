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
cfg$gms$c_timesteps <- "coup2100"
cfg$recalibrate <- TRUE
cfg$gms$c80_nlp_solver <- "conopt4"
cfg$gms$s80_optfile <- 0

cfg$gms$factor_costs <- "fixed_per_ton_mar18"

for(low in c(250,500,1000,2000,4000,5000,6000)) {
  for (high in c(8000,10000,12000,14000,20000)) {
    cfg$title <- paste("lcost",low,high,"fixed",sep="_")
    cfg$gms$landconversion <- "gdp_vegc_may18"
    a <- read.magpie("modules/39_landconversion/gdp_vegc_may18/input/f39_landclear_gdp.csv")
    a[,,"medium_estimate.low_gdp"] <- low
    a[,,"medium_estimate.high_gdp"] <- high
    write.magpie(a,"modules/39_landconversion/gdp_vegc_may18/input/f39_landclear_gdp.cs3")
    file.rename("modules/39_landconversion/gdp_vegc_may18/input/f39_landclear_gdp.cs3","modules/39_landconversion/gdp_vegc_may18/input/f39_landclear_gdp.csv")
    a <- read.magpie("modules/39_landconversion/gdp_vegc_may18/input/f39_establish_gdp.cs3")
    a[,,"crop.medium_estimate.low_gdp"] <- low
    a[,,"crop.medium_estimate.high_gdp"] <- high
    a[,,"past.medium_estimate.low_gdp"] <- low/2
    a[,,"past.medium_estimate.high_gdp"] <- high/2
    write.magpie(a,"modules/39_landconversion/gdp_vegc_may18/input/f39_establish_gdp.cs3")
    start_run(cfg,codeCheck=FALSE)
    cfg$recalc_npi_ndc <- FALSE
  }
}


