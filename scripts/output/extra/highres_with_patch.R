# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: starts a run with higher resolution in parallel mode (each region is solved individually) using trade patterns from an existing run
# comparison script: FALSE
# ---------------------------------------------------------------

# Author: Florian Humpenoeder

library(magclass)
library(gdx)
library(magpie4)
library(lucode2)
library(gms)
library(madrat)
library(gms)
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- "output/LAMA86_Sustainability"
  readArgs("outputdir")
}

cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
gdx <- file.path(outputdir,"fulldata.gdx")
rds <- paste0(outputdir, "/report.rds")
runstatistics <- paste0(outputdir,"/runstatistics.rda")
resultsarchive <- "/p/projects/rd3mod/models/results/magpie"
###############################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

highres <- function(cfg) {
  #lock the model folder
  lockId <- gms::model_lock(timeout1 = 1)
  withr::defer(gms::model_unlock(lockId))

  if(any(!(modelstat(gdx) %in% c(2,7)))) stop("Modelstat different from 2 or 7 detected")

  cfg$output <- cfg$output[cfg$output!="extra/highres"]

  # set high resolution, available options are c1000 and c2000
  res <- "c2000"

  #update cellular input files
  cfg$input <- c(
      regional = "rev4.81FSEC_e2bdb6cd_magpie.tgz",
      cellular = "rev4.81FSEC_e2bdb6cd_a2e37ede_cellularmagpie_c2000_MRI-ESM2-0-ssp126_lpjml-8e6c5eb1.tgz",
      validation = "rev4.81FSEC_e2bdb6cd_validation.tgz",
      additional = "additional_data_rev4.38.tgz",
      calibration = "calibration_FSEC_14Feb23.tgz",
      patch = "consv_prio_fsec_c2000.tgz"
    )
  cfg$repositories <- append(
      list(
        "https://rse.pik-potsdam.de/data/magpie/public" = NULL,
        "../patch_inputdata" = NULL
      ),
      getOption("magpie_repos")
  )

  #copy gdx file for 1st time step from low resolution run for better starting point
  #note: using gdx files for more than the 1st time step sometimes pushes the model into corner solutions, which might result in infeasibilites.
  cfg$files2export$start <- c(cfg$files2export$start,
                              paste0(cfg$results_folder, "/", "magpie_y1995.gdx"))
  cfg$gms$s_use_gdx   <- 1
  cfg$gms$s80_optfile <- 1

  #max resources for parallel runs
  cfg$qos <- "standby_maxMem_dayMax"

  # set force download to FALSE
  # otherwise data is download again when calling start_run(), which overwrites
  # f21_trade_balance.cs3, f13_tau_scenario.csv, f32_max_aff_area.cs4 etc
  cfg$force_download <- FALSE

  #download input files with high resolution
  download_and_update(cfg)

  # set title
  tmp       <- unlist(strsplit(cfg$title, "_"))
  tmp[1]    <- paste0(tmp[1], paste0("HR", res))
  cfg$title <- paste(tmp, collapse = "_")

  cfg$results_folder <- paste0("output/HR", res, "/:title:")
  cfg$force_replace  <- TRUE
  cfg$recalc_npi_ndc <- TRUE

  #get trade pattern from low resolution run with c200
  ov_prod_reg <- readGDX(gdx, "ov_prod_reg", select = list(type = "level"))
  ov_supply   <- readGDX(gdx, "ov_supply", select = list(type = "level"))
  supreg      <- readGDX(gdx, "supreg")
  f21_trade_balance <- toolAggregate(ov_prod_reg - ov_supply, supreg)
  write.magpie(f21_trade_balance, paste0("modules/21_trade/input/f21_trade_balance.cs3"))

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
  aff_max[aff_max < 0] <- 0
  write.magpie(aff_max,"modules/32_forestry/input/f32_max_aff_area.cs4")
  cfg$gms$s32_max_aff_area_glo <- 0
  #check
  if(cfg$gms$s32_max_aff_area < Inf) {
    indicator <- abs(sum(aff_max)-cfg$gms$s32_max_aff_area)
    if(indicator > 1e-06) warning(paste("Global and regional afforestation limit differ by",indicator,"Mha"))
  }

  Sys.sleep(2)

  start_run(cfg, codeCheck = FALSE, lock_model = FALSE)

  Sys.sleep(1)

  if (file.exists("modules/32_forestry/input/f32_max_aff_area.cs4")) file.remove("modules/32_forestry/input/f32_max_aff_area.cs4")

}
highres(cfg)
