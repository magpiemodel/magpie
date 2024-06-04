# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: merge agmip-reports of single runs into one project-report
# comparison script: TRUE
# ---------------------------------------------------------------

library(lucode2)
library(magclass)
library(quitte)
library(madrat)
library(piamInterfaces)
library(gms)
library(dplyr)

options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- file.path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  readArgs("outputdir")
}
###############################################################################
cat("\nStarting output generation\n")

missing <- NULL

if (file.exists("output/agmip_report_full.csv")) {
  file.rename("output/agmip_report_full.csv", "output/agmip_report_full.bak")
}

for (i in 1:length(outputdir)) {
  print(paste("Processing", outputdir[i]))
  #gdx file
  rep <- file.path(outputdir[i],"agmip_report.mif")
  if (file.exists(rep)) {
    #get scenario name
    cfg <- gms::loadConfig(file.path(outputdir[i], "config.yml"))
    scen <- cfg$title
    #Remove prefix starting with "V", like "V2"
    scen_parts <- unlist(strsplit(scen, "_"))
    remove     <- grep("V[0-9]", scen_parts)
    if (length(remove) > 0) {
      scen <- paste(scen_parts[-remove], collapse = "_")
    }
    #read-in reporting file
    a <- read.report(rep,as.list = FALSE)
    getNames(a, dim = 1) <- scen
    #add to reporting csv file
    write.report(a, file = "output/agmip_report_full.csv", append = TRUE,
                 ndigit = 4, skipempty = FALSE)
  } else {
    missing <- c(missing, outputdir[i])
  }
}
if (!is.null(missing)) {
  cat("\nList of folders with missing agmip_report.mif\n")
  print(missing)
}

if (file.exists("output/agmip_report_full.csv")) {
  submission <- generateIIASASubmission(
    mifs = "output/agmip_report_full.csv",
    mapping = "AgMIP",
    model = "MAgPIE",
    outputFilename = NULL,
    timesteps = c(seq(1995, 2100, 1)),
    naAction = "na.pass"
  )
  submission <- submission %>%
    mutate(
      "item" := gsub(".*\\.", "", variable),
      "variable" := gsub("\\..*", "", variable)
    ) %>%
    select(
      "Model" = "model",
      "Scenario" = "scenario",
      "Region" = "region",
      "Item" = "item",
      "Variable" = "variable",
      "Year" = "period",
      "Unit" = "unit",
      "Value" = "value"
    )
  write.csv(submission,
    quote = FALSE,
    file = "output/agmip_submission_report.csv",
    row.names = FALSE
  )
}
