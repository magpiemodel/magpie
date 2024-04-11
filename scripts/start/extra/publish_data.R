# |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
# |  authors, and contributors see CITATION.cff file. This file is part
# |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
# |  AGPL-3.0, you are granted additional permissions described in the
# |  MAgPIE License Exception, version 1.0 (see LICENSE file).
# |  Contact: magpie@pik-potsdam.de

# -----------------------------------------------------------------
# description: publish data set as input in default.cfg on a server
# -----------------------------------------------------------------

require(gms)

# publish data which is defined in default.cfg on https://rse.pik-potsdam.de/data/magpie/intern or magpie/public

source("config/default.cfg")
gms::publish_data(cfg,target = "dataupload@rse.pik-potsdam.de:/magpie/intern|dataupload@rse.pik-potsdam.de:/magpie/public")
