# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ------------------------------------------------
# description: start run with default.cfg settings
# position: 1
# ------------------------------------------------

# Load start_run(cfg) function which is needed to start MAgPIE runs
source("scripts/start_functions.R")

#start MAgPIE run
source("config/default.cfg")
cfg$gms$nitrogen="ipcc2006_sep16"
cfg$title="default_high_nue"
cfg$gms$c50_scen_neff <- "neff85_85_starty2010"   # def = neff60_60_starty2010
cfg$gms$c50_scen_neff_noselect <- "neff85_85_starty2010"   # def = neff60_60_starty2010
cfg$gms$c50_scen_neff_pasture <- "neff80_85_starty2010"       # def = constant
cfg$gms$c50_scen_neff_pasture_noselect <- "neff80_85_starty2010" 
start_run(cfg)

cfg$gms$nitrogen="rescaled_jan21"
cfg$title="rescaled_high_nue"
cfg$gms$c50_scen_neff <- "neff85_85_starty2010"   # def = neff60_60_starty2010
cfg$gms$c50_scen_neff_noselect <- "neff85_85_starty2010"   # def = neff60_60_starty2010
cfg$gms$c50_scen_neff_pasture <- "neff80_85_starty2010"       # def = constant
cfg$gms$c50_scen_neff_pasture_noselect <- "neff80_85_starty2010" 
start_run(cfg)

