# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: extract inms-report in mif format from run
# comparison script: FALSE
# ---------------------------------------------------------------

#Version 1.00 - Benjamin Leon Bodirsky
# 1.00: first working version

library(lucode2)
library(magpie4)
library(magpiesets)
library(iamc)
library(gms)
print("Start inms reporting reg runscript")

############################# BASIC CONFIGURATION #######################################

if(!exists("source_include")) {

  title     <- "inms_SSP2_RCP4p5_PolicyLow_v4"
  outputdir <- "output/inms_SSP2_RCP4p5_PolicyLow_v4_2020-07-13_15.37.07"

  ###Define arguments that can be read from command line
  readArgs("outputdir", "title")
}
#########################################################################################

print(paste0("script started for output directory", outputdir))

withr::local_dir(outputdir)

cfg <- gms::loadConfig("config.yml")
title <- cfg$title
print("generating INMS output for the run: ")
print(title)

filename <- paste0("report_", title, ".mif")
gdx <- paste0("fulldata.gdx")
a <- getReportINMS(gdx, file = filename, scenario = title, dir = ".")

print(filename)
mif <- read.report(filename)


missingyears <- function(x) {
  history <- paste0("y", 1965 + ((0:5) * 5))
  x[[1]][[1]] <- time_interpolate(x[[1]][[1]],
                                  interpolated_year = c(history,paste0("y",2005+((0:9)*10))),
                                  integrate_interpolated_years = TRUE)
  x[[1]][[1]][, history, ] <- 0
  return(x)
}

#a=c(missingyears(ssp1),missingyears(ssp2))
a <- missingyears(mif)

write.reportProject(a, mapping = paste0(wdbefore, "/mapping_inms.csv"), file = "report_inms.mif")
#write.report(a,file="magpie_results_nov2019.mif")
warnings()
