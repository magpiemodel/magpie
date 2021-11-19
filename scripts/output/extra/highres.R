# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: starts a run with higher resolution in parallel mode (each region is solved individually) using trade patterns from an existing run
# comparison script: FALSE
# ---------------------------------------------------------------

library(magclass)
library(gdx)
library(magpie4)
library(lucode2)
library(gms)
library(madrat)
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- "output/LAMA60_Sustainability"
  readArgs("outputdir")
}

load(paste0(outputdir, "/config.Rdata"))
gdx	<- file.path(outputdir,"fulldata.gdx")
rds <- paste0(outputdir, "/report.rds")
runstatistics <- paste0(outputdir,"/runstatistics.rda")
resultsarchive <- "/p/projects/rd3mod/models/results/magpie"
###############################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# wait some seconds (random between 5-30 sec) to avoid conflicts with locking the model folder (.lock file)
Sys.sleep(runif(1, 5, 30))

highres <- function(cfg) {
  #lock the model folder
  lock_id <- gms::model_lock(timeout1=1,check_interval=runif(1, 10, 30))
  on.exit(gms::model_unlock(lock_id), add=TRUE)
  
  if(any(!(modelstat(gdx) %in% c(2,7)))) stop("Modelstat different from 2 or 7 detected")
  
  cfg$output <- cfg$output[cfg$output!="extra/highres"]
  
  #update cellular input files
#  cfg$input["cellular"] <- "rev4.65_h12_a2626201_cellularmagpie_c1000_MRI-ESM2-0-ssp370_lpjml-3eb70376.tgz"
  cfg$input["cellular"] <- "rev4.65_h12_026f93b5_cellularmagpie_c2000_MRI-ESM2-0-ssp370_lpjml-3eb70376.tgz"
  
  #copy gdx files from low resolution run for better starting points
  cfg$files2export$start <- c(cfg$files2export$start,
                              paste0(cfg$results_folder,"/","magpie_y*.gdx"))
  
  #max resources for parallel runs
  cfg$qos <- "priority_maxMem"
  
  #download input files with high resolution
  download_and_update(cfg)
  
  #set title
  cfg$title <- paste0("HR_",cfg$title)
  cfg$results_folder <- "output/:title:"
  cfg$force_replace <- TRUE
  cfg$recalc_npi_ndc <- TRUE
  
  #get trade pattern from low resolution run with c200
  ov_prod_reg <- readGDX(gdx,"ov_prod_reg",select=list(type="level"))
  ov_supply <- readGDX(gdx,"ov_supply",select=list(type="level"))
  supreg <- readGDX(gdx, "supreg")
  f21_trade_balance <- toolAggregate(ov_prod_reg - ov_supply, supreg)
  write.magpie(f21_trade_balance,paste0("modules/21_trade/input/f21_trade_balance.cs3"))
  
  #get tau from low resolution run with c200
  ov_tau <- readGDX(gdx, "ov_tau",select=list(type="level"))
  write.magpie(ov_tau,"modules/13_tc/input/f13_tau_scenario.csv")
  cfg$gms$tc <- "exo"
  
  #use exo trade and parallel optimization
  cfg$gms$trade <- "exo"
  cfg$gms$optimization <- "nlp_par"
  cfg$gms$s15_elastic_demand <- 0
  
  #get regional afforestation patterns from low resolution run with c200
  aff <- dimSums(landForestry(gdx)[,,c("aff","ndc")],dim=3)
  #Take away initial NDC area for consistency with global afforestation limit
  aff <- aff-setYears(aff[,1,],NULL)
  #calculate maximum regional afforestation over time
  aff_max <- setYears(aff[,1,],NULL)
  for (r in getRegions(aff)) {
    aff_max[r,,] <- max(aff[r,,])
  }
  aff_max[aff_max<0] <- 0
  write.magpie(aff_max,"modules/32_forestry/input/f32_max_aff_area.cs4")
  cfg$gms$c32_max_aff_area <- "regional"
  #check
  if(cfg$gms$s32_max_aff_area < Inf) {
    indicator <- abs(sum(aff_max)-cfg$gms$s32_max_aff_area)
    if(indicator > 1e-06) warning(paste("Global and regional afforestation limit differ by",indicator,"Mha"))
  }
  
  Sys.sleep(2)
  
  start_run(cfg,codeCheck=FALSE,lock_model=FALSE)
}
highres(cfg)

