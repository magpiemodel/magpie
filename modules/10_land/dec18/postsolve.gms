*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*** Land Patterns are transferred to next timestep
pcm_land(j,land) = vm_land.l(j,land);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_landdiff(t,"marginal")                                 = vm_landdiff.m;
 ov_land(t,j,land,"marginal")                              = vm_land.m(j,land);
 ov_landexpansion(t,j,land,"marginal")                     = vm_landexpansion.m(j,land);
 ov10_landreduction(t,j,land,"marginal")                   = v10_landreduction.m(j,land);
 ov_croplandexpansion(t,j,land,"marginal")                 = vm_croplandexpansion.m(j,land);
 ov_croplandreduction(t,j,land,"marginal")                 = vm_croplandreduction.m(j,land);
 ov_cost_land_transition(t,j,"marginal")                   = vm_cost_land_transition.m(j);
 ov10_lu_transitions(t,j,land_from10,land_to10,"marginal") = v10_lu_transitions.m(j,land_from10,land_to10);
 oq10_land(t,j,"marginal")                                 = q10_land.m(j);
 oq10_transition_matrix(t,j,"marginal")                    = q10_transition_matrix.m(j);
 oq10_transition_to(t,j,land_to10,"marginal")              = q10_transition_to.m(j,land_to10);
 oq10_transition_from(t,j,land_from10,"marginal")          = q10_transition_from.m(j,land_from10);
 oq10_landexpansion(t,j,land_to10,"marginal")              = q10_landexpansion.m(j,land_to10);
 oq10_landreduction(t,j,land_from10,"marginal")            = q10_landreduction.m(j,land_from10);
 oq10_croplandreduction(t,j,land_to10,"marginal")          = q10_croplandreduction.m(j,land_to10);
 oq10_croplandexpansion(t,j,land_from10,"marginal")        = q10_croplandexpansion.m(j,land_from10);
 oq10_cost(t,j,"marginal")                                 = q10_cost.m(j);
 oq10_landdiff(t,"marginal")                               = q10_landdiff.m;
 ov_landdiff(t,"level")                                    = vm_landdiff.l;
 ov_land(t,j,land,"level")                                 = vm_land.l(j,land);
 ov_landexpansion(t,j,land,"level")                        = vm_landexpansion.l(j,land);
 ov10_landreduction(t,j,land,"level")                      = v10_landreduction.l(j,land);
 ov_croplandexpansion(t,j,land,"level")                    = vm_croplandexpansion.l(j,land);
 ov_croplandreduction(t,j,land,"level")                    = vm_croplandreduction.l(j,land);
 ov_cost_land_transition(t,j,"level")                      = vm_cost_land_transition.l(j);
 ov10_lu_transitions(t,j,land_from10,land_to10,"level")    = v10_lu_transitions.l(j,land_from10,land_to10);
 oq10_land(t,j,"level")                                    = q10_land.l(j);
 oq10_transition_matrix(t,j,"level")                       = q10_transition_matrix.l(j);
 oq10_transition_to(t,j,land_to10,"level")                 = q10_transition_to.l(j,land_to10);
 oq10_transition_from(t,j,land_from10,"level")             = q10_transition_from.l(j,land_from10);
 oq10_landexpansion(t,j,land_to10,"level")                 = q10_landexpansion.l(j,land_to10);
 oq10_landreduction(t,j,land_from10,"level")               = q10_landreduction.l(j,land_from10);
 oq10_croplandreduction(t,j,land_to10,"level")             = q10_croplandreduction.l(j,land_to10);
 oq10_croplandexpansion(t,j,land_from10,"level")           = q10_croplandexpansion.l(j,land_from10);
 oq10_cost(t,j,"level")                                    = q10_cost.l(j);
 oq10_landdiff(t,"level")                                  = q10_landdiff.l;
 ov_landdiff(t,"upper")                                    = vm_landdiff.up;
 ov_land(t,j,land,"upper")                                 = vm_land.up(j,land);
 ov_landexpansion(t,j,land,"upper")                        = vm_landexpansion.up(j,land);
 ov10_landreduction(t,j,land,"upper")                      = v10_landreduction.up(j,land);
 ov_croplandexpansion(t,j,land,"upper")                    = vm_croplandexpansion.up(j,land);
 ov_croplandreduction(t,j,land,"upper")                    = vm_croplandreduction.up(j,land);
 ov_cost_land_transition(t,j,"upper")                      = vm_cost_land_transition.up(j);
 ov10_lu_transitions(t,j,land_from10,land_to10,"upper")    = v10_lu_transitions.up(j,land_from10,land_to10);
 oq10_land(t,j,"upper")                                    = q10_land.up(j);
 oq10_transition_matrix(t,j,"upper")                       = q10_transition_matrix.up(j);
 oq10_transition_to(t,j,land_to10,"upper")                 = q10_transition_to.up(j,land_to10);
 oq10_transition_from(t,j,land_from10,"upper")             = q10_transition_from.up(j,land_from10);
 oq10_landexpansion(t,j,land_to10,"upper")                 = q10_landexpansion.up(j,land_to10);
 oq10_landreduction(t,j,land_from10,"upper")               = q10_landreduction.up(j,land_from10);
 oq10_croplandreduction(t,j,land_to10,"upper")             = q10_croplandreduction.up(j,land_to10);
 oq10_croplandexpansion(t,j,land_from10,"upper")           = q10_croplandexpansion.up(j,land_from10);
 oq10_cost(t,j,"upper")                                    = q10_cost.up(j);
 oq10_landdiff(t,"upper")                                  = q10_landdiff.up;
 ov_landdiff(t,"lower")                                    = vm_landdiff.lo;
 ov_land(t,j,land,"lower")                                 = vm_land.lo(j,land);
 ov_landexpansion(t,j,land,"lower")                        = vm_landexpansion.lo(j,land);
 ov10_landreduction(t,j,land,"lower")                      = v10_landreduction.lo(j,land);
 ov_croplandexpansion(t,j,land,"lower")                    = vm_croplandexpansion.lo(j,land);
 ov_croplandreduction(t,j,land,"lower")                    = vm_croplandreduction.lo(j,land);
 ov_cost_land_transition(t,j,"lower")                      = vm_cost_land_transition.lo(j);
 ov10_lu_transitions(t,j,land_from10,land_to10,"lower")    = v10_lu_transitions.lo(j,land_from10,land_to10);
 oq10_land(t,j,"lower")                                    = q10_land.lo(j);
 oq10_transition_matrix(t,j,"lower")                       = q10_transition_matrix.lo(j);
 oq10_transition_to(t,j,land_to10,"lower")                 = q10_transition_to.lo(j,land_to10);
 oq10_transition_from(t,j,land_from10,"lower")             = q10_transition_from.lo(j,land_from10);
 oq10_landexpansion(t,j,land_to10,"lower")                 = q10_landexpansion.lo(j,land_to10);
 oq10_landreduction(t,j,land_from10,"lower")               = q10_landreduction.lo(j,land_from10);
 oq10_croplandreduction(t,j,land_to10,"lower")             = q10_croplandreduction.lo(j,land_to10);
 oq10_croplandexpansion(t,j,land_from10,"lower")           = q10_croplandexpansion.lo(j,land_from10);
 oq10_cost(t,j,"lower")                                    = q10_cost.lo(j);
 oq10_landdiff(t,"lower")                                  = q10_landdiff.lo;
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
