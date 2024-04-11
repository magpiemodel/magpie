# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ----------------------------------------------------------
# description: LAMACLIMA WP4 runs
# ----------------------------------------------------------

######################################
#### Script to start a MAgPIE run ####
######################################


library(gms)
library(magclass)
library(gdx)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

prefix <- "LAMA91"
cfg$force_replace <- TRUE

cfg$gms$factor_costs <- "sticky_labor"
cfg$input["calibration"] <- "calibration_H12_sticky_feb18_dynamic_30Nov21.tgz"
cfg$gms$c17_prod_init <- "off"

cfg$gms$labor_prod <- "exo"
cfg$gms$c37_labor_rcp <- "rcp119"
cfg$gms$c37_labor_metric <- "ISO"
cfg$gms$c37_labor_intensity <- "400W"
cfg$gms$c37_labor_uncertainty <- "ensmean"

cfg$results_folder <- "output/:title:"
cfg$output <- c("rds_report","extra/disaggregation","extra/disaggregation_LUH2","extra/highres")
cfg$qos <- "priority_maxMem"

#### Main scenarios

### Global Sustainability, largely based on SDP
cfg$title <- paste(prefix,"Sustainability",sep="_")
cfg <- setScenario(cfg,c("LAMA_Sustainability","rcp1p9"))
cfg$gms$policy_countries30 <- all_iso_countries
cfg$gms$policy_countries22 <- all_iso_countries
cfg$gms$EFP_countries <- all_iso_countries
cfg$gms$cropneff_countries <- all_iso_countries
cfg$gms$scen_countries55 <- all_iso_countries
cfg$gms$policy_countries56 <- all_iso_countries
start_run(cfg,codeCheck=FALSE)

### Global Inequality, largely based on SSP4
cfg$title <- paste(prefix,"Inequality",sep="_")
cfg <- setScenario(cfg,c("LAMA_Inequal","rcp1p9"))
cfg$gms$policy_countries30 <- oecd90andEU
cfg$gms$policy_countries22 <- oecd90andEU
cfg$gms$EFP_countries <- oecd90andEU
cfg$gms$cropneff_countries <- oecd90andEU
cfg$gms$scen_countries55 <- oecd90andEU
cfg$gms$policy_countries56 <- oecd90andEU
start_run(cfg,codeCheck=FALSE)

#### Sensitivity scenarios

### LAMA_Inequal-SustDemand
cfg$title <- paste(prefix,"Inequality-SustDemand",sep="_")
cfg <- setScenario(cfg,c("LAMA_Inequal-SustDemand","rcp1p9"))
cfg$gms$policy_countries30 <- oecd90andEU
cfg$gms$policy_countries22 <- oecd90andEU
cfg$gms$EFP_countries <- oecd90andEU
cfg$gms$cropneff_countries <- oecd90andEU
cfg$gms$scen_countries55 <- oecd90andEU
cfg$gms$policy_countries56 <- oecd90andEU
start_run(cfg,codeCheck=FALSE)

### LAMA_Inequal-EnvirProt
cfg$title <- paste(prefix,"Inequality-EnvirProt",sep="_")
cfg <- setScenario(cfg,c("LAMA_Inequal-EnvirProt","rcp1p9"))
cfg$gms$policy_countries30 <- all_iso_countries
cfg$gms$policy_countries22 <- all_iso_countries
cfg$gms$EFP_countries <- all_iso_countries
cfg$gms$cropneff_countries <- all_iso_countries
cfg$gms$scen_countries55 <- all_iso_countries
cfg$gms$policy_countries56 <- oecd90andEU
start_run(cfg,codeCheck=FALSE)

### LAMA_Inequal-GHGPrice
cfg$title <- paste(prefix,"Inequality-GHGPrice",sep="_")
cfg <- setScenario(cfg,c("LAMA_Inequal-GHGPrice","rcp1p9"))
cfg$gms$policy_countries30 <- oecd90andEU
cfg$gms$policy_countries22 <- oecd90andEU
cfg$gms$EFP_countries <- oecd90andEU
cfg$gms$cropneff_countries <- oecd90andEU
cfg$gms$scen_countries55 <- oecd90andEU
cfg$gms$policy_countries56 <- all_iso_countries
start_run(cfg,codeCheck=FALSE)

### Global Inequality with higher climate impacts
cfg$title <- paste(prefix,"Inequality-rcp7p0",sep="_")
cfg <- setScenario(cfg,c("LAMA_Inequal","rcp7p0"))
cfg$gms$policy_countries30 <- oecd90andEU
cfg$gms$policy_countries22 <- oecd90andEU
cfg$gms$EFP_countries <- oecd90andEU
cfg$gms$cropneff_countries <- oecd90andEU
cfg$gms$scen_countries55 <- oecd90andEU
cfg$gms$policy_countries56 <- oecd90andEU
cfg$gms$c37_labor_rcp <- "rcp585"
start_run(cfg,codeCheck=FALSE)
