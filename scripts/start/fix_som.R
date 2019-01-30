# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(lucode)
source("scripts/start_functions.R")
source("config/default.cfg")

cfg$title <- "static_som_cellular"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title <- "static_som_cluster"
cfg$gms$c59_static_spatial_level <-  "cluster"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title <- "cellpoll_som_cluster"
cfg$gms$som <- "cellpool_aug16"
start_run(cfg=cfg,codeCheck=TRUE)
