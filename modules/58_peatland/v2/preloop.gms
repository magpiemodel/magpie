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

* Peatland scaling factor: ratio of total peatland area and total land area
p58_scaling_factor(j)$(sum(land, pcm_land(j,land)) > 1e-20) = sum(land58, f58_peatland_area(j,land58)) / sum(land, pcm_land(j,land));

* Initialization of peatland
pc58_peatland(j,land58) = 0;
* Degraded peatland is estimated by multiplication of managed land (cropland, pasture, forestry) with the peatland scaling factor (p58_scaling_factor) 
* and simultaneously constrained by observed degraded peatland area (f58_peatland_area).
pc58_peatland(j,"crop") = min(f58_peatland_area(j,"crop"),pcm_land(j,"crop") * p58_scaling_factor(j));
pc58_peatland(j,"past") = min(f58_peatland_area(j,"past"),pcm_land(j,"past") * p58_scaling_factor(j));
pc58_peatland(j,"forestry") = min(f58_peatland_area(j,"forestry"),vm_land_forestry.l(j,"plant") * p58_scaling_factor(j));

* The residual is added to an "unused" category, which represents degraded but unused peatland.
pc58_peatland(j,"unused") = sum(landDrainedUsed58, f58_peatland_area(j,landDrainedUsed58) - pc58_peatland(j,landDrainedUsed58));
pc58_peatland(j,"unused")$(pc58_peatland(j,"unused") < 0) = 0;

pc58_peatland(j,"peatExtract") = f58_peatland_area(j,"peatExtract");
pc58_peatland(j,"intact") = f58_peatland_area(j,"intact");
