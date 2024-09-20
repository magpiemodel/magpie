# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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
library(gdx2)
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

# Plausible values for "res" (high resolution): "c1000" and "c2000"
# Options for "tc" (13_tc realization): NULL (no change), "exo" and "endo_jan22"

highres <- function(cfg = cfg, res = "c1000", tc = NULL) {
  #lock the model folder
  lockId <- gms::model_lock(timeout1 = 24)
  withr::defer(gms::model_unlock(lockId))

  if(any(!(modelstat(gdx) %in% c(2,7)))) stop("Modelstat different from 2 or 7 detected")

  cfg$output <- cfg$output[cfg$output!="extra/highres"]

  # search for matching high resolution file in repositories
  # pattern: "rev4.65_h12_*_cellularmagpie_c2000_MRI-ESM2-0-ssp370_lpjml-3eb70376.tgz"
  x <- unlist(strsplit(cfg$input["cellular"],"_"))
  x[3] <- "*"
  x[5] <- res
  file <- paste0(x,collapse = "_")
  message(paste0("Searching for ",file," in repositories"))
  repositories <- cfg$repositories
  found <- NULL
  debug <- FALSE
  for (repo in names(repositories)) {
    if (grepl("https://|http://", repo)) {
      #read html index file and extract file names
      h <- try(curl::new_handle(verbose = debug, .list = repositories[[repo]]), silent = !debug)
      con <- curl::curl(paste0(repo,"/"), handle = h)
      dat <- try(readLines(con), silent = TRUE)
      close(con)
      dat <- grep("href",dat,value = T)
      dat <- unlist(lapply(strsplit(dat, "\\]\\] <a href\\=\\\"|\\\">"),function(x) x[2]))
      dat <- gsub(" <a href=\"","",dat,fixed=TRUE)
      found <- c(found,grep(glob2rx(file),dat,value = T))
    } else if (grepl("scp://", repo)) {
      #list files with sftp command
      path <- paste0(sub("scp://","sftp://",repo),"/")
      h <- try(curl::new_handle(verbose = debug, .list = repositories[[repo]], ftp_use_epsv = TRUE, dirlistonly = TRUE), silent = TRUE)
      con <- try(curl::curl(url = path, "r", handle = h), silent = TRUE)
      dat <- try(readLines(con), silent = TRUE)
      try(close(con), silent = TRUE)
      found <- c(found,grep(glob2rx(file),dat,value = T))
    } else if (dir.exists(repo)) {
      dat <- list.files(repo)
      found <- c(found,grep(glob2rx(file),dat,value = T))
    }
  }

  if(length(found) == 0) {
    stop("No matching file found")
  } else {
    if (length(unique(found)) > 1) {
      found <- found[1]
      warning("More than one file found that matches the pattern. Only the first one will be used.")
    } else found <- found[1]
    message(paste0("Matching file with ",res," resolution found: ",found))
  }

  #update cellular input files
  cfg$input["cellular"] <- found

  #copy gdx file for 1st time step from low resolution run for better starting point
  #note: using gdx files for more than the 1st time step sometimes pushes the model into corner solutions, which might result in infeasibilites.
  cfg$files2export$start <- c(cfg$files2export$start,
                              paste0(cfg$results_folder, "/", "magpie_y*.gdx"))
  cfg$gms$s_use_gdx   <- 2

  #max resources for parallel runs
  cfg$qos <- "standby_highMem_dayMax"

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

  if(!is.null(cfg$results_folder_highres)) {
    cfg$results_folder <- file.path(cfg$results_folder_highres,":title:")
  } else {
    cfg$results_folder <- paste0("output/HR", res, "/:title:")
  }
  cfg$force_replace  <- TRUE
  cfg$recalc_npi_ndc <- TRUE

  #get trade pattern from low resolution run with c200
  k_trade      <- readGDX(gdx, "k_trade")
  ov_prod_reg <- readGDX(gdx, "ov_prod_reg", select = list(type = "level"))[,,k_trade]
  ov_supply   <- readGDX(gdx, "ov_supply", select = list(type = "level"))[,,k_trade]
  import_for_feasibility   <- readGDX(gdx, "ov21_import_for_feasibility", select = list(type = "level"), react = "silent")
  if(is.null(import_for_feasibility)) {
    import_for_feasibility <- new.magpie(getCells(ov_supply),getYears(ov_supply),getNames(ov_supply),fill = 0)
  }
  supreg      <- readGDX(gdx, "supreg")
  f21_trade_balance <- toolAggregate(ov_prod_reg - (ov_supply + import_for_feasibility), supreg)
  write.magpie(f21_trade_balance, paste0("modules/21_trade/input/f21_trade_balance.cs3"))

  if(!is.null(tc)) {
    #get tau from low resolution run with c200
    ov_tau <- readGDX(gdx, "ov_tau",select=list(type="level"))
    write.magpie(ov_tau,"modules/13_tc/input/f13_tau_scenario.csv")
    cfg$gms$tc <- tc
  }

  #use exo trade and parallel optimization
  cfg$gms$trade <- "exo"
  cfg$gms$optimization <- "nlp_par"
  cfg$gms$s15_elastic_demand <- 0

  #get exogenous bioenergy demand and GHG prices from c200 run because these files may have been overwritten
  write.magpie(readGDX(gdx,"f56_pollutant_prices_coupling"),"modules/56_ghg_policy/input/f56_pollutant_prices_coupling.cs3")
  write.magpie(readGDX(gdx,"f56_pollutant_prices_emulator"),"modules/56_ghg_policy/input/f56_pollutant_prices_emulator.cs3")
  write.magpie(readGDX(gdx,"f60_bioenergy_dem_coupling"),"modules/60_bioenergy/input/reg.2ndgen_bioenergy_demand.csv")
  write.magpie(readGDX(gdx,"f60_bioenergy_dem_emulator"),"modules/60_bioenergy/input/glo.2ndgen_bioenergy_demand.csv")

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
