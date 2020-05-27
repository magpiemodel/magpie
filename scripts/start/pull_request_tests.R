# |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de


###############################################
#### Starting a current default MAgPIE run ####
###############################################

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")

# Set an indentifier flag
#identifier_flag <- "AM01" ## Identifier flag for easy filterung of run by name in appResults. Use a combination of user initials and count upards in numbers like 01,02... etc

#use user name and model version defined in default.cfg for generating the titel
pr_flag <- "PR"
user <- Sys.info()[["user"]]
version <- cfg$model_version
  
for(ssp in c("SSP2")) { ## Add SSP* here for testing other SSPs. Basic test should be for SSP2
  
  for (co2_price_path in c("BAU","POL")) {
    
    if (co2_price_path == "BAU") {
      cfg <- setScenario(cfg,c(ssp,"NPI"))
      co2_price_path_flag = "BAU"
    } else if (co2_price_path == "POL"){
      cfg <- setScenario(cfg,c(ssp,"NDC"))
      co2_price_path_flag = "POL"
      cfg$gms$c56_pollutant_prices <- "R2M41-SSP2-Budg600" #update to most recent coupled runs asap
      cfg$gms$c60_2ndgen_biodem <- "R2M41-SSP2-Budg600" ##update to most recent coupled runs asap
    }
    
    cfg$title <- paste0(pr_flag,"_",user,"_",version,"_",ssp,"-",co2_price_path_flag) #PR_mishra_4.2-forestry_SSP2-BAU
    
    cfg$output <- c("rds_report")
    
    start_run(cfg,codeCheck=FALSE)
  }
}
