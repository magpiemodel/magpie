# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

library(magclass)
library(lucode2)
library(magpie4)

#options(error=function()traceback(2))

load("config.Rdata")

maindir <- cfg$magpie_folder

# write the config file in the output_folder: config.log
write(capture.output(cfg), file="config.log")

# Capture start time
timeGAMSStart <- Sys.time()

cat("\nStarting MAgPIE...\n")
system(paste("gams full.gms -errmsg=1 -lf=full.log -lo=",cfg$logoption,sep=""))

# Capture runtimes
timeGAMSEnd  <- Sys.time()
gams_runtime <- timeGAMSEnd - timeGAMSStart
timeOutputStart <- Sys.time()

if(!file.exists("fulldata.gdx")) stop("MAgPIE model run did not finish properly (fulldata.gdx is missing). Please check full.lst for further information!")
cat("\nMAgPIE run finished!\n")
ms_all <- magpie4::modelstat("fulldata.gdx")
ms <- tail(as.numeric(ms_all),1)
if(ms==1)  cat("\nLast known model status is",ms,": Optimal solution achieved.\n")
if(ms==2)  cat("\nLast known model status is",ms,": Local optimal solution achieved. MAgPIE run was successful.\n")
if(ms==3)  cat("\nLast known model status is",ms,": Unbounded model found.\n")
if(ms==4)  cat("\nLast known model status is",ms,": Infeasible model found.\n")
if(ms==5)  cat("\nLast known model status is",ms,": Locally infeasible model found.\n")
if(ms==6)  cat("\nLast known model status is",ms,": Solver terminated early and model was still infeasible. \n")
if(ms==7)  cat("\nLast known model status is",ms,": Solver terminated early and model was feasible but not yet optimal.\n")
if(ms==8)  cat("\nLast known model status is",ms,": Integer solution found.\n")
if(ms==9)  cat("\nLast known model status is",ms,": Solver terminated early with a non integer solution found.\n")
if(ms==10) cat("\nLast known model status is",ms,": No feasible integer solution could be found.\n")
if(ms==11) cat("\nLast known model status is",ms,": Licensing problem. Check if you correctly applied solver licence for MAgPIE in GAMS.\n")
if(ms==12) cat("\nLast known model status is",ms,": Error - No cause known.\n")
if(ms==13) cat("\nLast known model status is",ms,": Error - No solution attained.\n")
if(ms==14) cat("\nLast known model status is",ms,": No solution returned.\n")
if(ms==15) cat("\nLast known model status is",ms,": Unique solution in a CNS models.\n")
if(ms==16) cat("\nLast known model status is",ms,": Feasible solution in a CNS models.\n")
if(ms==17) cat("\nLast known model status is",ms,": Singular in a CNS models.\n")
if(ms==18) cat("\nLast known model status is",ms,": Unbounded - no solution.\n")
if(ms==19) cat("\nLast known model status is",ms,": Infeasible - no solution.\n")

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
input_data<-readLines(path(cfg$results_folder,"info.txt"))
# extract module info from full.gms
tmp<-readLines(path(cfg$results_folder,"full.gms"),warn=FALSE,encoding="ASCII")
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
