# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: create cellular cropland management data
# comparison script: FALSE
# ---------------------------------------------------------------

#Version 1.00 - Benjamin Leon Bodirsky
# 1.00: first working version

library(lucode2)
library(magpie4)
library(gms)

print("Start inms reporting reg runscript")

############################# BASIC CONFIGURATION #######################################

if(!exists("source_include")) {

  title       <- "inms_SSP2_RCP4p5_PolicyLow_v4"
  outputdir       <- "output/inms_SSP2_RCP4p5_PolicyLow_v4_2020-07-13_15.37.07"

  ###Define arguments that can be read from command line
  readArgs("outputdir","title")
}
#########################################################################################

print(paste0("script started for output directory ",outputdir))

cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
title <- cfg$title
print("generating INMS output for the run: ")
print(title)

gdx <- paste0(outputdir,"/fulldata.gdx")

tgz <- paste0("/p/projects/landuse/data/input/archive/",strsplit(cfg$input[1],split = "c200")[[1]][[1]],"0.5.tgz")
print(paste0("trying to extract lpj_yields_0.5.mz from ",tgz))
untar(tarfile = tgz, files = "lpj_yields_0.5.mz", exdir=outputdir)

print("create an separate output directory for cellular results")
outputpath<-paste0("./output/",title,"/")
dir.create(outputpath)
print("save origin path in folder so that original run data can be found")
write.table(x = outputdir,file = paste0(outputpath,"origin_folder.txt"),row.names = FALSE,col.names = FALSE)

print("starting cellular output generation using getReportMAgPIE2LPJmL")

a <- getReportMAgPIE2LPJmL(gdx = gdx,
                           folder=outputpath,
                           dir = outputdir)
