# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: EAT 2.0 simulations
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################
library(gms)
library(lucode2)
library(magclass)

# load start_function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# laod default configuration
source("config/default.cfg")

# Set defaults
codeCheck <- FALSE

#################################################
# Testing of new EAT-Lancet diet implementation #
#################################################
# Current develop default diet
cfg$title <- "default_Diet"
cfg$gms$s15_exo_diet <- 0             # default
start_run(cfg, codeCheck = codeCheck)

# Previous EAT-Lancet implementation
cfg$title <- "eatLancet_1"
cfg$gms$s15_exo_diet <- 1
start_run(cfg, codeCheck = codeCheck)

# New EAT-Lancet implementation
cfg$title <- "eatLancet_2"
cfg$gms$s15_exo_diet <- 3
start_run(cfg, codeCheck = codeCheck)
