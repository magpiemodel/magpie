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

runOutputs <- function(runscripts=NULL, submit=NULL) {
  choose_submit <- function(title="Please choose run submission type") {
    slurm <- suppressWarnings(ifelse(system2("srun",stdout=FALSE,stderr=FALSE) != 127, TRUE, FALSE))
    modes <- c("SLURM priority",
               "SLURM standby",
               "SLURM medium",
               "Direct execution",
               "Background execution",
               "Debug mode")
    if(slurm) {
      cat("\nCurrent cluster utilization:\n")
      system("sclass")
      cat("\n")
    } else {
      modes <- grep("SLURM",modes,invert=TRUE,value=TRUE)
    }
    cat("\n",title,":\n", sep="")
    cat(paste(seq_along(modes), modes, sep=": " ),sep="\n")
    cat("Number: ")
    identifier <- gms::getLine()
    identifier <- as.numeric(strsplit(identifier,",")[[1]])
    if(slurm) {
      comp <- switch(identifier,
                     "1" = "slurmpriority",
                     "2" = "slurmstandby",
                     "3" = "slurmmedium",
                     "4" = "direct",
                     "5" = "background",
                     "6" = "debug")
    } else {
      comp <- switch(identifier,
                     "1" = "direct",
                     "2" = "background",
                     "3" = "debug")
    }
    if(is.null(comp)) stop("This type is invalid. Please choose a valid type")
    return(comp)
  }

  runsubmit <- function(runscripts, submit) {
    if(!dir.exists("logs")) dir.create("logs")
    
    for(rout in runscripts){
      name   <- paste0("./scripts/start/",rout)
      if(!file.exists(name)) {
        name2 <- paste0(name,".R")
        if(!file.exists(name2)) {
          warning("Script ",name2, " could not be found. Skip execution!")
          next
        }
        name <- name2
      }

      cat("Executing",name,"\n")
      rout_name <- sub("\\.R$","",sub("/","_",rout))
      sbatch_command <- paste0("sbatch --job-name=",rout_name," --output=logs/",rout_name,"-%j.out --mail-type=END --wrap=\"Rscript ",name,"\"")
      if(submit=="direct") {
        tmp.env <- new.env()
        tmp.error <- try(sys.source(name,envir=tmp.env))
        if(!is.null(tmp.error)) warning("Script ",name," was stopped by an error and not executed properly!")
        rm(tmp.env)
      } else if(submit=="background") {
        log <- format(Sys.time(), paste0("logs/", rout_name, "-%Y-%H-%M-%S-%OS3.log"))
        system2("Rscript",name, stderr = log, stdout = log, wait=FALSE)
      } else if(submit=="slurmpriority") {
        system(paste(sbatch_command,"--qos=priority"))
        Sys.sleep(1)
      } else if(submit=="slurmstandby") {
        system(paste(sbatch_command,"--qos=standby"))
        Sys.sleep(1)
      } else if(submit=="slurmmedium") {
        system(paste(sbatch_command,"--qos=medium"))
        Sys.sleep(1)
      } else if(submit=="debug") {
        tmp.env <- new.env()
        sys.source(name,envir=tmp.env)
        rm(tmp.env)
      } else {
        stop("Unknown submission type")
      }
    }
  }



  if(is.null(runscripts)) runscripts <- gms::selectScript("./scripts/start")
  if(is.null(runscripts)) {
    message("No start script selected! Stop here.")
    return(invisible(NULL))
  }
  if(is.null(submit))     submit     <- choose_submit("Choose submission type")
  runsubmit(runscripts, submit)
}


system("git config core.hooksPath .githooks")

submit <- NULL
runscripts <- NULL
lucode2::readArgs("runscripts","submit", .silent=TRUE)
runOutputs(runscripts=runscripts, submit=submit)
