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
cfg$gms$c_timesteps <- "coup2100"


cfg$gms$c80_nlp_solver <- "conopt4"
cfg$gms$s80_optfile <- 1

cfg$title <- "t3_SSP2-Ref_conopt4_opt1"
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "t3_SSP2-26_conopt4_opt1"
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA0"
start_run(cfg,codeCheck=FALSE)


cfg$gms$c80_nlp_solver <- "conopt4"
cfg$gms$s80_optfile <- 0

cfg$title <- "t3_SSP2-Ref_conopt4_opt0"
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "t3_SSP2-26_conopt4_opt0"
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA0"
start_run(cfg,codeCheck=FALSE)


cfg$gms$c80_nlp_solver <- "conopt4+conopt3"
cfg$gms$s80_optfile <- 1

cfg$title <- "t3_SSP2-Ref_conopt43_opt1"
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "t3_SSP2-26_conopt43_opt1"
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA0"
start_run(cfg,codeCheck=FALSE)


cfg$gms$c80_nlp_solver <- "conopt4"
cfg$gms$s80_optfile <- 0

cfg$gms$c_timesteps <- "coup2100_old"

cfg$title <- "t3_SSP2-Ref_conopt4_opt0_no2000"
cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0"
cfg$gms$c60_2ndgen_biodem <- "SSP2-Ref-SPA0"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "t3_SSP2-26_conopt4_opt0_no2000"
cfg$gms$c56_pollutant_prices <- "SSP2-26-SPA0"
cfg$gms$c60_2ndgen_biodem <- "SSP2-26-SPA0"
start_run(cfg,codeCheck=FALSE)

