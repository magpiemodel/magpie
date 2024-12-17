# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
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
mif <- paste0(outputdir, "/agmip_report.mif")
rds <- paste0(outputdir, "/agmip_report.rds")
###############################################################################

report <- getReportAgMIP(gdx, scenario = cfg$title, dir = outputdir)

for (mapping in c("AgMIP")) {
  missingVariables <- sort(setdiff(unique(deletePlus(getMappingVariables(mapping,"M"))),unique(deletePlus(getNames(report,dim="variable")))))
  if (length(missingVariables) > 0) {
    warning("# The following ", length(missingVariables), " variables are expected in the piamInterfaces package ",
            "for mapping ", mapping, ", but cannot be found in the MAgPIE report.\nPlease either fix in magpie4 or adjust the mapping in piamInterfaces.\n- ",
            paste(missingVariables, collapse = ",\n- "), "\n")
  }
}

### regional aggregation
write.report(report, file = mif, skipempty = FALSE)
saveRDS(as.quitte(report), file = rds)
