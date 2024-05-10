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
library(gdx)
library(magpie4)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

# create additional information to describe the runs
cfg$info$flag <- "V14LRc500"

cfg$results_folder <- "output/:title:"
cfg$results_folder_highres <- "output"
cfg$force_replace <- TRUE
cfg$qos <- "priority_maxMem"
#cfg$qos <- "standby_maxMem_dayMax"

# support function to create standardized title
.title <- function(cfg, ...) return(paste(cfg$info$flag, sep="_",...))


# EUR <- "ALB,AUT,BEL,BGR,CYP,CZE,DEU,DNK,ESP,EST,FIN,FRA,FRO,
#                 GBR,GGY,GIB,GRC,HRV,HUN,IMN,IRL,ITA,JEY,LTU,LUX,LVA,MLT,
#                 NLD,POL,PRT,ROU,SVK,SVN,SWE"

ssp <- "SSP2"
#cfg$input['calibration'] <- "calibration_H12c400_16Apr24.tgz"
cfg$input['calibration'] <- "calibration_H12c500_15Apr24.tgz"
cfg$gms$c_timesteps <- "5year"

limitAff <- function(cfg,gdx) {
  #download input files with high resolution
  download_and_update(cfg)

  # #get tau from low resolution run
  # ov_tau <- readGDX(gdx, "ov_tau",select=list(type="level"))
  # write.magpie(ov_tau,"modules/13_tc/input/f13_tau_scenario.csv")
  # cfg$gms$tc <- "exo"

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
  return(cfg)
}


cfg$output <- c("rds_report")
cfg$sequential <- TRUE
cfg$title <- .title(cfg, paste(ssp,"1p5deg","PricePeatOff","AffEndo",sep="-"))
cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9","ForestryEndo"))
#cfg$input['cellular'] <- "rev4.104_h12_6aa915b6_cellularmagpie_c400_MRI-ESM2-0-ssp119_lpjml-8e6c5eb1.tgz"
cfg$input['cellular'] <- "rev4.104_h12_4c83b5e5_cellularmagpie_c500_MRI-ESM2-0-ssp119_lpjml-8e6c5eb1.tgz"
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$gms$c56_pollutant_prices <- paste0("R32M46-",ifelse(ssp=="SSP2",paste0(ssp,"EU"),ssp),"-PkBudg650")
cfg$gms$c60_2ndgen_biodem    <- paste0("R32M46-",ifelse(ssp=="SSP2",paste0(ssp,"EU"),ssp),"-PkBudg650")
cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
start_run(cfg, codeCheck = FALSE)
cfg$sequential <- FALSE

PricePeatOff <- .title(cfg, paste(ssp,"1p5deg","PricePeatOff","AffEndo",sep="-"))

#limitAff runs
cfg$output <- c("extra/highres", "extra/disaggregation", "rds_report", "rds_report_iso")

cfg$title <- .title(cfg, paste(ssp,"NDC",sep="-"))
cfg <- setScenario(cfg,c(ssp,"NDC","rcp4p5","ForestryEndo"))
#cfg$input['cellular'] <- "rev4.104_h12_3d941455_cellularmagpie_c400_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1.tgz"
cfg$input['cellular'] <- "rev4.104_h12_9ab12c13_cellularmagpie_c500_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1.tgz"
cfg <- limitAff(cfg,file.path("output",PricePeatOff,"fulldata.gdx"))
cfg$gms$c56_mute_ghgprices_until <- "y2150"
cfg$gms$c56_pollutant_prices <- paste0("R32M46-",ifelse(ssp=="SSP2",paste0(ssp,"EU"),ssp),"-NDC")
cfg$gms$c60_2ndgen_biodem    <- paste0("R32M46-",ifelse(ssp=="SSP2",paste0(ssp,"EU"),ssp),"-NDC")
cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
start_run(cfg, codeCheck = FALSE)

