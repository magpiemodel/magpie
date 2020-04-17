*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


pc58_peatland_intact(j) = f58_peatland_intact(j);	
p58_peatland_area(j) = f58_peatland_degrad(j) + f58_peatland_intact(j);
p58_land_area(j) = sum(land, pcm_land(j,land));
p58_scaling_factor(j) = p58_peatland_area(j)/p58_land_area(j);
	
*' Initialization of peatland
*' First, all degraded peatland is assigned to cropland. However, if the degraded peatland 
*' is larger than the actual cropland multiplied by a scaling factor (see below), 
*' degraded peatland used as cropland is reduced accordingly. In each cell, 
*' we scale the actual cropland with the ratio of total peatland area and total land area 
*' (factor between 0 and 1) because we use this scaling factor for modeling future 
*' peatland dynamics based on agricultural land use (see equations). Accounting for 
*' this scaling factor in the initial distribution of degraded peatland to cropland 
*' makes sure that a full reduction of cropland would also reduce degraded peatland 
*' used as cropland to zero in a given cell, which is of particular importance 
*' for the peatland restoration scenarios. After this first step, the remaining degraded 
*' peatland (if any exists) is assigned to pasture with the same rules, i.e. 
*' assignment to pasture is constrained by the scaled actual pasture area. In a third 
*' step, all remaining degraded peatland is assigned to forestry with these rules. 
*' Finally, any remaining degraded peatland in a cell after these 3 steps is 
*' added to the degraded peatland category with equal distribution among 
*' cropland, pasture and forestry (land-use categories are important for the 
*' application of the wetland GHG emission factors). In total, we therefore have 
*' 3 peatland categories: intact, degraded and restored. And for degraded and restored
*' we know the current/previous land use: cropland, pasture and forestry.
pc58_peatland_man(j,man58,land58) = 0;
p58_peatland_degrad_left(j) = f58_peatland_degrad(j);
*First step: cropland
pc58_peatland_man(j,"degrad","crop") = min(p58_peatland_degrad_left(j),pcm_land(j,"crop")*p58_scaling_factor(j));
p58_peatland_degrad_left(j) = p58_peatland_degrad_left(j)-pc58_peatland_man(j,"degrad","crop");
*Second step: pasture
pc58_peatland_man(j,"degrad","past") = min(p58_peatland_degrad_left(j),pcm_land(j,"past")*p58_scaling_factor(j));
p58_peatland_degrad_left(j) = p58_peatland_degrad_left(j)-pc58_peatland_man(j,"degrad","past");
*Third step: forestry
*pc58_peatland_man(j,"degrad","forestry") = min(p58_peatland_degrad_left(j),pcm_land(j,"forestry")*p58_scaling_factor(j));
*p58_peatland_degrad_left(j) = p58_peatland_degrad_left(j)-pc58_peatland_man(j,"degrad","forestry");
*Finally, the remaining undistributed degraded peatland is equally distributed among crop, past and forestry.
pc58_peatland_man(j,"degrad",land58) = pc58_peatland_man(j,"degrad",land58) + p58_peatland_degrad_left(j)/card(land58);



p58_mapping_cell_climate(j,climate58) = sum(clcl_climate58(clcl,climate58),pm_climate_class(j,clcl));

p58_ipcc_wetland_ef(climate58,land58,emis58,man58) = f58_ipcc_wetland_ef(climate58,land58,emis58,man58);
p58_ipcc_wetland_ef(climate58,land58,"ch4",man58) = p58_ipcc_wetland_ef(climate58,land58,"ch4",man58)/34*28;
p58_ipcc_wetland_ef(climate58,land58,"n2o",man58) = p58_ipcc_wetland_ef(climate58,land58,"n2o",man58)/298*265;

p58_peatland_cost_past(t,j) = 0;
