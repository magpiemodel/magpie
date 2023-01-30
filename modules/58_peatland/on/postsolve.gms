*** |  (C) 2008-2023 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Update of degraded peatland based on current managed land in the last time steps of fixed peatland area.  
if (m_year(t) = s58_fix_peatland,
	p58_scaling_factor(j) = (sum((man58,land58), v58_peatland_man.l(j,man58,land58)) + v58_peatland_intact.l(j)) / sum(land, vm_land.l(j,land));
	p58_calib_factor(j,land58) = 1;
	p58_calib_factor(j,land58)$(vm_land.l(j,land58) * p58_scaling_factor(j) > 0) = (p58_peatland_degrad(j) * p58_peatland_degrad_weight(j,land58)) / (vm_land.l(j,land58)*p58_scaling_factor(j));
	p58_calib_factor(j,land58)$(p58_calib_factor(j,land58) > 1) = 1;
	pc58_peatland_man(j,"degrad",land58) = vm_land.l(j,land58) * p58_scaling_factor(j) * p58_calib_factor(j,land58);
	pc58_peatland_man(j,"unused",land58) = p58_peatland_degrad(j) * p58_peatland_degrad_weight(j,land58) - pc58_peatland_man(j,"degrad",land58);
else
	pc58_peatland_man(j,man58,land58) = v58_peatland_man.l(j,man58,land58);
);

