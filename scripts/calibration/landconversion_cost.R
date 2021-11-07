# |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# *********************************************************************
# ***    This script calculates a regional calibration factor       ***
# ***              based on a pre run of magpie                     ***
# *********************************************************************

calibration_run<-function(putfolder,calib_magpie_name,logoption=3){

  require(lucode2)

  # create putfolder for the calib run
  unlink(putfolder,recursive=TRUE)
  dir.create(putfolder)

  # create a modified magpie.gms for the calibration run
  unlink(paste(calib_magpie_name,".gms",sep=""))
  unlink("fulldata.gdx")

  if(!file.copy("main.gms",paste(calib_magpie_name,".gms",sep=""))){
    stop(paste("Unable to create",paste(calib_magpie_name,".gms",sep="")))
  }
  lucode2::manipulateConfig(paste(calib_magpie_name,".gms",sep=""),c_timesteps="calib")
  lucode2::manipulateConfig(paste(calib_magpie_name,".gms",sep=""),s_use_gdx=0)
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
  data <- superAggregate(readGDX(gdx_file,"f10_land"),level="reg",aggr_type = "sum")[,2015,"crop"]
  magpie <- land(gdx_file)[,,c("crop")][,2015,]
  if(nregions(magpie)!=nregions(data) | !all(getRegions(magpie) %in% getRegions(data))) {
    stop("Regions in MAgPIE do not agree with regions in reference calibration area data set!")
  }
  out <- magpie/data
  out[out==0] <- 1
  getYears(out) <- NULL
  getNames(out) <- NULL
  return(magpiesort(out))
}

get_rewardcalib <- function(gdx_file,calib_factor) {
  require(magclass)
  require(magpie4)
  require(gdx)
  require(luscale)
  data <- superAggregate(readGDX(gdx_file,"f10_land"),level="reg",aggr_type = "sum")[,,"crop"]
  hist <- setYears(data[,2015,],NULL) - setYears(data[,1995,],NULL)
  getYears(hist) <- NULL
  getNames(hist) <- NULL
  
  out <- calib_factor
  out[,,] <- 0
  sel <- which(calib_factor > 1 & hist < 0)
  out[sel,,]   <- (calib_factor[sel,,] - 1)^2
  
  return(magpiesort(out))
}

