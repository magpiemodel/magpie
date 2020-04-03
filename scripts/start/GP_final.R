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

#Should we avoid calibration
cfg$recalibrate <- "TRUE"     # def = "ifneeded"

#Change the results folder name
cfg$title<-"Good_Practice_Scenario"

#Output
cfg$output <- c("rds_report","interpolation")


# INPUT FILES
cfg$input <- c("isimip_rcp-IPSL_CM5A_LR-rcp2p6-co2_rev38_c200_690d3718e151be1b450b394c1064b1c5.tgz",
              "rev4.34_690d3718e151be1b450b394c1064b1c5_magpie.tgz",
              "rev4.34_690d3718e151be1b450b394c1064b1c5_validation.tgz",
              "calibration_H12_c200_12Sep18.tgz",
               "additional_data_rev3.76.tgz"
               )

#NITROGEN UPTAKE SCENARIO
cfg$gms$c50_scen_neff_select <- "neff85_85_starty2010"

#Manure share used in an anaerobic digester 0.15 in 2015 0.30 in 2030, 0.5 in 2050 and 0.7 in 2100
cfg$gms$c55_scen_conf<-"GoodPractice"

#start MAgPIE run
start_run(cfg=cfg)
