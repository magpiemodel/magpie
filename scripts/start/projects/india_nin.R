
# ------------------------------------------------
# description: start run with default.cfg settings
# position: 1
# ------------------------------------------------

library(gms)
source("scripts/start_functions.R")
source("config/default.cfg")

# General settings:
general_settings <- function(title) {

  source("config/default.cfg")
  codeCheck <- FALSE
  cfg$info$flag <- "1710"
  cfg$title       <- paste(cfg$info$flag,title,sep="_")
  cfg$results_folder <- "output/:title:"
  cfg$recalibrate <- FALSE

#  cfg$qos         <- "priority_"
  cfg$gms$food <- "anthro_iso_jun22"            # def = anthropometrics_jan18
  cfg$gms$c15_kcal_scen <- "healthy_BMI"
  #setting exogenous food demand scenario to zero
  cfg$gms$c15_exo_foodscen <- "lin_zero_20_30"                    # def = lin_zero_20_50
  #kcal target
  cfg$gms$c15_kcal_scen <- "2100kcal"       # def = healthy_BMI
  #food specific diet scenario
  cfg$gms$c15_EAT_scen <- "FLX_hmilk"                # def = FLX
  #Exogenous scenario applied only for India
  cfg$gms$scen_countries15  <- "IND"

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

source("config/default.cfg")
cfg$title <- "BAU1"
start_run(cfg, codeCheck = codeCheck)

####################################################################333
##BAU with special settings as per India requirements

cfg <- general_settings(title = "BAU2")
start_run(cfg, codeCheck=FALSE)

####################################################################333
##NIN

cfg <- general_settings(title = "NIN")
#switch towards exogenous diet scenario
cfg$gms$s15_exo_nin <- 1               # def = 0
start_run(cfg, codeCheck=FALSE)


####################################################################333
##EAT

cfg <- general_settings(title = "EAT")
#switch towards exogenous diet scenario
cfg$gms$s15_exo_diet <- 1               # def = 0
start_run(cfg, codeCheck=FALSE)
