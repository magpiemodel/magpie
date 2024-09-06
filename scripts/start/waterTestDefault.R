#description: Pumping cost implementation for India (11_cost>default>equations.gms updated manually)

# Load start_run(cfg) function which is needed to start MAgPIE runs
library(gms)
library(magclass)
library(gdx2)
library(luscale)
library(magpie4)
source("scripts/start_functions.R")
source("config/default.cfg")

codeCheck <- FALSE

## Basic settings:

basic_settings <- function(title) {

  source("config/default.cfg")

  cfg$force_download <- FALSE
  cfg$info$flag <- "060924"
  cfg$title       <- paste(cfg$info$flag,title,sep="_")
  cfg$results_folder <- "output/:title:"
  cfg$recalibrate <- FALSE
  return(cfg)
}


cfg <- basic_settings(title = "WaterTestBug")

# * Switch to activate pumping costs (only available for India currently), Set to 1 if want to use for India
cfg$gms$s42_pumping <- 1     # def = 0

start_run(cfg, codeCheck=FALSE)
