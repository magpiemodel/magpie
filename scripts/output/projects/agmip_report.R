# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: extract agmip-report in rds format from run 
# comparison script: FALSE
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
mif <- paste0(outputdir, "/agmip_report.mif")
rds <- paste0(outputdir, "/agmip_report.rds")
###############################################################################


report <- getReportAgMIP(gdx,scenario = cfg$title)

###regional aggregation

write.report2(report, file=mif)
saveRDS(as.quitte(report),file=rds)
