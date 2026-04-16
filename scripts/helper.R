# Collection of helper functions

#' Save a quitte report to the results archive
#'
#' Ensures that run statistics have a valid id, saves the quitte object as an
#' RDS file named after that id in the results archive, and updates the file
#' list used by shinyresults.
#'
#' @param qu A quitte object to be saved.
#' @param runstatistics Path to the runstatistics.rda file.
#' @param submit Value passed to \code{lucode2::runstatistics(submit = ...)},
#'   typically \code{cfg$runstatistics}.
#' @param resultsarchive Path to the results archive directory. Can also be set
#' via the env variable MAGPIE_RESULTS_ARCHIVE_PATH
saveToResultsArchive <- function(qu, runstatistics, submit,
                                 resultsarchive = Sys.getenv("MAGPIE_RESULTS_ARCHIVE_PATH")) {

  if (resultsarchive == "") {
    # The following exists to ensure that the uploading of results continues
    # to work even when the env variable has not yet been set in a users session.
    # This block may be removed at some point.
    resultsarchive <- "/p/projects/rd3mod/models/results/magpie" # nolint: absolute_path_linter
  }

  if (!(file.exists(runstatistics) && dir.exists(resultsarchive))) {
    # We only run in environments that are set up with a results archive
    return(NULL)
  }

  stats <- list()
  load(runstatistics)
  if (is.null(stats$id)) {
    # create an id if it does not exist (which means that statistics have not
    # been saved to the archive before) and save statistics to the archive
    message("No id found in runstatistics.rda. Calling lucode2::runstatistics() to create one.")
    stats <- lucode2::runstatistics(file = runstatistics, submit = submit)
    message("Created the id ", stats$id)
    # save stats locally (including id) otherwise it would generate a new id (and
    # resubmit the results and the statistics) next time rds_report is executed
    save(stats, file = runstatistics, compress = "xz")
  }

  # Save report to results archive
  saveRDS(qu, file = paste0(resultsarchive, "/", stats$id, ".rds"), version = 2)
  withr::with_dir(resultsarchive, {
    system("find -type f -name '1*.rds' -printf '%f\n' | sort > fileListForShinyresults")
  })
}

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
