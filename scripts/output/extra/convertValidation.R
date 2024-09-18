# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: converts validation.mif file into validation.rds for use in shinyresults
# comparison script: FALSE
# ---------------------------------------------------------------

#########################
#### convert validation.mif ####
#########################
# Version 1.0, Florian Humpenoeder
#
library(quitte)

options(error=function()traceback(2))

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdir <- file.path("output/",list.dirs("output/", full.names = FALSE, recursive = FALSE))
  #Define arguments that can be read from command line
  lucode2::readArgs("outputdir")
}
###############################################################################
cat("\nStarting output generation\n")


for (i in 1:length(outputdir)) {
  print(paste("Processing",outputdir[i]))
  val<-file.path(outputdir[i],"validation.mif")
  rds <- file.path(outputdir[i],"validation.rds")
  if(file.exists(val)) {
    q <- read.quitte(val)
    # as.quitte converts "World" into "GLO". But we want to keep "World" and therefore undo these changes
    q <- droplevels(q)
    levels(q$region)[levels(q$region) == "GLO"] <- "World"
    q$region <- factor(q$region,levels = sort(levels(q$region)))
    saveRDS(q, file = rds, version = 2)
  }
}
