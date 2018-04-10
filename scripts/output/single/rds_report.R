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
rda <- paste0(outputdir, "/",make.names(paste0("report_",normalizePath(outputdir))),".rda")
###############################################################################


report <- getReport(gdx,scenario = cfg$title)
saveRDS(as.quitte(report),file=rda)
