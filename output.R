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

runOutputs <- function(comp=NULL, output=NULL, outputdir=NULL, submit=NULL) {

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
    tmp <- try(system("find ./output -name 'full.gms'", intern=TRUE,  ignore.stderr = TRUE), silent=TRUE)
    if("try-error" %in% class(tmp) | length(tmp)==0) {
      tmp <- base::list.dirs("./output/",recursive=TRUE)
      dirs <- NULL
      for (i in 1:length(tmp)) {
        if (file.exists(path(tmp[i],"full.gms"))) dirs <- c(dirs,sub("./output/","",tmp[i]))
      }
    } else {
      dirs <- sub("full.gms","",sub("./output/","",tmp, fixed=TRUE), fixed=TRUE)
    }
    dirs <- sort(dirs)
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
      id <- grep(pattern=pattern, dirs[-1], perl=TRUE)
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

  runsubmit <- function(output, alloutputdirs, submit, script_path) {
    #Set value source_include so that loaded scripts know, that they are
    #included as source (instead of a load from command line)
    source_include <- TRUE
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
		print("script executed as comparison script")
        loop <- list(alloutputdirs)
      } else {
		if(length(alloutputdirs)>1) {print("script executed multiple times in parallel")} else {print("script executed as single output script")}
		loop <- alloutputdirs
		print(loop)
		print(str(loop))
      }
      for(outputdir in loop) {
        message(" -> ",name)
		print(paste0("starting script for outputdir",outputdir))
        r_command <- paste0("Rscript output.R outputdir=",paste(outputdir,collapse=","),"  output=",rout," submit=direct")
        sbatch_command <- paste0("sbatch --job-name=scripts-output --output=log_out-%j.out --error=log_out-%j.err --mail-type=END --time=200 --mem-per-cpu=8000 --wrap=\"",r_command,"\"")
        if(submit=="direct") {
          tmp.env <- new.env()
          tmp.error <- try(sys.source(script,envir=tmp.env))
          if(!is.null(tmp.error)) warning("Script ",name," was stopped by an error and not executed properly!")
          rm(tmp.env)
        } else if(submit=="background") {
          system(paste0(r_command," &> ",format(Sys.time(), "blog_out-%Y-%H-%M-%S-%OS3.log")," &"))
        } else if(submit=="slurm default") {
          system(paste(sbatch_command, "--qos=standby"))
        } else if(submit=="slurm priority") {
          system(paste(sbatch_command, "--qos=priority"))
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

  if(is.null(outputdir)) outputdir <- choose_folder("Choose runs")
  if(is.null(output))     output     <- gms::selectScript("./scripts/output")
  if(is.null(submit))     submit     <- choose_submit("Choose submission type")
  if(is.null(output)) {
    message("No output script selected! Stop here.")
    return(invisible(NULL))
  }
  if(is.null(outputdir)) {
    message("No output folder selected! Stop here.")
    return(invisible(NULL))
  }
  runsubmit(output, alloutputdirs = outputdir, submit, "scripts/output/")
}

if(!exists("source_include")) {
  output <- outputdir <- submit <- NULL
  lucode2::readArgs("output","outputdir","submit", .silent=TRUE)
}

runOutputs(output=output, outputdir = outputdir, submit=submit)