# Calculate the correction factor and save it
update_calib<-function(gdx_file, calib_accuracy=0.1, damping_factor=0.8, calib_file, crop_max=2, calibration_step="",n_maxcalib=20, best_calib = FALSE){
  print("ENTER update")
  require(magclass)
  require(magpie4)
  if(!(modelstat(gdx_file)[1,1,1]%in%c(1,2,7))) stop("Calibration run infeasible")

  area_factor  <- get_areacalib(gdx_file)
  calib_correction <- area_factor
  calib_divergence <- abs(calib_correction-1)

  ###-> in case it is the first step, it forces the initial factors to be equal to 1
  if(file.exists(calib_file)) {
    old_calib        <- magpiesort(read.magpie(calib_file))
  } else {
    old_calib<-new.magpie(cells_and_regions = getCells(calib_divergence),names = c("cost","reward"),fill = 1)
  }

#initial guess equal to 1
  if(calibration_step==1) {
    old_calib[,,"cost"] <- 1
    old_calib[,,"reward"] <- 0
  }

  calib_factor     <- setNames(old_calib[,,"cost"],NULL) * (damping_factor*(calib_correction-1) + 1)
  
  if(!is.null(crop_max)) {
    above_limit <- (calib_factor > crop_max)
    calib_factor[above_limit]  <- crop_max
    calib_divergence[getRegions(calib_factor),,][above_limit] <- 0
  }
  
  ### write down current calib factors (and area_factors) for tracking
  write_log <- function(x,file,calibration_step) {
    x <- add_dimension(x, dim=3.1, add="iteration", nm=paste0("iter",calibration_step))
    try(write.magpie(round(setYears(x,NULL),2), file, append = (calibration_step!=1)))
  }
  
  write_log(calib_correction, "land_conversion_cost_calib_correction.cs3" , calibration_step)
  write_log(calib_divergence, "land_conversion_cost_calib_divergence.cs3" , calibration_step)
  write_log(calib_factor,     "land_conversion_cost_calib_factor.cs3"     , calibration_step)

  # in case of sufficient convergence, stop here (no additional update of
  # calibration factors!)
  
  if(all(calib_divergence < calib_accuracy) |  calibration_step==n_maxcalib) {
    
    ### Depending on the selected calibration selection type (best_calib FALSE or TRUE)
    # the reported and used regional calibration factors can be either the ones of the last iteration,
    # or the "best" based on the iteration value with the lower divergence.
    if (best_calib == TRUE){
    ###-Select best calibration factor for each region and from the all the calibration steps
    calib_best<-new.magpie(cells_and_regions = getCells(calib_divergence),years = getYears(calib_divergence))
    print("best")
    
    divergence_data<-read.csv("land_conversion_cost_calib_divergence.cs3")
    factors_data<-read.csv("land_conversion_cost_calib_factor.cs3")

    for (i in getCells(calib_best)){
      factors_data_sub<-subset(factors_data,dummy==i)
      divergence_data_sub<-subset(divergence_data,dummy==i)

      calib_best[i,NULL,]<-as.numeric(factors_data_sub[which.min(divergence_data_sub)])
    }

    getNames(calib_best) <- NULL
    getYears(calib_best) <- NULL
    calib_reward <- get_rewardcalib(gdx_file,calib_best)
    calib_best_full <- mbind(setNames(calib_best,"cost"),setNames(calib_reward,"reward"))
    comment <- c(" description: Regional land conversion cost calibration file",
                 " unit: -",
                 paste0(" note: Best calibration factor from the run"),
                 " origin: scripts/calibration/landconversion_cost.R (path relative to model main directory)",
                 paste0(" creation date: ",date()))
    write.magpie(round(setYears(calib_best_full,NULL),2), calib_file, comment = comment)

    write_log(calib_best,     "land_conversion_cost_calib_factor.cs3"     , "best")
####
  return(TRUE)
}else{
  return(TRUE)
}
}else{
  print("nobest")
  calib_reward <- get_rewardcalib(gdx_file,calib_factor)
  calib_full <- mbind(setNames(calib_factor,"cost"),setNames(calib_reward,"reward"))
  comment <- c(" description: Regional land conversion cost calibration file",
               " unit: -",
               paste0(" note: Calibration step ",calibration_step),
               " origin: scripts/calibration/landconversion_cost.R (path relative to model main directory)",
               paste0(" creation date: ",date()))
  
  write.magpie(round(setYears(calib_full,NULL),2), calib_file, comment = comment)
  return(FALSE)
}


}


calibrate_magpie <- function(n_maxcalib = 20,
                             calib_accuracy = 0.05,
                             crop_max = Inf,
                             calib_magpie_name = "magpie_calib",
                             damping_factor = 0.98,
                             calib_file = "modules/39_landconversion/input/f39_calib.csv",
                             putfolder = "land_conversion_cost_calib_run",
                             data_workspace = NULL,
                             logoption = 3,
                             debug = FALSE,
                             best_calib = TRUE) {

  require(magclass)

  if(file.exists(calib_file)) file.remove(calib_file)
  for(i in 1:n_maxcalib){
    cat(paste("\nStarting calibration iteration",i,"\n"))
    calibration_run(putfolder=putfolder, calib_magpie_name=calib_magpie_name, logoption=logoption)
    if(debug) file.copy(paste0(putfolder,"/fulldata.gdx"),paste0("fulldata_calib",i,".gdx"))
    done <- update_calib(gdx_file=paste0(putfolder,"/fulldata.gdx"),calib_accuracy=calib_accuracy,crop_max=crop_max,damping_factor=damping_factor, calib_file=calib_file, calibration_step=i,n_maxcalib=n_maxcalib,best_calib = best_calib)
    if(done){
      break
    }
  }

  # delete calib_magpie_gms in the main folder
  unlink(paste0(calib_magpie_name,".*"))
  unlink("fulldata.gdx")

  cat("\ncalibration finished\n")
}

