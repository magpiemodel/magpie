# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: extract report in rds format from run
# comparison script: FALSE
# position: 1
# ---------------------------------------------------------------


library(magclass)
library(magpie4)
library(lucode2)
library(quitte)
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- "/p/projects/landuse/users/miodrag/projects/tests/flexreg/output/H12_setup1_2016-11-23_12.38.56/"
  readArgs("outputdir")
}

load(paste0(outputdir, "/config.Rdata"))
gdx	<- path(outputdir,"fulldata.gdx")
rds <- paste0(outputdir, "/report.rds")
runstatistics <- paste0(outputdir,"/runstatistics.rda")
resultsarchive <- "/p/projects/rd3mod/models/results/magpie"
###############################################################################


report <- getReport(gdx,scenario = cfg$title)
q <- as.quitte(report)
if(all(is.na(q$value))) stop("No values in reporting!")

saveRDS(q,file=rds)

if(file.exists(runstatistics) & dir.exists(resultsarchive)) {
  stats <- list()
  load(runstatistics)
  if(is.null(stats$id)) {
    # create an id if it does not exist (which means that statistics have not
    # been saved to the archive before) and save statistics to the archive
    message("No id found in runstatistics.rda. Calling lucode2::runstatistics() to create one.")
    stats <- lucode2::runstatistics(file = runstatistics, submit = cfg$runstatistics)
    message("Created the id ",stats$id)
    # save stats locally (including id) otherwise it would generate a new id (and
    # resubmit the results and the statistics) next time rds_report is executed
    save(stats, file=runstatistics, compress="xz")
  }

  # Save report to results archive
  saveRDS(q,file=paste0(resultsarchive,"/",stats$id,".rds"))
  cwd <- getwd()
  setwd(resultsarchive)
  system("ls 1*.rds > files")
  setwd(cwd)
}
