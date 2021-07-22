
# ------------------------------------------------
# description: start run with default.cfg settings
# position: 1
# ------------------------------------------------

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

cfg$title <- "test with regional rf switch"

cfg$gms$c42_reg_reserved_fraction <- "on"        #def= off

cfg$gms$select_regions42  <- "IND"      # def = NULL


#start MAgPIE run
start_run(cfg="default.cfg")
