# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

library(magclass)
library(magpie4)
library(lucode)
options("magclass.verbosity" = 1)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  
  outputdir <- "/p/projects/landuse/users/miodrag/projects/tests/flexreg/output/H12_setup1_2016-11-23_12.38.56/"
    
  readArgs("outputdir")
} 
###############################################################################

gdx	<- path(outputdir,"fulldata.gdx")
mif <- path(outputdir, "report.mif")
report <- getReport(gdx)
write.report2(report, file=mif)

