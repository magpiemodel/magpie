#Postprocessing / Output Generation
output <- c("validation_trafficlight","validation_detailed")
outputdir <- Sys.glob("output/bio26__*")

for(i in outputdir) {
  for(j in output) {
    system(paste0("srun --qos=short --job-name=scripts-output --output=log_out-%j.out --output=log_out-%j.err --mail-type=END --time=45 Rscript output.R outputdir=",i," comp=FALSE output=",j," &"))
  }
}

