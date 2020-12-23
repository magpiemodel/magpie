######################################################################################
#### Script to start a MAgPIE run using different factor_costs realizations ##########
######################################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Sources the default configuration file
source("config/default.cfg")

#List of clusterin types
#clustering<-c("n200","c200")
clustering<-c("m200")

#Factor cost realizations
realization<-c("sticky_feb18","mixed_feb17")
climate<-c("cc")
#AEI<-c("LUH2v2","Siebert")
#AEI<-c("LUH2v2")

#missing inputs lpj 7p0 ,"SSP3","7p0",,"60"
SSP<-c("SSP1","SSP2","SSP2","SSP5","SSP2","SSP2")
RCP<-c("2p6","2p6","6p0","8p5","2p6","6p0")
MIT<-c("26","26","60","85","60","45")
#HadGEM2_ES, IPSL_CM5A_LR, GFDL_ESM2M, MIROC_ESM_CHEM, NorESM1_M
ClimateModel<-c("HadGEM2_ES", "IPSL_CM5A_LR", "GFDL_ESM2M")

for(sce in 1:length(SSP)){
    for(clim_model in ClimateModel){        #Change the results folder name
      for(i in 1:length(realization)){

       #Scenario setting
       cfg<-gms::setScenario(cfg,c(SSP[sce],"cc"))

      if(MIT[sce] != "85"){
       cfg$gms$c56_pollutant_prices <- paste0("SSPDB-",SSP[sce],"-",MIT[sce],"-REMIND-MAGPIE")
       cfg$gms$c60_2ndgen_biodem <- paste0("SSPDB-",SSP[sce],"-",MIT[sce],"-REMIND-MAGPIE")
     }else if(SSP[sce]=="SSP3" & MIT[sce]=="60"){
       cfg$gms$c56_pollutant_prices <- 	"SSPDB-SSP3-60-AIM-CGE"
       cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP3-60-AIM-CGE"

     }

        #NBC STANDS FOR NEW BEST CALIBRATION
        cfg$title<-paste0("Paper_Runs_",SSP[sce],"_RCP_",RCP[sce],"_MIT_",MIT[sce],"_",clim_model)
      }else{




        #Inputs
        cfg$input <- c(paste0("isimip_rcp-",clim_model,"-rcp", RCP[sce],"-co2_rev48_",clustering[1],"_690d3718e151be1b450b394c1064b1c5.tgz"),
         "rev4.52_h12_magpie.tgz",
         "rev4.52_h12_validation.tgz",
         "additional_data_rev3.86.tgz")

        #recalibrate
        cfg$recalibrate <- TRUE

        #recalc_npi_ndc
        #cfg$recalc_npi_ndc <- TRUE

        #forestry (depends on which we need)
        cfg$gms$forestry  <- "static_sep16"

        #AEI
        cfg$gms$c41_initial_irrigation_area  <- AEI[1]

        #Factor costs realization
        cfg$gms$factor_costs <- realization[i]


        start_run(cfg=cfg)
}
}
}
