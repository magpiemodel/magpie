# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

##########################################################
#### MAgPIE output generation ####
##########################################################

if (!is.null(renv::project()) && !exists("source_include") && Sys.getenv("SLURM_JOB_ID") == "") {
  ask <- function(question) {
    message(question, appendLF = FALSE)
    return(tolower(gms::getLine()) %in% c("", "y", "yes"))
  }

  message("Checking for updates... ", appendLF = FALSE)
  if (getOption("autoRenvUpdates", FALSE) ||
        (!is.null(piamenv::showUpdates()) && ask("Update now? (Y/n): "))) {
    updates <- piamenv::updateRenv()
    piamenv::stopIfLoaded(names(updates))
  }
  message("Update check done.")

  message("Checking package version requirements... ", appendLF = FALSE)
  updates <- piamenv::fixDeps(ask = TRUE)
  piamenv::stopIfLoaded(names(updates))
  message("Requirements check done.")
}

library(lucode2)
library(gms)
source("scripts/helper.R")

runOutputs <- function(comp=NULL, output=NULL, outputdir=NULL, submit=NULL) {
  chooseFolder <- function(title="Please choose a folder") {
    dirs <- c(Sys.glob("./output/*/full.gms"), Sys.glob("./output/HR*/*/full.gms"))
    dirs <- sub("^\\./output/", "", dirs)
    dirs <- sub("/full\\.gms$", "", dirs)
    dirs <- sort(dirs)
    dirs <- c("all",dirs)
    cat("\n",title,":\n", sep="")
    cat(paste(seq_along(dirs), dirs, sep=": " ),sep="\n")
    cat(paste(length(dirs)+1, "Search by the pattern.\n", sep=": "))
    cat("Number: ")
    identifier <- gms::getLine()
    identifier <- strsplit(identifier,",")[[1]]
    tmp <- NULL
    for (i in seq_along(identifier)) {
      if (length(strsplit(identifier,":")[[i]]) > 1) {
        tmp <- c(tmp,as.numeric(strsplit(identifier,":")[[i]])[1]:as.numeric(strsplit(identifier,":")[[i]])[2])
      }
      else tmp <- c(tmp,as.numeric(identifier[i]))
    }
    identifier <- tmp
    # PATTERN
    if(length(identifier) == 1 && identifier == length(dirs) + 1) {
      cat("\nInsert the search pattern or the regular expression: ")
      pattern <- gms::getLine()
      id <- grep(pattern=pattern, dirs[-1], perl=TRUE)
      # lists all directories matching the pattern and ask for confirmation
      cat("\n\nYou have chosen the following directories:\n")
      cat(paste(seq_along(id), dirs[id+1], sep=": "), sep="\n")
      cat("\nAre you sure these are the right directories?(y/n): ")
      answer <- gms::getLine()
      if(answer=="y"){
        return(paste0("./output/",dirs[id+1]))
      } else {
        chooseFolder(title)
      }
    } else if(any(dirs[identifier] == "all")){
      identifier <- 2:length(dirs)
      return(paste0("./output/",dirs[identifier]))
    } else {
      return(paste0("./output/",dirs[identifier]))
    }
  }

  runsubmit <- function(output, alloutputdirs, submit, scriptPath, slurmModes) {
    if(!dir.exists("logs")) dir.create("logs")
    #Set value source_include so that loaded scripts know, that they are
    #included as source (instead of a load from command line)
    source_include <- TRUE # nolint
    # run output scripts over all choosen folders
    for(rout in output){
      name <- ifelse(file.exists(paste0(scriptPath, rout)), rout, paste0(rout, ".R"))
      script <- paste0(scriptPath, name)
      if(!file.exists(script)) {
        warning("Script ",name, " could not be found. Skip execution!")
        next
      }
      header <- read_yaml_header(script)
      comp <- (!is.null(header[["comparison script"]]) && isTRUE(header[["comparison script"]]))
      if(comp) {
        loop <- list(alloutputdirs)
      } else {
        loop <- alloutputdirs
      }
      rout_name <- sub("\\.R$","",sub("/","_",rout))
      for(outputdir in loop) {
        message("\n# ",name, " -> ", outputdir)
        rCommand <- paste0("output.R outputdir=",paste(outputdir,collapse=","),"  output=",rout," submit=direct")
        if(submit %in% c("Direct execution", "direct")) {
          tmp.env <- new.env()
          tmp.error <- try(sys.source(script,envir=tmp.env))
          if(!is.null(tmp.error)) warning("Script ",name," was stopped by an error and not executed properly!")
          rm(tmp.env)
        } else if(submit %in% c("Background execution", "background")) {
          log <- format(Sys.time(), paste0("logs/out-",rout_name,"-%Y-%H-%M-%S-%OS3.log"))
          system2("Rscript", rCommand, stderr = log, stdout = log, wait=FALSE)
        } else if(submit %in% c("Debug mode", "debug")) {
          tmp.env <- new.env()
          sys.source(script,envir=tmp.env)
          rm(tmp.env)
        } else {
          slurm <- yaml::read_yaml(slurmModes)$slurmjobs
          if(submit %in% names(slurm)) {
            command <- slurm[submit]
            command <- gsub("%NAME", rout_name, command)
            command <- gsub("%SCRIPT", rCommand, command)
            message(command)
            system(command)
          } else {
            stop("Unknown submission type")
          }
        }
      }
    }
  }

  if (is.null(outputdir)) outputdir <- chooseFolder("Choose runs")
  if (is.null(output))     output   <- gms::selectScript("./scripts/output")
  if (is.null(submit))     submit <- chooseSubmit("Choose submission type",
                                                  slurmModes = "scripts/slurmOutput.yml")
  if (is.null(output)) {
    message("No output script selected! Stop here.")
    return(invisible(NULL))
  }
  if(is.null(outputdir)) {
    message("No output folder selected! Stop here.")
    return(invisible(NULL))
  }

  # Write a separate lockfile called {datetime}_{outputscript}_renv.lock into outputdir
  # unless the renv from outputdir itself was used to run output.R
  if (!is.null(renv::project())) {
    freshLockfile <- withr::local_tempfile()

    message("Generating lockfile... ", appendLF = FALSE)
    errorMessage1 <- utils::capture.output({
      errorMessage2 <- utils::capture.output({
        snapshotSuccess <- tryCatch({
          renv::snapshot(lockfile = freshLockfile, prompt = FALSE)
          TRUE
        }, error = function(error) FALSE)
      }, type = "message")
    })
    if (!snapshotSuccess) {
      warning(paste(errorMessage1, collapse = "\n"), paste(errorMessage2, collapse = "\n"))
    }
    message("done.")

    datetime <- format(Sys.time(), "%Y-%m-%dT%H%M%S")
    scriptName <- gsub("/", "-", paste(sub("\\.R$", "", output), collapse = "--"))

    for (runFolder in setdiff(normalizePath(outputdir), normalizePath(renv::project()))) {
      newLockfile <- file.path(runFolder, paste0(datetime, "__", scriptName, "__renv.lock"))

      file.copy(freshLockfile, newLockfile)

      if (!file.exists(file.path(runFolder, "renv.lock"))) {
        warning(normalizePath(runFolder), "/renv.lock does not exist.")
        message("Lockfile written to ", newLockfile)
      } else if (!file.exists(newLockfile)) {
        message("Could not write lockfile, see warning thrown earlier.")
      } else if (identical(readLines(file.path(runFolder, "renv.lock")), readLines(newLockfile))) {
        file.remove(newLockfile)
      } else {
        message("Lockfile written to ", newLockfile)
      }
    }
  }

  runsubmit(output = output, alloutputdirs = outputdir,
            submit = submit, scriptPath = "scripts/output/",
            slurmModes = "scripts/slurmOutput.yml")
  message("")
}

if (!exists("source_include")) {
  output <- outputdir <- submit <- NULL
  lucode2::readArgs("output", "outputdir", "submit", .silent = TRUE)
}

runOutputs(output = output, outputdir = outputdir, submit = submit)