pc58_peatland_intact(j) = v58_peatland_intact.l(j);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_peatland_cost(t,j,"marginal")                 = vm_peatland_cost.m(j);
 ov58_peatland_cost(t,j,"marginal")               = v58_peatland_cost.m(j);
 ov58_peatland_cost_annuity(t,j,"marginal")       = v58_peatland_cost_annuity.m(j);
 ov58_peatland_emis(t,j,emis58,"marginal")        = v58_peatland_emis.m(j,emis58);
 ov58_lu_transitions(t,j,from58,to58,"marginal")  = v58_lu_transitions.m(j,from58,to58);
 ov58_expansion(t,j,stat58,"marginal")            = v58_expansion.m(j,stat58);
 ov58_reduction(t,j,stat58,"marginal")            = v58_reduction.m(j,stat58);
 ov58_peatland_man(t,j,man58,land58,"marginal")   = v58_peatland_man.m(j,man58,land58);
 ov58_peatland_intact(t,j,"marginal")             = v58_peatland_intact.m(j);
 ov58_balance_positive(t,j,"marginal")            = v58_balance_positive.m(j);
 ov58_balance_negative(t,j,"marginal")            = v58_balance_negative.m(j);
 oq58_transition_matrix(t,j,"marginal")           = q58_transition_matrix.m(j);
 oq58_transition_to(t,j,to58,"marginal")          = q58_transition_to.m(j,to58);
 oq58_transition_from(t,j,from58,"marginal")      = q58_transition_from.m(j,from58);
 oq58_expansion(t,j,to58,"marginal")              = q58_expansion.m(j,to58);
 oq58_reduction(t,j,from58,"marginal")            = q58_reduction.m(j,from58);
 oq58_peatland_degrad(t,j,land58,"marginal")      = q58_peatland_degrad.m(j,land58);
 oq58_peatland_rewet(t,j,"marginal")              = q58_peatland_rewet.m(j);
 oq58_peatland_cost_full(t,j,"marginal")          = q58_peatland_cost_full.m(j);
 oq58_peatland_cost(t,j,"marginal")               = q58_peatland_cost.m(j);
 oq58_peatland_cost_annuity(t,j,"marginal")       = q58_peatland_cost_annuity.m(j);
 oq58_peatland_emis_detail(t,j,emis58,"marginal") = q58_peatland_emis_detail.m(j,emis58);
 oq58_peatland_emis(t,i,poll58,"marginal")        = q58_peatland_emis.m(i,poll58);
 ov_peatland_cost(t,j,"level")                    = vm_peatland_cost.l(j);
 ov58_peatland_cost(t,j,"level")                  = v58_peatland_cost.l(j);
 ov58_peatland_cost_annuity(t,j,"level")          = v58_peatland_cost_annuity.l(j);
 ov58_peatland_emis(t,j,emis58,"level")           = v58_peatland_emis.l(j,emis58);
 ov58_lu_transitions(t,j,from58,to58,"level")     = v58_lu_transitions.l(j,from58,to58);
 ov58_expansion(t,j,stat58,"level")               = v58_expansion.l(j,stat58);
 ov58_reduction(t,j,stat58,"level")               = v58_reduction.l(j,stat58);
 ov58_peatland_man(t,j,man58,land58,"level")      = v58_peatland_man.l(j,man58,land58);
 ov58_peatland_intact(t,j,"level")                = v58_peatland_intact.l(j);
 ov58_balance_positive(t,j,"level")               = v58_balance_positive.l(j);
 ov58_balance_negative(t,j,"level")               = v58_balance_negative.l(j);
 oq58_transition_matrix(t,j,"level")              = q58_transition_matrix.l(j);
 oq58_transition_to(t,j,to58,"level")             = q58_transition_to.l(j,to58);
 oq58_transition_from(t,j,from58,"level")         = q58_transition_from.l(j,from58);
 oq58_expansion(t,j,to58,"level")                 = q58_expansion.l(j,to58);
 oq58_reduction(t,j,from58,"level")               = q58_reduction.l(j,from58);
 oq58_peatland_degrad(t,j,land58,"level")         = q58_peatland_degrad.l(j,land58);
 oq58_peatland_rewet(t,j,"level")                 = q58_peatland_rewet.l(j);
 oq58_peatland_cost_full(t,j,"level")             = q58_peatland_cost_full.l(j);
 oq58_peatland_cost(t,j,"level")                  = q58_peatland_cost.l(j);
 oq58_peatland_cost_annuity(t,j,"level")          = q58_peatland_cost_annuity.l(j);
 oq58_peatland_emis_detail(t,j,emis58,"level")    = q58_peatland_emis_detail.l(j,emis58);
 oq58_peatland_emis(t,i,poll58,"level")           = q58_peatland_emis.l(i,poll58);
 ov_peatland_cost(t,j,"upper")                    = vm_peatland_cost.up(j);
 ov58_peatland_cost(t,j,"upper")                  = v58_peatland_cost.up(j);
 ov58_peatland_cost_annuity(t,j,"upper")          = v58_peatland_cost_annuity.up(j);
 ov58_peatland_emis(t,j,emis58,"upper")           = v58_peatland_emis.up(j,emis58);
 ov58_lu_transitions(t,j,from58,to58,"upper")     = v58_lu_transitions.up(j,from58,to58);
 ov58_expansion(t,j,stat58,"upper")               = v58_expansion.up(j,stat58);
 ov58_reduction(t,j,stat58,"upper")               = v58_reduction.up(j,stat58);
 ov58_peatland_man(t,j,man58,land58,"upper")      = v58_peatland_man.up(j,man58,land58);
 ov58_peatland_intact(t,j,"upper")                = v58_peatland_intact.up(j);
 ov58_balance_positive(t,j,"upper")               = v58_balance_positive.up(j);
 ov58_balance_negative(t,j,"upper")               = v58_balance_negative.up(j);
 oq58_transition_matrix(t,j,"upper")              = q58_transition_matrix.up(j);
 oq58_transition_to(t,j,to58,"upper")             = q58_transition_to.up(j,to58);
 oq58_transition_from(t,j,from58,"upper")         = q58_transition_from.up(j,from58);
 oq58_expansion(t,j,to58,"upper")                 = q58_expansion.up(j,to58);
 oq58_reduction(t,j,from58,"upper")               = q58_reduction.up(j,from58);
 oq58_peatland_degrad(t,j,land58,"upper")         = q58_peatland_degrad.up(j,land58);
 oq58_peatland_rewet(t,j,"upper")                 = q58_peatland_rewet.up(j);
 oq58_peatland_cost_full(t,j,"upper")             = q58_peatland_cost_full.up(j);
 oq58_peatland_cost(t,j,"upper")                  = q58_peatland_cost.up(j);
 oq58_peatland_cost_annuity(t,j,"upper")          = q58_peatland_cost_annuity.up(j);
 oq58_peatland_emis_detail(t,j,emis58,"upper")    = q58_peatland_emis_detail.up(j,emis58);
 oq58_peatland_emis(t,i,poll58,"upper")           = q58_peatland_emis.up(i,poll58);
 ov_peatland_cost(t,j,"lower")                    = vm_peatland_cost.lo(j);
 ov58_peatland_cost(t,j,"lower")                  = v58_peatland_cost.lo(j);
 ov58_peatland_cost_annuity(t,j,"lower")          = v58_peatland_cost_annuity.lo(j);
 ov58_peatland_emis(t,j,emis58,"lower")           = v58_peatland_emis.lo(j,emis58);
 ov58_lu_transitions(t,j,from58,to58,"lower")     = v58_lu_transitions.lo(j,from58,to58);
 ov58_expansion(t,j,stat58,"lower")               = v58_expansion.lo(j,stat58);
 ov58_reduction(t,j,stat58,"lower")               = v58_reduction.lo(j,stat58);
 ov58_peatland_man(t,j,man58,land58,"lower")      = v58_peatland_man.lo(j,man58,land58);
 ov58_peatland_intact(t,j,"lower")                = v58_peatland_intact.lo(j);
 ov58_balance_positive(t,j,"lower")               = v58_balance_positive.lo(j);
 ov58_balance_negative(t,j,"lower")               = v58_balance_negative.lo(j);
 oq58_transition_matrix(t,j,"lower")              = q58_transition_matrix.lo(j);
 oq58_transition_to(t,j,to58,"lower")             = q58_transition_to.lo(j,to58);
 oq58_transition_from(t,j,from58,"lower")         = q58_transition_from.lo(j,from58);
 oq58_expansion(t,j,to58,"lower")                 = q58_expansion.lo(j,to58);
 oq58_reduction(t,j,from58,"lower")               = q58_reduction.lo(j,from58);
 oq58_peatland_degrad(t,j,land58,"lower")         = q58_peatland_degrad.lo(j,land58);
 oq58_peatland_rewet(t,j,"lower")                 = q58_peatland_rewet.lo(j);
 oq58_peatland_cost_full(t,j,"lower")             = q58_peatland_cost_full.lo(j);
 oq58_peatland_cost(t,j,"lower")                  = q58_peatland_cost.lo(j);
 oq58_peatland_cost_annuity(t,j,"lower")          = q58_peatland_cost_annuity.lo(j);
 oq58_peatland_emis_detail(t,j,emis58,"lower")    = q58_peatland_emis_detail.lo(j,emis58);
 oq58_peatland_emis(t,i,poll58,"lower")           = q58_peatland_emis.lo(i,poll58);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
