# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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


library(magclass)
library(magpie4)
library(lucode2)
library(quitte)
library(gms)
library(piamInterfaces)
library(piamutils)
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
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

for (mapping in c("AR6", "NAVIGATE", "SHAPE", "AR6_MAgPIE")) {
  missingVariables <- sort(setdiff(unique(deletePlus(getMappingVariables(mapping,"M"))),unique(deletePlus(getNames(report,dim="variable")))))
  if (length(missingVariables) > 0) {
    warning("# The following ", length(missingVariables), " variables are expected in the piamInterfaces package ",
            "for mapping ", mapping, ", but cannot be found in the MAgPIE report.\nPlease either fix in magpie4 or adjust the mapping in piamInterfaces.\n- ",
            paste(missingVariables, collapse = ",\n- "), "\n")
  }
}

write.report(report, file = mif)

q <- as.quitte(report)
# as.quitte converts "World" into "GLO". But we want to keep "World" and therefore undo these changes
q <- droplevels(q)
levels(q$region)[levels(q$region) == "GLO"] <- "World"
q$region <- factor(q$region,levels = sort(levels(q$region)))

if(all(is.na(q$value))) stop("No values in reporting!")

saveRDS(q, file = rds, version = 2)

if(file.exists(runstatistics) & dir.exists(resultsarchive)) {
  stats <- list()
  load(runstatistics)
  if(is.null(stats$id)) {
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
  saveRDS(q, file = paste0(resultsarchive, "/", stats$id, ".rds"), version = 2)
  cwd <- getwd()
  setwd(resultsarchive)
  system("find -type f -name '1*.rds' -printf '%f\n' | sort > fileListForShinyresults")
  setwd(cwd)
}
