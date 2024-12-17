# Collection of helper functions

chooseSubmit <- function(title, slurmModes) {
  modes <- c("Direct execution",
             "Background execution",
             "Debug mode")

  #Is SLURM available?
  slurm <- lucode2::SystemCommandAvailable("srun")
  if(slurm) {
    slurmModes <- yaml::read_yaml(slurmModes)$slurmjobs
    modes <- c(modes, names(slurmModes))
    if(lucode2::SystemCommandAvailable("sclass")) {
      cat("\nCurrent cluster utilization:\n")
      system("sclass")
      cat("\n")
    }
  }
  cat("\n",title,":\n", sep="")
  cat(paste(seq_along(modes), modes, sep=": " ),sep="\n")
  cat("Number: ")
  identifier <- gms::getLine()
  identifier <- as.integer(strsplit(identifier,",")[[1]])
  comp <- modes[identifier]
  if(is.null(comp) || is.na(comp)) stop("This type is invalid. Please choose a valid type")
  return(comp)
}
