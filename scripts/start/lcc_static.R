# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
cfg$results_folder <- "output/:title:"
cfg$recalibrate <- TRUE

cfg$gms$landconversion <- "global_static_aug18"
for (est in c(3000,4000,5000,6000,7000,8000,9000,10000)) {
  for (cl in c(0,1,5,10,20)) {
    cfg$title <- paste0("lcc3_est",est,"_cl",cl)
    manipulateConfig("modules/39_landconversion/global_static_aug18/preloop.gms",s39_cost_establish=est)
    manipulateConfig("modules/39_landconversion/global_static_aug18/preloop.gms",s39_cost_clearing=cl)
    start_run(cfg,codeCheck=FALSE)
  }
}

cfg$gms$landconversion <- "gdp_vegc_may18"
cfg$title <- "lcc3_old"
start_run(cfg,codeCheck=FALSE)
