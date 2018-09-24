# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de

# *********************************************************************
# ***   This script downloads model input data                      ***
# ***       and applies corresponding changes to gams code          ***
# *********************************************************************

# New version is based on tgz files

library(magclass)
library(lucode)

################################################################################
#Create file2destination mapping based on information from the model
################################################################################
getfiledestinations <- function() {
  folders <- base::list.dirs(recursive=FALSE, full.names=FALSE)
  folders <- grep("^(\\.|225|output|calib_run|figure)",folders, invert=TRUE, value=TRUE)
  files <- NULL
  for(f in folders) files <- c(files,dir(path=f,pattern="^files$",recursive = TRUE, full.names=TRUE))
  out <- NULL
  for(f in files) {
    tmp <- grep("^\\*",readLines(f, warn = FALSE),invert=TRUE,value=TRUE)
    add <- data.frame(file=tmp,destination=dirname(f),stringsAsFactors = FALSE)
    out <- rbind(out,add)
  }
  out <- as.data.frame(lapply(out,trimws),stringsAsFactors=FALSE)
  return(out[out[[1]]!="",])
}

################################################################################
#Delete data provided in mapping
################################################################################
delete_olddata <- function(x) {
  if(is.character(x)) {
    if(!file.exists(x)) stop("Cannot find file mapping!")
    map <- read.csv(x, sep = ";", stringsAsFactors = FALSE, comment.char = "#")
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
    copy.magpie(inputpath, outputpath, round=8)
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

  reg1 <- unique(map$RegionCode)
  reg2 <- names(cpr)
   if(!all(union(reg1,reg2) %in% intersect(reg1,reg2))) {
     stop("Inconsistent region information!",
          "\n cpr info: ",paste(reg2,collapse=", "),
          "\n spatial header info: ", paste(reg1,collapse=", "))
   }


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

  content <- c(content,paste('   i world regions /',paste(names(cpr),collapse=','),'/',sep=''),'')

  # write iso set with nice formatting (10 countries per line)
  tmp <- lapply(split(map$CountryCode, ceiling(seq_along(map$CountryCode)/10)),paste,collapse=",")
  content <- c(content,'   iso countries /')
  content <- c(content, .tmp(map$CountryCode, suffix1=",", suffix2=" /"))

  content <- c(content,  '', paste('   j spatial clusters /\n       ',paste(cells,collapse=',\n       '),'/',sep=''),'',
               '   cell(i,j) mapping between regions i and clusters j','      /')
  for(i in 1:length(cpr)) {
    content <- c(content,paste('       ',names(cpr)[i],' . ',cells[i],sep=''))
  }
  content <- c(content,'      /','')

  content <- c(content,'   i_to_iso(i,iso) mapping between regions and countries','      /')
  map$RegionCode <- as.factor(map$RegionCode)
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
  for(dataset in rownames(datasets)) {
    useddata <- c(useddata,
                  '',
                  paste('Used data set:',dataset),
                  paste('md5sum:',datasets[dataset,"md5"]),
                  paste('Repository:',datasets[dataset,"repo"]))
  }

  warnings <- attr(datasets,"warnings")
  if(!is.null(warnings)) {
    warnings <- capture.output(warnings)
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
                             repositories=list("/p/projects/landuse/data/input/raw_data"=NULL,
                                               "/p/projects/rd3mod/inputdata/output"=NULL),
                             modelfolder=".",
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
  delete_olddata("scripts/downloader/inputdelete.cfg")
  cat("done!\n\n")

  ##################### DATA DOWNLOAD #########################################
  # load data from source and unpack it
  filemap <- lucode::download_unpack(input=files, targetdir="input", repositories=repositories, debug=FALSE)

  low_res  <- get_info("input/info.txt","^\\* Output ?resolution:",": ")
  high_res <- get_info("input/info.txt","^\\* Input ?resolution:",": ")

  ################## COPY MAGPIE INPUT FILES ###################################
  # In the following input files in MAgPIE format are converted (if required) to
  # csX files and copied into the corresponding input folders. In this step also
  # the resolution information in the file name (if existing) is removed to
  # allow a resolution-indepedent gams-sourcecode.

  copy_input(file2destination, "input", low_res, !debug)


  ###################### MANIPULATE GAMS FILES ###################################
  # In the following the GAMS sourcecode files magpie.gms and core/sets.gms
  # are manipulated. Therefore some information about the number of cells per
  # region is required (CPR). This information is gained by extracting it from
  # the avl_land.cs3 input file (any other cellular file could be used as well).
  # This information is then transfered to update_info, which is
  # updating the general information in magpie.gms and input/info.txt
  # and update_sets, which is updating the resolution- and region-depending
  # sets in core/sets.gms

  tmp <- read.magpie("modules/10_land/input/avl_land_t.cs3")
  cpr <- getCPR(tmp)
  # read spatial_header, map, reg_revision and regionscode
  load("input/spatial_header.rda")
  update_info(filemap,low_res,high_res,cpr,regionscode,reg_revision, warnings)
  update_sets(cpr,map)
}
