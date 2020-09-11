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

cfg$input <- c("additional_data_rev3.68.tgz",
                              "LPJmL5-IPSL_CM5A_LR-rcp2p6-co2_rev40.2_c200_c2a48c5eae535d4b8fe9c953d9986f1b.tgz",
                              "rev4.19_c2a48c5eae535d4b8fe9c953d9986f1b_magpie.tgz",
                              "rev4.19_c2a48c5eae535d4b8fe9c953d9986f1b_validation.tgz")

cfg$title    <- "lpjml5_test"
cfg$gms$yields <- "managementcalib_aug19"
cfg$gms$c41_initial_irrigation_area <- "LUH2v2"
start_run(cfg=cfg,codeCheck=TRUE)

cfg$title    <- "lpjml5_test_cc"
cfg<-lucode::setScenario(cfg,"cc")
start_run(cfg=cfg,codeCheck=TRUE)

cfg<-lucode::setScenario(cfg,"nocc")
