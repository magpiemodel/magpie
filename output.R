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

runOutputs <- function(comp=NULL, output=NULL, outputdir=NULL, submit=NULL) {
  choose_folder <- function(title="Please choose a folder") {
    # try to use find because it is significantly quicker than list.dirs
    tmp <- try(system("find ./output -path './output/*/renv' -prune -o -name 'full.gms'",
                      intern=TRUE,  ignore.stderr = TRUE), silent=TRUE)
    if("try-error" %in% class(tmp) || length(tmp)==0) {
      tmp <- base::list.dirs("./output/",recursive=TRUE)
      dirs <- NULL
      for (i in seq_along(tmp)) {
        if (file.exists(file.path(tmp[i],"full.gms"))) dirs <- c(dirs,sub("./output/","",tmp[i]))
      }
    } else {
      tmp <- grep("/full.gms$", tmp, value = TRUE)
      dirs <- sub("full.gms","",sub("./output/","",tmp, fixed=TRUE), fixed=TRUE)
    }
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
        choose_folder(title)
      }
    } else if(any(dirs[identifier] == "all")){
      identifier <- 2:length(dirs)
      return(paste0("./output/",dirs[identifier]))
    } else {
      return(paste0("./output/",dirs[identifier]))
    }
  }

  choose_submit <- function(title="Please choose run submission type") {
    slurm <- suppressWarnings(ifelse(system2("srun",stdout=FALSE,stderr=FALSE) != 127, TRUE, FALSE))
    modes <- c("SLURM standby", "SLURM standby maxMem", "SLURM priority", "SLURM priority maxMem","Direct execution", "Background execution", "Debug mode")
    if(slurm) {
      cat("\nCurrent cluster utilization:\n")
      system("sclass")
      cat("\n")
    } else {
     modes <- grep("^SLURM", modes, invert = TRUE, value = TRUE)
    }
    cat("\n",title,":\n",sep="")
    cat(paste(seq_along(modes), modes, sep=": " ),sep="\n")
    cat("Number: ")
    identifier <- gms::getLine()
    identifier <- as.numeric(strsplit(identifier,",")[[1]])
    if(slurm) {
      system("sclass")
      comp <- switch(identifier,
                     "1" = "slurm standby",
                     "2" = "slurm standby maxMem",
                     "3" = "slurm priority",
                     "4" = "slurm priority maxMem",
                     "5" = "direct",
                     "6" = "background",
                     "7" = "debug")

    } else {
      comp <- switch(identifier,
                     "1" = "direct",
                     "2" = "background",
                     "3" = "debug")
    }
    if(is.null(comp)) stop("This type is invalid. Please choose a valid type")
    return(comp)
  }

  runsubmit <- function(output, alloutputdirs, submit, script_path) {
    if(!dir.exists("logs")) dir.create("logs")
    #Set value source_include so that loaded scripts know, that they are
    #included as source (instead of a load from command line)
    source_include <- TRUE # nolint
    # run output scripts over all choosen folders
    for(rout in output){
      name <- ifelse(file.exists(paste0(script_path,rout)), rout, paste0(rout,".R"))
      script <- paste0(script_path,name)
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
        r_command <- paste0("output.R outputdir=",paste(outputdir,collapse=","),"  output=",rout," submit=direct")
        sbatch_command <- paste0("sbatch ",
                                 "--job-name=scripts-output ",
                                 "--output=logs/out-", rout_name, "-%j.out ",
                                 "--error=logs/out-", rout_name, "-%j.err ",
                                 "--mail-type=END ",
                                 "--time=200 ",
                                 "--mem-per-cpu=8000 ",
                                 "--wrap=\"Rscript ", r_command, "\"")
        if(submit=="direct") {
          tmp.env <- new.env()
          tmp.error <- try(sys.source(script,envir=tmp.env))
          if(!is.null(tmp.error)) warning("Script ",name," was stopped by an error and not executed properly!")
          rm(tmp.env)
        } else if(submit=="background") {
          log <- format(Sys.time(), paste0("logs/out-",rout_name,"-%Y-%H-%M-%S-%OS3.log"))
          system2("Rscript", r_command, stderr = log, stdout = log, wait=FALSE)
        } else if(submit=="slurm standby") {
          system(paste(sbatch_command, "--qos=standby --time=24:00:00"))
        } else if(submit=="slurm standby maxMem") {
          system(paste(sbatch_command, "--qos=standby --time=24:00:00 --mem-per-cpu=0 --cpus-per-task=16"))
        } else if(submit=="slurm priority") {
          system(paste(sbatch_command, "--qos=priority"))
        } else if(submit=="slurm priority maxMem") {
          system(paste(sbatch_command, "--qos=priority --mem-per-cpu=0 --cpus-per-task=16"))
        } else if(submit=="debug") {
          tmp.env <- new.env()
          sys.source(script,envir=tmp.env)
          rm(tmp.env)
        } else {
          stop("Unknown submission type")
        }
      }
    }
  }

  if (is.null(outputdir)) outputdir <- choose_folder("Choose runs")
  if (is.null(output))     output   <- gms::selectScript("./scripts/output")
  if (is.null(submit))     submit   <- choose_submit("Choose submission type")
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
      stop(paste(errorMessage1, collapse = "\n"), paste(errorMessage2, collapse = "\n"))
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
      } else if (identical(readLines(file.path(runFolder, "renv.lock")), readLines(newLockfile))) {
        file.remove(newLockfile)
      } else {
        message("Lockfile written to ", newLockfile)
      }
    }
  }

  runsubmit(output, alloutputdirs = outputdir, submit, "scripts/output/")
  message("")
}

if(!exists("source_include")) {
  output <- outputdir <- submit <- NULL
  lucode2::readArgs("output","outputdir","submit", .silent=TRUE)
}

runOutputs(output=output, outputdir = outputdir, submit=submit)
