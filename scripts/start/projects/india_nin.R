
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

  ##Downloading new input data
  cfg$force_download <- TRUE
  cfg$info$flag <- "2302"
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
  cfg$gms$s42_multiplier_startyear <- 1995
  ##Pumping cost value to  0.005
  cfg$gms$s42_multiplier <- 1

return(cfg)
}

####################################################################333
###BAU with no special settings
general_settings2 <- function(title) {
  source("config/default.cfg")

  ##Downloading new input data
  cfg$force_download <- TRUE
  cfg$info$flag <- "2302"
  cfg$title       <- paste(cfg$info$flag,title,sep="_")
  cfg$results_folder <- "output/:title:"
  cfg$recalibrate <- FALSE
  return(cfg)
  }

 cfg <- general_settings2(title = "default")
start_run(cfg, codeCheck=FALSE)

####################################################################333
##BAU with special settings as per India requirements

cfg <- general_settings(title = "BAU")
start_run(cfg, codeCheck=FALSE)

####################################################################333
##NIN

cfg <- general_settings(title = "NIN_India_EAT_others")
#switch towards exogenous diet scenario
cfg$gms$s15_exo_nin <- 1               # def = 0
#ensuring EAT switch gets active for other regions
#Modeified on 1602 I think this setting of exo diet is not needed here when we want to implement NIN india eat others
#cfg$gms$s15_exo_diet <- 1               # def = 0

start_run(cfg, codeCheck=FALSE)

####################################################################333
##NIN

cfg <- general_settings(title = "NIN_India_SSP2_others")
#switch towards exogenous diet scenario
cfg$gms$s15_exo_nin <- 1               # def = 0
#Exogenous scenario applied only for India
cfg$gms$scen_countries15  <- "IND"

start_run(cfg, codeCheck=FALSE)


###################################################################333
##EAT

cfg <- general_settings(title = "EAT_all")
#switch towards exogenous diet scenario
cfg$gms$s15_exo_diet <- 1               # def = 0

start_run(cfg, codeCheck=FALSE)


###################################################################
####regionalized####
cfg <- general_settings(title = "NIN_India_SSP2_others_slowlib")

cfg$gms$c21_trade_liberalization  <- "regionalized"     # def = l909090r808080

cfg$gms$s15_exo_nin <- 1               # def = 0
#ensuring EAT switch gets active for other regions
cfg$gms$scen_countries15  <- "IND"

start_run(cfg, codeCheck=FALSE)


#####################################################################
#####globalized#############
cfg <- general_settings(title = "NIN_India_SSP2_others_fastlib")

cfg$gms$c21_trade_liberalization  <- "globalized"     # def = l909090r808080

cfg$gms$s15_exo_nin <- 1               # def = 0
#ensuring EAT switch gets active for other regions
cfg$gms$scen_countries15  <- "IND"

start_run(cfg, codeCheck=FALSE)

####################################################################333
##BAU with different trade general_settings

cfg <- general_settings(title = "BAU_fastlib")
cfg$gms$c21_trade_liberalization  <- "globalized"     # def = l909090r808080

start_run(cfg, codeCheck=FALSE)


####################################################################333
##BAU with different trade general_settings

cfg <- general_settings(title = "BAU_slowlib")
cfg$gms$c21_trade_liberalization  <- "regionalized"     # def = l909090r808080

start_run(cfg, codeCheck=FALSE)
