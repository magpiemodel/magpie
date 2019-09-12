# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

library(magclass)
library(magpie4)
library(lucode)
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
  if(!is.null(stats$id)) {
    if(file.exists(paste0(resultsarchive,"/",stats$id,".rds"))){
      cat(paste0("Existing rds file ",stats$id," will be deleted and then created from scratch."))
      invisible(file.remove(paste0(resultsarchive,"/",stats$id,".rds")))
      #saveRDS(as.quitte(as.data.frame(0)),file=paste0(resultsarchive,"/",stats$id,"_dummy",".rds"))
    }
    saveRDS(q,file=paste0(resultsarchive,"/",stats$id,".rds"))
    cwd <- getwd()
    setwd(resultsarchive)
    system("ls 1*.rds > files")
    setwd(cwd)
  }
}
