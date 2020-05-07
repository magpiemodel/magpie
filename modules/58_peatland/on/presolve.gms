*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

p58_peatland_area(j) = sum((man58,land58), pc58_peatland_man(j,man58,land58)) + pc58_peatland_intact(j);
p58_land_area(j) = sum(land, pcm_land(j,land));

if(m_year(t) < 2015,
	v58_peatland_man.fx(j,man58,land58) = 0;
	v58_peatland_intact.fx(j) = 0;
	v58_lu_transitions.fx(j2,from58,to58)$(not sameas(from58,to58)) = 0;
else
	if(sum(j, p58_peatland_area(j)) = 0,
*' @code
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
*' 3 peatland categories: intact, degraded and unused. And for degraded and unused
*' we know the current/previous land use: cropland, pasture and forestry.
*' @stop
	pc58_peatland_intact(j) = f58_peatland_intact(j);
	p58_peatland_area(j) = f58_peatland_degrad(j) + f58_peatland_intact(j);
	p58_scaling_factor(j) = p58_peatland_area(j)/p58_land_area(j);
	p58_peatland_degrad_unused(j) = f58_peatland_degrad(j);
*First step: cropland
	pc58_peatland_man(j,"degrad","crop") = min(p58_peatland_degrad_unused(j),pcm_land(j,"crop")*p58_scaling_factor(j));
	p58_peatland_degrad_unused(j) = p58_peatland_degrad_unused(j)-pc58_peatland_man(j,"degrad","crop");
*Second step: pasture
	pc58_peatland_man(j,"degrad","past") = min(p58_peatland_degrad_unused(j),pcm_land(j,"past")*p58_scaling_factor(j));
	p58_peatland_degrad_unused(j) = p58_peatland_degrad_unused(j)-pc58_peatland_man(j,"degrad","past");
*Third step: forestry
	pc58_peatland_man(j,"degrad","forestry") = min(p58_peatland_degrad_unused(j),pcm_land(j,"forestry")*p58_scaling_factor(j));
	p58_peatland_degrad_unused(j) = p58_peatland_degrad_unused(j)-pc58_peatland_man(j,"degrad","forestry");
*Finally, the remaining undistributed degraded peatland is distributed among crop, past and forestry.
	p58_peatland_degrad_used(j) = sum(land58, pc58_peatland_man(j,"degrad",land58));
	p58_peatland_degrad_unused_weight(j,land58) = 1/card(land58);
	p58_peatland_degrad_unused_weight(j,land58)$(p58_peatland_degrad_used(j) > 0) = pc58_peatland_man(j,"degrad",land58)/p58_peatland_degrad_used(j);
	pc58_peatland_man(j,"unused",land58) = p58_peatland_degrad_unused(j)*p58_peatland_degrad_unused_weight(j,land58);
	p58_peatland_degrad_unused(j) = p58_peatland_degrad_unused(j)-sum(land58, pc58_peatland_man(j,"unused",land58));

	v58_peatland_man.fx(j,man58,land58) = pc58_peatland_man(j,man58,land58);
	v58_peatland_intact.fx(j) = pc58_peatland_intact(j);
	v58_lu_transitions.fx(j2,from58,to58)$(not sameas(from58,to58)) = 0;

	else	
	p58_scaling_factor(j) = p58_peatland_area(j)/p58_land_area(j);
*define bound for peatland area after 2015
	v58_peatland_man.lo(j,man58,land58) = 0;
	v58_peatland_man.up(j,"degrad",land58) = Inf;
	v58_peatland_man.up(j,"unused",land58) = Inf;
	v58_peatland_man.up(j,"rewet",land58) = s58_rewetting_switch;
	v58_peatland_man.l(j,man58,land58) = pc58_peatland_man(j,man58,land58);
	v58_peatland_intact.lo(j) = 0;
	v58_peatland_intact.up(j) = pc58_peatland_intact(j);
	v58_peatland_intact.l(j) = pc58_peatland_intact(j);

*define allowed transitions within peatland area	
	v58_lu_transitions.fx(j2,from58,to58)$(not sameas(from58,to58)) = 0;
	v58_lu_transitions.up(j2,"intact","degrad_crop") = Inf;
	v58_lu_transitions.up(j2,"intact","degrad_past") = Inf;
	v58_lu_transitions.up(j2,"intact","degrad_forestry") = Inf;
	v58_lu_transitions.up(j2,"degrad_crop","unused_crop") = Inf;
	v58_lu_transitions.up(j2,"degrad_past","unused_past") = Inf;
	v58_lu_transitions.up(j2,"degrad_forestry","unused_forestry") = Inf;
	v58_lu_transitions.up(j2,"degrad_crop","rewet_crop") = Inf;
	v58_lu_transitions.up(j2,"degrad_past","rewet_past") = Inf;
	v58_lu_transitions.up(j2,"degrad_forestry","rewet_forestry") = Inf;
	v58_lu_transitions.up(j2,"unused_crop","degrad_crop") = Inf;
	v58_lu_transitions.up(j2,"unused_past","degrad_past") = Inf;
	v58_lu_transitions.up(j2,"unused_forestry","degrad_forestry") = Inf;
	v58_lu_transitions.up(j2,"unused_crop","rewet_crop") = Inf;
	v58_lu_transitions.up(j2,"unused_past","rewet_past") = Inf;
	v58_lu_transitions.up(j2,"unused_forestry","rewet_forestry") = Inf;
	);
);

pc58_peatland_cost_past(j) = p58_peatland_cost_past(t,j);
