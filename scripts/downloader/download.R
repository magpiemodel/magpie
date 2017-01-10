# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3 
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

# *********************************************************************
# ***   This script downloads biophysical input data from archive   ***
# ***       and applies corresponding changes to gams code          ***
# *********************************************************************

# New version based on tgz files

library(magclass)
library(lucode)

################################################################################
#Create file2destination mapping based on information from the model
################################################################################
getfiledestinations <- function() {
  files <- dir(pattern="files$",recursive = TRUE)
  out <- NULL
  for(f in files) {
    tmp <- grep("^\\*",readLines(f),invert=TRUE,value=TRUE)
    add <- data.frame(file=tmp,destination=dirname(f),stringsAsFactors = FALSE)
    out <- rbind(out,add)
  }
  return(out)
}

################################################################################
#Define function which loads data from repository and unpacks it
################################################################################
load_unpack <- function(files, repository, username=NULL, ssh_private_keyfile=NULL, debug=FALSE) {
  
  if(is.null(username)) username <- getOption("username")
  if(is.null(ssh_private_keyfile)) ssh_private_keyfile <- getOption("ssh_private_keyfile")
  
  cat("Load data from repository\n")
  anydatafound <- FALSE
  md5sum <- list()
  for(i in 1:length(files)) {
    file <- files[i]
    cat(" Search for",file,"...\n")
    filepath <- NULL
    for(repo in repository) {
      cat("  Try",repo,"...")
      path <- paste0(sub("/$","",repo),"/",file)
      if(grepl("://",path)) {
        require(curl, quietly = !debug)
        h <- new_handle(ssh_private_keyfile=ssh_private_keyfile, username=username, verbose=debug)
        tmpdir <- tempdir()
        #tmpdir <- "input"
        tmp <- try(curl_download(path,paste0(tmpdir,"/",file),handle=h),silent = !debug)
        if(is(tmp,"try-error")) {
          cat(" failed!\n")
          if(debug) {
            cat(tmp)
          }
        } else {
          names(files)[i] <- repo
          filepath <- paste0(tmpdir,"/",file)
          cat(" success!\n")
          break        
        }
      } else {
        if(file.exists(path)) {
          names(files)[i] <- repo
          filepath <- path
          cat(" success!\n")
          break
        } else {
          cat(" failed!\n")
        }
      }
    }
    if(is.null(filepath)) {
      warning(file," could not be found in any of the specified repositories!")
    } else {
      anydatafound <- TRUE
      md5sum[[files[i]]] <- md5sum(filepath)
      untar(filepath,exdir="input")
    }
  }  
  if(!anydatafound) stop("None of the provided input data files could be found! In the case of remote access: Did you provide proper username and ssh_private_keyfile?")
  attr(files,"md5") <- md5sum
  return(files)
}

################################################################################
#Delete data provided in mapping
################################################################################
delete_olddata <- function(x) {
  if(is.character(x)) {
    if(!file.exists(x)) stop("Cannot find file mapping!")
    map <- read.csv(x, sep = ";", stringsAsFactors = FALSE)
  } else {
    map <- x
  }
  x <- map$file
  names(x) <- map$destination
  for(i in 1:length(x)) {
    outputpath <- Sys.glob(path(names(x)[i],x[i]))
    for(file in outputpath) file.remove(file)  
  }
}
################################################################################

################################################################################
#Define the copy routine that additionally performs some checks
################################################################################
copy_input <- function(x, sourcepath, low_res, move=FALSE) {
  if(is.character(x)) {
    if(!file.exists(x)) stop("Cannot find file mapping!")
    map <- read.csv(x, sep = ";", stringsAsFactors = FALSE)
  } else {
    map <- x
  }
  x <- map$file
  names(x) <- map$destination
  if(move) {
    cat("\nStart moving input files:\n")
  } else {
    cat("\nStart copying input files:\n")    
  }
  nmax <- max(nchar(x))
  require(magclass)
  for(i in 1:length(x)) {
    outputpath <- path(names(x)[i],x[i])
    if(file.exists(outputpath)) file.remove(outputpath)  
    inputpath <- paste0(sourcepath,"/",x[i])
    if(!file.exists(inputpath)) {
      inputpath <- Sys.glob(sub("^(.*)\\.[^\\.]*$", paste0(sourcepath,"/\\1_",low_res,".*"), x[i]))
      if(length(inputpath)>1) {
        stop("Problem determining the proper input path for file", x[i], "(more than one possible path found)")
      } else if(length(inputpath)==0) {
        warning("File ", x[i]," seems to be missing!")
        cat("   ",format(x[i],width=nmax)," ->  FAILED!\n") 
        next
      }      
    }
    copy.magpie(inputpath,outputpath)
    if(move & !(i != length(x) &  (x[i] %in% x[i+1:length(x)]))) {
        file.remove(inputpath)
    }
    cat("   ",format(x[i],width=nmax)," -> ",outputpath, "\n") 
  }
  cat("\n")
}
################################################################################

