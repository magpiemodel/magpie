# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
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
cfg$info$flag <- "elastic_demand"

cfg$results_folder <- "output/:title:"
cfg$force_replace <- TRUE

# support function to create standardized title
.title <- function(cfg, ...) return(paste(cfg$info$flag, sep="_",...))

# Reference and Policy run for various shares of tax recycling
for(s15_tax_recycling in c(0,0.5,1)) {

  ssp="SSP2"

  cfg$title <- .title(cfg, paste(ssp,"PkBudg650","recycling",s15_tax_recycling,sep="-"))
  cfg$gms$s15_elastic_demand <- 1
  cfg$gms$s15_tax_recycling <- s15_tax_recycling
  cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9"))
  cfg$gms$c56_mute_ghgprices_until <- "y2030"
  cfg$gms$c56_pollutant_prices <- paste0("R32M46-", if (ssp=="SSP2") "SSP2EU" else ssp,"-PkBudg650")
  cfg$gms$c60_2ndgen_biodem    <- paste0("R32M46-", if (ssp=="SSP2") "SSP2EU" else ssp,"-PkBudg650")
  start_run(cfg, codeCheck = FALSE)
 

}

s15_tax_recycling=1
  cfg$title <- .title(cfg, paste(ssp,"Ref",s15_tax_recycling,sep="-"))
  cfg$gms$s15_elastic_demand <- 1
  cfg$gms$s15_tax_recycling <- s15_tax_recycling
  cfg <- setScenario(cfg,c(ssp,"NPI","rcp7p0"))
  cfg$gms$c56_mute_ghgprices_until <- "y2150"
  cfg$gms$c56_pollutant_prices <- paste0("R32M46-", if (ssp=="SSP2") "SSP2EU" else ssp,"-NPi")
  cfg$gms$c60_2ndgen_biodem    <- paste0("R32M46-", if (ssp=="SSP2") "SSP2EU" else ssp,"-NPi")
  start_run(cfg, codeCheck = FALSE)
  
s15_tax_recycling=1
  cfg$title <- .title(cfg, paste(ssp,"Ref_inelastic",sep="-"))
  cfg$gms$s15_elastic_demand <- 0
  cfg$gms$s15_tax_recycling <- s15_tax_recycling
  cfg <- setScenario(cfg,c(ssp,"NPI","rcp7p0"))
  cfg$gms$c56_mute_ghgprices_until <- "y2150"
  cfg$gms$c56_pollutant_prices <- paste0("R32M46-", if (ssp=="SSP2") "SSP2EU" else ssp,"-NPi")
  cfg$gms$c60_2ndgen_biodem    <- paste0("R32M46-", if (ssp=="SSP2") "SSP2EU" else ssp,"-NPi")
  start_run(cfg, codeCheck = FALSE)

