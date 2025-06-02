# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Project WetHorizons Peatland
# position: 5
# ----------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(magclass)
library(gdx2)
library(magpie4)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

# create additional information to describe the runs
cfg$info$flag <- "WH06"

cfg$results_folder <- "output/:title:"
cfg$results_folder_highres <- "output"
cfg$force_replace <- TRUE
cfg$force_download <- FALSE
cfg$qos <- "standby"

# support function to create standardized title
.title <- function(cfg, ...)
  return(paste(cfg$info$flag, sep = "_", ...))

cfg$repositories <- append(
  list(
    "https://rse.pik-potsdam.de/data/magpie/public" = NULL,
    "./patch_inputdata" = NULL
  ),
  getOption("magpie_repos")
)

cfg$gms$c_timesteps <- "5year"

ssps <- c("SSP1","SSP2","SSP3","SSP5")

for (ssp in ssps) {
  if (ssp %in% c("SSP1","SSP2","SSP5")) {
    cfg$title <- .title(cfg, paste(ssp, "1p5deg", "noPeatland", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NDC", "rcp1p9"))
    cfg$gms$c56_mute_ghgprices_until <- "y2025"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-",ssp,"-PkBudg650")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-",ssp,"-PkBudg650")
  } else {
    cfg$title <- .title(cfg, paste(ssp, "2deg", "noPeatland", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NDC", "rcp2p6"))
    cfg$gms$c56_mute_ghgprices_until <- "y2025"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-",ssp,"-PkBudg1000")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-",ssp,"-PkBudg1000")
  }
  cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
  cfg$gms$s58_rewetting_exo <- 0
  cfg$gms$s58_rewet_exo_start_value <- 0
  cfg$gms$s58_rewet_exo_target_value <- 0.5
  cfg$gms$s58_annual_rewetting_limit <- 0.02
  cfg$gms$s58_intact_prot_exo <- 0
  cfg$gms$tc <- "endo_jan22"
  x <- try(modelstat(file.path("output",cfg$title,"fulldata.gdx")),silent = TRUE)
  if(is.null(x) | (is.magpie(x) & any(!x %in% c(2,7)))) {
    download_and_update(cfg)
    start_run(cfg,codeCheck=FALSE)
    message(paste0("TAU run started: ",cfg$title))
    Sys.sleep(10)
  }
}

### wait until model runs with endogenous TAU are finished, check is performed every 10 minutes
success <- FALSE
while (!success) {
  z <- NULL
  for (ssp in ssps) {
    if (ssp %in% c("SSP1","SSP2","SSP5")) {
      x <- try(modelstat(file.path("output",.title(cfg, paste(ssp, "1p5deg", "noPeatland", sep = "-")),"fulldata.gdx")),silent = TRUE)
    } else {
      x <- try(modelstat(file.path("output",.title(cfg, paste(ssp, "2deg", "noPeatland", sep = "-")),"fulldata.gdx")),silent = TRUE)
    }
    if (is.magpie(x) & all(x %in% c(2,7))) {
      x <- add_dimension(collapseNames(x),dim = 3.1,add = "scen",nm = paste0(ssp))
    } else x <- NULL
    z <- mbind(z,x)
  }
  if (is.null(z)) {
    message("Not any model run with endogenous TAU finished. Sleeping for 10 minutes.")
    Sys.sleep(60*10)
  } else if (dim(z)[3] < length(ssps)) {
    message("At least on model run with endogenous TAU not yet finished. Sleeping for 10 minutes.")
    Sys.sleep(60*10)
  } else if (dim(z)[3] == length(ssps)) {
    if (all(z %in% c(2,7))) success <- TRUE else stop("Modelstat different from 2 or 7 detected")
  }
}


cfg$gms$tc <- "exo"

for (ssp in ssps) {
  
  if (ssp %in% c("SSP1","SSP2","SSP5")) {
    
    # PkBudg650
    cfg$title <- .title(cfg, paste(ssp, "1p5deg", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NDC", "rcp1p9"))
    cfg$gms$c56_mute_ghgprices_until <- "y2025"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-",ssp,"-PkBudg650")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-",ssp,"-PkBudg650")
    cfg$gms$c56_emis_policy <- "reddnatveg_nosoil"
    cfg$gms$s58_rewetting_exo <- 0
    cfg$gms$s58_rewet_exo_start_value <- 0
    cfg$gms$s58_rewet_exo_target_value <- 0.5
    cfg$gms$s58_annual_rewetting_limit <- 0.02
    cfg$gms$s58_intact_prot_exo <- 0
    download_and_update(cfg)
    write.magpie(readGDX(file.path("output",.title(cfg, paste(ssp, "1p5deg", "noPeatland", sep = "-")),"fulldata.gdx"), "ov_tau", select=list(type="level")),"modules/13_tc/input/f13_tau_scenario.csv")
    start_run(cfg, codeCheck = FALSE)
    
    ## Exo rewet scenarios
    # 15% of currently drained peatland rewetted by 2050
    cfg$title <- .title(cfg, paste(ssp, "1p5deg", "NRL15", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NDC", "rcp1p9"))
    cfg$gms$c56_mute_ghgprices_until <- "y2025"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-",ssp,"-PkBudg650")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-",ssp,"-PkBudg650")
    cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
    cfg$gms$s58_rewetting_exo <- 1
    cfg$gms$s58_rewet_exo_start_value <- 0
    cfg$gms$s58_rewet_exo_target_value <- 0.15
    cfg$gms$s58_annual_rewetting_limit <- 1
    cfg$gms$s58_intact_prot_exo <- 1
    download_and_update(cfg)
    write.magpie(readGDX(file.path("output",.title(cfg, paste(ssp, "1p5deg", "noPeatland", sep = "-")),"fulldata.gdx"), "ov_tau", select=list(type="level")),"modules/13_tc/input/f13_tau_scenario.csv")
    start_run(cfg, codeCheck = FALSE)
    
    ## Exo rewet scenarios
    # 25% of currently drained peatland rewetted by 2050
    cfg$title <- .title(cfg, paste(ssp, "1p5deg", "NRL25", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NDC", "rcp1p9"))
    cfg$gms$c56_mute_ghgprices_until <- "y2025"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-",ssp,"-PkBudg650")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-",ssp,"-PkBudg650")
    cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
    cfg$gms$s58_rewetting_exo <- 1
    cfg$gms$s58_rewet_exo_start_value <- 0
    cfg$gms$s58_rewet_exo_target_value <- 0.25
    cfg$gms$s58_annual_rewetting_limit <- 1
    cfg$gms$s58_intact_prot_exo <- 1
    download_and_update(cfg)
    write.magpie(readGDX(file.path("output",.title(cfg, paste(ssp, "1p5deg", "noPeatland", sep = "-")),"fulldata.gdx"), "ov_tau", select=list(type="level")),"modules/13_tc/input/f13_tau_scenario.csv")
    start_run(cfg, codeCheck = FALSE)
    
    ## Exo rewet scenarios
    # 50% of currently drained peatland rewetted by 2050
    cfg$title <- .title(cfg, paste(ssp, "1p5deg", "NRL50", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NDC", "rcp1p9"))
    cfg$gms$c56_mute_ghgprices_until <- "y2025"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-",ssp,"-PkBudg650")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-",ssp,"-PkBudg650")
    cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
    cfg$gms$s58_rewetting_exo <- 1
    cfg$gms$s58_rewet_exo_start_value <- 0
    cfg$gms$s58_rewet_exo_target_value <- 0.5
    cfg$gms$s58_annual_rewetting_limit <- 1
    cfg$gms$s58_intact_prot_exo <- 1
    download_and_update(cfg)
    write.magpie(readGDX(file.path("output",.title(cfg, paste(ssp, "1p5deg", "noPeatland", sep = "-")),"fulldata.gdx"), "ov_tau", select=list(type="level")),"modules/13_tc/input/f13_tau_scenario.csv")
    start_run(cfg, codeCheck = FALSE)
    
    ## Exo rewet scenarios
    # 100% of currently drained peatland rewetted by 2050
    cfg$title <- .title(cfg, paste(ssp, "1p5deg", "NRL100", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NDC", "rcp1p9"))
    cfg$gms$c56_mute_ghgprices_until <- "y2025"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-",ssp,"-PkBudg650")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-",ssp,"-PkBudg650")
    cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
    cfg$gms$s58_rewetting_exo <- 1
    cfg$gms$s58_rewet_exo_start_value <- 0
    cfg$gms$s58_rewet_exo_target_value <- 1
    cfg$gms$s58_annual_rewetting_limit <- 1
    cfg$gms$s58_intact_prot_exo <- 1
    download_and_update(cfg)
    write.magpie(readGDX(file.path("output",.title(cfg, paste(ssp, "1p5deg", "noPeatland", sep = "-")),"fulldata.gdx"), "ov_tau", select=list(type="level")),"modules/13_tc/input/f13_tau_scenario.csv")
    start_run(cfg, codeCheck = FALSE)
  } else {
    # PkBudg1000
    cfg$title <- .title(cfg, paste(ssp, "2deg", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NDC", "rcp2p6"))
    cfg$gms$c56_mute_ghgprices_until <- "y2025"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-",ssp,"-PkBudg1000")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-",ssp,"-PkBudg1000")
    cfg$gms$c56_emis_policy <- "reddnatveg_nosoil"
    cfg$gms$s58_rewetting_exo <- 0
    cfg$gms$s58_rewet_exo_start_value <- 0
    cfg$gms$s58_rewet_exo_target_value <- 0.5
    cfg$gms$s58_annual_rewetting_limit <- 0.02
    cfg$gms$s58_intact_prot_exo <- 0
    download_and_update(cfg)
    write.magpie(readGDX(file.path("output",.title(cfg, paste(ssp, "2deg", "noPeatland", sep = "-")),"fulldata.gdx"), "ov_tau", select=list(type="level")),"modules/13_tc/input/f13_tau_scenario.csv")
    start_run(cfg, codeCheck = FALSE)
    
    ## Exo rewet scenarios
    # 15% of currently drained peatland rewetted by 2050
    cfg$title <- .title(cfg, paste(ssp, "2deg", "NRL15", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NDC", "rcp2p6"))
    cfg$gms$c56_mute_ghgprices_until <- "y2025"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-",ssp,"-PkBudg1000")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-",ssp,"-PkBudg1000")
    cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
    cfg$gms$s58_rewetting_exo <- 1
    cfg$gms$s58_rewet_exo_start_value <- 0
    cfg$gms$s58_rewet_exo_target_value <- 0.15
    cfg$gms$s58_annual_rewetting_limit <- 1
    cfg$gms$s58_intact_prot_exo <- 1
    download_and_update(cfg)
    write.magpie(readGDX(file.path("output",.title(cfg, paste(ssp, "2deg", "noPeatland", sep = "-")),"fulldata.gdx"), "ov_tau", select=list(type="level")),"modules/13_tc/input/f13_tau_scenario.csv")
    start_run(cfg, codeCheck = FALSE)
    
    ## Exo rewet scenarios
    # 25% of currently drained peatland rewetted by 2050
    cfg$title <- .title(cfg, paste(ssp, "2deg", "NRL25", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NDC", "rcp2p6"))
    cfg$gms$c56_mute_ghgprices_until <- "y2025"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-",ssp,"-PkBudg1000")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-",ssp,"-PkBudg1000")
    cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
    cfg$gms$s58_rewetting_exo <- 1
    cfg$gms$s58_rewet_exo_start_value <- 0
    cfg$gms$s58_rewet_exo_target_value <- 0.25
    cfg$gms$s58_annual_rewetting_limit <- 1
    cfg$gms$s58_intact_prot_exo <- 1
    download_and_update(cfg)
    write.magpie(readGDX(file.path("output",.title(cfg, paste(ssp, "2deg", "noPeatland", sep = "-")),"fulldata.gdx"), "ov_tau", select=list(type="level")),"modules/13_tc/input/f13_tau_scenario.csv")
    start_run(cfg, codeCheck = FALSE)
    
    ## Exo rewet scenarios
    # 50% of currently drained peatland rewetted by 2050
    cfg$title <- .title(cfg, paste(ssp, "2deg", "NRL50", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NDC", "rcp2p6"))
    cfg$gms$c56_mute_ghgprices_until <- "y2025"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-",ssp,"-PkBudg1000")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-",ssp,"-PkBudg1000")
    cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
    cfg$gms$s58_rewetting_exo <- 1
    cfg$gms$s58_rewet_exo_start_value <- 0
    cfg$gms$s58_rewet_exo_target_value <- 0.5
    cfg$gms$s58_annual_rewetting_limit <- 1
    cfg$gms$s58_intact_prot_exo <- 1
    download_and_update(cfg)
    write.magpie(readGDX(file.path("output",.title(cfg, paste(ssp, "2deg", "noPeatland", sep = "-")),"fulldata.gdx"), "ov_tau", select=list(type="level")),"modules/13_tc/input/f13_tau_scenario.csv")
    start_run(cfg, codeCheck = FALSE)
    
    ## Exo rewet scenarios
    # 100% of currently drained peatland rewetted by 2050
    cfg$title <- .title(cfg, paste(ssp, "2deg", "NRL100", sep = "-"))
    cfg <- setScenario(cfg, c(ssp, "NDC", "rcp2p6"))
    cfg$gms$c56_mute_ghgprices_until <- "y2025"
    cfg$gms$c56_pollutant_prices <- paste0("R34M410-",ssp,"-PkBudg1000")
    cfg$gms$c60_2ndgen_biodem    <- paste0("R34M410-",ssp,"-PkBudg1000")
    cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
    cfg$gms$s58_rewetting_exo <- 1
    cfg$gms$s58_rewet_exo_start_value <- 0
    cfg$gms$s58_rewet_exo_target_value <- 1
    cfg$gms$s58_annual_rewetting_limit <- 1
    cfg$gms$s58_intact_prot_exo <- 1
    download_and_update(cfg)
    write.magpie(readGDX(file.path("output",.title(cfg, paste(ssp, "2deg", "noPeatland", sep = "-")),"fulldata.gdx"), "ov_tau", select=list(type="level")),"modules/13_tc/input/f13_tau_scenario.csv")
    start_run(cfg, codeCheck = FALSE)
    
  }
}
