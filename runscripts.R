# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

##########################################################
#### MAgPIE output generation ####
##########################################################

library(lucode)

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


  choose_module <- function(Rfolder,title="Please choose an outputmodule") {
    module <- gsub("\\.R$","",grep("\\.R$",list.files(Rfolder), value=TRUE))
    cat("\n\n",title,":\n\n")
    cat(paste(1: length(module), module, sep=": " ),sep="\n")
    cat("\nNumber: ")
    identifier <- get_line()
    identifier <- as.numeric(strsplit(identifier,",")[[1]])
    if (any(!(identifier %in% 1:length(module)))) stop("This choice (",identifier,") is not possible. Please type in a number between 1 and ",length(module))
    return(module[identifier])
  }

  choose_submit <- function(title="Please choose run submission type") {
    slurm <- suppressWarnings(ifelse(system2("srun",stdout=FALSE,stderr=FALSE) != 127, TRUE, FALSE))
    modes <- c("Direct execution", "Background execution", "SLURM submission", "Debug mode")
    if(!slurm) modes <- modes[-3]
    cat("\n\n",title,":\n\n")
    cat(paste(1:length(modes), modes, sep=": " ),sep="\n")
    cat("\nNumber: ")
    identifier <- get_line()
    identifier <- as.numeric(strsplit(identifier,",")[[1]])
    if(slurm) {
      comp <- switch(identifier,
                     "1" = "direct",
                     "2" = "background",
                     "3" = "slurm",
                     "4" = "debug")
    } else {
      comp <- switch(identifier,
                     "1" = "direct",
                     "2" = "background",
                     "3" = "debug")
    }
    if(is.null(comp)) stop("This type is invalid. Please choose a valid type")
    return(comp)
  }

  runsubmit <- function(output) {
    # run output scripts over all choosen folders
    for(rout in output){
      name   <- paste0("./scripts/runscripts/",rout,".R")

      if(!file.exists(name)) {
        warning("Script ",name, " could not be found. Skip execution!")
        next
      }

      cat("Executing",name,"\n")
      if(submit=="direct") {
        tmp.env <- new.env()
        tmp.error <- try(sys.source(name,envir=tmp.env))
        if(!is.null(tmp.error)) warning("Script ",name," was stopped by an error and not executed properly!")
        rm(tmp.env)
      } else if(submit=="background") {
        stop("dont know what background means. sorry. benni.")
      } else if(submit=="slurm") {
        system(paste0("srun --qos=short --job-name=scripts-output --output=log_out-%j.out --error=log_out-%j.err --mail-type=END --time=100 Rscript ",name))
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



  if(is.null(output))     runscripts     <- choose_module("./scripts/runscripts",
                                                      "Please choose the output modules to be used for output generation")
  if(is.null(submit))     submit     <- choose_submit("Please choose a run submission type")

  #Set value source_include so that loaded scripts know, that they are
  #included as source (instead of a load from command line)
  source_include <- TRUE

  runsubmit(runscripts)

}

if(!exists("source_include")) {
  comp <- output <- outputdirs <- submit <- NULL
  readArgs("runscripts","submit")
}

runOutputs(runscripts=runscripts, submit=submit)
