# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

library(magclass)
library(lucode2)
library(magpie4)
library(gms)

#options(error=function()traceback(2))

.getRestartFiles <- function() {
  restartFiles <- dir(pattern="restart_.*\\.g00")
  names(restartFiles) <- gsub("restart_y([0-9]*)\\.g00", "\\1", restartFiles)
  return(restartFiles)
}

.getRestartCode <- function() {
  restartFiles <- .getRestartFiles()
  if (length(restartFiles) == 0) return("")
  restartFiles <- tail(restartFiles, 1)
  return(paste0(" --RESTARTPOINT=TimeLoop --TIMESTEP=", names(restartFiles), " r=", restartFiles))
}

cfg <- gms::loadConfig("config.yml")

maindir <- cfg$magpie_folder

# Capture start time
timeGAMSStart <- Sys.time()

cat("\nStarting MAgPIE...\n")
system(paste0("gams full.gms -errmsg=1 -lf=full.log -lo=",cfg$logoption, .getRestartCode()))

if (isFALSE(cfg$keep_restarts)) unlink(.getRestartFiles())

# Capture runtimes
timeGAMSEnd  <- Sys.time()
gams_runtime <- timeGAMSEnd - timeGAMSStart
timeOutputStart <- Sys.time()

if(!file.exists("fulldata.gdx")) stop("MAgPIE model run did not finish properly (fulldata.gdx is missing). Please check full.lst for further information!")
cat("\nMAgPIE run finished!\n")

gams_modelstats <- c("1" ="Optimal solution achieved.",
                     "2" ="Local optimal solution achieved.",
                     "3" ="Unbounded model found.",
                     "4" ="Infeasible model found.",
                     "5" ="Locally infeasible model found.",
                     "6" ="Solver terminated early and model was still infeasible. ",
                     "7" ="Solver terminated early and model was feasible but not yet optimal.",
                     "8" ="Integer solution found.",
                     "9" ="Solver terminated early with a non integer solution found.",
                     "10"="No feasible integer solution could be found.",
                     "11"="Licensing problem. Check if you correctly applied solver licence for MAgPIE in GAMS.",
                     "12"="Error - No cause known.",
                     "13"="Error - No solution attained.",
                     "14"="No solution returned.",
                     "15"="Unique solution in a CNS models.",
                     "16"="Feasible solution in a CNS models.",
                     "17"="Singular in a CNS models.",
                     "18"="Unbounded - no solution.",
                     "19"="Infeasible - no solution.")

ms_all <- as.numeric(magpie4::modelstat("fulldata.gdx"))
ms <- unique(ms_all[ms_all!=0])

if(length(ms)== 1) message("Model finished with modelstat ",ms,":",gams_modelstats[as.numeric(names(gams_modelstats)) %in% ms])
if(length(ms) > 1){
  message("Following modelstats were observed during simulation:")
  for(i in 1:length(ms)){
    message(ms[i],":",gams_modelstats[as.numeric(names(gams_modelstats)) %in% ms[i]])
  }
}

lucode2::runstatistics(file       = "runstatistics.rda",
                       modelstat  = magpie4::modelstat("fulldata.gdx"),
                       config     = cfg,
                       runtime    = gams_runtime,
                       setup_info = lucode2::setup_info(),
                       submit     = cfg$runstatistics)

runfolder <- getwd()
setwd(maindir)

#Set value source_include so that loaded scripts know, that they are
#included as source (instead of loaded from command line)
source_include <- TRUE

################################################################################

#copy important files into output_folder (after MAgPIE execution)
for (file in cfg$files2export$end) {
  file.copy(file, cfg$results_folder, overwrite=TRUE)
}

#update validation.RData
#### Collect technical information for validation ##############################
# info on the used dataset
input_data<-readLines(file.path(cfg$results_folder,"info.txt"))
# extract module info from full.gms
tmp<-readLines(file.path(cfg$results_folder,"full.gms"),warn=FALSE,encoding="ASCII")
lines<-grep(".*MODULE SETUP.*",tmp)[1]:grep(".*MODULE SETUP.*",tmp)[2]
module_setup<-c("","","### MODULE SETUP ###",grep("\\$",tmp[lines],value=TRUE))

load(cfg$val_workspace)
validation$technical$time$magpie.gms <- gams_runtime
validation$technical$input_data <- input_data
validation$technical$model_setup <- c(validation$technical$model_setup,
                                      module_setup)
if (exists("last.warning")) {
  validation$technical$last.warning <- c(validation$technical$last.warning,
                                         last.warning)
}
validation$technical$setup_info$model_run <- lucode2::setup_info()
save(validation,file=cfg$val_workspace, compress="xz")
rm(gams_runtime,input_data,module_setup,validation)


# Postprocessing / Output Generation
comp <- FALSE
submit <- "direct"
output <- cfg$output
outputdir <- runfolder
sys.source("output.R",envir=new.env())

# get runtime for output
timeOutputEnd <- Sys.time()

# Save run statistics to local file
cat("Saving timeGAMSStart, timeGAMSEnd, timeOutputStart and timeOutputStart to runstatistics.rda\n")
lucode2::runstatistics(file           = paste0(cfg$results_folder, "/runstatistics.rda"),
                      timeGAMSStart   = timeGAMSStart,
                      timeGAMSEnd     = timeGAMSEnd,
                      timeOutputStart = timeOutputStart,
                      timeOutputEnd   = timeOutputEnd)

print(warnings())

# quit with gams status as exit code unless model completed locally optimal everywhere
gamsCode <- Find(function(code) !code %in% c(2, 7), ms_all)
if (is.null(gamsCode) && 7 %in% ms_all) {
  gamsCode <- 7
}
if (!is.null(gamsCode)) {
  exitCode <- gamsCode + 200 # low numbered exit codes are used by R, add 200 to avoid confusion
  message("gams status was ", gamsCode, ", exiting with code ", exitCode)
  quit(status = exitCode)
}
