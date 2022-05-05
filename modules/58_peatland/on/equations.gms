*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Land transition matrix for peatland area. 
*' The sum of current peatland area defined in `v58_lu_transitions` has to equal the sum of 
*' peatland area in the previous time step (`pc58_peatland_man` + `pc58_peatland_intact`).
*' The two balancing variables `v58_balance_positive` and `v58_balance_negative` are needed 
*' to avoid technical infeasibilities due to small differences in accuracy between 
*' variables and parameters in GAMS. The use of `v58_balance_positive` and 
*' `v58_balance_negative` is minimized by putting a high cost factor on these variables 
*' (`q58_peatland_cost_full`). In practice, `v58_balance_positive` and 
*' `v58_balance_negative`should deviate from zero only in exceptional cases. 
 
 q58_transition_matrix(j2) ..
	sum((from58,to58), v58_lu_transitions(j2,from58,to58)) 
	+ v58_balance_positive(j2) - v58_balance_negative(j2) =e=
	sum((man58,land58), pc58_peatland_man(j2,man58,land58)) + pc58_peatland_intact(j2);

 q58_transition_to(j2,to58) ..
	sum(from58, v58_lu_transitions(j2,from58,to58)) =e=
	v58_peatland_man(j2,"degrad","crop")$(sameas(to58,"degrad_crop"))
	+ v58_peatland_man(j2,"degrad","past")$(sameas(to58,"degrad_past"))
	+ v58_peatland_man(j2,"degrad","forestry")$(sameas(to58,"degrad_forestry"))
	+ v58_peatland_man(j2,"unused","crop")$(sameas(to58,"unused_crop"))
	+ v58_peatland_man(j2,"unused","past")$(sameas(to58,"unused_past"))
	+ v58_peatland_man(j2,"unused","forestry")$(sameas(to58,"unused_forestry"))
	+ v58_peatland_man(j2,"rewet","crop")$(sameas(to58,"rewet_crop"))
	+ v58_peatland_man(j2,"rewet","past")$(sameas(to58,"rewet_past"))
	+ v58_peatland_man(j2,"rewet","forestry")$(sameas(to58,"rewet_forestry"))
	+ v58_peatland_intact(j2)$(sameas(to58,"intact"));

 q58_transition_from(j2,from58) ..
	sum(to58, v58_lu_transitions(j2,from58,to58)) =e=
	pc58_peatland_man(j2,"degrad","crop")$(sameas(from58,"degrad_crop"))
	+ pc58_peatland_man(j2,"degrad","past")$(sameas(from58,"degrad_past"))
	+ pc58_peatland_man(j2,"degrad","forestry")$(sameas(from58,"degrad_forestry"))
	+ pc58_peatland_man(j2,"unused","crop")$(sameas(from58,"unused_crop"))
	+ pc58_peatland_man(j2,"unused","past")$(sameas(from58,"unused_past"))
	+ pc58_peatland_man(j2,"unused","forestry")$(sameas(from58,"unused_forestry"))
	+ pc58_peatland_man(j2,"rewet","crop")$(sameas(from58,"rewet_crop"))
	+ pc58_peatland_man(j2,"rewet","past")$(sameas(from58,"rewet_past"))
	+ pc58_peatland_man(j2,"rewet","forestry")$(sameas(from58,"rewet_forestry"))
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

*' Future peatland degradation (`v58_peatland_man`) depends on managed land (`vm_land`),
*' scaled with the ratio of total peatland area and total land area (`p58_scaling_factor`) 
*' and a calibration factor (`p58_calib_factor`) for alignment with historic levels of degraded peatland.
*' By multiplying changes in managed land (`vm_land`) with the scaling factor we implicitly assume
*' that intact peatlands are distributed equally within a grid cell.
*' The following example illustrates the mechanism used for projecting peatland dynamics:
*' In a given grid cell, the total land area is 50 Mha and the total peatland area is 10 Mha.
*' Therefore, the scaling factor is 0.2 (10 Mha divided by 50 Mha).
*' If cropland expands by 5 Mha, 1 Mha of intact peatland is converted to degraded peatland (5 Mha*0.2).
*' If the total cell would become cropland, degraded peatland would equal to the total peatland area (50 Mha * 0.2 = 10 Mha).

 q58_peatland_degrad(j2,land58)$(sum(ct, m_year(ct)) > s58_fix_peatland) ..
	v58_peatland_man(j2,"degrad",land58) =e=
	 vm_land(j2,land58)*p58_scaling_factor(j2)*p58_calib_factor(j2,land58);

*' This constraint avoids the conversion of intact peatland into rewetted peatland.

 q58_peatland_rewet(j2) ..
 sum(stat_rewet58, v58_expansion(j2,stat_rewet58)) =l= 
 	sum(stat_degrad58, v58_reduction(j2,stat_degrad58) + v58_expansion(j2,stat_degrad58)) - v58_reduction(j2,"intact");

*' Costs for peatland degradation and rewetting

 q58_peatland_cost_full(j2) ..
	vm_peatland_cost(j2) =e= v58_peatland_cost(j2) + (v58_balance_positive(j2) + v58_balance_negative(j2)) * s58_cost_balance;

 q58_peatland_cost(j2) ..
	v58_peatland_cost(j2) =e= v58_peatland_cost_annuity(j2) 
							+ sum(land58, v58_peatland_man(j2,"rewet",land58)) * sum(ct, i58_cost_rewet_recur(ct))
							+ sum((degrad58,land58), v58_peatland_man(j2,degrad58,land58)) * sum(ct, i58_cost_degrad_recur(ct));
							
 q58_peatland_cost_annuity(j2) ..
	v58_peatland_cost_annuity(j2) =e=
    (sum(stat_rewet58, v58_expansion(j2,stat_rewet58)) * sum(ct, i58_cost_rewet_onetime(ct))
    + (v58_reduction(j2,"intact") + sum(stat_rewet58, v58_reduction(j2,stat_rewet58))) * sum(ct, i58_cost_degrad_onetime(ct)))
	* sum((cell(i2,j2),ct),pm_interest(ct,i2)/(1+pm_interest(ct,i2)));

*' GHG emissions from managed peatlands (degraded and rewetted)

 q58_peatland_emis_detail(j2,emis58) ..
	v58_peatland_emis(j2,emis58) =e=
	sum((man58,land58,clcl58), v58_peatland_man(j2,man58,land58) *
	p58_mapping_cell_climate(j2,clcl58) * p58_ipcc_wetland_ef(clcl58,land58,emis58,man58));

*' Conversion from CO2 equivalent to element unit for interface `vm_btm_cell` using GWP100 conversion factors from AR5 (same as in @wilson_2016).

 q58_peatland_emis(i2,poll58) ..
	vm_btm_reg(i2,"peatland",poll58) =e= 
	sum((cell(i2,j2),emisSub58_to_poll58(emisSub58,poll58)),
		v58_peatland_emis(j2,emisSub58) * p58_conversion_factor(emisSub58));
	