# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test marginal abatement costs
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

prefix <- "maccs_test_v10"

for(ssp in c("SSP1","SSP2","SSP3","SSP4","SSP5")){
    source("config/default.cfg")
    cfg=setScenario(cfg=cfg,scenario=ssp)
    cfg$title <- paste(prefix,"newdefault",ssp,sep="_")
    start_run(cfg,codeCheck=FALSE)

    source("config/default.cfg")
    cfg=setScenario(cfg=cfg,scenario=ssp)
    cfg$title <- paste(prefix,"newdefault_mitigation",ssp,sep="_")
    cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"     # def = R21M42-SSP2-NPi
    cfg$gms$c56_pollutant_prices_noselect <- "R21M42-SSP2-PkBudg900"     # def = R21M42-SSP2-NPi
    start_run(cfg,codeCheck=FALSE)

    source("config/default.cfg")
    cfg=setScenario(cfg=cfg,scenario=ssp)
    cfg$title <- paste(prefix,"newsetup_maxmaccs",ssp,sep="_")
    cfg$gms$s57_maxmac_n_soil  <- 201   # def = -1
    cfg$gms$s57_maxmac_n_awms  <- 201   # def =  -1
    cfg$gms$s57_maxmac_ch4_rice   <- 201   # def =  -1
    cfg$gms$s57_maxmac_ch4_entferm <- 201   # def =  -1
    cfg$gms$s57_maxmac_ch4_awms  <- 201   # def =  -1
    start_run(cfg,codeCheck=FALSE)
}
