# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de

# *********************************************************************
# ***    This script calculates a regional calibration factor       ***
# ***              based on a pre run of magpie                     ***
# *********************************************************************

calibration_run<-function(putfolder,calib_magpie_name,logoption=3){

  require(lucode)

  # create putfolder for the calib run
  unlink(putfolder,recursive=TRUE)
  dir.create(putfolder)

  # create a modified magpie.gms for the calibration run
  unlink(paste(calib_magpie_name,".gms",sep=""))
  unlink("fulldata.gdx")

  if(!file.copy("main.gms",paste(calib_magpie_name,".gms",sep=""))){
    stop(paste("Unable to create",paste(calib_magpie_name,".gms",sep="")))
  }
  manipulateConfig(paste(calib_magpie_name,".gms",sep=""),c_timesteps=1)
  manipulateConfig(paste(calib_magpie_name,".gms",sep=""),s_use_gdx=0)
  file.copy(paste(calib_magpie_name,".gms",sep=""),putfolder)

  # execute calibration run
  system(paste("gams ",calib_magpie_name,".gms"," -errmsg=1 -PUTDIR ./",putfolder," -LOGOPTION=",logoption,sep=""),wait=TRUE)
  file.copy("fulldata.gdx",putfolder)
}

# get ratio between modelled area and reference area
get_areacalib <- function(gdx_file) {
  require(magclass)
  require(magpie4)
  require(gdx)
  require(luscale)
  data <- readGDX(gdx_file,"pm_land_start")[,,c("crop","past")]
  data <- superAggregate(data,"sum",level="reg")
  magpie <- land(gdx_file)[,,c("crop","past")]
  if(nregions(magpie)!=nregions(data) | !all(getRegions(magpie) %in% getRegions(data))) {
    stop("Regions in MAgPIE do not agree with regions in reference calibration area data set!")
  }
  out <- magpie/data
  out[out==0] <- 1
  return(magpiesort(out))
}

get_yieldcalib <- function(gdx_file) {
  require(magclass)
  require(gdx)
  require(luscale)

  prep <- function(x) {
    # use maiz as surrogate for all crops
    elem <- c("maiz","pasture")
    y <- collapseNames(x[,,"rainfed"][,,elem])
    getNames(y) <- c("crop","past")
    return(superAggregate(y,level="reg",aggr_type="mean", na.rm=TRUE))
  }

  y_ini <- prep(readGDX(gdx_file,"i14_yields"))
  y     <- prep(readGDX(gdx_file,"vm_yld")[,,"l"])

  out <- y/y_ini
  out[out==0] <- 1
  return(magpiesort(out))
}

# Calculate the correction factor and save it
update_calib<-function(gdx_file, calib_accuracy=0.1, calibrate_pasture=TRUE,calibrate_cropland=TRUE,damping_factor=0.8, calib_file, crop_max=1, calibration_step=""){
  require(magclass)
  require(magpie4)
  if(!(modelstat(gdx_file)[1,1,1]%in%c(1,2,7))) stop("Calibration run infeasible")

  area_factor  <- get_areacalib(gdx_file)
  tc_factor    <- get_yieldcalib(gdx_file)
  calib_correction <- area_factor * tc_factor
  calib_divergence <- abs(calib_correction-1)

  old_calib        <- magpiesort(read.magpie(calib_file))
  calib_factor     <- old_calib * (damping_factor*(calib_correction-1) + 1)

  if(!is.null(crop_max)) {
    above_limit <- (calib_factor[,,"crop"] > crop_max)
    calib_factor[,,"crop"][above_limit]  <- crop_max
    calib_divergence[getRegions(calib_factor),,"crop"][above_limit] <- 0
  }
  if(!calibrate_pasture)  {
    calib_factor[,,"past"] <- 1
    calib_divergence[,,"past"] <- 0
  }
  if(!calibrate_cropland) {
    calib_factor[,,"crop"] <- 1
    calib_divergence[,,"crop"] <- 0
  }

  ### write down current calib factors (and area_factors) for tracking
  write_log <- function(x,file,calibration_step) {
    x <- add_dimension(x, dim=3.1, add="iteration", nm=calibration_step)
    try(write.magpie(round(setYears(x,NULL),2), file, append = (calibration_step!=1)))
  }

  write_log(calib_correction, "calib_correction.cs3" , calibration_step)
  write_log(calib_divergence, "calib_divergence.cs3" , calibration_step)
  write_log(area_factor,      "calib_area_factor.cs3", calibration_step)
  write_log(tc_factor,        "calib_tc_factor.cs3"  , calibration_step)

  # in case of sufficient convergence, stop here (no additional update of
  # calibration factors!)
  if(all(calib_divergence < calib_accuracy)) return(TRUE)

  comment <- c(" description: Regional yield calibration file",
               " unit: -",
               paste0(" note: Calibration step ",calibration_step),
               " origin: scripts/calibration/calc_calib.R (path relative to model main directory)",
               paste0(" creation date: ",date()))
  write.magpie(round(setYears(calib_factor,NULL),2), calib_file, comment = comment)

  write_log(calib_factor,     "calib_factor.cs3"     , calibration_step)

  return(FALSE)
}


calibrate_magpie <- function(n_maxcalib = 1,
                             calib_accuracy = 0.1,
                             calibrate_pasture = FALSE,
                             calibrate_cropland = TRUE,
                             calib_magpie_name = "magpie_calib",
                             damping_factor = 0.6,
                             calib_file = "modules/14_yields/input/f14_yld_calib.csv",
                             putfolder = "calib_run",
                             data_workspace = NULL,
                             logoption = 3,
                             debug = FALSE) {

  require(magclass)

  for(i in 1:n_maxcalib){
    cat(paste("\nStarting calibration iteration",i,"\n"))
    calibration_run(putfolder=putfolder, calib_magpie_name=calib_magpie_name, logoption=logoption)
    if(debug) file.copy(paste0(putfolder,"/fulldata.gdx"),paste0("fulldata_calib",i,".gdx"))
    done <- update_calib(gdx_file=paste0(putfolder,"/fulldata.gdx"),calib_accuracy=calib_accuracy, calibrate_pasture=calibrate_pasture,calibrate_cropland=calibrate_cropland,damping_factor=damping_factor, calib_file=calib_file, calibration_step=i)
    if(done){
      break
    }
  }

  # delete calib_magpie_gms in the main folder
  unlink(paste0(calib_magpie_name,".*"))
  unlink("fulldata.gdx")

  cat("\ncalibration finished\n")
}
