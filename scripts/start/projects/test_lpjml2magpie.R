# |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: Test new lpjml version in magpie
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################
# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

# # Current MAgPIE default with same preprocessing status as the lpjml ones to be compared with
# source("config/default.cfg")
# cfg$title <- "Default_mngtcalib"
# # input data
# cfg$input <- c(regional    = "rev4.125+griddedL2Mcomp_v1_default_h12_magpie.tgz",
#                cellular    = "rev4.125+griddedL2Mcomp_v1_default_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
#                validation  = "rev4.125+griddedL2Mcomp_v1_default_h12_validation.tgz",
#                additional  = "additional_data_rev4.63.tgz",
#                calibration = "calibration_H12_FAO_18Sep25.tgz")
# # old yield realization
# cfg$gms$yields <- "managementcalib_aug19"
# cfg$gms$tc     <- "endo_jan22"
# # start MAgPIE run
# start_run(cfg, codeCheck = TRUE)

# # LPJmL Version runs_lpjml5.9.16-m2
# source("config/default.cfg")
# cfg$title <- "LPJmL_5.9.16-m2_gsadapt"
# # input data
# cfg$input <- c(regional    = "rev4.125+griddedL2Mcomp_v1_l2m_h12_magpie_debug.tgz",
#                cellular    = "rev4.125+griddedL2Mcomp_v1_l2m_h12_a23b62b7_cellularmagpie_debug_c200_MRI-ESM2-0-ssp370_lpjml-491b39ba.tgz",
#                validation  = "rev4.125+griddedL2Mcomp_v1_l2m_h12_validation_debug.tgz",
#                additional  = "additional_data_rev4.63.tgz",
#                calibration = "calibration_H12_FAO_18Sep25.tgz")
# # new yield realization
# cfg$gms$yields <- "gsadapt_nov25"
# cfg$gms$tc     <- "endo_nov25"
# # start MAgPIE run
# start_run(cfg, codeCheck = TRUE)

# # LPJmL Version runs_lpjml5.10.0-m1
# source("config/default.cfg")
# cfg$title <- "LPJmL_5.10.0-m1_gsadapt"
# # input data
# cfg$input <- c(regional    = "rev4.125+griddedL2Mcomp_v2_l2m_h12_magpie_debug.tgz",
#                cellular    = "rev4.125+griddedL2Mcomp_v2_l2m_h12_4ad25a7f_cellularmagpie_debug_c200_MRI-ESM2-0-ssp370_lpjml-351193fc.tgz",
#                validation  = "rev4.125+griddedL2Mcomp_v2_l2m_h12_validation_debug.tgz",
#                additional  = "additional_data_rev4.63.tgz",
#                calibration = "calibration_H12_FAO_18Sep25.tgz")
# # new yield realization
# cfg$gms$yields <- "gsadapt_nov25"
# cfg$gms$tc     <- "endo_nov25"
# # start MAgPIE run
# start_run(cfg, codeCheck = TRUE)


# # LPJmL Version runs_lpjml5.9.16-m2
# source("config/default.cfg")
# cfg$title <- "LPJmL_5.9.16-m2_NOgsadapt"
# # input data
# cfg$input <- c(regional    = "rev4.125+griddedL2Mcomp_v1_l2m_h12_magpie_debug.tgz",
#                cellular    = "rev4.125+griddedL2Mcomp_v1_l2m_h12_a23b62b7_cellularmagpie_debug_c200_MRI-ESM2-0-ssp370_lpjml-491b39ba.tgz",
#                validation  = "rev4.125+griddedL2Mcomp_v1_l2m_h12_validation_debug.tgz",
#                additional  = "additional_data_rev4.63.tgz",
#                calibration = "calibration_H12_FAO_18Sep25.tgz")
# # new yield realization
# cfg$gms$yields <- "gsadapt_nov25"
# cfg$gms$tc     <- "endo_nov25"
# # deactivate gsadapt 
# cfg$gms$s14_use_gsadapt <- 0
# cfg$gms$s14_gsadapt2tau <- 0
# # start MAgPIE run
# start_run(cfg, codeCheck = TRUE)

# # LPJmL Version runs_lpjml5.10.0-m1
# source("config/default.cfg")
# cfg$title <- "LPJmL_5.10.0-m1_NOgsadapt"
# # input data
# cfg$input <- c(regional    = "rev4.125+griddedL2Mcomp_v2_l2m_h12_magpie_debug.tgz",
#                cellular    = "rev4.125+griddedL2Mcomp_v2_l2m_h12_4ad25a7f_cellularmagpie_debug_c200_MRI-ESM2-0-ssp370_lpjml-351193fc.tgz",
#                validation  = "rev4.125+griddedL2Mcomp_v2_l2m_h12_validation_debug.tgz",
#                additional  = "additional_data_rev4.63.tgz",
#                calibration = "calibration_H12_FAO_18Sep25.tgz")
# # new yield realization
# cfg$gms$yields <- "gsadapt_nov25"
# cfg$gms$tc     <- "endo_nov25"
# # deactivate gsadapt 
# cfg$gms$s14_use_gsadapt <- 0
# cfg$gms$s14_gsadapt2tau <- 0
# # start MAgPIE run
# start_run(cfg, codeCheck = TRUE)


