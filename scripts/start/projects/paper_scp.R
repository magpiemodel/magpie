# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: SCP paper runs
# ----------------------------------------------------------


######################################
#### Script to start a MAgPIE run ####
######################################

library(gms)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

#cfg$force_download <- TRUE

cfg$results_folder <- "output/:title:"
cfg$output <- c("rds_report")

cfg <- setScenario(cfg,c("SSP2","NPI"))

prefix <- "SCP30"
cfg$gms$s80_optfile <- 1
cfg$gms$s80_maxiter <- 5

cfg$gms$s15_elastic_demand <- 0

cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"

for (pol in c("Ref","1p5deg")) {
  for (scp_level in c(0,20,50,80)) {
    for (scp_type in c("mixed")) {
      if (pol == "Ref") {
        cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
        cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"
      } else if (pol == "1p5deg") {
        cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
        cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"
      }
      cfg$title <- paste(prefix,paste0("SSP2-",pol,"-BioTech",scp_level),scp_type,sep="_")
      cfg$gms$c20_scp_type <- scp_type
      if (scp_level == 0) scp_scen <- "constant" else if (scp_level == 20) scp_scen <- "sigmoid_80pc_20_50" else if (scp_level == 50) scp_scen <- "sigmoid_50pc_20_50" else if (scp_level == 80) scp_scen <- "sigmoid_20pc_20_50"
      cfg$gms$c15_rumdairy_scp_scen <- scp_scen
      start_run(cfg,codeCheck=FALSE)
    }
  }
}


# for (scp_level in c(0,20,50,80)) {
#   for (scp_type in c("mixed", "methane", "sugar", "cellulose","hydrogen")) {
#     cfg$title <- paste(prefix,paste0("SSP2-BioTech",scp_level),scp_type,sep="_")
#     cfg$gms$c20_scp_type <- scp_type
#     if (scp_level == 0) scp_scen <- "constant" else if (scp_level == 20) scp_scen <- "sigmoid_80pc_20_50" else if (scp_level == 50) scp_scen <- "sigmoid_50pc_20_50" else if (scp_level == 80) scp_scen <- "sigmoid_20pc_20_50"
#     cfg$gms$c15_rumdairy_scp_scen <- scp_scen
#     start_run(cfg,codeCheck=FALSE)
#   }
# }

# ### Ref
# cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
# cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"
# 
# cfg$title <- paste0(prefix,"_SSP2_Ref_SCPoff")
# cfg$gms$c20_scp_type <- "mixed"
# cfg$gms$c15_rumdairy_scp_scen <- "constant"
# cfg$gms$c70_cereal_scp_scen <- "constant"
# cfg$gms$c70_foddr_scp_scen <- "constant"
# start_run(cfg,codeCheck=FALSE)
# 
# cfg$title <- paste0(prefix,"_SSP2_Ref_SCPfood")
# cfg$gms$c20_scp_type <- "mixed"
# cfg$gms$c15_rumdairy_scp_scen <- "sigmoid_20pc_20_50"
# cfg$gms$c70_cereal_scp_scen <- "constant"
# cfg$gms$c70_foddr_scp_scen <- "constant"
# start_run(cfg,codeCheck=FALSE)
# 
# cfg$title <- paste0(prefix,"_SSP2_Ref_SCPfeed")
# cfg$gms$c20_scp_type <- "mixed"
# cfg$gms$c15_rumdairy_scp_scen <- "constant"
# cfg$gms$c70_cereal_scp_scen <- "sigmoid_20pc_20_50"
# cfg$gms$c70_foddr_scp_scen <- "sigmoid_20pc_20_50"
# start_run(cfg,codeCheck=FALSE)
# 
# cfg$title <- paste0(prefix,"_SSP2_Ref_SCPfoodfeed")
# cfg$gms$c20_scp_type <- "mixed"
# cfg$gms$c15_rumdairy_scp_scen <- "sigmoid_20pc_20_50"
# cfg$gms$c70_cereal_scp_scen <- "sigmoid_20pc_20_50"
# cfg$gms$c70_foddr_scp_scen <- "sigmoid_20pc_20_50"
# start_run(cfg,codeCheck=FALSE)
# 
# ### Pol
# cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600"
# cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600"
# 
# cfg$title <- paste0(prefix,"_SSP2_Pol_SCPoff")
# cfg$gms$c20_scp_type <- "mixed"
# cfg$gms$c15_rumdairy_scp_scen <- "constant"
# cfg$gms$c70_cereal_scp_scen <- "constant"
# cfg$gms$c70_foddr_scp_scen <- "constant"
# start_run(cfg,codeCheck=FALSE)
# 
# cfg$title <- paste0(prefix,"_SSP2_Pol_SCPfood")
# cfg$gms$c20_scp_type <- "mixed"
# cfg$gms$c15_rumdairy_scp_scen <- "sigmoid_20pc_20_50"
# cfg$gms$c70_cereal_scp_scen <- "constant"
# cfg$gms$c70_foddr_scp_scen <- "constant"
# start_run(cfg,codeCheck=FALSE)
# 
# cfg$title <- paste0(prefix,"_SSP2_Pol_SCPfeed")
# cfg$gms$c20_scp_type <- "mixed"
# cfg$gms$c15_rumdairy_scp_scen <- "constant"
# cfg$gms$c70_cereal_scp_scen <- "sigmoid_20pc_20_50"
# cfg$gms$c70_foddr_scp_scen <- "sigmoid_20pc_20_50"
# start_run(cfg,codeCheck=FALSE)
# 
# cfg$title <- paste0(prefix,"_SSP2_Pol_SCPfoodfeed")
# cfg$gms$c20_scp_type <- "mixed"
# cfg$gms$c15_rumdairy_scp_scen <- "sigmoid_20pc_20_50"
# cfg$gms$c70_cereal_scp_scen <- "sigmoid_20pc_20_50"
# cfg$gms$c70_foddr_scp_scen <- "sigmoid_20pc_20_50"
# start_run(cfg,codeCheck=FALSE)
# 