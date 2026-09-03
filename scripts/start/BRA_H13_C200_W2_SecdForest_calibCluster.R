# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


# ----------------------------------------------------------
# description: Script using BRA_H13_C200_W2 data (Secd Forest from MapBiomas) 
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


cfg$repositories <- append(list("https://rse.pik-potsdam.de/data/magpie/public"=NULL,
                                "./patch_inputdata"=NULL),
                           getOption("magpie_repos"))

#Input data files to be used for SecdForest data analysis
# cfg$input <- c(regional    = "rev4.129.9001NZB_BRA_H13_C200_W2_SwpFun_5638d5dc_magpie.tgz",
#                cellular    = "rev4.129.9001NZB_BRA_H13_C200_W2_SwpFun_5638d5dc_22226bc0_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1_clusterweight-917fb741.tgz",
#                validation  = "rev4.129.9001NZB_BRA_H13_C200_W2_SwpFun_5638d5dc_92e02314_validation.tgz",
#                additional  = "additional_data_rev4.65.tgz",
#                calibration = "calibration_BRA_H13_C200_W2_SwpFun_Feb26.tgz")
# which input data sets should be used?
cfg$input <- c(regional    = "rev4.131.9001BRA_H13_C200_W3_MapbiomasIBGE_5638d5dc_magpie.tgz",
               cellular    = "rev4.131.9001BRA_H13_C200_W3_MapbiomasIBGE_5638d5dc_d8411e75_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1_clusterweight-d0236589.tgz",
               validation  = "rev4.131.9001BRA_H13_C200_W3_MapbiomasIBGE_5638d5dc_92e02314_validation.tgz",
               additional  = "additional_data_rev4.65.tgz",
               calibration = "calibration_BRA_H13_C200_W2_MapbiomasIBGE_17Jun26.tgz")




# cfg$title <- "calib_cluster_test27jun_W3newTGZ"
cfg$title <- "BRA_test27jun_W3_MapbiomasIBGE"

cfg$gms$c_timesteps          <- "5year2050"

# * (calib):    Costs for cropland expansion are scaled with a regional calibration factor
# *       Costs for pasture and forestry expansion are global static
# * (calib_cluster): Costs for cropland expansion are scaled with a regional calibration factor, which is further scaled
# * on cluster level with the share of cropland in the cluster. Costs for pasture expansion are scaled with a regional calibration factor, 
# * which is further scaled on cluster level with the share of pasture in the cluster. Costs for forestry expansion are global static.
# cfg$gms$landconversion <- "calib_cluster"           # def = calib

# * Switch for ignoring land conversion cost calibration factors
# * Options: 1 (ignore calibration factors)
# *      0 (use calibration factors)
# cfg$gms$s39_ignore_calib <- 0           #def = 0

start_run(cfg,codeCheck = FALSE)
