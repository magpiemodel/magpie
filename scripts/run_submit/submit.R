# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

library(magclass)
library(lucode)

options(error=function()traceback(2))

load("config.Rdata")

maindir <- cfg$magpie_folder

#Is the run performed on the cluster?
on_cluster <- file.exists('/p/projects/landuse')
#Setting relevant paths
if(on_cluster) { #run is performed on the cluster
  gamspath <- '/p/system/packages/gams/24.0.1/'
} else {
  gamspath   <- ''
}

cat("\nStarting MAgPIE...\n")
begin<-Sys.time()
system(paste(gamspath,"gams full.gms -lf=full.log -lo=",cfg$logoption,sep=""))
gams_runtime<-Sys.time()-begin  #calculate runtime info
cat("\nMAgPIE run finished!\n")

# write the config file in the output_folder: config.log
write(capture.output(cfg), file="config.log")

runfolder <- getwd()

setwd(maindir)

#Set value source_include so that loaded scripts know, that they are 
#included as source (instead a load from command line)
source_include <- TRUE

#####################################################################################

#copy important files into output_folder (after MAgPIE execution)
for (file in cfg$files2export$end) file.copy(file, cfg$results_folder, overwrite=TRUE)

#update validation.RData
####Collect technical information for validation#########################################
# info on the used dataset
input_data<-readLines(path(cfg$results_folder,"info.txt"))
# extract module info from full.gms
tmp<-readLines(path(cfg$results_folder,"full.gms"),warn=FALSE,encoding="ASCII")
lines<-grep(".*MODULE SETUP.*",tmp)[1]:grep(".*MODULE SETUP.*",tmp)[2]
module_setup<-c("","","### MODULE SETUP ###",grep("\\$",tmp[lines],value=TRUE))

load(cfg$val_workspace)  
validation$technical$time$magpie.gms <- gams_runtime
validation$technical$input_data <- input_data
validation$technical$model_setup <- c(validation$technical$model_setup,module_setup)
if (exists("last.warning")) validation$technical$last.warning <- c(validation$technical$last.warning,last.warning)
validation$technical$setup_info$model_run <- setup_info()
save(validation,file=cfg$val_workspace, compress="xz")
rm(gams_runtime,input_data,module_setup,validation)


#Postprocessing / Output Generation
comp <- FALSE
submit <- "direct"
output <- cfg$output
outputdirs <- runfolder
sys.source("output.R",envir=new.env())

print(warnings())
