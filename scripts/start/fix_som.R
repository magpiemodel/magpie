# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


##########################################################
#### Script to MAgPIE test runs ####
##########################################################

library(lucode)
source("scripts/start_functions.R")
source("config/default.cfg")


buildInputVector <- function(regionmapping   = "h12",
                             project_name    = "isimip_rcp",
                             climatescen_name= "rcp2p6",
                             co2             = "noco2",
                             climate_model   = "IPSL_CM5A_LR",
                             resolution      = "h200",
                             archive_rev     = "33",
                             madrat_rev      = "3.33",
                             validation_rev  = "3.33",
                             calibration     = NULL,
                             additional_data = "additional_data_rev3.40.tgz",
                             npi_base        = "calibration_H12_29Jun18.tgz") {
  mappings <- c(h11="8a828c6ed5004e77d1ba2025e8ea2261",
                h12="690d3718e151be1b450b394c1064b1c5",
                mag="c30c1c580039c2b300d86cc46ff4036a")
  archive_name=paste(project_name,climate_model,climatescen_name,co2,sep="-")
  archive <- paste0(archive_name, "_rev", archive_rev, "_", resolution, "_", mappings[regionmapping], ".tgz")
  madrat  <- paste0("rev", madrat_rev, "_", mappings[regionmapping], "_magpie.tgz")
  validation  <- paste0("rev", validation_rev, "_", mappings[regionmapping], "_validation.tgz")
  return(c(archive,madrat,validation,calibration,additional_data,npi_base))
}


cfg$title <- "new_carbon_som_on"
cfg$input <- buildInputVector()
cfg$gms$som <- "cellpool_aug16"
cfg$gms$c59_som_scenario  <- "nocc"   # def = "nocc"
start_run(cfg=cfg,codeCheck=FALSE)

cfg$title <- "new_carbon_som_off"
cfg$input <- buildInputVector()
cfg$gms$som <- "off"
start_run(cfg=cfg,codeCheck=FALSE)


cfg$title <- "old_carbon_som_off"
cfg$input <- buildInputVector(archive_rev="32")
cfg$gms$som <- "off"
start_run(cfg=cfg,codeCheck=FALSE)
