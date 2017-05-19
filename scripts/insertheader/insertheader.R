# (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

# *******************************************************************************
# *** This function returns a vector with numbers of lines in f that match h. ***
# ***     If h consists of a text block (multiple lines) only matches         ***
# ***             of the full text block in f are returned.                   ***
# *******************************************************************************

insertheader <- function(maindir="../../", header="scripts/insertheader/header.lhd", oldheader="scripts/insertheader/oldheader.lhd", line_endings="notwin") {

  .findheader <- function(h,f){
    # find line numbers that match first line of header
    first <- which(grepl(h[1],f,fixed=TRUE)) # fixed=T needed since pattern contains brackets
    # start collection
    res <- as.list(first)

    ind_res <- 1

    # For all matches of first line of header: look for matches for next line of
    # header. Only if next line of header matches next line in file, mark line
    # number and continue, else do not continue search for next elemens of h
    for (before in first) {
      for (i in 2:length(h)) {
        current <- which(grepl(h[i],f,fixed=TRUE))
        if( (before+1) %in% current) {
          before <- before+1
          res[[ind_res]]<-c(res[[ind_res]],before)
        } else {
          break
        }
      }
      ind_res <- ind_res + 1
    }
    # Return only full matches (list elements with number of elements equal to
    # number of lines in header)
    complete_matches <- unlist(lapply(res, function(x,h) length(x)==length(h),h))
    ind_matches <- NULL
    if (length(complete_matches) > 0) ind_matches <- which(complete_matches)
    if (length(ind_matches) > 0) return(unlist(res[[ind_matches]]))
    else return(NULL)
  }

  .getExtension <- function(file) {
    return(gsub(".*(\\..*)","\\1",file))
  }

  .addcommentchar <- function(charlist, header,file) {
    if(.getExtension(file) %in% names(charlist)){
      for (i in 1:length(header)) {
        # Do not add comment char in empty lines
        if(header[i] != "") header[i] <- paste(append(header[i],charlist[.getExtension(file)],after=0),collapse = " ")
      }
    }
    return(header)
  }

  cwd <- getwd()
  on.exit(setwd(cwd))
  setwd(maindir)

  h <- readLines(header)

  if(is.null(oldheader)) {
    old <- NULL
  } else {
    old <- readLines(oldheader)
  }

  # create list of all files recursively
  files <- list.files(recursive = TRUE)

  cat("File extension found:")
  print(unique(gsub(".*(\\..*)","\\1",files)))

  donottouch <- c("AUTHORS","README","LICENSE",".lhd",".mz",".rda",".opt",
                  ".spam",".xlsx",".sh",".csv")

  comments <- c(".R"="#",".gms"="***",".cfg"="#",".cs2"="*",".cs3"="*",
                ".cs4"="*",".sh"="#",".txt"="#")

  # insert header to all files
  forbidden <- NULL
  already   <- NULL
  removed   <- NULL
  done      <- NULL

  for (file in files) {
    writefile <- FALSE
    # Ommit files that are in the "donottouch" list
    if (.getExtension(file) %in% donottouch) {
      forbidden <- c(forbidden,file)
      next
      }
    cat("Checking",file,"\n")
    f <- readLines(file)

    # Remove old header
    if (!is.null(0)) {
      tmp <- .findheader(old,f)
      if (!is.null(tmp)){
        f <- f[-tmp]
        writefile <- TRUE
        removed <- c(removed,file)
      }
    }

    # If header is defined
    # AND file does not contain header already
    if (!is.null(h)) {
      if (is.null(.findheader(h,f))) {
        # insert header after line 0
        withcomment <- .addcommentchar(comments,h,file)
        f <- append(f,withcomment,after = 0)
        writefile <- TRUE
        done <- c(done,file)
      } else {
        already <- c(already,file)
      }
    }

    # Write file only if it was modified
    if (writefile) {
      if (line_endings == "win") {
        writeLinesDOS(f,file)
      } else {
        writeLines(f,file)
      }
    }
  }

  cat("Files ommitted:\n")
  print(forbidden)
  cat("Files headers were added to:\n")
  print(done)
  cat("Files that already contain the header:\n")
  print(already)
  cat("Files from which old header was removed:\n")
  print(removed)
}

insertheader()
