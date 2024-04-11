# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# ------------------------------------------------
# description: download input and compile main.gms
# position: 7
# ------------------------------------------------

source("scripts/start_functions.R")
source("config/default.cfg")
download_and_update(cfg)

# compile main.gms
system("gams main.gms action=c")