################################################################################
#Define routine to update GAMS sets
################################################################################
update_sets <- function(cpr,map) {
  require(lucode)
  j <- 0; cells <- NULL
  for(i in 1:length(cpr)) {
    cells <- c(cells,paste(names(cpr)[i],"_",j+1,"*",names(cpr)[i],"_",j+cpr[i],sep=""))
    j <- j+cpr[i]
  }
  
  .tmp <- function(x,prefix="", suffix1="", suffix2=" /", collapse=",", n=10) {
    content <- NULL
    tmp <- lapply(split(x, ceiling(seq_along(x)/n)),paste,collapse=collapse)
    end <- suffix1
    for(i in 1:length(tmp)) {
      if(i==length(tmp)) end <- suffix2
      content <- c(content,paste0('       ',prefix,tmp[[i]],end))
    }
    return(content)
  }
  
  subject <- 'SETS'
  modification_warning <- c(
    '*THIS CODE IS CREATED AUTOMATICALLY, DO NOT MODIFY THESE LINES DIRECTLY',
    '*ANY DIRECT MODIFICATION WILL BE LOST AFTER NEXT INPUT DOWNLOAD',
    '*CHANGES CAN BE DONE USING THE INPUT DOWNLOADER UNDER SCRIPTS/DOWNLOAD',
    '*THERE YOU CAN ALSO FIND ADDITIONAL INFORMATION')
  content <- c(modification_warning,'','sets','')
  
  content <- c(content,paste('   i all economic regions /',paste(names(cpr),collapse=','),'/',sep=''),'')
  
  # write iso set with nice formatting (10 countries per line)
  tmp <- lapply(split(map$CountryCode, ceiling(seq_along(map$CountryCode)/10)),paste,collapse=",")
  content <- c(content,'   iso list of iso countries /')
  content <- c(content, .tmp(map$CountryCode, suffix1=",", suffix2=" /"))
  
  content <- c(content,  '', paste('   j number of LPJ cells /\n       ',paste(cells,collapse=',\n       '),'/',sep=''),'',
               '   cell(i,j) number of LPJ cells per region i','      /')
  for(i in 1:length(cpr)) {
    content <- c(content,paste('       ',names(cpr)[i],' . ',cells[i],sep=''))
  }
  content <- c(content,'      /','')
  
  content <- c(content,'   i_to_iso(i,iso) mapping regions to iso countries','      /')
  for(i in levels(map$RegionCode)) {
    content <- c(content, .tmp(map$CountryCode[map$RegionCode==i], prefix=paste0(i," . ("), suffix1=")", suffix2=")"))
    
  }
  content <- c(content,'      /',';') 
  replace_in_file("core/sets.gms",content,subject)
}
################################################################################

################################################################################
#Define routine to update info file in input folder and info in main.gms
################################################################################
update_info <- function(datasets, low_res, high_res, cpr,
                        regionscode, reg_revision, warnings=NULL) {
  require(lucode)
  info <- readLines('input/info.txt')
  subject <- 'VERSION INFO'
  
  useddata <- NULL
  for(i in 1:length(datasets)) {
    if(is.na(names(datasets)[i])) {
      warnings <- c(warnings,paste0("WARNING: Requested input data file ",datasets[i]," not found and therefore ignored!"))
    } else {
      useddata <- c(useddata,
                    '',
                    paste('Used data set:',datasets[i]),
                    paste('md5sum:',attr(datasets,"md5")[[datasets[i]]]),
                    paste('Repository:',names(datasets)[i]))
    }
  }
  
  
  content <- c(useddata,
               '',
               paste('Low resolution:',low_res),
               paste('High resolution:',high_res),
               '',
               paste('Total number of cells:',sum(cpr)),
               '',
               'Number of cells per region:',
               paste(format(names(cpr),width=5,justify="right"),collapse=""),
               paste(format(cpr,width=5),collapse=""),
               '',
               paste('Regionscode:',regionscode),
               '',
               paste('Regions data revision:',reg_revision),
               '',
               info,
               '',
               warnings,
               '',
               paste('Last modification (input data):',date()),
               '')
  writeLines(content,'input/info.txt')
  replace_in_file("main.gms",paste('*',content),subject)  
}
################################################################################

