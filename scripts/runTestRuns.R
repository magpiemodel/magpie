# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R") # get start_run function

runTestRuns <- function(cfg) {
  cfg$results_folder <- "output/:title:"
  cfg$force_replace <- TRUE

  # support function to create standardized title
  .title <- function(cfg, ...) paste(cfg$info$flag, sep = "_", ...)

  # Single time step run
  timeSteps <- cfg$gms$c_timesteps
  cfg$gms$c_timesteps <- 1
  cfg$title <- .title(cfg, "singleTimeStep")
  start_run(cfg, codeCheck = TRUE)
  cfg$gms$c_timesteps <- timeSteps

  # Reference and Policy run for the following SSPs:
  for (ssp in c("SSP1", "SSP2", "SSP5")) {
    cfg$title <- .title(cfg, paste(ssp, "Ref", sep = "-"))
    cfg <- gms::setScenario(cfg, c(ssp, "NPI", "rcp7p0"))
    cfg$gms$c56_mute_ghgprices_until <- "y2150"
    cfg$gms$c56_pollutant_prices <- paste0("R32M46-", if (ssp == "SSP2") "SSP2EU" else ssp, "-NPi")
    cfg$gms$c60_2ndgen_biodem    <- cfg$gms$c56_pollutant_prices
    start_run(cfg, codeCheck = FALSE)

    cfg$title <- .title(cfg, paste(ssp, "NDC", sep = "-"))
    cfg <- gms::setScenario(cfg, c(ssp, "NDC", "rcp4p5"))
    cfg$gms$c56_mute_ghgprices_until <- "y2150"
    cfg$gms$c56_pollutant_prices <- paste0("R32M46-", if (ssp == "SSP2") "SSP2EU" else ssp, "-NDC")
    cfg$gms$c60_2ndgen_biodem    <- cfg$gms$c56_pollutant_prices
    start_run(cfg, codeCheck = FALSE)

    cfg$title <- .title(cfg, paste(ssp, "PkBudg650", sep = "-"))
    cfg <- gms::setScenario(cfg, c(ssp, "NDC", "rcp1p9"))
    cfg$gms$c56_mute_ghgprices_until <- "y2030"
    cfg$gms$c56_pollutant_prices <- paste0("R32M46-", if (ssp == "SSP2") "SSP2EU" else ssp, "-PkBudg650")
    cfg$gms$c60_2ndgen_biodem    <- cfg$gms$c56_pollutant_prices
    start_run(cfg, codeCheck = FALSE)
  }
}
