# |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)
library(magclass)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE runs
source("config/default.cfg")

cfg$force_download <- TRUE

#cfg$results_folder <- "output/:title:"
cfg$results_folder <- "output/:title::date:"



### SSPs with and w/o mitigation ###
cfg$title <- "SSP1"
cfg <- setScenario(cfg,c("SSP1","NPI"))
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP2"
cfg <- setScenario(cfg,c("SSP2","NPI"))
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP5"
cfg <- setScenario(cfg,c("SSP5","NPI"))
start_run(cfg,codeCheck=FALSE)



cfg$title <- "SSP1_rcp26"
cfg <- setScenario(cfg,c("SSP1","NDC"))
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP2_rcp26"
cfg <- setScenario(cfg,c("SSP2","NDC"))
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP2-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP2-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SSP5_rcp26"
cfg <- setScenario(cfg,c("SSP5","NDC"))
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP5-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP5-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)



#reset:
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"





### SDP with and w/o mitigation ###

cfg$title <- "SDP"
cfg <- setScenario(cfg,c("SDP","NPI"))
start_run(cfg,codeCheck=FALSE)


cfg$title <- "SDP_rcp26_SSP2DB_RM"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)



#reset:
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"




### SSPs & SDP variations w/o mitigation ###############################


####trade variation SSP2
cfg$title <- "SDP_tradessp2"
cfg <- setScenario(cfg,c("SDP","NPI"))
cfg$gms$c21_trade_liberalization <- "l909090r808080"
start_run(cfg,codeCheck=FALSE)


####trade variation SSP3
cfg$title <- "SDP_tradessp3"
cfg <- setScenario(cfg,c("SDP","NPI"))
cfg$gms$c21_trade_liberalization <- "l909595r809090"
start_run(cfg,codeCheck=FALSE)

#reset trade settings:
cfg$gms$c21_trade_liberalization <- "l908080r807070"



### SSPs & SDP variations with mitigation ###############################

####trade variation SSP2
cfg$title <- "SDP_tradessp2_rcp26"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$c21_trade_liberalization <- "l909090r808080"
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)

####trade variation SSP3
cfg$title <- "SDP_tradessp3_rcp26"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$c21_trade_liberalization <- "l909595r809090"
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)


#reset trade settings:
cfg$gms$c21_trade_liberalization <- "l908080r807070"
#reset:
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"



#### variations in afforestation settings for mitigation scenarios

cfg$title <- "SDP_affore500_rcp26"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$s32_max_aff_area <- 500
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)


cfg$title <- "SDP_affore760_rcp26"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$s32_max_aff_area <- 760
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SDP_affore900_rcp26"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$s32_max_aff_area <- 900
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)

#reset afforestation setting:
cfg$gms$s32_max_aff_area <- Inf



cfg$title <- "SDP_affore_trop_rcp26"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$c32_aff_mask <- "onlytropical"
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SDP_affore500_trop_rcp26"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$s32_max_aff_area <- 500
cfg$gms$c32_aff_mask <- "onlytropical"
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SDP_affore760_trop_rcp26"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$s32_max_aff_area <- 760
cfg$gms$c32_aff_mask <- "onlytropical"
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "SDP_affore900_trop_rcp26"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$s32_max_aff_area <- 900
cfg$gms$c32_aff_mask <- "onlytropical"
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)


#reset:
cfg$gms$s32_max_aff_area <- Inf 
cfg$gms$c32_aff_mask <- "noboreal"
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"





### Variations regarding emission pricing (carbon pools and negative emissions)


cfg$title <- "SDP_all_nosoil-Inf_rcp26"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$c56_emis_policy      <- "all_nosoil"
cfg$gms$s56_reward_neg_emis  <- -Inf
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)


cfg$title <- "SDP_all-Inf_rcp26"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$c56_emis_policy      <- "all"
cfg$gms$s56_reward_neg_emis  <- -Inf
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)


cfg$title <- "SDP_ssp_nosoil-Inf_rcp26"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$c56_emis_policy      <- "ssp_nosoil"
cfg$gms$s56_reward_neg_emis  <- -Inf
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)


cfg$title <- "SDP_ssp-Inf_rcp26"
cfg <- setScenario(cfg,c("SDP","NDC"))
cfg$gms$c56_emis_policy      <- "ssp"
cfg$gms$s56_reward_neg_emis  <- -Inf
cfg$gms$c56_pollutant_prices <- "SSPDB-SSP1-26-REMIND-MAGPIE"
cfg$gms$c60_2ndgen_biodem <- "SSPDB-SSP1-26-REMIND-MAGPIE"
start_run(cfg,codeCheck=FALSE)




#reset:
cfg$gms$c56_emis_policy      <- "ssp_nosoil"
cfg$gms$s56_reward_neg_emis  <- 0
cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-NPi"
cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-NPi"







