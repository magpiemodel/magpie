
# ------------------------------------------------
# description: Food scenarios for India
# position: 1
# ------------------------------------------------

library(gms)
source("scripts/start_functions.R")
source("config/default.cfg")
codeCheck <- FALSE

# General settings:
general_settings <- function(title) {
  source("config/default.cfg")

  cfg$input <- c(regional    = "WARNINGS1_rev4.771810__h12_magpie.tgz",
                 cellular    = "rev4.771810__h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
                 validation  = "rev4.771810__h12_validation.tgz",
                 additional  = "additional_data_rev4.30.tgz",
                 calibration = "calibration_H12+ir2rf_05Oct22.tgz")

  ##Downloading new input data
  cfg$force_download <- TRUE
  cfg$info$flag <- "2010"
  cfg$title       <- paste(cfg$info$flag,title,sep="_")
  cfg$results_folder <- "output/:title:"
  cfg$recalibrate <- FALSE

#  cfg$qos         <- "priority_"
  cfg$gms$food <- "anthro_iso_jun22"            # def = anthropometrics_jan18
  #setting exogenous food demand scenario to zero
  cfg$gms$c15_exo_foodscen <- "lin_zero_20_30"                    # def = lin_zero_20_50
  #food specific diet scenario
  cfg$gms$c15_EAT_scen <- "FLX_hmilk"                # def = FLX

  #Setting pumping to 1
  cfg$gms$s42_pumping <- 1
  #Setting start year as 1995 in default so that the values are set for India
  cfg$gms$s42_start_multiplier <- 1995
  ##Pumping cost value to  0.005
  cfg$gms$s42_multiplier <- 1

return(cfg)
}

####################################################################333
###BAU with no special settings
general_settings2 <- function(title) {
  source("config/default.cfg")

  cfg$input <- c(regional    = "WARNINGS1_rev4.771810__h12_magpie.tgz",
                 cellular    = "rev4.771810__h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
                 validation  = "rev4.771810__h12_validation.tgz",
                 additional  = "additional_data_rev4.30.tgz",
                 calibration = "calibration_H12+ir2rf_05Oct22.tgz")

  ##Downloading new input data
  cfg$force_download <- TRUE
  cfg$info$flag <- "2010"
  cfg$title       <- paste(cfg$info$flag,title,sep="_")
  cfg$results_folder <- "output/:title:"
  cfg$recalibrate <- FALSE
  return(cfg)
  }

  cfg <- general_settings2(title = "BAU")
  start_run(cfg, codeCheck=FALSE)

####################################################################333
##BAU with special settings as per India requirements

cfg <- general_settings(title = "BAU2")
start_run(cfg, codeCheck=FALSE)

####################################################################333
##NIN

cfg <- general_settings(title = "NIN_India_EAT_others")
#switch towards exogenous diet scenario
cfg$gms$s15_exo_nin <- 1               # def = 0
#Exogenous scenario applied only for India
#cfg$gms$scen_countries15  <- "IND"

start_run(cfg, codeCheck=FALSE)

####################################################################333
##NIN

cfg <- general_settings(title = "NIN_India_endo_others")
#switch towards exogenous diet scenario
cfg$gms$s15_exo_nin <- 1               # def = 0
#Exogenous scenario applied only for India
cfg$gms$scen_countries15  <- "IND"

start_run(cfg, codeCheck=FALSE)


####################################################################333
##EAT

cfg <- general_settings(title = "EAT_India_endo_others")
#switch towards exogenous diet scenario
cfg$gms$s15_exo_diet <- 1               # def = 0
cfg$gms$scen_countries15  <- "IND"

start_run(cfg, codeCheck=FALSE)


####################################################################333
##EAT

cfg <- general_settings(title = "EAT_all")
#switch towards exogenous diet scenario
cfg$gms$s15_exo_diet <- 1               # def = 0

start_run(cfg, codeCheck=FALSE)


####################################################################333
##NIN no_overweight

cfg <- general_settings(title = "NIN_no_overweight")
#switch towards exogenous diet scenario
cfg$gms$s15_exo_nin <- 1               # def = 0
cfg$gms$c15_kcal_scen <- "no_overweight"

start_run(cfg, codeCheck=FALSE)

####################################################################333
## no_underweight scenario

cfg <- general_settings(title = "NIN_no_underweight")
#switch towards exogenous diet scenario
cfg$gms$s15_exo_nin <- 1               # def = 0
cfg$gms$c15_kcal_scen <- "no_underweight"

start_run(cfg, codeCheck=FALSE)

####################################################################333
##NIN_nosugar/oil change scenario - when sugars and oils are allowed to be used as BAU and don't factor in transition

cfg <- general_settings(title = "NIN_high_processed")
#switch towards exogenous diet scenario
cfg$gms$s15_exo_nin <- 1               # def = 0
cfg$gms$s15_exo_sugar       <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_oils        <- 0   # def = 1, options: 0,1
start_run(cfg, codeCheck=FALSE)

####################################################################
##Only reduction in select commodities - processed food consumption

cfg <- general_settings(title = "NIN_no_processed")
#switch towards exogenous diet scenario
cfg$gms$s15_exo_nin <- 1               # def = 0
cfg$gms$s15_exo_monogastric <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_ruminant    <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_fish        <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_fruitvegnut <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_pulses      <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_sugar       <- 1   # def = 1, options: 0,1
cfg$gms$s15_exo_oils        <- 1   # def = 1, options: 0,1
cfg$gms$s15_exo_brans       <- 0   # def = 1, options: 0,1
cfg$gms$s15_exo_scp         <- 0   # def = 1, options: 0,1

start_run(cfg, codeCheck=FALSE)


###################################################################
# SSP3 diet scenario

cfg <- general_settings(title = "SSP3")

cfg$gms$c15_food_scenario <- "SSP3"                 # def = SSP2
cfg$gms$c15_food_scenario_noselect <- "SSP3"        # def = SSP2
start_run(cfg, codeCheck=FALSE)
