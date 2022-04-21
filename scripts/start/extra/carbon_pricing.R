# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Carbon pricing options
# position: 5
# ----------------------------------------------------------

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

#download default input data
download_and_update(cfg)

# create additional information to describe the runs
cfg$info$flag <- "PR_CO2" 

cfg$output <- c("rds_report") # Only run rds_report after model run
cfg$results_folder <- "output/:title:"
cfg$force_replace <- TRUE

#cfg$gms$c56_carbon_stock_pricing <- "actual"

cfg$gms$c_timesteps <- "quicktest2"

# support function to create standardized title
.title <- function(...) return(paste(cfg$info$flag, sep="_",...))

ssp <- "SSP2"
cfg$title <- .title(paste(ssp,"Ref",sep="-"))
cfg <- setScenario(cfg,c(ssp,"NPI","rcp7p0"))
cfg$gms$c56_pollutant_prices <- paste0("R21M42-",ssp,"-NPi")
cfg$gms$c60_2ndgen_biodem    <- paste0("R21M42-",ssp,"-NPi")
start_run(cfg, codeCheck = TRUE)

#option 0: no change. Version with problems.
c56_carbon_stock_pricing <- "actual"
c56_emis_policy <- "redd+natveg_nosoil"
s56_reward_neg_emis <- 0
for(t in c("coup2100","quicktest2")) {
#  cfg$title <- .title(paste(ssp,"Pk900",t,c56_emis_policy,"RewNeg",s56_reward_neg_emis,substr(c56_carbon_stock_pricing,1,8),sep="-"))
  cfg$title <- .title(paste(ssp,"Pk900","Option0",t,sep="-"))
  cfg$gms$c_timesteps <- t
  cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9"))
  cfg$gms$c56_pollutant_prices <- paste0("R21M42-",ssp,"-PkBudg900")
  cfg$gms$c60_2ndgen_biodem    <- paste0("R21M42-",ssp,"-PkBudg900")
  cfg$gms$c56_emis_policy <- c56_emis_policy
  cfg$gms$s56_reward_neg_emis <- s56_reward_neg_emis
  cfg$gms$c56_carbon_stock_pricing <- c56_carbon_stock_pricing
  start_run(cfg, codeCheck = TRUE)
}


#option 1: minimal change
c56_carbon_stock_pricing <- "previousCarbonDensity"
c56_emis_policy <- "redd+natveg_nosoil"
s56_reward_neg_emis <- 0
for(t in c("coup2100","quicktest2")) {
  #  cfg$title <- .title(paste(ssp,"Pk900",t,c56_emis_policy,"RewNeg",s56_reward_neg_emis,substr(c56_carbon_stock_pricing,1,8),sep="-"))
  cfg$title <- .title(paste(ssp,"Pk900","Option1",t,sep="-"))
  cfg$gms$c_timesteps <- t
  cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9"))
  cfg$gms$c56_pollutant_prices <- paste0("R21M42-",ssp,"-PkBudg900")
  cfg$gms$c60_2ndgen_biodem    <- paste0("R21M42-",ssp,"-PkBudg900")
  cfg$gms$c56_emis_policy <- c56_emis_policy
  cfg$gms$s56_reward_neg_emis <- s56_reward_neg_emis
  cfg$gms$c56_carbon_stock_pricing <- c56_carbon_stock_pricing
  start_run(cfg, codeCheck = TRUE)
}

#option 2: medium change
c56_carbon_stock_pricing <- "actualNoAcEst"
c56_emis_policy <- "redd+natveg_nosoil"
s56_reward_neg_emis <- -Inf
for(t in c("coup2100","quicktest2")) {
  #  cfg$title <- .title(paste(ssp,"Pk900",t,c56_emis_policy,"RewNeg",s56_reward_neg_emis,substr(c56_carbon_stock_pricing,1,8),sep="-"))
  cfg$title <- .title(paste(ssp,"Pk900","Option2",t,sep="-"))
  cfg$gms$c_timesteps <- t
  cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9"))
  cfg$gms$c56_pollutant_prices <- paste0("R21M42-",ssp,"-PkBudg900")
  cfg$gms$c60_2ndgen_biodem    <- paste0("R21M42-",ssp,"-PkBudg900")
  cfg$gms$c56_emis_policy <- c56_emis_policy
  cfg$gms$s56_reward_neg_emis <- s56_reward_neg_emis
  cfg$gms$c56_carbon_stock_pricing <- c56_carbon_stock_pricing
  start_run(cfg, codeCheck = TRUE)
}

#option 3: larger change
c56_carbon_stock_pricing <- "actualNoAcEst"
c56_emis_policy <- "all_nosoil"
s56_reward_neg_emis <- -Inf
for(t in c("coup2100","quicktest2")) {
  #  cfg$title <- .title(paste(ssp,"Pk900",t,c56_emis_policy,"RewNeg",s56_reward_neg_emis,substr(c56_carbon_stock_pricing,1,8),sep="-"))
  cfg$title <- .title(paste(ssp,"Pk900","Option3",t,sep="-"))
  cfg$gms$c_timesteps <- t
  cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9"))
  cfg$gms$c56_pollutant_prices <- paste0("R21M42-",ssp,"-PkBudg900")
  cfg$gms$c60_2ndgen_biodem    <- paste0("R21M42-",ssp,"-PkBudg900")
  cfg$gms$c56_emis_policy <- c56_emis_policy
  cfg$gms$s56_reward_neg_emis <- s56_reward_neg_emis
  cfg$gms$c56_carbon_stock_pricing <- c56_carbon_stock_pricing
  start_run(cfg, codeCheck = TRUE)
}

#option 4: larger change2
c56_carbon_stock_pricing <- "actualNoAcEst"
c56_emis_policy <- "all_vegc"
s56_reward_neg_emis <- -Inf
for(t in c("coup2100","quicktest2")) {
  #  cfg$title <- .title(paste(ssp,"Pk900",t,c56_emis_policy,"RewNeg",s56_reward_neg_emis,substr(c56_carbon_stock_pricing,1,8),sep="-"))
  cfg$title <- .title(paste(ssp,"Pk900","Option4",t,sep="-"))
  cfg$gms$c_timesteps <- t
  cfg <- setScenario(cfg,c(ssp,"NDC","rcp1p9"))
  cfg$gms$c56_pollutant_prices <- paste0("R21M42-",ssp,"-PkBudg900")
  cfg$gms$c60_2ndgen_biodem    <- paste0("R21M42-",ssp,"-PkBudg900")
  cfg$gms$c56_emis_policy <- c56_emis_policy
  cfg$gms$s56_reward_neg_emis <- s56_reward_neg_emis
  cfg$gms$c56_carbon_stock_pricing <- c56_carbon_stock_pricing
  start_run(cfg, codeCheck = TRUE)
}
