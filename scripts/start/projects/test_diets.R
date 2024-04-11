# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test diet scenarios
# ----------------------------------------------------------


######################################
#### Script to start a MAgPIE run ####
######################################

library(gms)
library(lucode2)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

cfg$results_folder <- "output/:title:"
prefix <- "diet_change_v11"

cfg$title <- paste(prefix,"olddefault",sep="_")
start_run(cfg,codeCheck=FALSE)

cfg$title <- paste(prefix,"olddefaultEATlancet",sep="_")
cfg$gms$s15_exo_waste <- 1
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "no_underweight_half_overweight"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$s15_exo_monogastric <- 1
cfg$gms$s15_exo_ruminant    <- 1
cfg$gms$s15_exo_fish        <- 1
cfg$gms$s15_exo_fruitvegnut <- 1
cfg$gms$s15_exo_pulses      <- 1
cfg$gms$s15_exo_sugar       <- 1
cfg$gms$s15_exo_oils        <- 1
cfg$gms$s15_exo_brans       <- 1
cfg$gms$s15_exo_scp         <- 1
cfg$gms$s15_exo_alcohol     <- 1
start_run(cfg,codeCheck=FALSE)

source("config/default.cfg")
cfg$title <- paste(prefix,"newdefault",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
start_run(cfg,codeCheck=FALSE)

source("config/default.cfg")
cfg$title <- paste(prefix,"EATlancet",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
cfg$gms$s15_exo_waste <- 1
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "no_underweight_half_overweight"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$s15_exo_monogastric <- 1
cfg$gms$s15_exo_ruminant    <- 1
cfg$gms$s15_exo_fish        <- 1
cfg$gms$s15_exo_fruitvegnut <- 1
cfg$gms$s15_exo_pulses      <- 1
cfg$gms$s15_exo_sugar       <- 1
cfg$gms$s15_exo_oils        <- 1
cfg$gms$s15_exo_brans       <- 1
cfg$gms$s15_exo_scp         <- 1
cfg$gms$s15_exo_alcohol     <- 1
start_run(cfg,codeCheck=FALSE)


source("config/default.cfg")
cfg$title <- paste(prefix,"NoUnderweightHalfOverweight",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
cfg$gms$s15_exo_waste <- 0
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "no_underweight_half_overweight"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$s15_exo_monogastric <- 0
cfg$gms$s15_exo_ruminant    <- 0
cfg$gms$s15_exo_fish        <- 0
cfg$gms$s15_exo_fruitvegnut <- 0
cfg$gms$s15_exo_pulses      <- 0
cfg$gms$s15_exo_sugar       <- 0
cfg$gms$s15_exo_oils        <- 0
cfg$gms$s15_exo_brans       <- 0
cfg$gms$s15_exo_scp         <- 0
cfg$gms$s15_exo_alcohol     <- 0
start_run(cfg,codeCheck=FALSE)

source("config/default.cfg")
cfg$title <- paste(prefix,"noUnderweight",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
cfg$gms$s15_exo_waste <- 0
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "no_underweight"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$s15_exo_monogastric <- 0
cfg$gms$s15_exo_ruminant    <- 0
cfg$gms$s15_exo_fish        <- 0
cfg$gms$s15_exo_fruitvegnut <- 0
cfg$gms$s15_exo_pulses      <- 0
cfg$gms$s15_exo_sugar       <- 0
cfg$gms$s15_exo_oils        <- 0
cfg$gms$s15_exo_brans       <- 0
cfg$gms$s15_exo_scp         <- 0
cfg$gms$s15_exo_alcohol     <- 0
start_run(cfg,codeCheck=FALSE)

source("config/default.cfg")
cfg$title <- paste(prefix,"HalfOverweight",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
cfg$gms$s15_exo_waste <- 0
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "half_overweight"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$s15_exo_monogastric <- 0
cfg$gms$s15_exo_ruminant    <- 0
cfg$gms$s15_exo_fish        <- 0
cfg$gms$s15_exo_fruitvegnut <- 0
cfg$gms$s15_exo_pulses      <- 0
cfg$gms$s15_exo_sugar       <- 0
cfg$gms$s15_exo_oils        <- 0
cfg$gms$s15_exo_brans       <- 0
cfg$gms$s15_exo_scp         <- 0
cfg$gms$s15_exo_alcohol     <- 0
start_run(cfg,codeCheck=FALSE)


source("config/default.cfg")
cfg$title <- paste(prefix,"waste",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
cfg$gms$s15_exo_waste <- 1
cfg$gms$s15_exo_diet <- 0
cfg$gms$c15_kcal_scen <- "no_underweight_half_overweight"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$s15_exo_monogastric <- 0
cfg$gms$s15_exo_ruminant    <- 0
cfg$gms$s15_exo_fish        <- 0
cfg$gms$s15_exo_fruitvegnut <- 0
cfg$gms$s15_exo_pulses      <- 0
cfg$gms$s15_exo_sugar       <- 0
cfg$gms$s15_exo_oils        <- 0
cfg$gms$s15_exo_brans       <- 0
cfg$gms$s15_exo_scp         <- 0
cfg$gms$s15_exo_alcohol     <- 0
start_run(cfg,codeCheck=FALSE)

source("config/default.cfg")
cfg$title <- paste(prefix,"monogastric",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
cfg$gms$s15_exo_waste <- 0
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "endo"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$s15_exo_monogastric <- 1
cfg$gms$s15_exo_ruminant    <- 0
cfg$gms$s15_exo_fish        <- 0
cfg$gms$s15_exo_fruitvegnut <- 0
cfg$gms$s15_exo_pulses      <- 0
cfg$gms$s15_exo_sugar       <- 0
cfg$gms$s15_exo_oils        <- 0
cfg$gms$s15_exo_brans       <- 0
cfg$gms$s15_exo_scp         <- 0
cfg$gms$s15_exo_alcohol     <- 0
start_run(cfg,codeCheck=FALSE)


source("config/default.cfg")
cfg$title <- paste(prefix,"ruminant",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
cfg$gms$s15_exo_waste <- 0
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "endo"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$s15_exo_monogastric <- 0
cfg$gms$s15_exo_ruminant    <- 1
cfg$gms$s15_exo_fish        <- 0
cfg$gms$s15_exo_fruitvegnut <- 0
cfg$gms$s15_exo_pulses      <- 0
cfg$gms$s15_exo_sugar       <- 0
cfg$gms$s15_exo_oils        <- 0
cfg$gms$s15_exo_brans       <- 0
cfg$gms$s15_exo_scp         <- 0
cfg$gms$s15_exo_alcohol     <- 0
start_run(cfg,codeCheck=FALSE)


source("config/default.cfg")
cfg$title <- paste(prefix,"fish",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
cfg$gms$s15_exo_waste <- 0
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "endo"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$s15_exo_monogastric <- 0
cfg$gms$s15_exo_ruminant    <- 0
cfg$gms$s15_exo_fish        <- 1
cfg$gms$s15_exo_fruitvegnut <- 0
cfg$gms$s15_exo_pulses      <- 0
cfg$gms$s15_exo_sugar       <- 0
cfg$gms$s15_exo_oils        <- 0
cfg$gms$s15_exo_brans       <- 0
cfg$gms$s15_exo_scp         <- 0
cfg$gms$s15_exo_alcohol     <- 0
start_run(cfg,codeCheck=FALSE)


source("config/default.cfg")
cfg$title <- paste(prefix,"fruitvegnutseed",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
cfg$gms$s15_exo_waste <- 0
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "endo"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$s15_exo_monogastric <- 0
cfg$gms$s15_exo_ruminant    <- 0
cfg$gms$s15_exo_fish        <- 0
cfg$gms$s15_exo_fruitvegnut <- 1
cfg$gms$s15_exo_pulses      <- 0
cfg$gms$s15_exo_sugar       <- 0
cfg$gms$s15_exo_oils        <- 0
cfg$gms$s15_exo_brans       <- 0
cfg$gms$s15_exo_scp         <- 0
cfg$gms$s15_exo_alcohol     <- 0
start_run(cfg,codeCheck=FALSE)


source("config/default.cfg")
cfg$title <- paste(prefix,"pulses",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
cfg$gms$s15_exo_waste <- 0
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "endo"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$s15_exo_monogastric <- 0
cfg$gms$s15_exo_ruminant    <- 0
cfg$gms$s15_exo_fish        <- 0
cfg$gms$s15_exo_fruitvegnut <- 0
cfg$gms$s15_exo_pulses      <- 1
cfg$gms$s15_exo_sugar       <- 0
cfg$gms$s15_exo_oils        <- 0
cfg$gms$s15_exo_brans       <- 0
cfg$gms$s15_exo_scp         <- 0
cfg$gms$s15_exo_alcohol     <- 0
start_run(cfg,codeCheck=FALSE)


source("config/default.cfg")
cfg$title <- paste(prefix,"sugar",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
cfg$gms$s15_exo_waste <- 0
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "endo"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$s15_exo_monogastric <- 0
cfg$gms$s15_exo_ruminant    <- 0
cfg$gms$s15_exo_fish        <- 0
cfg$gms$s15_exo_fruitvegnut <- 0
cfg$gms$s15_exo_pulses      <- 0
cfg$gms$s15_exo_sugar       <- 1
cfg$gms$s15_exo_oils        <- 0
cfg$gms$s15_exo_brans       <- 0
cfg$gms$s15_exo_scp         <- 0
cfg$gms$s15_exo_alcohol     <- 0
start_run(cfg,codeCheck=FALSE)


source("config/default.cfg")
cfg$title <- paste(prefix,"oils",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
cfg$gms$s15_exo_waste <- 0
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "endo"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$s15_exo_monogastric <- 0
cfg$gms$s15_exo_ruminant    <- 0
cfg$gms$s15_exo_fish        <- 0
cfg$gms$s15_exo_fruitvegnut <- 0
cfg$gms$s15_exo_pulses      <- 0
cfg$gms$s15_exo_sugar       <- 0
cfg$gms$s15_exo_oils        <- 1
cfg$gms$s15_exo_brans       <- 0
cfg$gms$s15_exo_scp         <- 0
cfg$gms$s15_exo_alcohol     <- 0
start_run(cfg,codeCheck=FALSE)

source("config/default.cfg")
cfg$title <- paste(prefix,"alcohol",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
cfg$gms$s15_exo_waste <- 0
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "endo"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$s15_exo_monogastric <- 0
cfg$gms$s15_exo_ruminant    <- 0
cfg$gms$s15_exo_fish        <- 0
cfg$gms$s15_exo_fruitvegnut <- 0
cfg$gms$s15_exo_pulses      <- 0
cfg$gms$s15_exo_sugar       <- 0
cfg$gms$s15_exo_oils        <- 0
cfg$gms$s15_exo_brans       <- 0
cfg$gms$s15_exo_scp         <- 0
cfg$gms$s15_exo_alcohol     <- 1
start_run(cfg,codeCheck=FALSE)

source("config/default.cfg")
cfg$title <- paste(prefix,"processed",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
cfg$gms$s15_exo_waste <- 0
cfg$gms$s15_exo_diet <- 1
cfg$gms$c15_kcal_scen <- "endo"
cfg$gms$c15_EAT_scen <- "FLX"
cfg$gms$s15_exo_monogastric <- 0
cfg$gms$s15_exo_ruminant    <- 0
cfg$gms$s15_exo_fish        <- 0
cfg$gms$s15_exo_fruitvegnut <- 0
cfg$gms$s15_exo_pulses      <- 0
cfg$gms$s15_exo_sugar       <- 1
cfg$gms$s15_exo_oils        <- 1
cfg$gms$s15_exo_brans       <- 1
cfg$gms$s15_exo_scp         <- 1
cfg$gms$s15_exo_alcohol     <- 1
start_run(cfg,codeCheck=FALSE)

source("config/default.cfg")
cfg$title <- paste(prefix,"elastic",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
cfg$gms$s15_exo_waste <- 0
cfg$gms$s15_exo_diet <- 0
cfg$gms$s15_elastic_demand <- 1
start_run(cfg,codeCheck=FALSE)


# should show no change
source("config/default.cfg")
cfg$title <- paste(prefix,"elasticEAT",sep="_")
cfg$gms$food    <- "anthro_iso_jun22"
cfg$gms$s15_exo_waste <- 1
cfg$gms$s15_exo_diet <- 1
cfg$gms$s15_elastic_demand <- 1
start_run(cfg,codeCheck=FALSE)
