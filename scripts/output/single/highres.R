# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

library(magclass)
library(gdx)
library(magpie4)
library(lucode)
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- "/p/projects/landuse/users/miodrag/projects/tests/flexreg/output/H12_setup1_2016-11-23_12.38.56/"
  readArgs("outputdir")
}

load(paste0(outputdir, "/config.Rdata"))
gdx	<- path(outputdir,"fulldata.gdx")
rds <- paste0(outputdir, "/report.rds")
runstatistics <- paste0(outputdir,"/runstatistics.rda")
resultsarchive <- "/p/projects/rd3mod/models/results/magpie"
###############################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#lock the model folder
lock_id <- lucode::model_lock(timeout1=1)

cfg$results_folder <- "output/:title:"

cfg$output <- c("rds_report")

#set high resolution
hr <- "c1000"

#update input files. The following files are needed:
#isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev42_c200_690d3718e151be1b450b394c1064b1c5.tgz
#isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev42_c1000_690d3718e151be1b450b394c1064b1c5.tgz
#The calibration file must exist for c200 and c1000 with the same date
#calibration_H12_c200_26Feb20
#calibration_H12_c1000_26Feb20
cfg$input <- gsub("c200",hr,cfg$input)

#max resources for parallel runs
cfg$qos <- "shorr_maxMem"
#magpie4::submitCalibration("H12_c1000")
#c1000 with endoTC

#download and udpate input files
download_and_update(cfg)
cfg$recalc_npi_ndc <- TRUE

#set title
cfg$title <- paste(cfg$title,"hr",sep="_")

#get trade pattern from low resolution run with c200
ov_prod_reg <- readGDX(gdx,"ov_prod_reg",select=list(type="level"))
ov_supply <- readGDX(gdx,"ov_supply",select=list(type="level"))
f21_trade_balance <- ov_prod_reg - ov_supply
write.magpie(round(f21_trade_balance,6),paste0("modules/21_trade/input/f21_trade_balance.cs3"))

#get tau from low resolution run with c200, currently not used.
tau(gdx,file = "modules/13_tc/input/f13_tau_scenario.csv",digits = 4)

#use exo trade and parallel optimization
cfg$gms$trade <- "exo"
cfg$gms$optimization <- "nlp_par"
#cfg$gms$s15_elastic_demand <- 0
#cfg$gms$tc <- "exo"

#cfg$gms$c60_bioenergy_subsidy <- 0

start_run(cfg,codeCheck=FALSE,lock_model=FALSE)
#unlock the model folder
lucode::model_unlock(lock_id)
