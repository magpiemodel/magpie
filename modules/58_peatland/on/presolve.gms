*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*Update p58_scaling_factor. Needed because of tiny differences between input files and variables
p58_peatland_area(j) = sum((man58,land58), pc58_peatland_man(j,man58,land58)) + pc58_peatland_intact(j);
p58_land_area(j) = sum(land, pcm_land(j,land));
p58_scaling_factor(j) = p58_peatland_area(j)/p58_land_area(j);

if(m_year(t) <= 2015,
	v58_peatland_man.fx(j,man58,land58) = pc58_peatland_man(j,man58,land58);
	v58_peatland_intact.fx(j) = pc58_peatland_intact(j);
	v58_lu_transitions.fx(j2,from58,to58)$(not sameas(from58,to58)) = 0;
else
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
	v58_lu_transitions.up(j2,"unused_crop","rewet_crop") = Inf;
	v58_lu_transitions.up(j2,"unused_past","rewet_past") = Inf;
	v58_lu_transitions.up(j2,"unused_forestry","rewet_forestry") = Inf;
	v58_lu_transitions.up(j2,"unused_crop","degrad_crop") = Inf;
	v58_lu_transitions.up(j2,"unused_past","degrad_past") = Inf;
	v58_lu_transitions.up(j2,"unused_forestry","degrad_forestry") = Inf;
);

pc58_peatland_cost_past(j) = p58_peatland_cost_past(t,j);
