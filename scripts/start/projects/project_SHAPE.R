# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: SHAPE scenarios
# position: 5
# ----------------------------------------------------------


##### Version log (YYYYMMDD - Description - Author(s))
## 20220106 - SHAPE Baseline and Policy runs. For climate policy parametrization, indentical inputs are used across all scenarios ("R21M42-SSP2-PkBudg900") - IW

## Load lucode2 and gms to use setScenario later
library(lucode2)
library(gms)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")


### General configurations

prefix <- "R5_SHAPE"
cfg$results_folder <- "output/:title:"
cfg$output <- c("rds_report") # Only run rds_report after model run



#################################################################
# SSP2: NPI and climate policy runs                                           #
#################################################################

### SSP2 Base (NPI)
cfg$title <- paste(prefix,"SSP2_Base",sep="_")
cfg <- setScenario(cfg,c("SSP2","NPI"))
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"
start_run(cfg,codeCheck=FALSE)

### SSP2 with climate policy parametrized from R21M42-SSP2-PkBudg900
cfg$title <- paste(prefix,"SSP2_Cpol",sep="_")
cfg <- setScenario(cfg,c("SSP2","NDC"))
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"
start_run(cfg,codeCheck=FALSE)


#################################################################
# SDP-RC: NPI and climate policy runs                         #
#################################################################

#### SDP-RC Base (NPI)
cfg$title <- paste(prefix,"SDP-RC_Base",sep="_")
cfg <- setScenario(cfg,c("SDP-RC","NPI"))
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"
start_run(cfg,codeCheck=FALSE)

### SDP-RC with climate policy parametrized from R21M42-SSP2-PkBudg900
cfg$title <- paste(prefix,"SDP-RC_Cpol",sep="_")
cfg <- setScenario(cfg,c("SDP-RC","NDC"))
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"
start_run(cfg,codeCheck=FALSE)


#################################################################
# SDP-MC: NPI and climate policy runs                         #
#################################################################

#### SDP-MC Base (NPI)
cfg$title <- paste(prefix,"SDP-MC_Base",sep="_")
cfg <- setScenario(cfg,c("SDP-MC","NPI"))
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"
start_run(cfg,codeCheck=FALSE)

### SDP-MC with climate policy parametrized from R21M42-SSP2-PkBudg900
cfg$title <- paste(prefix,"SDP-MC_Cpol",sep="_")
cfg <- setScenario(cfg,c("SDP-MC","NDC"))
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"
start_run(cfg,codeCheck=FALSE)


#################################################################
# SDP-EI: NPI and climate policy runs                         #
#################################################################


#### SDP-EI Base (NPI)
cfg$title <- paste(prefix,"SDP-EI_Base",sep="_")
cfg <- setScenario(cfg,c("SDP-EI","NPI"))
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"
start_run(cfg,codeCheck=FALSE)

### SDP-EI with climate policy parametrized from R21M42-SSP2-PkBudg900
cfg$title <- paste(prefix,"SDP-EI_Cpol",sep="_")
cfg <- setScenario(cfg,c("SDP-EI","NDC"))
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"
start_run(cfg,codeCheck=FALSE)


#reset:
cfg$gms$kfo_rd <- "livst_rum,livst_milk"





#####################################################################
# Additional scenarios                                                                                                                 #
#####################################################################

###############################
# SSP1: NPI and climate policy runs   #

### SSP1 Base (NPI)
cfg$title <- paste(prefix,"SSP1_Base",sep="_")
cfg <- setScenario(cfg,c("SSP1","NPI"))
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"
start_run(cfg,codeCheck=FALSE)

### SSP1 with climate policy parametrized from R21M42-SSP2-PkBudg900
cfg$title <- paste(prefix,"SSP1_Cpol",sep="_")
cfg <- setScenario(cfg,c("SSP1","NDC"))
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"
start_run(cfg,codeCheck=FALSE)


###############################
# SDP: NPI and climate policy runs   #

### SDP Base (NPI)
cfg$title <- paste(prefix,"SDP_Base",sep="_")
cfg <- setScenario(cfg,c("SDP","NPI"))
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"
start_run(cfg,codeCheck=FALSE)

### SDP with climate policy parametrized from R21M42-SSP2-PkBudg900
cfg$title <- paste(prefix,"SDP_Cpol",sep="_")
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-PkBudg900"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-PkBudg900"
start_run(cfg,codeCheck=FALSE)



#reset:
cfg$gms$c56_pollutant_prices <- "R21M42-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R21M42-SSP2-NPi"
