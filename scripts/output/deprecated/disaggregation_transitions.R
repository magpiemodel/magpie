# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# --------------------------------------------------------------
# description: Interpolates land transitions to 0.5 degree resolution
# comparison script: FALSE
# ---------------------------------------------------------------

#Version 1.00 - Florian Humpenoeder

library(lucode2)
library(magpie4)
library(luscale)
library(madrat)
library(gms)

############################# BASIC CONFIGURATION #######################################
land_lr_file     <- "avl_land_t.cs3"
land_hr_file     <- "avl_land_t_0.5.mz"
land_hr_out_file           <- "cell.land_transitions_0.5.mz"
land_hr_share_out_file     <- "cell.land_transitions_0.5_share.mz"

prev_year        <- "y1985"            #timestep before calculations in MAgPIE
in_folder        <- "modules/10_land/input"

if(!exists("source_include")) {
  sum_spam_file    <- "0.5-to-n200_sum.spam"
  title       <- "base_run"
  outputdir       <- "output/SSP2_Ref_c200"

  ###Define arguments that can be read from command line
  readArgs("sum_spam_file","outputdir","title")
}
#########################################################################################

cfg <- gms::loadConfig(file.path(outputdir, "config.yml"))
title <- cfg$title
print(title)

# Function to extract information from info.txt
get_info <- function(file, grep_expression, sep, pattern="", replacement="") {
  if(!file.exists(file)) return("#MISSING#")
  file <- readLines(file, warn=FALSE)
  tmp <- grep(grep_expression, file, value=TRUE)
  tmp <- strsplit(tmp, sep)
  tmp <- sapply(tmp, "[[", 2)
  tmp <- gsub(pattern, replacement ,tmp)
  if(all(!is.na(as.logical(tmp)))) return(as.vector(sapply(tmp, as.logical)))
  if (all(!(regexpr("[a-zA-Z]",tmp) > 0))) {
    tmp <- as.numeric(tmp)
  }
  return(tmp)
}
low_res       <- get_info(paste0(outputdir,"/info.txt"),"^\\* Output ?resolution:",": ")
sum_spam_file <- paste0("0.5-to-",low_res,"_sum.spam")
print(sum_spam_file)

### Land Stock

# Load input data
gdx          <- file.path(outputdir,"fulldata.gdx")
land_ini_lr  <- readGDX(gdx,"f10_land","f_land", format="first_found")[,"y1995",]
land_lr      <- land(gdx,sum=FALSE,level="cell")
land_ini_hr  <- read.magpie(file.path(in_folder,land_hr_file))[,"y1995",]
land_ini_hr  <- land_ini_hr[,,getNames(land_lr)]
if(any(land_ini_hr < 0)) {
  warning(paste0("Negative values in inital high resolution dataset detected and set to 0. Check the file ",land_hr_file))
  land_ini_hr[which(land_ini_hr < 0,arr.ind = T)] <- 0
}

# Start interpolation (use interpolate from luscale)
print("Disaggregation Land Stock")
land_hr <- interpolate( x          = land_lr,
                        x_ini_lr   = land_ini_lr,
                        x_ini_hr   = land_ini_hr,
                        spam       = file.path(outputdir,sum_spam_file),
                        prev_year  = prev_year)
land_hr  <- land_hr[,-1,]

### Land Tranitions

# prepare input data
CountryToCell   <- toolGetMapping("CountryToCellMapping.csv", type = "cell")
land_lr <- readGDX(gdx,"ov10_lu_transitions",select = list(type="level"),react = "silent")
if(is.null(land_lr)) stop("No land transitions available in GDX file")
land_ini_hr <- new.magpie(CountryToCell$cell,NULL,getNames(land_lr),fill = 0)
x  <- read.magpie(file.path(in_folder,land_hr_file))[,"y1995",]
x  <- x[,,getNames(land_lr,dim=1)]
for (i in getNames(land_lr,dim=1)) {
  land_ini_hr[,,paste(i,i,sep=".")] <- x[,,i]
}
land_ini_lr <- speed_aggregate(land_ini_hr,file.path(outputdir,sum_spam_file))
getCells(land_ini_lr) <- getCells(land_lr)

# Interpolate Transitions
print("Disaggregation Land Transitions")
land_trans_hr <- interpolate( x          = land_lr,
                        x_ini_lr   = land_ini_lr,
                        x_ini_hr   = land_ini_hr,
                        spam       = file.path(outputdir,sum_spam_file),
                        prev_year  = prev_year)
land_trans_hr  <- land_trans_hr[,-1,]

# Test
test <- dimSums(land_trans_hr,dim=3.1) - land_hr
if(max(test)>0.1||min(test)< -0.1) warning("Sum over land transitions and land stock differ, but should be equal!")
#dimSums(land_hr[1,,],dim=c(1))[,,"crop"]
#dimSums(land_trans_hr[1,,],dim=c(1,3.1))[,,"crop"]

# Write outputs

print("Write outputs cell.land")
# write landpool
write.magpie(land_trans_hr,file.path(outputdir,paste(land_hr_out_file,sep="_")),comment="unit: Mha per grid-cell")
write.magpie(land_trans_hr,file.path(outputdir,paste(sub(".mz",".nc",land_hr_out_file),sep="_")),comment="unit: Mha per grid-cell", verbose=FALSE)

print("Write outputs cell.land_share")
# calculate share of land pools in terms of tatal cell size
land_trans_hr_shr <- land_trans_hr/dimSums(land_trans_hr,dim=3)
# write landpool shares
write.magpie(land_trans_hr_shr,file.path(outputdir,paste(land_hr_share_out_file,sep="_")),comment="unit: grid-cell land area fraction")
write.magpie(land_trans_hr_shr,file.path(outputdir,paste(sub(".mz",".nc",land_hr_share_out_file),sep="_")),comment="unit: grid-cell land area fraction", verbose=FALSE)
