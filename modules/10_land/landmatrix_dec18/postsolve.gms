*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*** Land Patterns are transferred to next timestep
pcm_land(j,land) = vm_land.l(j,land);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_landdiff(t,"marginal")                           = vm_landdiff.m;
 ov_land(t,j,land,"marginal")                        = vm_land.m(j,land);
 ov_landexpansion(t,j,land,"marginal")               = vm_landexpansion.m(j,land);
 ov_landreduction(t,j,land,"marginal")               = vm_landreduction.m(j,land);
 ov_cost_land_transition(t,j,"marginal")             = vm_cost_land_transition.m(j);
 ov_lu_transitions(t,j,land_from,land_to,"marginal") = vm_lu_transitions.m(j,land_from,land_to);
 ov10_balance_positive(t,j,"marginal")               = v10_balance_positive.m(j);
 ov10_balance_negative(t,j,"marginal")               = v10_balance_negative.m(j);
 oq10_transition_matrix(t,j,"marginal")              = q10_transition_matrix.m(j);
 oq10_transition_to(t,j,land_to,"marginal")          = q10_transition_to.m(j,land_to);
 oq10_transition_from(t,j,land_from,"marginal")      = q10_transition_from.m(j,land_from);
 oq10_landexpansion(t,j,land_to,"marginal")          = q10_landexpansion.m(j,land_to);
 oq10_landreduction(t,j,land_from,"marginal")        = q10_landreduction.m(j,land_from);
 oq10_cost(t,j,"marginal")                           = q10_cost.m(j);
 oq10_landdiff(t,"marginal")                         = q10_landdiff.m;
 ov_landdiff(t,"level")                              = vm_landdiff.l;
 ov_land(t,j,land,"level")                           = vm_land.l(j,land);
 ov_landexpansion(t,j,land,"level")                  = vm_landexpansion.l(j,land);
 ov_landreduction(t,j,land,"level")                  = vm_landreduction.l(j,land);
 ov_cost_land_transition(t,j,"level")                = vm_cost_land_transition.l(j);
 ov_lu_transitions(t,j,land_from,land_to,"level")    = vm_lu_transitions.l(j,land_from,land_to);
 ov10_balance_positive(t,j,"level")                  = v10_balance_positive.l(j);
 ov10_balance_negative(t,j,"level")                  = v10_balance_negative.l(j);
 oq10_transition_matrix(t,j,"level")                 = q10_transition_matrix.l(j);
 oq10_transition_to(t,j,land_to,"level")             = q10_transition_to.l(j,land_to);
 oq10_transition_from(t,j,land_from,"level")         = q10_transition_from.l(j,land_from);
 oq10_landexpansion(t,j,land_to,"level")             = q10_landexpansion.l(j,land_to);
 oq10_landreduction(t,j,land_from,"level")           = q10_landreduction.l(j,land_from);
 oq10_cost(t,j,"level")                              = q10_cost.l(j);
 oq10_landdiff(t,"level")                            = q10_landdiff.l;
 ov_landdiff(t,"upper")                              = vm_landdiff.up;
 ov_land(t,j,land,"upper")                           = vm_land.up(j,land);
 ov_landexpansion(t,j,land,"upper")                  = vm_landexpansion.up(j,land);
 ov_landreduction(t,j,land,"upper")                  = vm_landreduction.up(j,land);
 ov_cost_land_transition(t,j,"upper")                = vm_cost_land_transition.up(j);
 ov_lu_transitions(t,j,land_from,land_to,"upper")    = vm_lu_transitions.up(j,land_from,land_to);
 ov10_balance_positive(t,j,"upper")                  = v10_balance_positive.up(j);
 ov10_balance_negative(t,j,"upper")                  = v10_balance_negative.up(j);
 oq10_transition_matrix(t,j,"upper")                 = q10_transition_matrix.up(j);
 oq10_transition_to(t,j,land_to,"upper")             = q10_transition_to.up(j,land_to);
 oq10_transition_from(t,j,land_from,"upper")         = q10_transition_from.up(j,land_from);
 oq10_landexpansion(t,j,land_to,"upper")             = q10_landexpansion.up(j,land_to);
 oq10_landreduction(t,j,land_from,"upper")           = q10_landreduction.up(j,land_from);
 oq10_cost(t,j,"upper")                              = q10_cost.up(j);
 oq10_landdiff(t,"upper")                            = q10_landdiff.up;
 ov_landdiff(t,"lower")                              = vm_landdiff.lo;
 ov_land(t,j,land,"lower")                           = vm_land.lo(j,land);
 ov_landexpansion(t,j,land,"lower")                  = vm_landexpansion.lo(j,land);
 ov_landreduction(t,j,land,"lower")                  = vm_landreduction.lo(j,land);
 ov_cost_land_transition(t,j,"lower")                = vm_cost_land_transition.lo(j);
 ov_lu_transitions(t,j,land_from,land_to,"lower")    = vm_lu_transitions.lo(j,land_from,land_to);
 ov10_balance_positive(t,j,"lower")                  = v10_balance_positive.lo(j);
 ov10_balance_negative(t,j,"lower")                  = v10_balance_negative.lo(j);
 oq10_transition_matrix(t,j,"lower")                 = q10_transition_matrix.lo(j);
 oq10_transition_to(t,j,land_to,"lower")             = q10_transition_to.lo(j,land_to);
 oq10_transition_from(t,j,land_from,"lower")         = q10_transition_from.lo(j,land_from);
 oq10_landexpansion(t,j,land_to,"lower")             = q10_landexpansion.lo(j,land_to);
 oq10_landreduction(t,j,land_from,"lower")           = q10_landreduction.lo(j,land_from);
 oq10_cost(t,j,"lower")                              = q10_cost.lo(j);
 oq10_landdiff(t,"lower")                            = q10_landdiff.lo;
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
