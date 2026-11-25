# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -------------------------------------------------------------
# description: test runs for s59_scm_mode and s29_treecover_mode
# comment: comment out single runs to start only a subset
# -------------------------------------------------------------

library(lucode2)
library(gms)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source default cfg. This loads the object "cfg" in R environment
source("config/default.cfg")

# Input data with the new soil carbon stock change factor files
cfg$input["regional"]   <- "rev4.138+SCM+TCupdate_h12_magpie.tgz"
cfg$input["cellular"]   <- "rev4.138+SCM+TCupdate_h12_1b5c3817_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1.tgz"
cfg$input["validation"] <- "rev4.138+SCM+TCupdate_h12_92e02314_validation.tgz"

# defaults, must behave like develop
cfg$title <- "scmtc_default"
start_run(cfg, codeCheck = TRUE)

# SCM mode 0, relative share target
cfg$title <- "scmtc_scm_share"
cfg$gms$s59_scm_target <- 0.3
start_run(cfg, codeCheck = TRUE)

# SCM mode 1, absolute area target with per cell cap
cfg$title <- "scmtc_scm_absolute"
cfg$gms$s59_scm_mode <- 1
cfg$gms$s59_scm_reference_year <- 2025
cfg$gms$s59_scm_max_share_per_cell <- 0.5
start_run(cfg, codeCheck = TRUE)

# Reset SCM switches to defaults before the treecover runs
cfg$gms$s59_scm_target <- 0
cfg$gms$s59_scm_mode <- 0
cfg$gms$s59_scm_reference_year <- -1
cfg$gms$s59_scm_max_share_per_cell <- 1

# treecover mode 0, live share target
cfg$title <- "scmtc_treecover_share"
cfg$gms$s29_treecover_target <- 0.03
start_run(cfg, codeCheck = TRUE)

# treecover mode 1, absolute area target
cfg$title <- "scmtc_treecover_absolute"
cfg$gms$s29_treecover_mode <- 1
cfg$gms$s29_treecover_reference_year <- 2025
start_run(cfg, codeCheck = TRUE)
