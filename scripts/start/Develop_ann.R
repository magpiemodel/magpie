# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de
######################################################################################
#### Script to start a MAgPIE run using the Good Practice scenario configurations ####
######################################################################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# Sources the default configuration file
source("config/default.cfg")

factor<-c("mixed_feb17","fixed_per_ton_mar18")
scenarios<-c("","_woa")

for(i in 1:length(factor)){
  for(j in 1:length(scenarios)){

#Should we avoid calibration
cfg$recalibrate <- "TRUE"     # def = "ifneeded"

#Change the results folder name
cfg$title<-paste0("Develop_",factor[i],"_",scenarios[j],"_")

#Output
cfg$output <- c("rds_report","interpolation")


# INPUT FILES
cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev42_c200_690d3718e151be1b450b394c1064b1c5.tgz",
               "rev4.42_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
               "rev4.42_690d3718e151be1b450b394c1064b1c5_validation.tgz",
               "additional_data_rev3.78.tgz",
               "calibration_H12_c200_highres.tgz"
              )

#Modules with annuity calculations
cfg$gms$tc <-paste0("endo_jun18",scenarios[j])
cfg$gms$landconversion <-paste0("global_static_aug18",scenarios[j])
cfg$gms$area_equipped_for_irrigation <-paste0("endo_apr13",scenarios[j])
cfg$gms$ghg_policy <-paste0("price_jan20",scenarios[j])
cfg$gms$factor_costs<-factor[i]


#start MAgPIE run
start_run(cfg=cfg)
}}
