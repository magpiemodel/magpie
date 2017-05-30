
start_indc_preprocessing <- function(cfg="config/default.cfg",base_folder="scripts/indc/base_run",mainfolder=".",renew_base=FALSE)  {

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

  if(renew_base & dir.exists(base_folder)){
    unlink(base_folder,recursive = TRUE)
  }

  if(!dir.exists(base_folder) | renew_base) {
    cfg$title <- "SSP2_BASE"
    cfg <- setScenario(cfg,c("SSP2","BASE"))
		cfg$gms$c_timesteps <- "recalc_indc"
    cfg$sequential <- TRUE
    cfg$results_folder <- base_folder
		cfg$output <- c("validation","interpolation")
    #start_run(cfg,codeCheck=FALSE)
		
		dir.create(cfg$results_folder, recursive=TRUE, showWarnings=FALSE)
		
		#### Collect technical information for validation ############################
		
		# get git info
		git_info <- c("### GIT revision ###",
		              try(system("git rev-parse HEAD", intern=TRUE), silent=TRUE),
		              "", "### Modifications ###",
		              try(system("git status", intern=TRUE), silent=TRUE))

		# Create the workspace for validation
		cfg$val_workspace <- paste(cfg$results_folder,"/",cfg$title,".RData",sep="")
		validation <- list(technical=list(time=list(),
		                                  model_setup = git_info,
		                                  modules = codeCheck,
		                                  input_data = list(),
		                                  yield_calib = list(),
		                                  setup_info = list(start_functions = lucode::setup_info()),
		                                  last.warning = attr(codeCheck,"last.warning")))
		save(validation, file= cfg$val_workspace, compress="xz")
		
		# copy important files into output_folder (before MAgPIE execution)
		for(file in cfg$files2export$start) {
		  try(file.copy(Sys.glob(file), cfg$results_folder, overwrite=TRUE))
		}
		
		# copy spam files to output folder
		cfg$files2export$spam <- list.files(path="input/cellular", pattern = "*.spam",
		                                    full.names=TRUE)
		for(file in cfg$files2export$spam) {
		  file.copy(file, cfg$results_folder, overwrite=TRUE)
		}
		
		cfg$magpie_folder <- getwd()
		
		save(cfg, file=path(cfg$results_folder, "config.Rdata"))
		
		lucode::singleGAMSfile(output=lucode::path(cfg$results_folder, "full.gms"))
		lucode::model_unlock(lock_id)
		
		on.exit(setwd(mainfolder))
		setwd(cfg$results_folder)
		
		system("Rscript submit.R", wait=cfg$sequential)
    
  }

  setwd("scripts/indc")
  source("calc_NPI_INDC.R", local=TRUE)
  setwd(mainfolder)
}