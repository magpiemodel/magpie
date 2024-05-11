*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_emissions_reg.fx(i,"peatland",pollutants) = 0;
vm_emissions_reg.lo(i,"peatland",poll58) = -Inf;
vm_emissions_reg.up(i,"peatland",poll58) = Inf;

p58_mapping_cell_climate(j,clcl58) = sum(clcl_mapping(clcl,clcl58),pm_climate_class(j,clcl));

* Initialization of peatland area
pc58_peatland(j,land58) = 0;

* For the internal GHG emission pricing it is assumed that intact peatlands have the same GHG emission factors as rewetted peatlands.
* Without this assumption, GHG emissions of intact peatlands would be zero (no data available). This can lead to cases where intact peatland is converted to rewetted peatland.
f58_ipcc_wetland_ef(clcl58,"intact",emis58) = f58_ipcc_wetland_ef(clcl58,"rewetted",emis58);
