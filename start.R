# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

##########################################################
#### MAgPIE output generation ####
##########################################################

if (!is.null(renv::project())) {
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

runOutputs <- function(runscripts=NULL, submit=NULL) {

  runSubmit <- function(runscripts, submit,
                        slurmModes="scripts/slurmStart.yml") {
    if(!dir.exists("logs")) dir.create("logs")
    
    for(rout in runscripts){
      script   <- paste0("./scripts/start/",rout)
      if(!file.exists(script)) {
        script <- paste0(script,".R")
        if(!file.exists(script)) {
          warning("Script ",script, " could not be found. Skip execution!")
          next
        }
      }

      cat("Executing",script,"\n")
      name <- sub("\\.R$","",sub("/","_",rout))
      if(submit %in% c("Direct execution", "direct")) {
        tmp.env <- new.env()
        tmp.error <- try(sys.source(script, envir=tmp.env))
        if(!is.null(tmp.error)) warning("Script ",script," was stopped by an error and not executed properly!")
        rm(tmp.env)
      } else if(submit %in% c("Background execution", "background")) {
        log <- format(Sys.time(), paste0("logs/", name, "-%Y-%H-%M-%S-%OS3.log"))
        system2("Rscript",script, stderr = log, stdout = log, wait=FALSE)
      } else if(submit %in% c("Debug mode", "debug")) {
        tmp.env <- new.env()
        sys.source(script,envir=tmp.env)
        rm(tmp.env)
      } else {
        slurm <- yaml::read_yaml(slurmModes)$slurmjobs
        if(submit %in% names(slurm)) {
          command <- slurm[submit]
          command <- gsub("%NAME", name, command)
          command <- gsub("%SCRIPT", script, command)
          message(command)
          system(command)
          Sys.sleep(1)
        } else {
          stop("Unknown submission type")
        }
      }
    }
  }

  if(is.null(runscripts)) runscripts <- gms::selectScript("./scripts/start")
  if(is.null(runscripts)) {
    message("No start script selected! Stop here.")
    return(invisible(NULL))
  }
  if(is.null(submit)) submit <- chooseSubmit("Choose submission type",
                                             slurmModes = "scripts/slurmStart.yml")
  runSubmit(runscripts, submit)
}


system("git config core.hooksPath .githooks")

submit <- NULL
runscripts <- NULL
lucode2::readArgs("runscripts", "submit", .silent = TRUE)
runOutputs(runscripts = runscripts, submit = submit)
