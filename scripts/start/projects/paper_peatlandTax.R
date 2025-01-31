# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: paper peatlandTax
# position: 5
# ----------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)
library(gdx2)
library(magpie4)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

# create additional information to describe the runs
cfg$info$flag <- "PTax48"

cfg$results_folder <- "output/:title:"
cfg$results_folder_highres <- "output"
cfg$force_replace <- TRUE
cfg$force_download <- FALSE
cfg$qos <- "standby_dayMax"

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

download_and_update(cfg)

## Create patch file for GHG prices
calc_ghgprice <- function() {
  T0 <- read.magpie("modules/56_ghg_policy/input/f56_pollutant_prices.cs3")
  T0 <- collapseNames(T0[, , getNames(T0, dim = 2)[1]])
  T0[, , ] <- 0
  
  #T200 200 USD/tCO2 in 2050
  T200 <- new.magpie(getRegions(T0), c(seq(1995, 2025, by = 5), 2050, 2100, 2150), getNames(T0), fill = 0)
  T200[, "y2025", "co2_c"] <- 0
  T200[, "y2050", "co2_c"] <- 200
  T200[, "y2100", "co2_c"] <- 200
  T200[, "y2150", "co2_c"] <- 200
  T200 <- time_interpolate(T200, seq(2015, 2100, by = 5), TRUE)
  T200 <- time_interpolate(T200, seq(2100, 2150, by = 5), TRUE)
  T200[, , "ch4"] <- T200[, , "co2_c"] * 28
  T200[, , "n2o_n_direct"] <- T200[, , "co2_c"] * 265 * 44 / 28
  T200[, , "n2o_n_indirect"] <- T200[, , "co2_c"] * 265 * 44 / 28
  T200[, , "co2_c"] <- T200[, , "co2_c"] * 44 / 12
  
  T25 <- T200 * 0.125
  T50 <- T200 * 0.25
  T100 <- T200 * 0.5
  T400 <- T200 * 2
  T800 <- T200 * 4
  
  GHG <- mbind(
    add_dimension(T0, dim = 3.2, add = "scen", nm = "T0-GHG"),
    add_dimension(
      T25,
      dim = 3.2,
      add = "scen",
      nm = "T25-GHG"
    ),
    add_dimension(
      T50,
      dim = 3.2,
      add = "scen",
      nm = "T50-GHG"
    ),
    add_dimension(
      T100,
      dim = 3.2,
      add = "scen",
      nm = "T100-GHG"
    ),
    add_dimension(
      T200,
      dim = 3.2,
      add = "scen",
      nm = "T200-GHG"
    ),
    add_dimension(
      T400,
      dim = 3.2,
      add = "scen",
      nm = "T400-GHG"
    ),
    add_dimension(
      T800,
      dim = 3.2,
      add = "scen",
      nm = "T800-GHG"
    )
  )
  
  CO2 <- GHG
  CO2[, , c("ch4", "n2o_n_direct", "n2o_n_indirect")] <- 0
  getNames(CO2, dim = 2) <- gsub("GHG", "CO2", getNames(CO2, dim = 2))
  
  GHGCH4GWP20 <- GHG
  GHGCH4GWP20[, , "ch4"] <- GHGCH4GWP20[, , "ch4"] / 28 * 84
  getNames(GHGCH4GWP20, dim = 2) <- gsub("GHG", "GHG-GWP20", getNames(GHGCH4GWP20, dim =
                                                                        2))
  
  GHG <- mbind(CO2, GHG, GHGCH4GWP20)
  if (!dir.exists("./patch_inputdata"))
    dir.create("./patch_inputdata")
  if (dir.exists("./patch_inputdata/patchGHGprices"))
    unlink("./patch_inputdata/patchGHGprices", recursive = TRUE)
  dir.create("./patch_inputdata/patchGHGprices")
  write.magpie(GHG, file_name = "patch_inputdata/patchGHGprices/f56_pollutant_prices.cs3")
  tardir("patch_inputdata/patchGHGprices",
         "patch_inputdata/patchGHGprices.tgz")
  
  unlink("patch_inputdata/patchGHGprices", recursive = TRUE)
  return(getNames(GHG, dim = 2))
}
ghgscen56 <- calc_ghgprice()
cfg$input['zzzpatchGHGprices'] <- "patchGHGprices.tgz"

## General settings
cfg$gms$c_timesteps <- "5year"
ssp <- "SSP2"
cfg <- setScenario(cfg, c(ssp, "NPI", "rcp7p0"))
cfg$gms$c56_pollutant_prices_noselect <- "T0-CO2"
cfg$gms$policy_countries56  <- isoCountriesEUR
cfg$gms$policy_countries58 <- isoCountriesEUR
cfg$gms$c56_emis_policy <- "sdp_peatland"
cfg$gms$s56_c_price_induced_aff <- 0

