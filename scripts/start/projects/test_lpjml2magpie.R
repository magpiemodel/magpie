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

# source default configuration
source("config/default.cfg")
cfg$title <- title <- "l2m"

for (ir2rf in c(0, 1)) {
    for (limitCalib in c(0, 1)) {
        # Default runs
        cfg$title <- paste0(title, "_Default_mngtcalib_", 
                            "ir2rf_", ifelse(ir2rf == 0, "Off", "On"),
                            ifelse(limitCalib == 0, "_noLimitCalib", "_limitCalib"))
        # input data
        cfg$input <- c(regional    = "rev4.125+griddedL2Mcomp_v1_default_h12_magpie.tgz",
                       cellular    = "rev4.125+griddedL2Mcomp_v1_default_h12_fd712c0b_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-8e6c5eb1.tgz",
                       validation  = "rev4.125+griddedL2Mcomp_v1_default_h12_validation.tgz",
                       additional  = "additional_data_rev4.63.tgz",
                       calibration = "calibration_H12_FAO_18Sep25.tgz")
        # old yield realization
        cfg$gms$yields <- "managementcalib_aug19"
        cfg$gms$tc     <- "endo_jan22"
        # irrigated2rainfed setting
        cfg$gms$s14_calib_ir2rf <- ir2rf
        # limited calibration setting
        cfg$gms$s14_limit_calib <- limitCalib
        # start MAgPIE run
        start_run(cfg, codeCheck = TRUE)

        # New LPJmL Versions
        for (gsadaptOption in c("gsadapt", "NOgsadapt")) {

            # LPJmL Version runs_lpjml5.10.0-m2
            # +griddedL2Mcomp_v10_2_l2m
            cfg$title <- paste0(title, "_v5.10.0-2_", gsadaptOption, "_",
                            "ir2rf_", ifelse(ir2rf == 0, "Off", "On"),
                            ifelse(limitCalib == 0, "_noLimC", "_limC"))
            # input data
            cfg$input <- c(regional    = "rev4.125+griddedL2Mcomp_v10_2_l2m_h12_magpie.tgz",
                            cellular    = "rev4.125+griddedL2Mcomp_v10_2_l2m_h12_00e02813_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-a0c283bd.tgz",
                            validation  = "rev4.125+griddedL2Mcomp_v10_2_l2m_h12_validation.tgz",
                            additional  = "additional_data_rev4.63.tgz",
                            calibration = "calibration_H12_FAO_18Sep25.tgz")
            # new yield realization
            cfg$gms$yields <- "gsadapt_nov25"
            cfg$gms$tc     <- "endo_nov25"
            # irrigated2rainfed setting
            cfg$gms$s14_calib_ir2rf <- ir2rf
            # limited calibration setting
            cfg$gms$s14_limit_calib <- limitCalib
            # gsadapt settings
            if (gsadaptOption == "NOgsadapt") {
                cfg$gms$s14_use_gsadapt <- 0
                cfg$gms$s14_gsadapt2tau <- 0
            } else {
                cfg$gms$s14_use_gsadapt <- 1
                cfg$gms$s14_gsadapt2tau <- 1
            }
            # start MAgPIE run
            start_run(cfg, codeCheck = TRUE)

            # LPJmL Version runs_lpjml5.10.0-m1
            cfg$title <- paste0(title, "_v5.10.0-1_", gsadaptOption, "_",
                            "ir2rf_", ifelse(ir2rf == 0, "Off", "On"),
                            ifelse(limitCalib == 0, "_noLimC", "_limC"))
            # input data
            cfg$input <- c(regional    = "rev4.125+griddedL2Mcomp_v2_l2m_h12_magpie_debug.tgz",
                            cellular    = "rev4.125+griddedL2Mcomp_v2_l2m_h12_4ad25a7f_cellularmagpie_debug_c200_MRI-ESM2-0-ssp370_lpjml-351193fc.tgz",
                            validation  = "rev4.125+griddedL2Mcomp_v2_l2m_h12_validation_debug.tgz",
                            additional  = "additional_data_rev4.63.tgz",
                            calibration = "calibration_H12_FAO_18Sep25.tgz")
            # new yield realization
            cfg$gms$yields <- "gsadapt_nov25"
            cfg$gms$tc     <- "endo_nov25"
            # irrigated2rainfed setting
            cfg$gms$s14_calib_ir2rf <- ir2rf
            # limited calibration setting
            cfg$gms$s14_limit_calib <- limitCalib
            # gsadapt settings
            if (gsadaptOption == "NOgsadapt") {
                cfg$gms$s14_use_gsadapt <- 0
                cfg$gms$s14_gsadapt2tau <- 0
            } else {
                cfg$gms$s14_use_gsadapt <- 1
                cfg$gms$s14_gsadapt2tau <- 1
            }
            # start MAgPIE run
            start_run(cfg, codeCheck = TRUE)

            # LPJmL Version runs_lpjml5.9.16-m2
            cfg$title <- paste0(title, "_v5.9.16-2_", gsadaptOption, "_",
                            "ir2rf_", ifelse(ir2rf == 0, "Off", "On"),
                            ifelse(limitCalib == 0, "_noLimC", "_limC"))
            # input data
            cfg$input <- c(regional    = "rev4.125+griddedL2Mcomp_v2_l2m_h12_magpie_debug.tgz",
                        cellular    = "rev4.125+griddedL2Mcomp_v2_l2m_h12_4ad25a7f_cellularmagpie_debug_c200_MRI-ESM2-0-ssp370_lpjml-351193fc.tgz",
                        validation  = "rev4.125+griddedL2Mcomp_v2_l2m_h12_validation_debug.tgz",
                        additional  = "additional_data_rev4.63.tgz",
                        calibration = "calibration_H12_FAO_18Sep25.tgz")
            # new yield realization
            cfg$gms$yields <- "gsadapt_nov25"
            cfg$gms$tc     <- "endo_nov25"
            # irrigated2rainfed setting
            cfg$gms$s14_calib_ir2rf <- ir2rf
            # limited calibration setting
            cfg$gms$s14_limit_calib <- limitCalib
            # gsadapt settings
            if (gsadaptOption == "NOgsadapt") {
                cfg$gms$s14_use_gsadapt <- 0
                cfg$gms$s14_gsadapt2tau <- 0
            } else {
                cfg$gms$s14_use_gsadapt <- 1
                cfg$gms$s14_gsadapt2tau <- 1
            }
            # start MAgPIE run
            start_run(cfg, codeCheck = TRUE)
        }
    }
}
