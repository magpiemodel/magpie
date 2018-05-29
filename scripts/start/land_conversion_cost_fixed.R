# |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
# |  authors, and contributors see AUTHORS file
# |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
# |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
# |  Contact: magpie@pik-potsdam.de


######################################
#### Script to start a MAgPIE run ####
######################################

library(lucode)

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")
source("config/default.cfg")

cfg <- setScenario(cfg,"SSP2")

cfg$results_folder <- "output/:title:"
cfg$gms$c_timesteps <- "TS_benni"
cfg$output <- c("report","validation","interpolation","LU_DiffPlots","LandusePlots")
#cfg$gms$s15_elastic_demand = 0


#cfg$force_download <- TRUE
cfg$recalibrate <- TRUE

for (factor_cost in c("fixed_per_ton_mar18")) {
  for (pastTC in c(0.25,0.5,0.75)) {
    for (lccost in c("gdp_vegc_mar18","gdp_vegc_apr18")) {
      cfg$gms$factor_costs <- factor_cost
      cfg$gms$s14_yld_past_switch <- pastTC
      cfg$gms$landconversion <- lccost
      if (lccost == "gdp_vegc_mar18") {
        cfg$title <- paste0(substr(factor_cost,1,5),"_TC",pastTC*100,"_LCdefault")
        try(start_run(cfg=cfg, codeCheck=FALSE))
      } else if (lccost == "gdp_vegc_apr18"){
        for (c39_cost_establish in c("low","medium","high")) {
          for (c39_cost_landclear in c("low","medium","high")) {
            manipulateConfig("modules/39_landconversion/gdp_vegc_apr18/input.gms",c39_cost_establish=c39_cost_establish)
            manipulateConfig("modules/39_landconversion/gdp_vegc_apr18/input.gms",c39_cost_landclear=c39_cost_landclear)
            cfg$title <- paste0(substr(factor_cost,1,5),"_TC",pastTC*100,"_LC",c39_cost_establish,c39_cost_landclear)
            try(start_run(cfg=cfg, codeCheck=FALSE))
          }
        }
      }
    }
  }
}