## Start scenarios
## Ref scenario
cfg$title <- .title(cfg, paste("TAU",ssp, "Ref", sep = "-"))
cfg$gms$c56_mute_ghgprices_until <- "y2150"
cfg$gms$c56_pollutant_prices <- "T0-CO2"
cfg$gms$s58_rewetting_exo <- 0
cfg$gms$s58_intact_prot_exo <- 0
x <- try(modelstat(file.path("output",cfg$title,"fulldata.gdx")),silent = TRUE)
if(is.null(x) | (is.magpie(x) & any(!x %in% c(2,7)))) {
  download_and_update(cfg)
  start_run(cfg, codeCheck = FALSE)
  message(paste0("TAU run started: ",cfg$title))
  Sys.sleep(10)
}  


### wait until model runs with endogenous TAU are finished, check is performed every 10 minutes
success <- FALSE
while (!success) {
  z <- NULL
  x <- try(modelstat(file.path("output",cfg$title,"fulldata.gdx")),silent = TRUE)
  if (is.magpie(x) & all(x %in% c(2,7))) {
    x <- x
  } else x <- NULL
  z <- mbind(z,x)
  if (is.null(z)) {
    message("Not any model run with endogenous TAU finished. Sleeping for 10 minutes.")
    Sys.sleep(60*10)
  } else {
    if (all(z %in% c(2,7))) success <- TRUE else stop("Modelstat different from 2 or 7 detected")
  }
}

# use exo TC in all following runs
download_and_update(cfg)
write.magpie(readGDX(file.path("output",cfg$title,"fulldata.gdx"), "ov_tau", select=list(type="level")),"modules/13_tc/input/f13_tau_scenario.csv")
cfg$gms$tc <- "exo"

## GHG policy scenarios
for (tax in c("T0-CO2",
              "T25-CO2",
              "T50-CO2",
              "T100-CO2",
              "T200-CO2",
              "T400-CO2",
              "T400-GHG",
              "T400-GHG-GWP20")) {
  cfg$title <- .title(cfg, paste(ssp, tax, sep = "-"))
  cfg$gms$c56_mute_ghgprices_until <- "y2025"
  cfg$gms$c56_pollutant_prices <- tax
  start_run(cfg, codeCheck = FALSE)
}

## Exo rewet scenarios
# 15% of currently drained peatland rewetted by 2050 (0.3 * 0.5)
cfg$title <- .title(cfg, paste(ssp, "NRL15", sep = "-"))
cfg$gms$c56_mute_ghgprices_until <- "y2150"
cfg$gms$c56_pollutant_prices <- "T0-CO2"
cfg$gms$s58_rewetting_exo <- 0.3
cfg$gms$s58_rewet_exo_target_value <- 0.5
cfg$gms$s58_intact_prot_exo <- 1
start_run(cfg, codeCheck = FALSE)

# 25% of currently drained peatland rewetted by 2050 (0.5 * 0.5)
cfg$title <- .title(cfg, paste(ssp, "NRL25", sep = "-"))
cfg$gms$c56_mute_ghgprices_until <- "y2150"
cfg$gms$c56_pollutant_prices <- "T0-CO2"
cfg$gms$s58_rewetting_exo <- 0.5
cfg$gms$s58_rewet_exo_target_value <- 0.5
cfg$gms$s58_intact_prot_exo <- 1
start_run(cfg, codeCheck = FALSE)

# 50% of currently drained peatland rewetted by 2050 (1 * 0.5)
cfg$title <- .title(cfg, paste(ssp, "NRL50", sep = "-"))
cfg$gms$c56_mute_ghgprices_until <- "y2150"
cfg$gms$c56_pollutant_prices <- "T0-CO2"
cfg$gms$s58_rewetting_exo <- 1
cfg$gms$s58_rewet_exo_target_value <- 0.5
cfg$gms$s58_intact_prot_exo <- 1
start_run(cfg, codeCheck = FALSE)

# 100% of currently drained peatland rewetted by 2050 (2 * 0.5)
cfg$title <- .title(cfg, paste(ssp, "NRL100", sep = "-"))
cfg$gms$c56_mute_ghgprices_until <- "y2150"
cfg$gms$c56_pollutant_prices <- "T0-CO2"
cfg$gms$s58_rewetting_exo <- 2
cfg$gms$s58_rewet_exo_target_value <- 0.5
cfg$gms$s58_intact_prot_exo <- 1
start_run(cfg, codeCheck = FALSE)
