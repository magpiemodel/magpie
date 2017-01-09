# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

# creates report of MAgPIE runs in parallel (which save a lot of time) and writes all scenario results in one file (output/report.csv)
# Florian Humpenoeder, Jun 22 2016

library(parallel)
library(foreach)
library(doParallel)
library(magpie)
no_cores <- detectCores() - 1
cl <- makeCluster(no_cores,outfile="par_debug.txt")

rep_dim_names <- c("region","year","scenario.model.variable")

collect <- function(x) {
  foreach(scenario = x, 
          .combine = mbind,
          .packages = "magpie",
          .export = "rep_dim_names")  %dopar% {
            gdx <- path("output",scenario,"fulldata.gdx")
            x <- getReport(gdx)
            getNames(x) <- paste(scenario,"MAgPIE",getNames(x),sep=".")
            names(dimnames(x)) <- rep_dim_names
            return(x)
          }
}

registerDoParallel(cl)
all <- collect(c("R3B0","R3B0C"))
stopCluster(cl)

write.report(all,path("output","report.csv"),append = FALSE)
