# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de

library(mip)
library(magpie4)

############################# BASIC CONFIGURATION #############################
if(!exists("source_include")) {
  outputdirs    <-"."
}
hist    <- "input/validation.mif"
file    <- paste0("comparison_validation_",format(Sys.time(), "%Y%H%M%S"),".pdf")
###############################################################################

x <- NULL; i <- 1
for(outputdir in outputdirs) {
  config <- path(outputdir,"config.Rdata")
  if(file.exists(config)) {
    load(config)
    title <- cfg$title
  } else {
    title <- paste0("run",i)
  }
  gdx <- paste0(outputdir, "/fulldata.gdx")
  if(!is.null(x)) {
    scenarios <- getNames(x,dim=2)
    if(title %in% scenarios) {
      title <- tail(make.unique(c(scenarios,title),sep=""),n=1)
    }
  }
  tmp <- getReport(gdx, scenario=sub(".","_",title,fixed = TRUE))
  x <- mbind(x,tmp)
  i <- i+1
}

validationpdf(x=x, hist=hist, file = file, style="comparison")
