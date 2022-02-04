*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*** Land Patterns are transferred to next timestep
 pc31_grass(j,grassland) = v31_grass_area.l(j,grassland, "rainfed");

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov31_grass_area(t,j,grassland,w,"marginal")         = v31_grass_area.m(j,grassland,w);
 ov31_grass_yld(t,j,grassland,w,"marginal")          = v31_grass_yld.m(j,grassland,w);
 ov31_cost_grass_transition(t,j,"marginal")          = v31_cost_grass_transition.m(j);
 oq31_carbon(t,j,ag_pools,"marginal")                = q31_carbon.m(j,ag_pools);
 oq31_cost_prod_past(t,i,"marginal")                 = q31_cost_prod_past.m(i);
 oq31_bv_manpast(t,j,potnatveg,"marginal")           = q31_bv_manpast.m(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"marginal")         = q31_bv_rangeland.m(j,potnatveg);
 oq31_pasture_areas(t,j,"marginal")                  = q31_pasture_areas.m(j);
 oq31_manpast_suitability(t,i,"marginal")            = q31_manpast_suitability.m(i);
 oq31_prod_pm(t,j,"marginal")                        = q31_prod_pm.m(j);
 oq31_transitions_cost(t,j,"marginal")               = q31_transitions_cost.m(j);
 oq31_yield_grassl_range(t,j,grassland,w,"marginal") = q31_yield_grassl_range.m(j,grassland,w);
 oq31_yield_grassl_pastr(t,j,grassland,w,"marginal") = q31_yield_grassl_pastr.m(j,grassland,w);
 ov31_grass_area(t,j,grassland,w,"level")            = v31_grass_area.l(j,grassland,w);
 ov31_grass_yld(t,j,grassland,w,"level")             = v31_grass_yld.l(j,grassland,w);
 ov31_cost_grass_transition(t,j,"level")             = v31_cost_grass_transition.l(j);
 oq31_carbon(t,j,ag_pools,"level")                   = q31_carbon.l(j,ag_pools);
 oq31_cost_prod_past(t,i,"level")                    = q31_cost_prod_past.l(i);
 oq31_bv_manpast(t,j,potnatveg,"level")              = q31_bv_manpast.l(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"level")            = q31_bv_rangeland.l(j,potnatveg);
 oq31_pasture_areas(t,j,"level")                     = q31_pasture_areas.l(j);
 oq31_manpast_suitability(t,i,"level")               = q31_manpast_suitability.l(i);
 oq31_prod_pm(t,j,"level")                           = q31_prod_pm.l(j);
 oq31_transitions_cost(t,j,"level")                  = q31_transitions_cost.l(j);
 oq31_yield_grassl_range(t,j,grassland,w,"level")    = q31_yield_grassl_range.l(j,grassland,w);
 oq31_yield_grassl_pastr(t,j,grassland,w,"level")    = q31_yield_grassl_pastr.l(j,grassland,w);
 ov31_grass_area(t,j,grassland,w,"upper")            = v31_grass_area.up(j,grassland,w);
 ov31_grass_yld(t,j,grassland,w,"upper")             = v31_grass_yld.up(j,grassland,w);
 ov31_cost_grass_transition(t,j,"upper")             = v31_cost_grass_transition.up(j);
 oq31_carbon(t,j,ag_pools,"upper")                   = q31_carbon.up(j,ag_pools);
 oq31_cost_prod_past(t,i,"upper")                    = q31_cost_prod_past.up(i);
 oq31_bv_manpast(t,j,potnatveg,"upper")              = q31_bv_manpast.up(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"upper")            = q31_bv_rangeland.up(j,potnatveg);
 oq31_pasture_areas(t,j,"upper")                     = q31_pasture_areas.up(j);
 oq31_manpast_suitability(t,i,"upper")               = q31_manpast_suitability.up(i);
 oq31_prod_pm(t,j,"upper")                           = q31_prod_pm.up(j);
 oq31_transitions_cost(t,j,"upper")                  = q31_transitions_cost.up(j);
 oq31_yield_grassl_range(t,j,grassland,w,"upper")    = q31_yield_grassl_range.up(j,grassland,w);
 oq31_yield_grassl_pastr(t,j,grassland,w,"upper")    = q31_yield_grassl_pastr.up(j,grassland,w);
 ov31_grass_area(t,j,grassland,w,"lower")            = v31_grass_area.lo(j,grassland,w);
 ov31_grass_yld(t,j,grassland,w,"lower")             = v31_grass_yld.lo(j,grassland,w);
 ov31_cost_grass_transition(t,j,"lower")             = v31_cost_grass_transition.lo(j);
 oq31_carbon(t,j,ag_pools,"lower")                   = q31_carbon.lo(j,ag_pools);
 oq31_cost_prod_past(t,i,"lower")                    = q31_cost_prod_past.lo(i);
 oq31_bv_manpast(t,j,potnatveg,"lower")              = q31_bv_manpast.lo(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"lower")            = q31_bv_rangeland.lo(j,potnatveg);
 oq31_pasture_areas(t,j,"lower")                     = q31_pasture_areas.lo(j);
 oq31_manpast_suitability(t,i,"lower")               = q31_manpast_suitability.lo(i);
 oq31_prod_pm(t,j,"lower")                           = q31_prod_pm.lo(j);
 oq31_transitions_cost(t,j,"lower")                  = q31_transitions_cost.lo(j);
 oq31_yield_grassl_range(t,j,grassland,w,"lower")    = q31_yield_grassl_range.lo(j,grassland,w);
 oq31_yield_grassl_pastr(t,j,grassland,w,"lower")    = q31_yield_grassl_pastr.lo(j,grassland,w);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

*** EOF postsolve.gms ***
