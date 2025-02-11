# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: extract report in rds and mif format from run
# comparison script: FALSE
# position: 2
# ---------------------------------------------------------------

# note: set environment variable DATA_CHANGELOG_PATH to prepend to data changelog file

library(magclass)
library(magpie4)
library(lucode2)
library(quitte)
library(gms)
library(piamInterfaces)
library(piamutils)
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if (!exists("source_include")) {
  outputdir <- "/p/projects/landuse/users/miodrag/projects/tests/flexreg/output/H12_setup1_2016-11-23_12.38.56/"
  readArgs("outputdir")
}

cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
gdx <- file.path(outputdir, "fulldata.gdx")
rds <- paste0(outputdir, "/report.rds")
mif <- paste0(outputdir, "/report.mif")
runstatistics  <- paste0(outputdir, "/runstatistics.rda")
resultsarchive <- "/p/projects/rd3mod/models/results/magpie"
###############################################################################


report <- getReport(gdx, scenario = cfg$title, dir = outputdir)

if (!all(grepl(" \\(([^\\()]*)\\)($|\\.)", getNames(report, fulldim = TRUE)$variable))) {
  warning("Variables should be in the format 'name (unit)' (the space between name and unit is important), ",
          "but the following are not:\n",
          paste(grep(" \\(([^\\()]*)\\)($|\\.)", getNames(report, fulldim = TRUE)$variable,
                     invert = TRUE, value = TRUE), collapse = "\n"))
}

for (mapping in c("AR6", "NAVIGATE", "SHAPE", "AR6_MAgPIE")) {
  missingVariables <- sort(setdiff(unique(deletePlus(getMappingVariables(mapping, "M"))),
                                   unique(deletePlus(getNames(report, dim = "variable")))))
  if (length(missingVariables) > 0) {
    warning("# The following ", length(missingVariables), " variables are expected in the piamInterfaces package ",
            "for mapping ", mapping, ", but cannot be found in the MAgPIE report.\n",
            "Please either fix in magpie4 or adjust the mapping in piamInterfaces.\n- ",
            paste(missingVariables, collapse = ",\n- "), "\n")
  }
}

# append to data changelog if DATA_CHANGELOG_PATH is set
changelog <- Sys.getenv("DATA_CHANGELOG_PATH")
if (changelog != "") {
  message("Appending to data changelog at ", changelog)

  # TODO move addToDataChangelog to another place (gms? magpie4?)

  #' addToDataChangelog
  #'
  #' Prepend data from the given report to the changelog.
  #'
  #' @param report data.frame as obtained by readRDS("report.rds")
  #' @param changelog Path to the changelog file
  #' @param versionId The model version identifier, e.g. a release number like 4.9.1 or a data like 2025-02-01
  #' @param years For which years the variables should be read and put into the changelog
  #' @param variables Which variables to read from the report (e.g. "Emissions|CO2|Land|+|Land-use Change")
  #' @param ... Reserved for future expansion.
  #' @param maxEntries The maximum number of versionIds to keep in the changelog, the oldest one is removed first.
  #' @param roundDigits Numbers are rounded to this many decimal places before being written to the changelog.
  #'
  #' @author Pascal Sauer
  #' @export
  addToDataChangelog <- function(report, changelog, versionId, years, variables, ...,
                                 maxEntries = 15, roundDigits = 2) {
    x <- report[report$region == "World"
                & report$variable %in% variables
                & report$period %in% years,
                c("variable", "period", "value")]
    notFound <- setdiff(variables, x$variable)
    if (length(notFound) > 0) {
      warning("No data-changelog data found for ", paste(notFound, collapse = ", "))
    }

    # shorten variable names
    variableNames <- names(variables)
    names(variableNames) <- variables
    x$variable <- variableNames[as.character(x$variable)]

    colnames(x)[ncol(x)] <- rowname

    out <- data.frame(version = setdiff(colnames(x), c("variable", "period")))
    for (variableName in variableNames) {
      for (year in years) {
        newColumn <- x[x$variable == variableName & x$period == year, 3]
        newColumn <- round(newColumn, roundDigits)
        out <- cbind(out, newColumn)
        colnames(out)[ncol(out)] <- paste0(variableName, year)
      }
    }

    if (file.exists(changelog)) {
      out <- rbind(out, read.csv(changelog))
      out <- out[seq_len(min(maxEntries, nrow(out))), ]
    }
    write.csv(out, changelog, quote = FALSE, row.names = FALSE)
    return(invisible(out))
  }

  variables <- c(
    lucEmis = "Emissions|CO2|Land|+|Land-use Change", # +++++
    tau = "Productivity|Landuse Intensity Indicator Tau", # +++++
    cropland = "Resources|Land Cover|+|Cropland", # ++++++
    irrigated = "Resources|Land Cover|Cropland|Area actually irrigated", # +++
    pasture = "Resources|Land Cover|+|Pastures and Rangelands", # ++++
    forest = "Resources|Land Cover|+|Forest", # +++
    other = "Resources|Land Cover|+|Other Land", # ++
    production = "Production", # +++ (in contrast to all other indicators here, this should be robust to calibration issues, but indicate changes in demand/trade)
    costs = "Costs", # ++
    foodExp = "Household Expenditure|Food|Expenditure" # +
  )

  load("runstatistics.rda") # load 'stats'

  addToDataChangelog(report, changelog,
                     rowname = format(stats$date, "%Y-%m-%d"),
                     years = c(2050, 2100),
                     variables = variables)
}

write.report(report, file = mif)

qu <- as.quitte(report)
# as.quitte converts "World" into "GLO". But we want to keep "World" and therefore undo these changes
qu <- droplevels(qu)
levels(qu$region)[levels(qu$region) == "GLO"] <- "World"
qu$region <- factor(qu$region,levels = sort(levels(qu$region)))

if (all(is.na(qu$value))) {
  stop("No values in reporting!")
}

saveRDS(qu, file = rds, version = 2)

if (file.exists(runstatistics) && dir.exists(resultsarchive)) {
  stats <- list()
  load(runstatistics)
  if (is.null(stats$id)) {
    # create an id if it does not exist (which means that statistics have not
    # been saved to the archive before) and save statistics to the archive
    message("No id found in runstatistics.rda. Calling lucode2::runstatistics() to create one.")
    stats <- lucode2::runstatistics(file = runstatistics, submit = cfg$runstatistics)
    message("Created the id ", stats$id)
    # save stats locally (including id) otherwise it would generate a new id (and
    # resubmit the results and the statistics) next time rds_report is executed
    save(stats, file = runstatistics, compress = "xz")
  }

  # Save report to results archive
  saveRDS(qu, file = paste0(resultsarchive, "/", stats$id, ".rds"), version = 2)
  withr::with_dir(resultsarchive, {
    system("find -type f -name '1*.rds' -printf '%f\n' | sort > fileListForShinyresults")
  })
}
