# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(lucode)

source("scripts/start_functions.R")
source("scripts/performance_test.R")
source("config/default.cfg")

#set defaults
scenario <- "SSP2"
codeCheck <- FALSE
cfg$gms$c_timesteps <- 11

buildInputVector <- function(regionmapping   = "h11",
                             archive_name    = "GLUES2-sresa2-constant_co2-miub_echo_g_ERB",
                             resolution      = "h200", 
                             archive_rev     = "22.1", 
                             madrat_rev      = "2.06",
                             additional_data = "additional_data_rev1.01.tgz") {
  mappings <- c(h11="8a828c6ed5004e77d1ba2025e8ea2261",
                h12="690d3718e151be1b450b394c1064b1c5",
                mag="2da01c534a80df894e0384d999e415d4")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings[regionmapping], ".tgz")
  madrat  <- paste0("magpie_", mappings[regionmapping], "_rev", madrat_rev, ".tgz")
  return(c(archive,madrat,additional_data))
}


### Single test runs ###

cfg$title <- "default"
cfg$input <- buildInputVector()
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"     
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"  
start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck)

cfg$title <- "default_rcp26"
cfg$input <- buildInputVector()
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"     
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"  
start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck)


cfg$title <- "h12"
cfg$input <- buildInputVector(regionmapping = "h12")
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"     
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"  
start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck)

cfg$title <- "h12_rcp26"
cfg$input <- buildInputVector(regionmapping = "h12")
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"     
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"
start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck)

cfg$title <- "mag"
cfg$input <- buildInputVector(regionmapping = "mag")
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"     
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"  
start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck)


### Cluster resolution tests ###

cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"     
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"  

for(res in c("n200","h100","n100")) {
  cfg$title <- res
  cfg$input <- buildInputVector(resolution = res)
  start_run(cfg=cfg,scenario=scenario,codeCheck=codeCheck)
}


### Performance tests ###

cfg$title <- "bau"
cfg$input <- buildInputVector()
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"     
cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"  
performance_start(cfg=cfg, id=cfg$title, sequential=NA)

cfg$title <- "rcp26"
cfg$input <- buildInputVector()
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"     
cfg$gms$c60_2ndgen_biodem    <- "SSP2-26-SPA0"  
performance_start(cfg=cfg, id=cfg$title, sequential=NA)



