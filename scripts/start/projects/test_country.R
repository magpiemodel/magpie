# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test routine for standardized test runs
# position: 5
# ----------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

#download default input data
download_and_update(cfg)

# create additional information to describe the runs
cfg$info$flag <- "SIM" 

cfg$output <- c("rds_report") # "extra/highres_country"
cfg$results_folder <- "output/:title:"
cfg$force_replace <- TRUE

# support function to create standardized title
.title <- function(...) return(paste(cfg$info$flag, sep="_",...))

#Reference and Policy run for SSP1, SSP2 and SSP5
for(ssp in c("SSP2")) {
  for (processing in c("substitution_may21","off")) {
    for (residues in c("flexreg_apr16","off")) {
      for (nr_soil_budget in c("exoeff_aug16","off")) {
        for (disagg_lvst in c("foragebased_aug18","off")) {
          cfg$title <- .title(paste(ssp,"Ref",paste0("21PROC",if(processing!="off") "On" else "Off"),paste0("18RESID",if(residues!="off") "On" else "Off"),paste0("50SOIL",if(nr_soil_budget!="off") "On" else "Off"),paste0("71LIVST",if(disagg_lvst!="off") "On" else "Off"),sep="-"))
          cfg <- setScenario(cfg,c(ssp,"NPI","rcp7p0"))
          cfg$gms$c56_pollutant_prices <- paste0("R21M42-",ssp,"-NPi")
          cfg$gms$c60_2ndgen_biodem    <- paste0("R21M42-",ssp,"-NPi")
          
          cfg$gms$processing <- processing
          cfg$gms$residues <- residues
          cfg$gms$nr_soil_budget <- nr_soil_budget
          cfg$gms$disagg_lvst <- disagg_lvst
          
          start_run(cfg, codeCheck = FALSE)
          
        }
      }
    }
  }
  

  # cfg$title <- .title(paste(ssp,"PkBudg900",sep="-"))
  # cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9"))
  # cfg$gms$c56_pollutant_prices <- paste0("R21M42-",ssp,"-PkBudg900")
  # cfg$gms$c60_2ndgen_biodem    <- paste0("R21M42-",ssp,"-PkBudg900")
  # start_run(cfg, codeCheck = TRUE)
  
}
