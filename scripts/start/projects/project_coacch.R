# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


# ----------------------------------------------------------
# description: COACCH simulations (climate-impacts, Europe focus)
# ----------------------------------------------------------

library(gms)
source("scripts/start_functions.R")
source("scripts/performance_test.R")
source("config/default.cfg")

#set defaults
codeCheck <- FALSE

#isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev34_c200_690d3718e151be1b450b394c1064b1c5.tgz
#rev4.14_690d3718e151be1b450b394c1064b1c5_magpie.tgz
#rev4.14_690d3718e151be1b450b394c1064b1c5_validation.tgz
#calibration_H12_c200_12Sep18.tgz

#isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev34_c200_690d3718e151be1b450b394c1064b1c5.tgz
#rev4.18_690d3718e151be1b450b394c1064b1c5_magpie.tgz
#rev4.18_690d3718e151be1b450b394c1064b1c5_validation.tgz
#calibration_H12_c200_12Sep18.tgz
#additional_data_rev3.66.tgz


buildInputVector <- function(regionmapping   = "H12",
                             project_name    = "isimip_rcp",
                             climatescen_name= "rcp2p6",
                             co2             = "co2",
                             climate_model   = "IPSL_CM5A_LR",
                             resolution      = "c400",
                             archive_rev     = "38",
                             madrat_rev      = "4.18",
                             validation_rev  = "4.18",
                       calibration     = "calibration_coacch_08Oct19.tgz",
                             additional_data = "additional_data_rev3.68.tgz") {
  mappings <- c(H11="8a828c6ed5004e77d1ba2025e8ea2261",
                H12="690d3718e151be1b450b394c1064b1c5",
        coacch="c2a48c5eae535d4b8fe9c953d9986f1b",
                mag="c30c1c580039c2b300d86cc46ff4036a",
            agmip="c77f075908c3bc29bdbe1976165eccaf",
            sim4nexus="25dd7264e8e145385b3bd0b89ec5f3fc",
            inms="44f1e181a3da765729f2f1bfc926425a",
                capri="e7e72fddc44cc3d546af7b038c651f51")
  archive_name=paste(project_name,climate_model,climatescen_name,co2,sep="-")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings[regionmapping], ".tgz")
  madrat  <- paste0("rev", madrat_rev,"_", mappings[regionmapping], "_magpie", ".tgz")
  validation  <- paste0("rev", validation_rev,"_", mappings[regionmapping], "_validation", ".tgz")
  return(c(archive,madrat,validation,calibration,additional_data))
}

### COACCH runs ###
#general settings
cfg$gms$c_timesteps <- "coup2100"
cfg$input <- buildInputVector()
cfg$output <- c(cfg$output,"sustag_report")
cfg$recalibrate <- FALSE

# SSP control runs###############################################

# SSP2
general_settings<-function(title) {
  source("config/default.cfg")
  cfg$gms$c_timesteps <- "coup2100"
  cfg$input <- buildInputVector()
  cfg$output <- c(cfg$output,"sustag_report")
  cfg$recalibrate <- FALSE
  cfg<-gms::setScenario(cfg,"cc")
  cfg$gms$c56_emis_policy <- "all"
  cfg$gms$forestry  <- "affore_vegc_dec16"
  cfg$gms$maccs  <- "on_sep16"
  cfg$title <- paste0("v1_",title)
  return(cfg)
}


# SSP2
cfg<-general_settings(title="SSP2_nocc_newregion")
cfg<-gms::setScenario(cfg,"SSP2")
cfg<-gms::setScenario(cfg,"nocc")
cfg$input <- buildInputVector(regionmapping = "coacch")
cfg$recalibrate=TRUE
start_run(cfg=cfg,codeCheck=codeCheck)
calib<-magpie4::submitCalibration(name = "calibration_coacch")
cfg$recalibrate <- "ifneeded"

#COACCH standard runs#############################################

#SSP2 family

