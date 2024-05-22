# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Compiles model run time for PR
# comparison script: TRUE
# ---------------------------------------------------------------

############################# LOAD LIBRARIES #############################
library(lucode2, quietly = TRUE, warn.conflicts =FALSE)
  
if(!exists("source_include")) {
  outputdir <- file.path("output",list.dirs("output", full.names = FALSE, recursive = FALSE))
  lucode2::readArgs("outputdir")
}
  
runtime <- NULL
maindir <- getwd()

# ---- Read runtime data ----

cat("\nReading runtime for", length(outputdir), "runs\n")
for (d in outputdir) {
  splittedpath <- strsplit(d, "/")[[1]]
  runfolder <- splittedpath[length(splittedpath)]
  datafile <- paste0(d, "/runstatistics.rda")
  
  # try to read runtime data from runstatistics.rda
  tmp     <- NULL
  start   <- NULL
  end     <- NULL
  timePrepareStart <- NULL
  timePrepareEnd   <- NULL
  timeGAMSStart    <- NULL
  timeGAMSEnd      <- NULL
  timeOutputStart  <- NULL
  timeOutputEnd    <- NULL
  
  if (!file.exists(datafile)) {
    cat("No file found ", datafile, "\n")
  } else if (file.info(datafile)$size == 0) {
    cat("Empty file ", datafile, "\n")
  } else {
    # if file exists and it's file size is >0: load it
    stats <- NULL
    load(datafile)
    # try to load detailed runtime information
    if (!is.null(stats) && !is.null(stats$timePrepareStart)) {
      timePrepareStart <- stats$timePrepareStart
      timePrepareEnd   <- stats$timePrepareEnd
      timeGAMSStart    <- stats$timeGAMSStart
      timeGAMSEnd      <- stats$timeGAMSEnd
      timeOutputStart  <- stats$timeOutputStart
      timeOutputEnd    <- stats$timeOutputEnd
    } else if (!is.null(stats) && !is.null(stats$starttime)) {
      # if no detailed information is available load the old one (it's only the gams runtime)
      start <- stats$starttime
      end   <- stats$endtime
    }
  }
  
  # if no start and end was extractable from runstatistics.rda
  # conclude it from timestamps of the files in the results folder
  if (is.null(end) && is.null(timePrepareEnd) && is.null(timeGAMSEnd) && is.null(timeOutputEnd)) {
    local_dir(d)
    # find all files
    info <- file.info(dir())
    # sort files in info by mtime
    info <- info[order(info$mtime), ]
    # save time of first file in the list (oldest)
    start <- info[1, ]$mtime
    # save time if last file in the list (newest)
    
    if ("report.rds" %in% rownames(info)) {
      # if run has finished normally the report.rds file should exist. In this case take the newest file
      cat("Using the newest file in", runfolder, "as end\n")
      end <- tail(info$mtime, n = 1)
    } else {
      # if report.rds does not exist, this indicates that the run did not finish properly and the mif file has been
      # generated manually later without also producing the report.rds
      # In this case do not take the newest file (which is the manually and belated produced mif file) but take the
      # full.lst which is the newest file before the mif file
      cat("Using", runfolder, "full.lst as end\n")
      end <- info["full.lst", ]$mtime
    }
    local_dir(maindir)
  }
  
  # if (total) runtime data was found
  if (all(c(!is.null(start), !is.null(end)))) {
    # need to be transformed to NA otherwise rbind would not work if one of them is NULL
    tmp <- end - start
    units(tmp) <- "hours"
    if (is.null(start)) start <- NA
    if (is.null(end)) end   <- NA
    new <- data.frame(section = "total", run = runfolder, mins = round(tmp,1), stringsAsFactors = FALSE)
    runtime <- rbind(runtime, new)
  }
  
  # if detailed runtime data was found append it
  if (!is.null(timePrepareEnd)) {
    tmp <- timePrepareEnd - timePrepareStart
    units(tmp) <- "mins"
    new <- data.frame(section = "prep", run = runfolder, mins = round(tmp,1), stringsAsFactors = FALSE)
    runtime <- rbind(runtime, new)
  }
  
  if (!is.null(timeGAMSEnd)) {
    tmp <- timeGAMSEnd - timeGAMSStart
    units(tmp) <- "mins"
    new <- data.frame(section = "GAMS", run = runfolder, mins = round(tmp,1), stringsAsFactors = FALSE)
    runtime <- rbind(runtime, new)
  }
  
  if (!is.null(timeOutputEnd)) {
    tmp <- timeOutputEnd - timeOutputStart
    units(tmp) <- "mins"
    new <- data.frame(section = "output", run = runfolder, mins = round(tmp,1), stringsAsFactors = FALSE)
    runtime <- rbind(runtime, new)
  }
}

runtime <- runtime[order(runtime$section,runtime$run),]
write.csv(runtime, file = "output/runtimePR.csv", quote = FALSE,row.names = FALSE)
