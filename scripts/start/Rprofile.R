# |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -------------------------------------------------
# description: Add R snapshot to ".Rprofile"
# position: 4
# -------------------------------------------------

setSnapshot <- function(snapshotdir=NULL) {
  choose_snapshot <- function(title="Please choose a R snapshot") {
    if(dir.exists("/p/projects/rd3mod/R/libraries/snapshots/")) {
      dirs <- base::list.dirs("/p/projects/rd3mod/R/libraries/snapshots/",recursive=F,full.names=F)
      dirs <- sort(dirs)
      cat("\n",title,":\n", sep="")
      cat("0: No snapshot\n")
      cat(paste(1:length(dirs), dirs, sep=": " ),sep="\n")
      cat("Number: ")
      identifier <- as.numeric(gms::getLine())
      if(identifier > 0 & identifier <= length(dirs)) {
        return(paste0("/p/projects/rd3mod/R/libraries/snapshots/",dirs[identifier]))
      } else return(invisible(NULL))
    } else stop("R snapshot folder is only available on PIK cluster")
  }
  
  if(is.null(snapshotdir)) snapshotdir <- choose_snapshot("Please choose a R snapshot")
  
  if(is.null(snapshotdir)) {
    fc <- file(".Rprofile")
    on.exit(close(fc))
    writeLines(c('if(file.exists("~/.Rprofile")) source("~/.Rprofile")'),
               fc)
  } else {
    fc <- file(".Rprofile")
    on.exit(close(fc))
    writeLines(c('if(file.exists("~/.Rprofile")) source("~/.Rprofile")',
                 paste0('.libPaths(',deparse(snapshotdir),')'),
                 paste0('print("Setting libPaths to ',snapshotdir,'")')),
               fc)
  }
  message(".Rprofile written")
}
if(!exists("source_include")) {
  snapshotdir <- NULL
  lucode2::readArgs("snapshotdir", .silent=TRUE)
}

setSnapshot(snapshotdir = snapshotdir)