# SSP2 * RCP2.6 * Mit26 * 3 climate models (HADGEM, IPSL, GFDL)  (3)



start_the_run<-function(ssp,mit,rcp,gcm,co2,cc){
  # select alias names for reporting
  if(gcm=="IPSL_CM5A_LR"){gcm_alias="IPSL-CM5A-LR"}
  if(gcm=="HadGEM2_ES"){gcm_alias="HadGEM2-ES"}
  if(gcm=="GFDL_ESM2M"){gcm_alias="GFDL-ESM2M"}
  if(gcm=="NorESM1_M"){gcm_alias="NNorESM1-M"}
  if(rcp=="NoCC"){gcm_alias="NoCC"}
  if(mit=="26"){mit_alias="2p6"}
  if(mit=="45"){mit_alias="4p5"}
  if(mit=="Ref"){mit_alias="NoMit"}

  # create runname
  if(co2=="co2") {
    title=paste(ssp,gcm_alias,substring(rcp,4),mit_alias,sep="_")
  } else {
     title=paste(ssp,gcm_alias,substring("rcp2p6",4),mit_alias,"NoCO2",sep="_")
  }
  cat(paste(title))


  cfg<-general_settings(title=title)
  cfg<-gms::setScenario(cfg,ssp)
  cfg$input <- buildInputVector(climatescen_name=rcp,climate_model   = gcm, regionmapping = "coacch",calibration=calib)
  mitigation=paste0("SSPDB-",ssp,"-",mit,"-",model)
  cfg$gms$c56_pollutant_prices <- mitigation
  cfg$gms$c60_2ndgen_biodem    <- mitigation
  if(cc==FALSE){
    cfg<-gms::setScenario(cfg,"nocc")
  } else {
    cfg<-gms::setScenario(cfg,"cc")
  }
  start_run(cfg=cfg,codeCheck=codeCheck)
}

for (ssp in c("SSP1","SSP2","SSP3","SSP4","SSP5")){
  if(ssp=="SSP1"){
    model="IMAGE"
    mitopt = c("Ref")
    rcpopt = c("rcp2p6","rcp4p5","rcp6p0","NoCC")
    gcmopt = c("HadGEM2_ES")
    }
  if(ssp=="SSP2"){
    model="MESSAGE-GLOBIOM"
    mitopt = c("26","45","Ref")
    rcpopt = c("rcp2p6","rcp4p5","rcp6p0","NoCC")
    gcmopt = c("IPSL_CM5A_LR","HadGEM2_ES","GFDL_ESM2M","NorESM1_M")
    }
  if(ssp=="SSP3"){
    model="AIM-CGE"
    mitopt = c("Ref")
    rcpopt = c("rcp4p5","rcp6p0","NoCC")
    gcmopt = c("HadGEM2_ES")
    }
  if(ssp=="SSP4"){
    model="GCAM4"
    mitopt = c("Ref")
    rcpopt = c("rcp2p6","rcp4p5","rcp6p0","NoCC")
    gcmopt = c("HadGEM2_ES")
    }
  if(ssp=="SSP5"){
    model="REMIND-MAGPIE"
    mitopt = c("Ref")
    rcpopt = c("rcp2p6","rcp4p5","rcp6p0","rcp8p5","NoCC")
    gcmopt = c("HadGEM2_ES")
    }
  for(mit in mitopt){
    for (rcp in rcpopt) {
      co2="co2"
      if(rcp=="NoCC"){
        gcm = c("HadGEM2_ES")
        rcp=  c("rcp4p5")
        start_the_run(ssp,mit,rcp,gcm,co2,cc=FALSE)
      } else {
        for(gcm in gcmopt){
          start_the_run(ssp,mit,rcp,gcm,co2,cc=TRUE)
        }
        if (rcp == "rcp8p5"){
          co2="noco2"
          start_the_run(ssp,mit,rcp,gcm,co2,cc=TRUE)
        }
      }
    }
  }
}
