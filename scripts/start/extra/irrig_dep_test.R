# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ------------------------------------------------
# description: Test irrigation depreciation settings
# ------------------------------------------------

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")

# short description of the actual run
cfg$title <- "develop_default"

# Should input data be downloaded from source even if cfg$input did not change?
cfg$force_download <- TRUE

#Selection of QOS to be used for submitted runs on cluster.
cfg$qos <- "priority"

#Setting value for depreciation rate in 41_area_equipped_for_irrigation
cfg$gms$s41_AEI_depreciation <- 0                       # def = 0

#start MAgPIE run
start_run(cfg)

##dep rate as 0.05##

## Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")

# short description of the actual run
cfg$title <- "develop_dep05"

# Should input data be downloaded from source even if cfg$input did not change?
cfg$force_download <- TRUE

#Selection of QOS to be used for submitted runs on cluster.
cfg$qos <- "priority"

#Setting value for depreciation rate in 41_area_equipped_for_irrigation
cfg$gms$s41_AEI_depreciation <- 0.05                       # def = 0


#start MAgPIE run
start_run(cfg)
#
#
