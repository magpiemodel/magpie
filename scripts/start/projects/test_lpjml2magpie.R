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
title <- "l2m_jun26"
cfg$recalibrate_landconversion_cost <- TRUE

##############################################
### Current default (i.e., old lpjml data) ###
##############################################
cfg$gms$yields <- "managementcalib_aug19"
cfg$gms$tc     <- "endo_jan22"

# RCP2.6
#cfg$title <- paste0(title, "_Default_mngtcalib_", "rcp26")
#cfg$input <- c(regional    = "rev4.130l2m_default_feb2026_h12_magpie.tgz",
#               cellular    = "rev4.130l2m_default_feb2026_h12_6819938d_cellularmagpie_c200_MRI-ESM2-0-ssp126_lpjml-8e6c5eb1.tgz",
#               validation  = "rev4.130l2m_default_feb2026_h12_92e02314_validation.tgz",
#               additional  = "additional_data_rev4.65.tgz",
#               calibration = "calibration_H12_FAO_01Apr26.tgz")      #### Do I need to change this when I recalibrate?
# start MAgPIE run
#start_run(cfg, codeCheck = TRUE)

# RCP7.0
#cfg$title <- paste0(title, "_Default_mngtcalib_", "rcp70")
#cfg$input <- c(regional    = "rev4.131_h12_magpie.tgz",
#               cellular    = "rev4.131_h12_1b5c3817_cellularmagpie_c200_MRI-ESM2-0-ssp245_lpjml-8e6c5eb1.tgz",
#               validation  = "rev4.131_h12_92e02314_validation.tgz",
#               additional  = "additional_data_rev4.65.tgz",
      #         calibration = "calibration_H12_FAO_01Apr26.tgz")    #### Do I need to change this when I recalibrate?
# start MAgPIE run
#start_run(cfg, codeCheck = TRUE)

#####################
### New lpjml data ###
#####################

### Different RCPs (2x) ###
for (rcp in c("7p0")) { # 2p6

    if (rcp == "2p6") {
        # RCP2.6
        # To Do: need to run preprocessing for RCP2p6!!!
        cfg$input <- c(regional    = "rev4.130l2m_v5-10-0m2_feb2026_h12_magpie.tgz",
                       cellular    = "rev4.130l2m_v5-10-0m2_feb2026_h12_e3aebc2e_cellularmagpie_c200_MRI-ESM2-0-ssp126_lpjml-a0c283bd.tgz",
                       validation  = "rev4.130l2m_v5-10-0m2_feb2026_h12_92e02314_validation.tgz",
                       additional  = "additional_data_rev4.65.tgz",
                       calibration = "calibration_H12_FAO_01Apr26.tgz")    #### Do I need to change this when I recalibrate?
    } else if (rcp == "7p0") {
        # RCP7.0
        cfg$input <- c(regional    = "rev4.131l2m_v5-10-0m2_may2026+BEdata3_h12_magpie.tgz",
                       cellular    = "rev4.131l2m_v5-10-0m2_may2026+BEdata3_h12_00e02813_cellularmagpie_c200_MRI-ESM2-0-ssp370_lpjml-a0c283bd.tgz",
                       validation  = "rev4.131l2m_v5-10-0m2_may2026+BEdata3_h12_92e02314_validation.tgz",
                       additional  = "additional_data_rev4.65.tgz",
                       calibration = "calibration_H12_FAO_01Apr26.tgz") #### Do I need to change this when I recalibrate?
    } else {
      stop("selected rcp not available")
    }

    ### Different realizations (2x) ###
    for (realization in c("gsadapt")) { # "mngt", 

        if (realization == "mngt") {
        # default realizations
        cfg$gms$yields <- "managementcalib_aug19"
        cfg$gms$tc     <- "endo_jan22"

        # title 
        cfg$title <- paste0(title, "_LPJmL5-10-0m2", "_", "rcp", rcp, "_", realization)
        # start MAgPIE run
        start_run(cfg, codeCheck = TRUE)

        } else if (realization == "gsadapt") {
        # new realizations
        cfg$gms$yields <- "gsadapt_nov25"
        cfg$gms$tc     <- "endo_nov25"

        for (gsadapt in c("const", "adapt")) {
            if (gsadapt == "const") {
                # no growing period adaptation
                cfg$gms$s14_use_gsadapt <- 0
                cfg$gms$s14_gsadapt2tau <- 0

                # title 
                cfg$title <- paste0(title, "_LPJmL5-10-0m2", "_", "rcp", rcp, "_", realization, "_gs", gsadapt)
                # start MAgPIE run
                start_run(cfg, codeCheck = TRUE)

            } else if (gsadapt == "adapt") {

                for (gsad_in_tau in c("TCgsad0", "TCgsad1")) {
                  if (gsad_in_tau == "TCgsad0") {
                    # growing period adaptation
                    cfg$gms$s14_use_gsadapt <- 1
                    cfg$gms$s14_gsadapt2tau <- 0

                    # title 
                    cfg$title <- paste0(title, "_LPJmL5-10-0m2", "_", "rcp", rcp, "_", realization, "_gs", gsadapt, gsad_in_tau)
                    # start MAgPIE run
                    start_run(cfg, codeCheck = TRUE)

                  } else if (gsad_in_tau == "TCgsad1") {
                    # growing period adaptation
                    cfg$gms$s14_use_gsadapt <- 1
                    cfg$gms$s14_gsadapt2tau <- 1

                    # title 
                    cfg$title <- paste0(title, "_LPJmL5-10-0m2", "_", "rcp", rcp, "_", realization, "_gs", gsadapt, gsad_in_tau)
                    # start MAgPIE run
                    start_run(cfg, codeCheck = TRUE)

                  } else {
                    stop("Selected gsad_in_tau is not available.")
                  }
                }
            } else {
                stop("gsadapt setting does not exist")
            }
        }
        } else {
          stop("selected realization is not available.")
        }
    }
}
