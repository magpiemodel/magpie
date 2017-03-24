# (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
# authors, and contributors see AUTHORS file
# This file is part of MAgPIE and licensed under GNU AGPL Version 3
# or later. See LICENSE file or go to http://www.gnu.org/licenses/
# Contact: magpie@pik-potsdam.de

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
  manipulateConfig(paste(calib_magpie_name,".gms",sep=""),sm_use_gdx=0)
  file.copy(paste(calib_magpie_name,".gms",sep=""),putfolder)

  # execute calibration run
  system(paste("gams ",calib_magpie_name,".gms"," -PUTDIR ./",putfolder," -LOGOPTION=",logoption,sep=""),wait=TRUE)
  file.copy("fulldata.gdx",putfolder)
}

# function to determine the calibration reference and model output area
get_calibarea<-function(gdx_file){
  require(magclass)
  require(magpie4)
  require(gdx)
  require(luscale)
  data <- dimSums(readGDX(gdx_file,"pm_land_start")[,,c("crop","past")],dim=3.2)
  data <- superAggregate(data,"sum",level="reg")
  magpie <- land(gdx_file)[,,c("crop","past")]
  if(nregions(magpie)!=nregions(data) | !all(getRegions(magpie) %in% getRegions(data))) {
    stop("Regions in MAgPIE do not agree with regions in reference calibration area data set!")
  }
  return(list(magpie=magpie,data=data))
}

# Calculate the correction factor and store it in input/regional
update_calib<-function(gdx_file,calibrate_pasture=TRUE,damping_factor=0.6, calib_file){
  require(magclass)
  require(magpie4)
  if(!(modelstat(gdx_file)[1,1,1]%in%c(1,2,7))) stop("Calibration run infeasible")
  area<-get_calibarea(gdx_file=gdx_file)
  area_factor <- area$magpie/area$data
  tc_factor <- (tc(gdx_file)+1)[,"y1995",]
  calib_factor<-area_factor * tc_factor
  if(calibrate_pasture==FALSE) calib_factor[,,"past"] <- 1
  calib_factor_new <- calib_factor
  calib_factor <- damping_factor*(calib_factor-1) + 1
  old_calib<-read.magpie(calib_file)
  calib_factor <- old_calib * calib_factor
  comment <- c(" description: Regional yield calibration file",
               " unit: -",
               " note: All values in the file are set to 1 if a new regional setup is used.",
               " origin: scripts/calibration/calc_calib.R (path relative to model main directory)",
               paste0(" creation date: ",date()))
  write.magpie(setYears(calib_factor,NULL), calib_file, comment = comment)
  return(list(calib_factor_new ,tc_factor, area_factor))
}


calibrate_magpie <- function(n_maxcalib = 1,
                             calib_accuracy = 0.1,
                             calibrate_pasture = FALSE,
                             calib_magpie_name = "magpie_calib",
                             damping_factor = 0.6,
                             calib_file = "modules/14_yields/input/f14_yld_calib.csv",
                             putfolder = "calib_run",
                             data_workspace = NULL,
                             logoption = 3) {

  require(magclass)
  require(lusweave)

  begin<-Sys.time()
  swout <- swopen("calibration_results.pdf")

  for(i in 1:n_maxcalib){
    cat(paste("\nStarting calibration iteration",i,"\n"))
    calibration_run(putfolder=putfolder, calib_magpie_name=calib_magpie_name, logoption=logoption)
    new_calib <- update_calib(gdx_file=paste0(putfolder,"/fulldata.gdx"),calibrate_pasture=calibrate_pasture,damping_factor=damping_factor, calib_file=calib_file)
    if(i==1){
      calib_hist <- setYears(new_calib[[1]],"y1995")
      tc_hist <- setYears(new_calib[[2]],"y1995")
      area_hist <- setYears(new_calib[[3]],"y1995")
    } else{
      calib_hist <- mbind(calib_hist,setYears(new_calib[[1]],getYears(calib_hist,as.integer=T)[i-1]+10))
      tc_hist <- mbind(tc_hist,setYears(new_calib[[2]],getYears(tc_hist,as.integer=T)[i-1]+10))
      area_hist <- mbind(area_hist,setYears(new_calib[[3]],getYears(area_hist,as.integer=T)[i-1]+10))
    }
    if(all(abs(1-new_calib[[1]]) < calib_accuracy)){
      cat("\n\nCalibration accuracy reached after ",i," iterations\n\n")
      swlatex(swout,paste("Calibration accuracy reached after ",i," of ",n_maxcalib,"possible iterations\n\n"))
      break
    }
  }

  # Create a pdf with output information
  for(type in c("crop","past")){
    out_calib <- as.array(calib_hist[,,type])
    dimnames(out_calib)[[2]] <- (i-dim(out_calib)[2]+1):i
    out_tc <- as.array(tc_hist)
    dimnames(out_tc)[[2]]<-(i-dim(out_tc)[2]+1):i
    out_area <- as.array(area_hist[,,type])
    dimnames(out_area)[[2]]<-(i-dim(out_area)[2]+1):i
    swlatex(swout,paste("\\section{",type,"}"))
    swlatex(swout,paste("\\subsection{Area reference}"))
    area <- get_calibarea(gdx_file=paste0(putfolder,"/fulldata.gdx"))[["data"]]
    swtable(swout,area[,,type],caption="External cropland area information for calibration",transpose=T,digits=4,table.placement="H")
    swlatex(swout,paste("\\subsection{Total factor}"))
    swtable(swout,out_calib[,,1,drop=F],caption="Calibration factors calculated in each iteration",transpose=T,digits=4,table.placement="H")
    swlatex(swout,paste("\\subsection{TC factor}"))
    swtable(swout,out_tc[,,1,drop=F],caption="Contribution of tc to calibration factors calculated in each iteration",transpose=T,digits=4,table.placement="H")
    swlatex(swout,paste("\\subsection{Area factor}"))
    swtable(swout,out_area[,,1,drop=F],caption="Contribution of area to calibration factors calculated in each iteration",transpose=T,digits=4,table.placement="H")
  }
  swclose(swout)

  # delete the calib_magpie_gms in the main folder
  unlink(paste0(calib_magpie_name,".*"))
  unlink("fulldata.gdx")

  # calculate runtime info
  runtime<-Sys.time()-begin

  # update validation.RData
  if(file.exists(data_workspace)){
    load(data_workspace)
    validation$technical$time$calibration<-runtime
    save(validation,file=data_workspace)
  }
  cat("\ncalibration finished\n")
}
