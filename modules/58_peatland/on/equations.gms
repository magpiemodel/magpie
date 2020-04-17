*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


 q58_transition_matrix(j2) ..
	sum((from58,to58), v58_lu_transitions(j2,from58,to58)) =e= 
	sum((man58,land58), pc58_peatland_man(j2,man58,land58)) + pc58_peatland_intact(j2);

 q58_transition_to(j2,to58) ..
	sum(from58, v58_lu_transitions(j2,from58,to58)) =e= 
	v58_peatland_man(j2,"degrad","crop")$(sameas(to58,"degrad_crop"))
	+ v58_peatland_man(j2,"degrad","past")$(sameas(to58,"degrad_past"))
*	+ v58_peatland_man(j2,"degrad","forestry")$(sameas(to58,"degrad_forestry"))
	+ v58_peatland_man(j2,"rewet","crop")$(sameas(to58,"rewet_crop"))
	+ v58_peatland_man(j2,"rewet","past")$(sameas(to58,"rewet_past"))
*	+ v58_peatland_man(j2,"rewet","forestry")$(sameas(to58,"rewet_forestry"))
	+ v58_peatland_intact(j2)$(sameas(to58,"intact"));

 q58_transition_from(j2,from58) ..
	sum(to58, v58_lu_transitions(j2,from58,to58)) =e= 
	pc58_peatland_man(j2,"degrad","crop")$(sameas(from58,"degrad_crop"))
	+ pc58_peatland_man(j2,"degrad","past")$(sameas(from58,"degrad_past"))
*	+ pc58_peatland_man(j2,"degrad","forestry")$(sameas(from58,"degrad_forestry"))
	+ pc58_peatland_man(j2,"rewet","crop")$(sameas(from58,"rewet_crop"))
	+ pc58_peatland_man(j2,"rewet","past")$(sameas(from58,"rewet_past"))
*	+ pc58_peatland_man(j2,"rewet","forestry")$(sameas(from58,"rewet_forestry"))
	+ pc58_peatland_intact(j2)$(sameas(from58,"intact"));


*' The following two equations calculate land expansion and land contraction based
*' on the above land transition matrix.

 q58_expansion(j2,to58) ..
        v58_expansion(j2,to58) =e= 
        sum(from58$(not sameas(from58,to58)), 
        v58_lu_transitions(j2,from58,to58));

 q58_reduction(j2,from58) ..
        v58_reduction(j2,from58) =e= 
        sum(to58$(not sameas(from58,to58)), 
        v58_lu_transitions(j2,from58,to58));

*' Future peatland degradation (v58_peatland_man) depends on changes of managed land, 
*' scaled with  the ratio of total peatland area and total land area (p58_scaling_factor).
*' By multiplying changes in managed land with this scaling factor we implicitly assume 
*' that intact peatlands are distributed equally within a grid cell. 
*' The following example illustrates the mechanism used for projecting peatland dynamics: 
*' In a given grid cell, the total land area is 50 Mha and the total peatland area is 10 Mha. 
*' Therefore, the scaling factor is 0.2 (10 Mha divided by 50 Mha). 
*' If cropland expands by 5 Mha, 1 Mha of intact peatland is converted to degraded peatland (5 Mha*0.2). 
*' If the total cell would become cropland, degraded peatland would equal to the total peatland area (50 Mha * 0.2 = 10 Mha). 

 q58_peatland_degrad(j2,land58) ..
	v58_peatland_man(j2,"degrad",land58) =g=
    pc58_peatland_man(j2,"degrad",land58)$(sum(ct, m_year(ct))<=2015)
	+ (vm_land(j2,land58)*p58_scaling_factor(j2))$(sum(ct, m_year(ct))>2015);

*' Either conversion of intact to degraded peatland OR conversion of degraded to rewetted peatland.
*' This constraint avoid the conversion of intact peatland into rewetted peatland.

 q58_peatland_intact(j2) ..
	sum(stat_degrad58, v58_lu_transitions(j2,"intact",stat_degrad58)) * 
	sum((stat_degrad_from58,stat_rewet58), v58_lu_transitions(j2,stat_degrad_from58,stat_rewet58))
	=e= 
	0;

*' Small costs of 1 $ per ha on gross land-use change avoid unrealistic patterns in the land transition matrix

 q58_peatland_cost(j2) ..
	vm_peatland_cost(j2) =e= v58_peatland_cost_annuity(j2) + pc58_peatland_cost_past(j2)
							+ sum(land58, v58_peatland_man(j2,"rewet",land58) * s58_rewet_cost_recur)
							+ sum(land58, v58_peatland_man(j2,"degrad",land58) * s58_degrad_cost_recur)
							+ sum(stat58, v58_expansion(j2,stat58) + v58_reduction(j2,stat58)) * 1;
	
 q58_peatland_cost_annuity(j2) ..
	v58_peatland_cost_annuity(j2) =g=
    (sum((from58,stat_rewet58), v58_lu_transitions(j2,from58,stat_rewet58) * s58_rewet_cost_onetime) +
    sum(stat_degrad58, v58_lu_transitions(j2,"intact",stat_degrad58) * s58_degrad_cost_onetime))
	* sum(cell(i2,j2),pm_interest(i2)/(1+pm_interest(i2)));

 q58_peatland_emis_detail(j2,emis58) ..
	v58_peatland_emis(j2,emis58) =e=
	sum((man58,land58), v58_peatland_man(j2,man58,land58) * 
	sum(climate58, p58_mapping_cell_climate(j2,climate58) * p58_ipcc_wetland_ef(climate58,land58,emis58,man58)));

 q58_peatland_emis(j2) ..
	vm_peatland_emis(j2) =e=
	sum(emis58, v58_peatland_emis(j2,emis58));
