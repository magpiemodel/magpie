*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*define bound for peatland area
	v58_peatland_man.lo(j,man58,land58) = 0;
	v58_peatland_man.up(j,"degrad",land58) = Inf;
	v58_peatland_man.up(j,"unused",land58) = Inf;
	v58_peatland_man.l(j,man58,land58) = pc58_peatland_man(j,man58,land58);
	v58_peatland_intact.lo(j) = 0;
	v58_peatland_intact.up(j) = pc58_peatland_intact(j);
	v58_peatland_intact.l(j) = pc58_peatland_intact(j);

*define allowed transitions within peatland area	
	v58_lu_transitions.fx(j,from58,to58)$(not sameas(from58,to58)) = 0;
	v58_lu_transitions.up(j,"intact","degrad_crop") = Inf;
	v58_lu_transitions.up(j,"intact","degrad_past") = Inf;
	v58_lu_transitions.up(j,"intact","degrad_forestry") = Inf;
	v58_lu_transitions.up(j,"degrad_crop","unused_crop") = Inf;
	v58_lu_transitions.up(j,"degrad_past","unused_past") = Inf;
	v58_lu_transitions.up(j,"degrad_forestry","unused_forestry") = Inf;
	v58_lu_transitions.up(j,"degrad_crop","rewet_crop") = Inf;
	v58_lu_transitions.up(j,"degrad_past","rewet_past") = Inf;
	v58_lu_transitions.up(j,"degrad_forestry","rewet_forestry") = Inf;
	v58_lu_transitions.up(j,"unused_crop","degrad_crop") = Inf;
	v58_lu_transitions.up(j,"unused_past","degrad_past") = Inf;
	v58_lu_transitions.up(j,"unused_forestry","degrad_forestry") = Inf;
	v58_lu_transitions.up(j,"unused_crop","rewet_crop") = Inf;
	v58_lu_transitions.up(j,"unused_past","rewet_past") = Inf;
	v58_lu_transitions.up(j,"unused_forestry","rewet_forestry") = Inf;
	v58_lu_transitions.up(j,"rewet_crop","degrad_crop") = Inf;
	v58_lu_transitions.up(j,"rewet_past","degrad_past") = Inf;
	v58_lu_transitions.up(j,"rewet_forestry","degrad_forestry") = Inf;

if (m_year(t) <= sm_fix_SSP2,
	v58_peatland_man.up(j,"rewet",land58) = 0;
else
	v58_peatland_man.up(j,"rewet",land58) = s58_rewetting_switch;
);