### Runs without irrigated2rainfed correction ###
# Current MAgPIE default with same preprocessing status as the lpjml ones to be compared with
source("config/default.cfg")
cfg$title <- "Default_mngtcalib_ir2rfOff"
# input data
cfg$input <- c(regional    = "rev4.125+griddedL2Mcomp_v1_default_h12_magpie.tgz",
               cellular    = "rev4.125+griddedL2Mcomp_v1_default_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
               validation  = "rev4.125+griddedL2Mcomp_v1_default_h12_validation.tgz",
               additional  = "additional_data_rev4.63.tgz",
               calibration = "calibration_H12_FAO_18Sep25.tgz")
# old yield realization
cfg$gms$yields <- "managementcalib_aug19"
cfg$gms$tc     <- "endo_jan22"
# deactivate irrigated2rainfed correction
cfg$gms$s14_calib_ir2rf <- 0
# start MAgPIE run
start_run(cfg, codeCheck = TRUE)

# LPJmL Version runs_lpjml5.9.16-m2
source("config/default.cfg")
cfg$title <- "LPJmL_5.9.16-m2_gsadapt_ir2rfOff"
# input data
cfg$input <- c(regional    = "rev4.125+griddedL2Mcomp_v1_l2m_h12_magpie_debug.tgz",
               cellular    = "rev4.125+griddedL2Mcomp_v1_l2m_h12_a23b62b7_cellularmagpie_debug_c200_MRI-ESM2-0-ssp370_lpjml-491b39ba.tgz",
               validation  = "rev4.125+griddedL2Mcomp_v1_l2m_h12_validation_debug.tgz",
               additional  = "additional_data_rev4.63.tgz",
               calibration = "calibration_H12_FAO_18Sep25.tgz")
# new yield realization
cfg$gms$yields <- "gsadapt_nov25"
cfg$gms$tc     <- "endo_nov25"
# deactivate irrigated2rainfed correction
cfg$gms$s14_calib_ir2rf <- 0
# start MAgPIE run
start_run(cfg, codeCheck = TRUE)

# LPJmL Version runs_lpjml5.10.0-m1
source("config/default.cfg")
cfg$title <- "LPJmL_5.10.0-m1_gsadapt_ir2rfOff"
# input data
cfg$input <- c(regional    = "rev4.125+griddedL2Mcomp_v2_l2m_h12_magpie_debug.tgz",
               cellular    = "rev4.125+griddedL2Mcomp_v2_l2m_h12_4ad25a7f_cellularmagpie_debug_c200_MRI-ESM2-0-ssp370_lpjml-351193fc.tgz",
               validation  = "rev4.125+griddedL2Mcomp_v2_l2m_h12_validation_debug.tgz",
               additional  = "additional_data_rev4.63.tgz",
               calibration = "calibration_H12_FAO_18Sep25.tgz")
# new yield realization
cfg$gms$yields <- "gsadapt_nov25"
cfg$gms$tc     <- "endo_nov25"
# deactivate irrigated2rainfed correction
cfg$gms$s14_calib_ir2rf <- 0
# start MAgPIE run
start_run(cfg, codeCheck = TRUE)

# LPJmL Version runs_lpjml5.9.16-m2
source("config/default.cfg")
cfg$title <- "LPJmL_5.9.16-m2_NOgsadapt_ir2rfOff"
# input data
cfg$input <- c(regional    = "rev4.125+griddedL2Mcomp_v1_l2m_h12_magpie_debug.tgz",
               cellular    = "rev4.125+griddedL2Mcomp_v1_l2m_h12_a23b62b7_cellularmagpie_debug_c200_MRI-ESM2-0-ssp370_lpjml-491b39ba.tgz",
               validation  = "rev4.125+griddedL2Mcomp_v1_l2m_h12_validation_debug.tgz",
               additional  = "additional_data_rev4.63.tgz",
               calibration = "calibration_H12_FAO_18Sep25.tgz")
# new yield realization
cfg$gms$yields <- "gsadapt_nov25"
cfg$gms$tc     <- "endo_nov25"
# deactivate gsadapt 
cfg$gms$s14_use_gsadapt <- 0
cfg$gms$s14_gsadapt2tau <- 0
# deactivate irrigated2rainfed correction
cfg$gms$s14_calib_ir2rf <- 0
# start MAgPIE run
start_run(cfg, codeCheck = TRUE)

# LPJmL Version runs_lpjml5.10.0-m1
source("config/default.cfg")
cfg$title <- "LPJmL_5.10.0-m1_NOgsadapt_ir2rfOff"
# input data
cfg$input <- c(regional    = "rev4.125+griddedL2Mcomp_v2_l2m_h12_magpie_debug.tgz",
               cellular    = "rev4.125+griddedL2Mcomp_v2_l2m_h12_4ad25a7f_cellularmagpie_debug_c200_MRI-ESM2-0-ssp370_lpjml-351193fc.tgz",
               validation  = "rev4.125+griddedL2Mcomp_v2_l2m_h12_validation_debug.tgz",
               additional  = "additional_data_rev4.63.tgz",
               calibration = "calibration_H12_FAO_18Sep25.tgz")
# new yield realization
cfg$gms$yields <- "gsadapt_nov25"
cfg$gms$tc     <- "endo_nov25"
# deactivate gsadapt 
cfg$gms$s14_use_gsadapt <- 0
cfg$gms$s14_gsadapt2tau <- 0
# deactivate irrigated2rainfed correction
cfg$gms$s14_calib_ir2rf <- 0
# start MAgPIE run
start_run(cfg, codeCheck = TRUE)
