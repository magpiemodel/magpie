*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*** Land Patterns are transferred to next timestep
 pc31_grass(j,grassland) = v31_grass_area.l(j,grassland, "rainfed");

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov31_grass_area(t,j,grassland,w,"marginal")                    = v31_grass_area.m(j,grassland,w);
 ov31_grass_yld(t,j,grassland,w,"marginal")                     = v31_grass_yld.m(j,grassland,w);
 ov31_grass_expansion(t,j,grassland,"marginal")                 = v31_grass_expansion.m(j,grassland);
 ov31_grass_reduction(t,j,grassland,"marginal")                 = v31_grass_reduction.m(j,grassland);
 ov31_grass_transitions(t,j,grass_from31,grass_to31,"marginal") = v31_grass_transitions.m(j,grass_from31,grass_to31);
 ov31_pos_balance(t,j,grassland,"marginal")                     = v31_pos_balance.m(j,grassland);
 ov31_neg_balance(t,j,grassland,"marginal")                     = v31_neg_balance.m(j,grassland);
 ov31_cost_grass_conversion(t,j,"marginal")                     = v31_cost_grass_conversion.m(j);
 oq31_carbon(t,j,ag_pools,"marginal")                           = q31_carbon.m(j,ag_pools);
 oq31_cost_prod_past(t,i,"marginal")                            = q31_cost_prod_past.m(i);
 oq31_bv_manpast(t,j,potnatveg,"marginal")                      = q31_bv_manpast.m(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"marginal")                    = q31_bv_rangeland.m(j,potnatveg);
 oq31_grass_expansion(t,j,"marginal")                           = q31_grass_expansion.m(j);
 oq31_grass_reduction(t,j,"marginal")                           = q31_grass_reduction.m(j);
 oq31_transition_to(t,j,grass_to31,"marginal")                  = q31_transition_to.m(j,grass_to31);
 oq31_transition_from(t,j,grass_from31,"marginal")              = q31_transition_from.m(j,grass_from31);
 oq31_cost_transition(t,j,"marginal")                           = q31_cost_transition.m(j);
 oq31_pasture_areas(t,j,"marginal")                             = q31_pasture_areas.m(j);
 oq31_manpast_suitability(t,i,"marginal")                       = q31_manpast_suitability.m(i);
 oq31_prod_pm(t,j,"marginal")                                   = q31_prod_pm.m(j);
 oq31_yield_grassl_range(t,j,"marginal")                        = q31_yield_grassl_range.m(j);
 oq31_yield_grassl_pastr(t,j,"marginal")                        = q31_yield_grassl_pastr.m(j);
 ov31_grass_area(t,j,grassland,w,"level")                       = v31_grass_area.l(j,grassland,w);
 ov31_grass_yld(t,j,grassland,w,"level")                        = v31_grass_yld.l(j,grassland,w);
 ov31_grass_expansion(t,j,grassland,"level")                    = v31_grass_expansion.l(j,grassland);
 ov31_grass_reduction(t,j,grassland,"level")                    = v31_grass_reduction.l(j,grassland);
 ov31_grass_transitions(t,j,grass_from31,grass_to31,"level")    = v31_grass_transitions.l(j,grass_from31,grass_to31);
 ov31_pos_balance(t,j,grassland,"level")                        = v31_pos_balance.l(j,grassland);
 ov31_neg_balance(t,j,grassland,"level")                        = v31_neg_balance.l(j,grassland);
 ov31_cost_grass_conversion(t,j,"level")                        = v31_cost_grass_conversion.l(j);
 oq31_carbon(t,j,ag_pools,"level")                              = q31_carbon.l(j,ag_pools);
 oq31_cost_prod_past(t,i,"level")                               = q31_cost_prod_past.l(i);
 oq31_bv_manpast(t,j,potnatveg,"level")                         = q31_bv_manpast.l(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"level")                       = q31_bv_rangeland.l(j,potnatveg);
 oq31_grass_expansion(t,j,"level")                              = q31_grass_expansion.l(j);
 oq31_grass_reduction(t,j,"level")                              = q31_grass_reduction.l(j);
 oq31_transition_to(t,j,grass_to31,"level")                     = q31_transition_to.l(j,grass_to31);
 oq31_transition_from(t,j,grass_from31,"level")                 = q31_transition_from.l(j,grass_from31);
 oq31_cost_transition(t,j,"level")                              = q31_cost_transition.l(j);
 oq31_pasture_areas(t,j,"level")                                = q31_pasture_areas.l(j);
 oq31_manpast_suitability(t,i,"level")                          = q31_manpast_suitability.l(i);
 oq31_prod_pm(t,j,"level")                                      = q31_prod_pm.l(j);
 oq31_yield_grassl_range(t,j,"level")                           = q31_yield_grassl_range.l(j);
 oq31_yield_grassl_pastr(t,j,"level")                           = q31_yield_grassl_pastr.l(j);
 ov31_grass_area(t,j,grassland,w,"upper")                       = v31_grass_area.up(j,grassland,w);
 ov31_grass_yld(t,j,grassland,w,"upper")                        = v31_grass_yld.up(j,grassland,w);
 ov31_grass_expansion(t,j,grassland,"upper")                    = v31_grass_expansion.up(j,grassland);
 ov31_grass_reduction(t,j,grassland,"upper")                    = v31_grass_reduction.up(j,grassland);
 ov31_grass_transitions(t,j,grass_from31,grass_to31,"upper")    = v31_grass_transitions.up(j,grass_from31,grass_to31);
 ov31_pos_balance(t,j,grassland,"upper")                        = v31_pos_balance.up(j,grassland);
 ov31_neg_balance(t,j,grassland,"upper")                        = v31_neg_balance.up(j,grassland);
 ov31_cost_grass_conversion(t,j,"upper")                        = v31_cost_grass_conversion.up(j);
 oq31_carbon(t,j,ag_pools,"upper")                              = q31_carbon.up(j,ag_pools);
 oq31_cost_prod_past(t,i,"upper")                               = q31_cost_prod_past.up(i);
 oq31_bv_manpast(t,j,potnatveg,"upper")                         = q31_bv_manpast.up(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"upper")                       = q31_bv_rangeland.up(j,potnatveg);
 oq31_grass_expansion(t,j,"upper")                              = q31_grass_expansion.up(j);
 oq31_grass_reduction(t,j,"upper")                              = q31_grass_reduction.up(j);
 oq31_transition_to(t,j,grass_to31,"upper")                     = q31_transition_to.up(j,grass_to31);
 oq31_transition_from(t,j,grass_from31,"upper")                 = q31_transition_from.up(j,grass_from31);
 oq31_cost_transition(t,j,"upper")                              = q31_cost_transition.up(j);
 oq31_pasture_areas(t,j,"upper")                                = q31_pasture_areas.up(j);
 oq31_manpast_suitability(t,i,"upper")                          = q31_manpast_suitability.up(i);
 oq31_prod_pm(t,j,"upper")                                      = q31_prod_pm.up(j);
 oq31_yield_grassl_range(t,j,"upper")                           = q31_yield_grassl_range.up(j);
 oq31_yield_grassl_pastr(t,j,"upper")                           = q31_yield_grassl_pastr.up(j);
 ov31_grass_area(t,j,grassland,w,"lower")                       = v31_grass_area.lo(j,grassland,w);
 ov31_grass_yld(t,j,grassland,w,"lower")                        = v31_grass_yld.lo(j,grassland,w);
 ov31_grass_expansion(t,j,grassland,"lower")                    = v31_grass_expansion.lo(j,grassland);
 ov31_grass_reduction(t,j,grassland,"lower")                    = v31_grass_reduction.lo(j,grassland);
 ov31_grass_transitions(t,j,grass_from31,grass_to31,"lower")    = v31_grass_transitions.lo(j,grass_from31,grass_to31);
 ov31_pos_balance(t,j,grassland,"lower")                        = v31_pos_balance.lo(j,grassland);
 ov31_neg_balance(t,j,grassland,"lower")                        = v31_neg_balance.lo(j,grassland);
 ov31_cost_grass_conversion(t,j,"lower")                        = v31_cost_grass_conversion.lo(j);
 oq31_carbon(t,j,ag_pools,"lower")                              = q31_carbon.lo(j,ag_pools);
 oq31_cost_prod_past(t,i,"lower")                               = q31_cost_prod_past.lo(i);
 oq31_bv_manpast(t,j,potnatveg,"lower")                         = q31_bv_manpast.lo(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"lower")                       = q31_bv_rangeland.lo(j,potnatveg);
 oq31_grass_expansion(t,j,"lower")                              = q31_grass_expansion.lo(j);
 oq31_grass_reduction(t,j,"lower")                              = q31_grass_reduction.lo(j);
 oq31_transition_to(t,j,grass_to31,"lower")                     = q31_transition_to.lo(j,grass_to31);
 oq31_transition_from(t,j,grass_from31,"lower")                 = q31_transition_from.lo(j,grass_from31);
 oq31_cost_transition(t,j,"lower")                              = q31_cost_transition.lo(j);
 oq31_pasture_areas(t,j,"lower")                                = q31_pasture_areas.lo(j);
 oq31_manpast_suitability(t,i,"lower")                          = q31_manpast_suitability.lo(i);
 oq31_prod_pm(t,j,"lower")                                      = q31_prod_pm.lo(j);
 oq31_yield_grassl_range(t,j,"lower")                           = q31_yield_grassl_range.lo(j);
 oq31_yield_grassl_pastr(t,j,"lower")                           = q31_yield_grassl_pastr.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

*** EOF postsolve.gms ***
