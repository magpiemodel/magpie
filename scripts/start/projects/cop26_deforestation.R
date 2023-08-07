# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Simulations for COP26 deforestation declaration
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode2)
library(magclass)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

log_folder <- "run_details"
dir.create(log_folder, showWarnings = FALSE)

identifier_flag = "DEF02"

xx <- c()
all_configs <- list()

scen_vector <- c("ForestryEndo")

for (s10_cop26_deforestation in c(0, 1)){

  source("config/default.cfg")

  cfg <- setScenario(cfg, c("SSP2", "NPI", "ForestryEndo"))

  cfg$gms$s10_cop26_deforestation <- s10_cop26_deforestation

  if(cfg$gms$s10_cop26_deforestation == 0) cop26_flag = "BAU"
  if(cfg$gms$s10_cop26_deforestation == 1) cop26_flag = "COP26"

  cfg$title   <- paste(identifier_flag, cop26_flag, sep = "_")

  xx <- c(xx,cfg$title)
  all_configs[[cfg$title]] <- cfg
  cfg$gms$s80_optfile <- 0
  cfg$results_folder <- "output/:title:"
  start_run(cfg,codeCheck=FALSE)
}