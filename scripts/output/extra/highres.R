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
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- "output/LAMA65_Sustainability/"
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
  
  cfg$output <- cfg$output[cfg$output!="extra/highres"]
  
  #update cellular input files
  cfg$input["cellular"] <- "rev4.64_h12_184c2e25_cellularmagpie_c600_MRI-ESM2-0-ssp370_lpjml-4b917a03.tgz"
  
  #max resources for parallel runs
  cfg$qos <- "priority_maxMem"
  
  #download input files with high resolution
  download_and_update(cfg)
  
  #set title
  cfg$title <- paste0("hr_",cfg$title)
  cfg$results_folder <- "output/:title:"
  cfg$force_replace <- TRUE
  
  #get trade pattern from low resolution run with c200
  ov_prod_reg <- readGDX(gdx,"ov_prod_reg",select=list(type="level"))
  ov_supply <- readGDX(gdx,"ov_supply",select=list(type="level"))
  f21_trade_balance <- ov_prod_reg - ov_supply
  write.magpie(round(f21_trade_balance,6),paste0("modules/21_trade/input/f21_trade_balance.cs3"))
  
  #get tau from low resolution run with c200, currently not used.
  tau(gdx,file = "modules/13_tc/input/f13_tau_scenario.csv",digits = 4)
  #cfg$gms$tc <- "exo"
  
  #use exo trade and parallel optimization
  cfg$gms$trade <- "exo"
  cfg$gms$optimization <- "nlp_par"
  cfg$gms$s15_elastic_demand <- 0
  
  #cfg$gms$c60_bioenergy_subsidy <- 0
  
  start_run(cfg,codeCheck=FALSE,lock_model=FALSE)
}
highres(cfg)

