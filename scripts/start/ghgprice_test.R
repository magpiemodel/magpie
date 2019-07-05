# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(lucode)
source("scripts/start_functions.R")
source("config/default.cfg")

buildInputVector <- function(base            = "magpie4.1_default_apr19.tgz",
                             archive         = "isimip_rcp",         #NULL,
                             climate_model   = "IPSL_CM5A_LR",
                             climatescen_name= "rcp2p6",
                             co2             = "co2",
                             archive_rev     = "38",
                             resolution      = "c200",
                             regionmapping   = "H12",
                             addings         = NULL,                 #"_IND4", #NULL,
                             madrat          = NULL,                 #NULL
                             validation      = "4.19",               #NULL
                             calibration     = NULL,                 #NULL
                             additional_data = "3.68",               #NULL
                             patch           = NULL){              
  
  mappings <- c(H11="8a828c6ed5004e77d1ba2025e8ea2261",
                H12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a",
                agmip="c77f075908c3bc29bdbe1976165eccaf",
                sim4nexus="25dd7264e8e145385b3bd0b89ec5f3fc",
                capri="e7e72fddc44cc3d546af7b038c651f51")
  
  archive_name <- paste(archive,climate_model,climatescen_name,co2,sep="-")
  if(!is.null(archive))    archive     <- paste0(archive_name, "_rev", archive_rev, "_", resolution, addings,"_", mappings[regionmapping], ".tgz")
  if(!is.null(madrat))     madrat      <- paste0("rev", madrat,"_", mappings[regionmapping], "_magpie", ".tgz")
  if(!is.null(validation)) validation  <- paste0("rev", validation,"_", mappings[regionmapping], "_validation", ".tgz")
  if(!is.null(additional_data)) additional_data <- paste0("additional_data_rev",additional_data,".tgz")
  
  return(c(base,archive,madrat,validation,calibration,additional_data,patch))
}

#general settings
cfg$gms$s80_optfile <- 1
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg1300"
cfg$gms$c60_2ndgen_biodem    <- "R2M41-SSP2-Budg1300"
cfg$input <- buildInputVector()
#nocc

# none
cfg$gms$c56_emis_policy      <- "none"

cfg$gms$land <- "dec18" 
cfg$gms$som  <- "static_jan19"
cfg$title    <- "staticsom_none"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$gms$land <- "dec18" 
cfg$gms$som  <- "cellpool_aug16"
cfg$title    <- "dynamicsom_none"
start_run(cfg=cfg,codeCheck=TRUE)

# ssp
cfg$gms$c56_emis_policy      <- "ssp"

cfg$gms$land <- "dec18" 
cfg$gms$som  <- "static_jan19"
cfg$title    <- "staticsom_ssp"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$gms$land <- "dec18" 
cfg$gms$som  <- "cellpool_aug16"
cfg$title    <- "dynamicsom_ssp"
start_run(cfg=cfg,codeCheck=TRUE)

# ssp_nosoil
cfg$gms$c56_emis_policy      <- "ssp_nosoil"

cfg$gms$land <- "dec18" 
cfg$gms$som  <- "static_jan19"
cfg$title    <- "staticsom_ssp_nosoil"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$gms$land <- "dec18" 
cfg$gms$som  <- "cellpool_aug16"
cfg$title    <- "dynamicsom_ssp_nosoil"
start_run(cfg=cfg,codeCheck=TRUE)

# all_nosoil
cfg$gms$c56_emis_policy      <- "all_nosoil"

cfg$gms$land <- "dec18" 
cfg$gms$som  <- "static_jan19"
cfg$title    <- "staticsom_all_nosoil"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$gms$land <- "dec18" 
cfg$gms$som  <- "cellpool_aug16"
cfg$title    <- "dynamicsom_all_nosoil"
start_run(cfg=cfg,codeCheck=TRUE)

# all
cfg$gms$c56_emis_policy      <- "all"

cfg$gms$land <- "dec18" 
cfg$gms$som  <- "static_jan19"
cfg$title    <- "staticsom_all"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$gms$land <- "dec18" 
cfg$gms$som  <- "cellpool_aug16"
cfg$title    <- "dynamicsom_all"
start_run(cfg=cfg,codeCheck=TRUE)

# all_mINF
cfg$gms$c56_emis_policy      <- "all"
cfg$gms$s56_reward_neg_emis  <- -Inf

cfg$gms$land <- "dec18" 
cfg$gms$som  <- "static_jan19"
cfg$title    <- "staticsom_all_mINF"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$gms$land <- "dec18" 
cfg$gms$som  <- "cellpool_aug16"
cfg$title    <- "dynamicsom_all_mINF"
start_run(cfg=cfg,codeCheck=TRUE)


