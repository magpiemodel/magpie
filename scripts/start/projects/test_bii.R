# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Paper Climate vs. Nature
# ----------------------------------------------------------


######################################
#### Script to start a MAgPIE run ####
######################################

library(gms)
library(lucode2)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
#cfg$gms$c52_carbon_scenario  <- "nocc"
#cfg$gms$c59_som_scenario  <- "nocc"

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"
cfg$output <- c("rds_report","extra/disaggregation")#"extra/highres"

#CN14: 5000
#CN15: 4000
#CN16: 2000
#CN17: 3000
#CN16: 2000 + default coeff

prefix <- "BII04"
#cfg$gms$past <- "manpast_rangeland"
#cfg$gms$s31_fac_req_past  <- 100

cfg$qos <- "priority"

# cfg$gms$s80_optfile <- 1
# cfg$gms$s80_maxiter <- 30

# cfg$gms$s32_planing_horizon <- 50

#cfg$gms$c56_emis_policy <- "redd+_nosoil"
#cfg$gms$s56_ghgprice_phase_in <- 1

#cfg$recalibrate <- TRUE
cfg$gms$biodiversity <- "bv_btc_mar22"

#ref
for (price in c(500,1000,2000,3000,4000)) {
  for (ssp in c("SSP2")) {
      cfg <- setScenario(cfg,c(ssp,"NDC","rcp7p0"))
      cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"#"PIK_NPI"
      cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"#"PIK_NPI"
      cfg$gms$c60_biodem_level <- 1
      cfg$gms$s32_aff_plantation <- 0
      cfg$gms$s32_aff_bii_coeff <- 0
      cfg$gms$s44_price_bii_weighted_loss <- price
      cfg$gms$c35_protect_scenario <- "BH_IFL"
      cfg$gms$c30_set_aside_target <- "by2030"
      cfg$gms$s30_set_aside_shr <- 0.2
     
    cfg$title <- paste(prefix,paste0(ssp,"-",price),sep="_")
    # download_and_update(cfg)
    # a<-read.magpie("modules/44_biodiversity/bv_btc_mar21/input/f44_price_biodiv_loss.csv")
    # a[,getYears(a,as.integer = TRUE) <= 2020,] <- 0
    # a[,getYears(a,as.integer = TRUE) > 2020,"p10"] <- 1000
    # write.magpie(a,"modules/44_biodiversity/bv_btc_mar21/input/f44_price_biodiv_loss.csv")
    start_run(cfg,codeCheck=FALSE)
    #    cfg$recalibrate <- FALSE
  }
}
