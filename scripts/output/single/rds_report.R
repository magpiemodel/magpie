# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
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
    saveRDS(q,file=paste0(resultsarchive,"/",stats$id,".rds"))
    cwd <- getwd()
    setwd(resultsarchive)
    system("ls 1*.rds > files")
    setwd(cwd)
  }
}
