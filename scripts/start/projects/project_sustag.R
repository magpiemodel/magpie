# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


# ----------------------------------------------------------
# description: SUSTAg simulations (bioenergy and mitigation in Europe)
# ----------------------------------------------------------

library(gms)
source("scripts/start_functions.R")
source("scripts/performance_test.R")
source("config/default.cfg")

#set defaults
codeCheck <- FALSE

buildInputVector <- function(regionmapping   = "agmip",
                             project_name    = "isimip_rcp",
                             climatescen_name= "rcp2p6",
                             co2             = "noco2",
                             climate_model   = "IPSL_CM5A_LR",
                             resolution      = "c200",
                             archive_rev     = "34",
                             madrat_rev      = "4.14",
                             validation_rev  = "4.14",
                             calibration     = "calibration_agmip_c200_19Dec18.tgz",
                             additional_data = "additional_data_rev3.58.tgz") {
  mappings <- c(H11="8a828c6ed5004e77d1ba2025e8ea2261",
                H12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a",
                agmip="c77f075908c3bc29bdbe1976165eccaf",
                sim4nexus="270870819da5607e288b6d0e5a5e6594",
                inms="69c65bb3c88e8033cf8df6b5ac5d52a9",
                inms2="ef2ae7cd6110d5d142a9f8bd7d5a68f2",
                capri="e7e72fddc44cc3d546af7b038c651f51")
  archive_name=paste(project_name,climate_model,climatescen_name,co2,sep="-")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings[regionmapping], ".tgz")
  madrat  <- paste0("rev", madrat_rev,"_", mappings[regionmapping], "_magpie", ".tgz")
  validation  <- paste0("rev", validation_rev,"_", mappings[regionmapping], "_validation", ".tgz")
  return(c(archive,madrat,validation,calibration,additional_data))
}

### SUSTAg runs ###
#general settings
cfg$gms$c_timesteps <- 12
cfg$input <- buildInputVector()
cfg$output <- c(cfg$output,"sustag_report")
cfg$recalibrate <- FALSE


# SSP control runs###############################################

# SSP2
cfg$title <- "SSP2"
cfg<-gms::setScenario(cfg,"SSP2")
cfg<-gms::setScenario(cfg,"nocc")
cfg$force_download <- TRUE
cfg$input <- buildInputVector(co2="co2")
#cfg$recalibrate <- TRUE
start_run(cfg=cfg,codeCheck=codeCheck)
#cfg$recalibrate <- FALSE

# SSP1
cfg$title <- "SSP1"
cfg<-gms::setScenario(cfg,"SSP1")
cfg<-gms::setScenario(cfg,"nocc")
cfg$input <- buildInputVector(co2="co2")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP3
cfg$title <- "SSP3"
cfg<-gms::setScenario(cfg,"SSP3")
cfg<-gms::setScenario(cfg,"nocc")
cfg$input <- buildInputVector(co2="co2")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP4
cfg$title <- "SSP4"
cfg<-gms::setScenario(cfg,"SSP4")
cfg<-gms::setScenario(cfg,"nocc")
cfg$input <- buildInputVector(co2="co2")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP5
cfg$title <- "SSP5"
cfg<-gms::setScenario(cfg,"SSP5")
cfg<-gms::setScenario(cfg,"nocc")
cfg$input <- buildInputVector(co2="co2")
start_run(cfg=cfg,codeCheck=codeCheck)





#SUSTAg standard runs#############################################

# SSP1 family
cfg$title <- "SUSTAg1"
cfg<-gms::setScenario(cfg,"SUSTAg1")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp2p6")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP2 family
cfg$title <- "SUSTAg2"
cfg<-gms::setScenario(cfg,"SUSTAg2")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp2p6")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP3 family
cfg$title <- "SUSTAg3"
cfg<-gms::setScenario(cfg,"SUSTAg3")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp6p0")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP4 family
cfg$title <- "SUSTAg4"
cfg<-gms::setScenario(cfg,"SUSTAg4")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5")
start_run(cfg=cfg,codeCheck=codeCheck)

# SSP5 family
cfg$title <- "SUSTAg5"
cfg<-gms::setScenario(cfg,"SUSTAg5")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp4p5")
start_run(cfg=cfg,codeCheck=codeCheck)



#Sensitivity tests based on SUSTAg2###############################

#SUSTAg2 scenario without global CC mitigation policy
cfg$title <- "SUSTAg2_Ref"
cfg<-gms::setScenario(cfg,"SUSTAg2")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp6p0")
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-Ref-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem    <- "SSPDB-SSP2-Ref-REMIND-MAGPIE"
start_run(cfg=cfg,codeCheck=codeCheck)

#SUSTAg2 scenario without CC impacts
cfg$title <- "SUSTAg2_nocc"
cfg<-gms::setScenario(cfg,"SUSTAg2")
cfg$input <- buildInputVector(co2="co2")
cfg<-gms::setScenario(cfg,"nocc")
start_run(cfg=cfg,codeCheck=codeCheck)


#cfg$title <- "SUSTAg2_co2fix"
#cfg<-gms::setScenario(cfg,"SUSTAg2")
#cfg$input <- buildInputVector(co2="noco2")
#start_run(cfg=cfg,codeCheck=codeCheck)
#
#cfg$title <- "SUSTAg2_Ref_co2fix"
#cfg<-gms::setScenario(cfg,"SUSTAg2")
#cfg$input <- buildInputVector(co2="noco2",climatescen_name="rcp6p0")
#cfg$gms$c56_pollutant_prices <- "SSP2-Ref-SPA0-V15-REMIND-MAGPIE"
#cfg$gms$c60_2ndgen_biodem    <- "SSP2-Ref-SPA0"
#start_run(cfg=cfg,codeCheck=codeCheck)

# SUSTAg2 scenario with variation of 1st gen. bioenergy: phaseout2020
cfg$title <- "SUSTAg2_1stgenbio_phaseout"
cfg<-gms::setScenario(cfg,"SUSTAg2")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp2p6")
cfg$gms$c60_1stgen_biodem <- "phaseout2020"
start_run(cfg=cfg,codeCheck=codeCheck)

# SUSTAg2 scenario with variation of 1st gen. bioenergy: const2030
cfg$title <- "SUSTAg2_1stgenbio_const2030"
cfg<-gms::setScenario(cfg,"SUSTAg2")
cfg$input <- buildInputVector(co2="co2",climatescen_name="rcp2p6")
cfg$gms$c60_1stgen_biodem <- "const2030"
start_run(cfg=cfg,codeCheck=codeCheck)









### bioenergy experiments
