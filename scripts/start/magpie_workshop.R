###########################################################
#### Some header which explains what this script does  ####
###########################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Source the default config at this stage and then over-write it before starting the run.
source("config/default.cfg")

# Change results folder name
cfg$results_folder <- "output/:title:"

# Change time step settings
cfg$gms$c_timesteps <- 5

# Updating the desired output generation automatically after run
cfg$output <- c("rds_report","interpolation")

# Starting trade loop
for(trade_setting  in c("selfsuff_reduced","free_apr16")){
  # Starting land loop
  for(land_setting  in c("landmatrix_dec18","feb15")){
    
    # Set trade realization
    cfg$gms$trade <- trade_setting
    
    # Set land realization
    cfg$gms$land <- land_setting
    
    # Changing title flags
    if(trade_setting  == "selfsuff_reduced") trade_flag="resTrade"
    if(trade_setting  == "free_apr16") trade_flag="freeTrade"
    if(land_setting  == "landmatrix_dec18") land_flag = "landmatrix"
    if(land_setting  == "feb15") land_flag = "baseland"
    
    # Updating default tile
    cfg$title<- paste0("MAgPIE","_",trade_flag,"_",land_flag)
    
    ## cfg has been changed further at his stage, start the run
    start_run(cfg=cfg)
  } # <- Closing land loop
} # <- Closing trade loop


