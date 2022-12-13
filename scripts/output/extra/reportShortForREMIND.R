# |  (C) 2008-2022 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Write only those variables into a report that are relevant for the REMIND coupling
# comparison script: FALSE
# position: 2
# ---------------------------------------------------------------


library(magclass)
library(magpie4)
library(lucode2)
library(quitte)
library(gms)
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- "/p/projects/remind/runs/REMIND-MAgPIE-2022-10-12/magpie/output/C_SDP-PkBudg1150-mag-4"
  readArgs("outputdir")
}

cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
gdx	<- file.path(outputdir, "fulldata.gdx")
mif <- paste0(outputdir, "/report.mif")
###############################################################################

getReportShortForRemind <- function(gdx, file = NULL, scenario = NULL, filter = c(1, 2, 7),
                                    detail = TRUE, dir = ".", ...) {
  tryReport <- function(report, width, gdx) {
    regs <- c(readGDX(gdx, "i"), "GLO")
    years <- readGDX(gdx, "t")
    message("   ", format(report, width = width), appendLF = FALSE)
    t <- system.time(x <- try(eval(parse(text = paste0("suppressMessages(", report, ")"))), silent = TRUE))
    t <- paste0(" ", format(t["elapsed"], nsmall = 2, digits = 2), "s")
    if (is(x, "try-error")) {
      message("ERROR", t)
      x <- NULL
    } else if (is.null(x)) {
      message("no return value", t)
      x <- NULL
    } else if (is.character(x)) {
      message(x, t)
      x <- NULL
    } else if (!is.magpie(x)) {
      message("ERROR - no magpie object", t)
      x <- NULL
    } else if (!setequal(getYears(x), years)) {
      message("ERROR - wrong years", t)
      x <- NULL
    } else if (!setequal(getItems(x, dim = 1), regs)) {
      message("ERROR - wrong regions", t)
      x <- NULL
    } else if (any(grepl(".", getNames(x), fixed = TRUE))) {
      message("ERROR - data names contain dots (.)", t)
      x <- NULL
    } else {
      message("success", t)
    }
    return(x)
  }
  
  tryList <- function(..., gdx) {
    width <- max(nchar(c(...))) + 1
    return(lapply(unique(list(...)), tryReport, width, gdx))
  }
  
  message("Start getReportShortForRemind(gdx)...")
  
  t <- system.time(
    output <- tryList("reportDemandBioenergy(gdx,detail=detail)",
                      "reportEmissions(gdx)",
                      "reportCosts(gdx)",
                      "reportPriceBioenergy(gdx)",
                      gdx = gdx
    )
  )
  
  message(paste0("Total runtime:  ", format(t["elapsed"], nsmall = 2, digits = 2), "s"))
  
  output <- .filtermagpie(mbind(output), gdx, filter = filter)
  
  getSets(output, fulldim = FALSE)[3] <- "variable"
  
  if (!is.null(scenario)) {
    output <- add_dimension(output,
                            dim = 3.1,
                            add = "scenario",
                            nm = gsub(".", "_", scenario, fixed = TRUE)
    )
  }
  output <- add_dimension(output, dim = 3.1, add = "model", nm = "MAgPIE")
  
  missingUnit <- !grepl("\\(.*\\)", getNames(output))
  if (any(missingUnit)) {
    warning("Some units are missing in getReportShortForRemind!")
    warning("Missing units in:", getNames(output)[which(!grepl("\\(.*\\)", getNames(output)) == TRUE)])
    getNames(output)[missingUnit] <- paste(getNames(output)[missingUnit], "( )")
  }
  if (!is.null(file)) {
    write.report2(output, file = file, ...)
  } else {
    return(output)
  }
}

report <- getReportShortForRemind(gdx, scenario = cfg$title)
write.report(report, file = mif)
