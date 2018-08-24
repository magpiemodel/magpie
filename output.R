# | (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# | authors, and contributors see AUTHORS file
# | This file is part of MAgPIE and licensed under GNU AGPL Version 3
# | or later. See LICENSE file or go to http://www.gnu.org/licenses/
# | Contact: magpie@pik-potsdam.de

##########################################################
#### MAgPIE output generation ####
##########################################################

library(lucode)

runOutputs <- function(comp=NULL, output=NULL, outputdirs=NULL, submit=NULL) {

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

  choose_folder <- function(title="Please choose a folder") {
    # try to use find because it is significantly quicker than list.dirs
    tmp <- try(system("find ./output -name 'fulldata.gdx'", intern=TRUE,  ignore.stderr = TRUE), silent=TRUE)
    if("try-error" %in% class(tmp) | length(tmp)==0) {
      tmp <- base::list.dirs("./output/",recursive=TRUE)
      dirs <- NULL
      for (i in 1:length(tmp)) {
        if (file.exists(path(tmp[i],"fulldata.gdx"))) dirs <- c(dirs,sub("./output/","",tmp[i]))
      }
    } else {
      dirs <- sub("fulldata.gdx","",sub("./output/","",tmp, fixed=TRUE), fixed=TRUE)
    }
    dirs <- c("all",dirs)
    cat("\n",title,":\n", sep="")
    cat(paste(1:length(dirs), dirs, sep=": " ),sep="\n")
    cat(paste(length(dirs)+1, "Search by the pattern.\n", sep=": "))
    cat("Number: ")
    identifier <- get_line()
    identifier <- strsplit(identifier,",")[[1]]
    tmp <- NULL
    for (i in 1:length(identifier)) {
      if (length(strsplit(identifier,":")[[i]]) > 1) tmp <- c(tmp,as.numeric(strsplit(identifier,":")[[i]])[1]:as.numeric(strsplit(identifier,":")[[i]])[2])
      else tmp <- c(tmp,as.numeric(identifier[i]))
    }
    identifier <- tmp
    # PATTERN
    if(length(identifier==1) && identifier==(length(dirs)+1)){
      cat("\nInsert the search pattern or the regular expression: ")
      pattern <- get_line()
      id <- grep(pattern=pattern, dirs[-1])
      # lists all directories matching the pattern and ask for confirmation
      cat("\n\nYou have chosen the following directories:\n")
      cat(paste(1:length(id), dirs[id+1], sep=": "), sep="\n")
      cat("\nAre you sure these are the right directories?(y/n): ")
      answer <- get_line()
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

  choose_module <- function(Rfolder,title="Please choose an outputmodule") {
    module <- gsub("\\.R$","",grep("\\.R$",list.files(Rfolder), value=TRUE))
    cat("\n",title,":\n",sep="")
    cat(paste(1: length(module), module, sep=": " ),sep="\n")
    cat("Number: ")
    identifier <- get_line()
    identifier <- as.numeric(strsplit(identifier,",")[[1]])
    if (any(!(identifier %in% 1:length(module)))) stop("This choice (",identifier,") is not possible. Please type in a number between 1 and ",length(module))
    return(module[identifier])
  }

  choose_mode <- function(title="Please choose the output mode") {
    modes <- c("Output for single run ","Comparison across runs")
    cat("\n",title,":\n",sep="")
    cat(paste(1:length(modes), modes, sep=": " ),sep="\n")
    cat("Number: ")
    identifier <- get_line()
    identifier <- as.numeric(strsplit(identifier,",")[[1]])
    if (identifier==1) {
      return(FALSE)
    } else if (identifier==2) {
      return(TRUE)
    } else {
      stop("This mode is invalid. Please choose a valid mode")
    }
  }

  choose_submit <- function(title="Please choose run submission type") {
    slurm <- suppressWarnings(ifelse(system2("srun",stdout=FALSE,stderr=FALSE) != 127, TRUE, FALSE))
    modes <- c("SLURM (default)", "SLURM priority","Direct execution", "Background execution", "Debug mode")
    if(slurm) {
      cat("\nCurrent cluster utilization:\n")
      system("sclass")
      cat("\n")
    } else {
     modes <- modes[-1:-2]
    }
    cat("\n",title,":\n",sep="")
    cat(paste(1:length(modes), modes, sep=": " ),sep="\n")
    cat("Number: ")
    identifier <- get_line()
    identifier <- as.numeric(strsplit(identifier,",")[[1]])
    if(slurm) {
      system("sclass")
      comp <- switch(identifier,
                     "1" = "slurm default",
                     "2" = "slurm priority",
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

  runsubmit <- function(output, outputdirs, comp, script_path) {
    # run output scripts over all choosen folders
    for(rout in output){
      name   <- paste0(rout,".R")
      script <- paste0(script_path,name)
      if(!file.exists(script)) {
        warning("Script ",name, " could not be found. Skip execution!")
        next
      }
      if(!comp) outputdir <- outputdirs
      cat(" -> ",name)
      if(submit=="direct") {
        tmp.env <- new.env()
        tmp.error <- try(sys.source(script,envir=tmp.env))
        if(!is.null(tmp.error)) warning("Script ",name," was stopped by an error and not executed properly!")
        rm(tmp.env)
      } else if(submit=="background") {
        system(paste0("Rscript output.R outputdirs=",paste(outputdirs,collapse=",")," comp=",comp,"  output=",rout," submit=direct &> ",format(Sys.time(), "blog_out-%Y-%H-%M-%S-%OS3.log")," &"))
      } else if(submit=="slurm default") {
        system(paste0("srun --qos=standby --job-name=scripts-output --output=log_out-%j.out --error=log_out-%j.err --mail-type=END --time=200 --mem-per-cpu=8000 Rscript output.R outputdirs=",paste(outputdirs,collapse=",")," comp=",comp,"  output=",rout," submit=direct &"))
        Sys.sleep(1)
      } else if(submit=="slurm priority") {
        system(paste0("srun --qos=priority --job-name=scripts-output --output=log_out-%j.out --error=log_out-%j.err --mail-type=END --mem-per-cpu=8000 Rscript output.R outputdirs=",paste(outputdirs,collapse=",")," comp=",comp,"  output=",rout," submit=direct &"))
        Sys.sleep(1)
      } else if(submit=="debug") {
        tmp.env <- new.env()
        sys.source(script,envir=tmp.env)
        rm(tmp.env)
      } else {
        stop("Unknown submission type")
      }
    }
  }


  if(is.null(comp))       comp       <- choose_mode("Choose output type")
  if(is.null(outputdirs)) outputdirs <- choose_folder("Choose runs")
  if(is.null(output))     output     <- choose_module(ifelse(comp,"./scripts/output/comparison","./scripts/output/single"),
                                                      "Choose output scripts")
  if(is.null(submit))     submit     <- choose_submit("Choose submission type")

  #Set value source_include so that loaded scripts know, that they are
  #included as source (instead of a load from command line)
  source_include <- TRUE


  if (comp) {
    cat("Output comparsion mode\n")
    runsubmit(output, outputdirs, TRUE, "scripts/output/comparison/")
  } else {
    cat("Run postprocessing mode\n")
    for (outputdir in outputdirs) {
      cat(paste("\nSubmit",outputdir))
      runsubmit(output, outputdir, FALSE, "scripts/output/single/")
    }
  }
  cat("\n\n")
}

if(!exists("source_include")) {
  comp <- output <- outputdirs <- submit <- NULL
  readArgs("comp","output","outputdirs","submit", .silent=TRUE)
}

runOutputs(comp=comp, output=output, outputdirs = outputdirs, submit=submit)
