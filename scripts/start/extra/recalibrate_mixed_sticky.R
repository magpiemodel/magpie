library(magpie4)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")


cfg$results_folder <- "output/:title:"
cfg$recalibrate <- TRUE

realization<-c("mixed_feb17","sticky_feb18")

for (i in realization){
cfg$title <- paste0("calib_run_",i)
#Selects factor costs realization
cfg$gms$factor_costs <- i

cfg$gms$c_timesteps <- 1
cfg$output <- c("report")
cfg$sequential <- TRUE
start_run(cfg,codeCheck=FALSE)
magpie4::submitCalibration(paste0("H12_",i))
}
