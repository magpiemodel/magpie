*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

vm_emissions_reg.fx(i,"peatland",pollutants) = 0;
vm_emissions_reg.lo(i,"peatland",poll58) = -Inf;
vm_emissions_reg.up(i,"peatland",poll58) = Inf;

* GHG emission conversion factors from GWP100 to element unit.
p58_conversion_factor("co2") = 12/44;
p58_conversion_factor("ch4") = 1/34;
p58_conversion_factor("n2o") = 1/298*28/44;

p58_mapping_cell_climate(j,clcl58) = sum(clcl_mapping(clcl,clcl58),pm_climate_class(j,clcl));

p58_ipcc_wetland_ef(clcl58,land58,emis58,ef58) = f58_ipcc_wetland_ef(clcl58,land58,emis58,ef58);
p58_ipcc_wetland_ef(clcl58,land58,emis58,"unused") = f58_ipcc_wetland_ef(clcl58,land58,emis58,"degrad");

* Peatland scaling factor: ratio of total peatland area and total land area
p58_scaling_factor(j) = (f58_peatland_degrad(j) + f58_peatland_intact(j)) / sum(land, pcm_land(j,land));
* Intact peatland area
pc58_peatland_intact(j) = f58_peatland_intact(j);
* Share of cropland, pasture and forestry in total managed land, used for distribution of degraded peatland (f58_peatland_degrad) to managed land.
p58_man_land_area(j) = sum(land58, pcm_land(j,land58));
p58_peatland_degrad_weight(j,land58) = 1/card(land58);
p58_peatland_degrad_weight(j,land58)$(p58_man_land_area(j) > 0) = pcm_land(j,land58) / p58_man_land_area(j);
* Calibration factor for alignment with historic levels of degraded peatland
p58_calib_factor(j,land58) = 1;
p58_calib_factor(j,land58)$(pcm_land(j,land58) * p58_scaling_factor(j) > 0) = (f58_peatland_degrad(j) * p58_peatland_degrad_weight(j,land58)) / (pcm_land(j,land58)*p58_scaling_factor(j));
p58_calib_factor(j,land58)$(p58_calib_factor(j,land58) > 1) = 1;

* Initialization of peatland
pc58_peatland_man(j,man58,land58) = 0;
* Degraded peatland is estimated by multiplication of managed land (pcm_land) with the peatland scaling factor (p58_scaling_factor).
* The calibration factor (p58_calib_factor) reduces this estimate to historic levels of degraded peatland. p58_calib_factor is 1 for most cases.
pc58_peatland_man(j,"degrad",land58) = pcm_land(j,land58) * p58_scaling_factor(j) * p58_calib_factor(j,land58);
* The residual is added to an "unused" category, which represents degraded but unused peatland.
pc58_peatland_man(j,"unused",land58) = f58_peatland_degrad(j) * p58_peatland_degrad_weight(j,land58) - pc58_peatland_man(j,"degrad",land58);
pc58_peatland_man(j,"unused",land58)$(pc58_peatland_man(j,"unused",land58) < 0) = 0;
p58_peatland_degrad(j) = sum((man58,land58), pc58_peatland_man(j,man58,land58));
