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

cfg$force_download <- TRUE

# Set defaults
codeCheck <- FALSE

#################################################
# Testing of new EAT-Lancet diet implementation #
#################################################
# Current develop default diet
cfg$title <- "default_Diet_update"
cfg$gms$s15_exo_diet <- 0             # default
start_run(cfg, codeCheck = codeCheck)

# Previous EAT-Lancet implementation
cfg$title <- "eatLancet_1_update"
cfg$gms$s15_exo_diet <- 1
start_run(cfg, codeCheck = codeCheck)

# New EAT-Lancet implementation
cfg$title <- "eatLancet_2_update"
cfg$gms$s15_exo_diet <- 3
start_run(cfg, codeCheck = codeCheck)

# Single measures on or off
cfg$title <- "eatLancet_2_ruminants"
cfg$gms$s15_exo_diet <- 3
cfg$gms$s15_exo_monogastric  <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_ruminant     <- 1   # def = 1, options: 0,1
cfg$gms$s15_exo_fish         <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_fruitvegnutroots  <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_pulses       <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_sugar        <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_oils         <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_brans        <- 0   # def = 0 (as no target defined in EATLancet. with 1: brans are set to 0), options: 0,1
cfg$gms$s15_exo_scp          <- 0   # def = 1, options: 0,1
start_run(cfg, codeCheck = codeCheck)

cfg$title <- "eatLancet_2_monogastrics"
cfg$gms$s15_exo_diet <- 3
cfg$gms$s15_exo_monogastric  <- 1   # def = 1, options: 0,1
cfg$gms$s15_exo_ruminant     <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_fish         <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_fruitvegnutroots  <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_pulses       <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_sugar        <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_oils         <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_brans        <- 0   # def = 0 (as no target defined in EATLancet. with 1: brans are set to 0), options: 0,1
cfg$gms$s15_exo_scp          <- 0   # def = 1, options: 0,1
start_run(cfg, codeCheck = codeCheck)

cfg$title <- "eatLancet_2_fruits"
cfg$gms$s15_exo_diet <- 3
cfg$gms$s15_exo_monogastric  <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_ruminant     <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_fish         <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_fruitvegnutroots  <- 1   # def = 1, options: 0,1
cfg$gms$s15_exo_pulses       <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_sugar        <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_oils         <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_brans        <- 0   # def = 0 (as no target defined in EATLancet. with 1: brans are set to 0), options: 0,1
cfg$gms$s15_exo_scp          <- 0   # def = 1, options: 0,1
start_run(cfg, codeCheck = codeCheck)

cfg$title <- "eatLancet_2_legumes"
cfg$gms$s15_exo_diet <- 3
cfg$gms$s15_exo_monogastric  <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_ruminant     <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_fish         <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_fruitvegnutroots  <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_pulses       <- 1   # def = 1, options: 0,1
cfg$gms$s15_exo_sugar        <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_oils         <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_brans        <- 0   # def = 0 (as no target defined in EATLancet. with 1: brans are set to 0), options: 0,1
cfg$gms$s15_exo_scp          <- 0   # def = 1, options: 0,1
start_run(cfg, codeCheck = codeCheck)