cfg$title <- .title(cfg, paste(ssp,"1p5deg","PricePeatOff",sep="-"))
cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9","ForestryEndo"))
#cfg$input['cellular'] <- "rev4.104_h12_6aa915b6_cellularmagpie_c400_MRI-ESM2-0-ssp119_lpjml-8e6c5eb1.tgz"
cfg$input['cellular'] <- "rev4.104_h12_4c83b5e5_cellularmagpie_c500_MRI-ESM2-0-ssp119_lpjml-8e6c5eb1.tgz"
cfg <- limitAff(cfg,file.path("output",PricePeatOff,"fulldata.gdx"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$gms$c56_pollutant_prices <- paste0("R32M46-",ifelse(ssp=="SSP2",paste0(ssp,"EU"),ssp),"-PkBudg650")
cfg$gms$c60_2ndgen_biodem    <- paste0("R32M46-",ifelse(ssp=="SSP2",paste0(ssp,"EU"),ssp),"-PkBudg650")
cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_nopeat"
start_run(cfg, codeCheck = FALSE)

cfg$title <- .title(cfg, paste(ssp,"1p5deg","PricePeatCO2",sep="-"))
cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9","ForestryEndo"))
#cfg$input['cellular'] <- "rev4.104_h12_6aa915b6_cellularmagpie_c400_MRI-ESM2-0-ssp119_lpjml-8e6c5eb1.tgz"
cfg$input['cellular'] <- "rev4.104_h12_4c83b5e5_cellularmagpie_c500_MRI-ESM2-0-ssp119_lpjml-8e6c5eb1.tgz"
cfg <- limitAff(cfg,file.path("output",PricePeatOff,"fulldata.gdx"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$gms$c56_pollutant_prices <- paste0("R32M46-",ifelse(ssp=="SSP2",paste0(ssp,"EU"),ssp),"-PkBudg650")
cfg$gms$c60_2ndgen_biodem    <- paste0("R32M46-",ifelse(ssp=="SSP2",paste0(ssp,"EU"),ssp),"-PkBudg650")
cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_peatCO2only"
start_run(cfg, codeCheck = FALSE)

cfg$title <- .title(cfg, paste(ssp,"1p5deg","PricePeatGHG",sep="-"))
cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9","ForestryEndo"))
#cfg$input['cellular'] <- "rev4.104_h12_6aa915b6_cellularmagpie_c400_MRI-ESM2-0-ssp119_lpjml-8e6c5eb1.tgz"
cfg$input['cellular'] <- "rev4.104_h12_4c83b5e5_cellularmagpie_c500_MRI-ESM2-0-ssp119_lpjml-8e6c5eb1.tgz"
cfg <- limitAff(cfg,file.path("output",PricePeatOff,"fulldata.gdx"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$gms$c56_pollutant_prices <- paste0("R32M46-",ifelse(ssp=="SSP2",paste0(ssp,"EU"),ssp),"-PkBudg650")
cfg$gms$c60_2ndgen_biodem    <- paste0("R32M46-",ifelse(ssp=="SSP2",paste0(ssp,"EU"),ssp),"-PkBudg650")
cfg$gms$c56_emis_policy <- "reddnatveg_nosoil"
start_run(cfg, codeCheck = FALSE)

cfg$title <- .title(cfg, paste(ssp,"1p5deg","PricePeatGHG_CH4GWP20",sep="-"))
cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9","ForestryEndo"))
#cfg$input['cellular'] <- "rev4.104_h12_6aa915b6_cellularmagpie_c400_MRI-ESM2-0-ssp119_lpjml-8e6c5eb1.tgz"
cfg$input['cellular'] <- "rev4.104_h12_4c83b5e5_cellularmagpie_c500_MRI-ESM2-0-ssp119_lpjml-8e6c5eb1.tgz"
cfg <- limitAff(cfg,file.path("output",PricePeatOff,"fulldata.gdx"))
cfg$gms$c56_mute_ghgprices_until <- "y2030"
cfg$gms$c56_pollutant_prices <- paste0("R32M46-",ifelse(ssp=="SSP2",paste0(ssp,"EU"),ssp),"-PkBudg650")
cfg$gms$c60_2ndgen_biodem    <- paste0("R32M46-",ifelse(ssp=="SSP2",paste0(ssp,"EU"),ssp),"-PkBudg650")
cfg$gms$c56_emis_policy <- "reddnatveg_nosoil_CH4GWP20"
start_run(cfg, codeCheck = FALSE)
