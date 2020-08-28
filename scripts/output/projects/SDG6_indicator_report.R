# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: copy water availability data from preprocessing
# comparison script: FALSE
# ---------------------------------------------------------------

# Version 1.00 - Felicitas Beier
# 1.00: first working version

library(lucode2)
library(magpie4)

print("Start SDG6 indicator report preparation")

############################# BASIC CONFIGURATION #######################################

if(!exists("source_include")) {
  
  title       <- "inms_SSP2_RCP4p5_PolicyLow_v4"
  outputdir   <- "output/inms_SSP2_RCP4p5_PolicyLow_v4_2020-07-13_15.37.07"
  
  ### Define arguments that can be read from command line
  readArgs("outputdir","title")
}
#########################################################################################

print(paste0("script started for output directory ",outputdir))

load(paste0(outputdir, "/config.Rdata"))
title <- cfg$title
print("copying water availability data for the run: ")
print(title)

# cluster-level data from preprocessing
tgz <- paste0("/p/projects/landuse/data/input/archive/",cfg$input[1])
# Move necessary inputs to output folder
untar(tarfile = tgz, files = c("lpj_watavail_total_c200.mz","lpj_watavail_grper_c200.mz","lpj_envflow_total_c200.mz","lpj_envflow_grper_c200.mz"), exdir=outputdir)
print("copied files:")
print(c("lpj_watavail_total_c200.mz","lpj_watavail_grper_c200.mz","lpj_envflow_total_c200.mz","lpj_envflow_grper_c200.mz"))
