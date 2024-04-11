# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: check output for known problems
# comparison script: FALSE
# position: 1
# ---------------------------------------------------------------


library(magpie4,  quietly = TRUE)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- ""
  readArgs("outputdir")
}

gdx <- file.path(outputdir,"fulldata.gdx")
###############################################################################

magpie4::outputCheck(gdx)
