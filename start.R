# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

##########################################################
#### MAgPIE output generation ####
##########################################################

library(lucode2)
library(gms)

runOutputs <- function(runscripts=NULL, submit=NULL) {

  get_line <- function(){
    # gets characters (line) from the terminal or from a connection
    # and returns it
    if(interactive()){
      s <- readline()
    } else {
      con <- file("stdin")
      s <- readLines(con, 1, warn=FALSE)
      on.exit(close(con))
    }
    return(s);
  }

  choose_submit <- function(title="Please choose run submission type") {
    slurm <- suppressWarnings(ifelse(system2("srun",stdout=FALSE,stderr=FALSE) != 127, TRUE, FALSE))
    modes <- c("SLURM priority",
               "SLURM standby",
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
    cat(paste(1:length(modes), modes, sep=": " ),sep="\n")
    cat("Number: ")
    identifier <- get_line()
    identifier <- as.numeric(strsplit(identifier,",")[[1]])
    if(slurm) {
      comp <- switch(identifier,
                     "1" = "slurmpriority",
                     "2" = "slurmstandby",
                     "3" = "direct",
                     "4" = "background",
                     "5" = "debug")
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
    for(rout in runscripts){
      name   <- paste0("./scripts/start/",rout)
      if(!file.exists(name)) {
        name2 <- paste0(name,".R")
        if(!file.exists(name)) {
          warning("Script ",name, " could not be found. Skip execution!")
          next
        }
        name <- name2
      }

      cat("Executing",name,"\n")
      sbatch_command <- paste0("sbatch --job-name=",rout," --output=",rout,"-%j.out --mail-type=END --wrap=\"Rscript ",name,"\"")
      if(submit=="direct") {
        tmp.env <- new.env()
        tmp.error <- try(sys.source(name,envir=tmp.env))
        if(!is.null(tmp.error)) warning("Script ",name," was stopped by an error and not executed properly!")
        rm(tmp.env)
      } else if(submit=="background") {
        log <- format(Sys.time(), paste0(rout,"-%Y-%H-%M-%S-%OS3.log"))
        system2("Rscript",name, stderr = log, stdout = log, wait=FALSE)
      } else if(submit=="slurmpriority") {
        system(paste(sbatch_command,"--qos=priority"))
        Sys.sleep(1)
      } else if(submit=="slurmstandby") {
        system(paste(sbatch_command,"--qos=standby"))
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



  if(is.null(runscripts)) runscripts <- selectScript("./scripts/start")
  if(is.null(submit))     submit     <- choose_submit("Choose submission type")
  runsubmit(runscripts, submit)
}


runscripts <- submit <- NULL
lucode2::readArgs("runscripts","submit", .silent=TRUE)
runOutputs(runscripts=runscripts, submit=submit)