################################################################################
#Function to extract information from info.txt
################################################################################
get_info <- function(file,grep_expression,sep,pattern="",replacement="") {
  if(!file.exists(file)) stop("info.txt file is missing with required information about the input")
  file <- readLines(file)
  tmp <- grep(grep_expression,file, value=TRUE)
  tmp <- strsplit(tmp, sep)
  tmp <- sapply(tmp, "[[", 2)
  tmp <- gsub(pattern,replacement,tmp)
  if(length(tmp)==0) stop(grep_expression," could not be found!")
  return(tmp)
}
################################################################################


archive_download <- function(files=c("GLUES2-sresa2-constant_co2-miub_echo_g_ERB_rev22.1_n200_690d3718e151be1b450b394c1064b1c5.tgz",
                                     "690d3718e151be1b450b394c1064b1c5_magpie_rev2.499.tgz"),
                             repositories=c("/p/projects/landuse/data/input/raw_data",
                                            "/p/projects/rd3mod/inputdata/output",
                                            "scp://cluster.pik-potsdam.de/p/projects/landuse/data/input/raw_data",
                                            "scp://cluster.pik-potsdam.de/p/projects/rd3mod/inputdata/output"),
                             modelfolder=".",
                             move=TRUE,
                             username=NULL,
                             ssh_private_keyfile=NULL,
                             debug=FALSE) {
  
  require(lucode)
  require(magclass)
  warnings <- NULL
  
  cdir <- getwd()
  setwd(modelfolder)
  on.exit(setwd(cdir))
  
  ################## GENERAL CLEAN UP ###################################
  # delete old input files to avoid mixed inputs in the case that data 
  # download fails at some point
  file2destination <- getfiledestinations()
  
  cat("\nDelete old data in input folders ... ")
  # delete files which will be copied/moved later on with copy_input
  delete_olddata(file2destination)
  # delete additional files not treated by copy_input
  delete_olddata("scripts/downloader/inputdelete.csv")
  cat("done!\n\n")
  
  ##################### DATA DOWNLOAD #########################################  
  # load data from source and unpack it
  filemap <- load_unpack(files, repositories, username, ssh_private_keyfile, debug)
  
  low_res  <- get_info("input/info.txt","^\\* Output ?resolution:",": ")
  high_res <- get_info("input/info.txt","^\\* Input ?resolution:",": ")
  
  ################## COPY MAGPIE INPUT FILES ###################################
  # In the following input files in MAgPIE format are converted (if required) to
  # csX files and copied into the corresponding input folders. In this step also the
  # resolution information in the file name (if existing) is removed to allow a resolution-
  # indepedent gams-sourcecode.

  copy_input(file2destination, "input", low_res, move)
  
    
  ###################### MANIPULATE GAMS FILES ###################################
  # In the following the GAMS sourcecode files magpie.gms and sourcecode/sets.gms
  # are manipulated. Therefore some information about the number of cells per 
  # region is required (CPR). This information is gained by extracting it from
  # the avl_land.cs3 input file (any other cellular file could be used as well). 
  # This information is then transfered to update_info, which is 
  # updating the general information in magpie.gms and input/info.txt 
  # and update_sets, which is updating the resolution- and region-depending 
  # sets in sourcecode/sets.gms
  
  tmp <- read.magpie("modules/10_land/input/avl_land.cs3")
  cpr <- getCPR(tmp)
  # read spatial_header, map, reg_revision and regionscode
  load("input/spatial_header.rda")
  update_info(filemap,low_res,high_res,cpr,regionscode,reg_revision, warnings)
  update_sets(cpr,map)
}
