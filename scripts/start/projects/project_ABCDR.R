# ----------------------------------------------------------
# description: ABCDR Project runs
# position: 5
# ----------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)
library(magclass)
library(gdx)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

#download default input data
#download_and_update(cfg)

# create additional information to describe the runs
cfg$info$flag <- "ABCDR05"

cfg$output <- c("rds_report") # Only run rds_report after model run
cfg$results_folder <- "output/:title:"
cfg$force_replace <- TRUE
cfg$force_download <- FALSE

cfg$qos <- "standby_maxMem_dayMax"
#cfg$qos <- "priority"

# support function to create standardized title
.title <- function(cfg, ...) return(paste(cfg$info$flag, sep="_",...))


cfg$input['regional'] <- "rev4.109_36f73207_magpie.tgz"
cfg$input['validation'] <- "rev4.109_36f73207_validation.tgz"
cfg$input['calibration'] <- "calibration_H16_14Jun24.tgz"
cfg$input['cellular'] <- "rev4.109_36f73207_44a213b6_cellularmagpie_c400_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1_clusterweight-ba4466a8.tgz"

ssp <- "SSP2"

cfg$gms$cropland <- "detail_apr24"
# cfg$gms$croparea <- "detail_apr24"


cfg$gms$scen_countries15  <- isoCountriesEUR
cfg$gms$policy_countries29  <- isoCountriesEUR
cfg$gms$policy_countries30  <- isoCountriesEUR

cfg$gms$s29_treecover_penalty <- 5000
cfg$gms$s30_betr_penalty <- 5000

for (pol in c("NDC","1p5deg")) {
  for (diet in c("dietDefault","dietShift")) {
    for (AFS in c("SRC","treeCover")) {
        for (shr in c(0, 0.01, 0.05, 0.1, 0.2)) {
          cfg$title <- .title(cfg, paste(ssp,pol,diet,paste0(AFS,sprintf("%02d",shr*100)),sep="-"))
          if (pol == "NDC") {
            cfg <- setScenario(cfg,c(ssp,"NDC","rcp4p5"))
            cfg$input['cellular'] <- "rev4.109_36f73207_30c9dc61_cellularmagpie_c400_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1_clusterweight-ba4466a8.tgz"
            cfg$gms$c56_mute_ghgprices_until <- "y2150"
            cfg$gms$c56_pollutant_prices <- paste0("R32M46-", if (ssp=="SSP2") "SSP2EU" else ssp,"-NDC")
            cfg$gms$c60_2ndgen_biodem    <- paste0("R32M46-", if (ssp=="SSP2") "SSP2EU" else ssp,"-NDC")
          } else if (pol == "1p5deg") {
            cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9"))
            cfg$input['cellular'] <- "rev4.109_36f73207_bc624950_cellularmagpie_c400_MRI-ESM2-0-ssp119_lpjml-8e6c5eb1_clusterweight-ba4466a8.tgz"
            cfg$gms$c56_mute_ghgprices_until <- "y2030"
            cfg$gms$c56_pollutant_prices <- paste0("R32M46-", if (ssp=="SSP2") "SSP2EU" else ssp,"-PkBudg650")
            cfg$gms$c60_2ndgen_biodem    <- paste0("R32M46-", if (ssp=="SSP2") "SSP2EU" else ssp,"-PkBudg650")
          }
          if (diet == "dietShift") cfg <- setScenario(cfg,"eat_lancet_diet")
          if (AFS == "SRC") {
            cfg$gms$s29_treecover_target <- 0
            cfg$gms$s30_betr_target <- shr
          } else if (AFS == "treeCover") {
            cfg$gms$s29_treecover_target <- shr
            cfg$gms$s30_betr_target <- 0
          }
          start_run(cfg, codeCheck = FALSE)
      }
    }
  }
}
