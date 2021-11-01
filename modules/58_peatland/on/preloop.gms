*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


p58_mapping_cell_climate(j,clcl58) = sum(clcl_mapping(clcl,clcl58),pm_climate_class(j,clcl));

p58_ipcc_wetland_ef(clcl58,land58,emis58,ef58) = f58_ipcc_wetland_ef(clcl58,land58,emis58,ef58);
p58_ipcc_wetland_ef(clcl58,land58,emis58,"unused") = f58_ipcc_wetland_ef(clcl58,land58,emis58,"degrad");

* Initialization of peatland
* Degraded peatland (f58_peatland_degrad) is assigned to cropland, pasture and forestry (managed land, land58), 
* weighted by the corresponding shares of cropland, pasture and forestry in total managed land (p58_peatland_degrad_weight).
* However, if the degraded peatland is larger than the actual managed land multiplied by a scaling factor 
* (p58_scaling_factor, see equations for details), degraded peatland is reduced accordingly. 
* The residual is added to an "unused" category, which represents degraded but unused peatland.

p58_scaling_factor(j) = (f58_peatland_degrad(j) + f58_peatland_intact(j)) / sum(land, pcm_land(j,land));

pc58_peatland_intact(j) = f58_peatland_intact(j);

p58_man_land_area(j) = sum(land58, pcm_land(j,land58));
p58_peatland_degrad_weight(j,land58) = 1/card(land58);
p58_peatland_degrad_weight(j,land58)$(p58_man_land_area(j) > 0) = pcm_land(j,land58) / p58_man_land_area(j);

pc58_peatland_man(j,man58,land58) = 0;
*pc58_peatland_man(j,"degrad",land58) = min(pcm_land(j,land58)*p58_scaling_factor(j),f58_peatland_degrad(j) * p58_peatland_degrad_weight(j,land58));
p58_calib_factor(j,land58) = 1;
p58_calib_factor(j,land58)$(pcm_land(j,land58) * p58_scaling_factor(j) > 0) = (f58_peatland_degrad(j) * p58_peatland_degrad_weight(j,land58)) / (pcm_land(j,land58)*p58_scaling_factor(j));
p58_calib_factor(j,land58)$(p58_calib_factor(j,land58) > 1) = 1;
pc58_peatland_man(j,"degrad",land58) = pcm_land(j,land58) * p58_scaling_factor(j) * p58_calib_factor(j,land58);
pc58_peatland_man(j,"unused",land58) = f58_peatland_degrad(j) * p58_peatland_degrad_weight(j,land58) - pc58_peatland_man(j,"degrad",land58);
pc58_peatland_man(j,"unused",land58)$(pc58_peatland_man(j,"unused",land58) < 0) = 0;
p58_peatland_degrad(j) = sum((man58,land58), pc58_peatland_man(j,man58,land58));
