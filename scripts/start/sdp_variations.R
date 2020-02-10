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


cfg$title <- "R2M41_SSP1"
cfg <- setScenario(cfg,c("SSP1"))
start_run(cfg,codeCheck=FALSE)

cfg$title <- "R2M41_SSP2"
cfg <- setScenario(cfg,c("SSP2"))
start_run(cfg,codeCheck=FALSE)


cfg$title <- "R2M41_SDP"
cfg <- setScenario(cfg,c("SDP"))
start_run(cfg,codeCheck=FALSE)


cfg$title <- "R2M41_SDP_inelastic_fdemand"
cfg <- setScenario(cfg,c("SDP"))
cfg$gms$s15_elastic_demand <- 0
start_run(cfg,codeCheck=FALSE)

cfg$title <- "R2M41_SDP_foodwaste_endo"
cfg <- setScenario(cfg,c("SDP"))
cfg$gms$s15_exo_waste <- 0
start_run(cfg,codeCheck=FALSE)

cfg$title <- "R2M41_SDP_foodwaste_quarter"
cfg <- setScenario(cfg,c("SDP"))
cfg$gms$s15_waste_scen <- 1.1
start_run(cfg,codeCheck=FALSE)

cfg$title <- "R2M41_SDP_diet_endo"
cfg <- setScenario(cfg,c("SDP"))
cfg$gms$s15_exo_diet <- 0
start_run(cfg,codeCheck=FALSE)

cfg$title <- "R2M41_SDP_EAT_2030"
cfg <- setScenario(cfg,c("SDP"))
cfg$gms$c15_exo_scen_targetyear <- "y2030"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "R2M41_SDP_EAT_2100kcal"
cfg <- setScenario(cfg,c("SDP"))
cfg$gms$c15_kcal_scen <- "2100kcal"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "R2M41_SDP_EAT_VEG"
cfg <- setScenario(cfg,c("SDP"))
cfg$gms$c15_EAT_scen <- "VEG"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "R2M41_SDP_protect_def"
cfg <- setScenario(cfg,c("SDP"))
cfg$gms$c35_protect_scenario <- "WDPA"
start_run(cfg,codeCheck=FALSE)

cfg$title <- "R2M41_SDP_irrig_def"
cfg <- setScenario(cfg,c("SDP"))
cfg$gms$s42_irrig_eff_scenario <- 1
start_run(cfg,codeCheck=FALSE)


cfg$title <- "R2M41_SDP_emis_policy_nodef"
cfg <- setScenario(cfg,c("SDP"))
cfg$gms$c56_emis_policy <- "all"
start_run(cfg,codeCheck=FALSE)
#reset:
cfg$gms$c56_emis_policy      <- "ssp_nosoil"


#reset run
cfg$title <- "R2M41_SDP_reset"
cfg <- setScenario(cfg,c("SDP"))
start_run(cfg,codeCheck=FALSE)