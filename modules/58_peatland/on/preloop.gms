*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

pc58_peatland_intact(j) = 0;
pc58_peatland_man(j,man58,land58) = 0;

p58_mapping_cell_climate(j,clcl58) = sum(clcl_mapping(clcl,clcl58),pm_climate_class(j,clcl));

p58_ipcc_wetland_ef(clcl58,land58,emis58,ef58) = f58_ipcc_wetland_ef(clcl58,land58,emis58,ef58);
p58_ipcc_wetland_ef(clcl58,land58,emis58,"unused") = f58_ipcc_wetland_ef(clcl58,land58,emis58,"degrad");

p58_peatland_cost_past(t,j) = 0;
