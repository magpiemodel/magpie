# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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
cfg$info$flag <- "PTax24"

cfg$results_folder <- "output/:title:"
cfg$results_folder_highres <- "output"
cfg$output <- c(cfg$output, "extra/highres")
cfg$force_replace <- TRUE
cfg$force_download <- FALSE
cfg$qos <- "standby_highMem_dayMax"

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

cfg$input['regional'] <- "rev4.111_36f73207_magpie.tgz"
cfg$input['validation'] <- "rev4.111_36f73207_validation.tgz"
cfg$input['calibration'] <- "calibration_H16_14Jun24.tgz"
cfg$input['cellular'] <- "rev4.111_36f73207_44a213b6_cellularmagpie_c400_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1_clusterweight-ba4466a8.tgz"
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

  T50 <- T200 * 0.25
  T100 <- T200 * 0.5
  T400 <- T200 * 2
  T800 <- T200 * 4

  GHG <- mbind(
    add_dimension(T0, dim = 3.2, add = "scen", nm = "T0-GHG"),
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
cfg$gms$c56_emis_policy <- "sdp_peatland"
cfg$gms$factor_costs <- "sticky_feb18"
cfg$gms$livestock <- "fbask_jan16_sticky"
cfg$gms$s56_c_price_induced_aff <- 0

## Start scenarios
for (res in c("c400")) {
  if (res == "c400")
    cfg$input['cellular'] <- "rev4.111_36f73207_44a213b6_cellularmagpie_c400_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1_clusterweight-ba4466a8.tgz"
  else if (res == "c1000") {
    cfg$input['cellular'] <- "rev4.111_36f73207_10f98ac1_cellularmagpie_c1000_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1_clusterweight-ba4466a8.tgz"
  }
  ## Ref scenario
  cfg$title <- .title(cfg, paste(res, ssp, "Ref", sep = "-"))
  cfg$gms$c56_mute_ghgprices_until <- "y2150"
  cfg$gms$c56_pollutant_prices <- "T0-CO2"
  start_run(cfg, codeCheck = FALSE)

  ## Policy scenarios
  for (tax in c("T50-CO2",
                "T100-CO2",
                "T200-CO2",
                "T400-CO2",
                "T400-GHG",
                "T400-GHG-GWP20")) {
    cfg$title <- .title(cfg, paste(res, ssp, tax, sep = "-"))
    cfg$gms$c56_mute_ghgprices_until <- "y2025"
    cfg$gms$c56_pollutant_prices <- tax
    start_run(cfg, codeCheck = FALSE)
  }
}
