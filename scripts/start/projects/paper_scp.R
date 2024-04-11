# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: SCP/MP paper runs
# ----------------------------------------------------------


######################################
#### Script to start a MAgPIE run ####
######################################

library(gms)
library(lucode2)
library(magclass)

source("scripts/start_functions.R")

source("config/default.cfg")

# prefix, added in front of title
prefix <- "SCP44"

# naming of result folders
cfg$results_folder <- "output/:title:"

# output scripts
cfg$output <- c("rds_report","extra/disaggregation")

#GAMS OptFile
cfg$gms$s80_optfile <- 1
cfg$gms$s80_maxiter <- 30

### Scenario setup
# SSP2 as basis
cfg <- setScenario(cfg,c("SSP2","NPI"))
# single-cell microbial protein production route
cfg$gms$c20_scp_type <- "sugar"
# replacement of ruminant meat with MP
cfg$gms$kfo_rd <- "livst_rum"

# Start MAgPIE runs with varying substitution targets of ruminant meat with MP by 2050, based on protein/cap/day basis
for (MP in c(0,20,50,80)) {
  cfg$title <- paste(prefix,paste0("SSP2-Ref-MP",MP),sep="_")
  if (MP == 0) {
    scp_scen <- "constant" 
  } else if (MP == 20) {
    scp_scen <- "sigmoid_80pc_20_50" 
  } else if (MP == 50) {
    scp_scen <- "sigmoid_50pc_20_50" 
  }else if (MP == 80) {
    scp_scen <- "sigmoid_20pc_20_50"
  }
  cfg$gms$c15_rumdairy_scp_scen <- scp_scen
  start_run(cfg,codeCheck=FALSE)
}
