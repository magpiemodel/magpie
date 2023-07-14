*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_emissions_reg.fx(i,"peatland",pollutants) = 0;
vm_emissions_reg.lo(i,"peatland",poll58) = -Inf;
vm_emissions_reg.up(i,"peatland",poll58) = Inf;

p58_mapping_cell_climate(j,clcl58) = sum(clcl_mapping(clcl,clcl58),pm_climate_class(j,clcl));

p58_ipcc_wetland_ef(clcl58,land58,emis58) = f58_ipcc_wetland_ef(clcl58,land58,emis58);

* Peatland scaling factor: ratio of total peatland area and total land area
p58_scaling_factor(j)$(sum(land, pcm_land(j,land)) > 1e-20) = sum(land58, f58_peatlandArea(j,land58)) / sum(land, pcm_land(j,land));


* Initialization of peatland
pc58_peatland(j,land58) = 0;
* Degraded peatland is estimated by multiplication of managed land (pcm_land) with the peatland scaling factor (p58_scaling_factor).
pc58_peatland(j,"crop") = min(f58_peatlandArea(j,"crop"),pcm_land(j,"crop") * p58_scaling_factor(j));
pc58_peatland(j,"past") = min(f58_peatlandArea(j,"past"),pcm_land(j,"past") * p58_scaling_factor(j));
pc58_peatland(j,"forestry") = min(f58_peatlandArea(j,"forestry"),pcm_land(j,"forestry") * p58_scaling_factor(j));

* The residual is added to an "unused" category, which represents degraded but unused peatland.
pc58_peatland(j,"unused") = sum(landMan58, f58_peatlandArea(j,landMan58) - pc58_peatland(j,landMan58));
*pc58_peatland(j,"unused")$(pc58_peatland(j,"unused") < 0) = 0;
*p58_peatland_degrad(j) = sum((man58,land58), pc58_peatland_man(j,man58,land58));
pc58_peatland(j,"peatExtract") = f58_peatlandArea(j,"peatExtract");

pc58_peatland(j,"intact") = f58_peatlandArea(j,"intact");

