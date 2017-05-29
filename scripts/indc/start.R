
start_indc_preprocessing <- function(cfg="config/default.cfg",bau_folder="scripts/indc/Base",mainfolder=".",renew_bau=FALSE)  {

  #change to the model mainfolder
  cwd <- getwd()
  on.exit(setwd(cwd))
  setwd(mainfolder)
  mainfolder <- getwd()
  
  require(lucode)
  source("scripts/start_functions.R")

  if(is.character(cfg)) {
    source(cfg, local=TRUE)
  }

  #copy calibration factors for requested resolution
  #file.copy(from = paste0("scripts/indc/",cfg$low_res,"/f14_yld_calib.csv"),to = "modules/14_yields/input/f14_yld_calib.csv",overwrite = TRUE)
  
  bau_folder <- paste(bau_folder,cfg$low_res,sep = "_")
  
  if(renew_bau & dir.exists(bau_folder)){
    unlink(bau_folder,recursive = TRUE)
  }

  if(!dir.exists(bau_folder) | renew_bau) {
    cfg$title <- paste("SSP2_BASE",cfg$low_res,sep="_")
    cfg <- setScenario(cfg,c("SSP2","BASE"))
		cfg$gms$c_timesteps <- "recalc_indc"
    cfg$sequential <- TRUE
    cfg$results_folder <- bau_folder
		cfg$output <- c("validation","emissions","interpolation")
    start_run(cfg,codeCheck=FALSE)
  }

  setwd("scripts/indc")
  source("calcNPI.R", local=TRUE)
	source("calcINDC.R", local = TRUE)
  setwd(mainfolder)
}