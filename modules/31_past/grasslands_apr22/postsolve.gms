*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*** Land Patterns are transferred to next timestep
 pc31_grass(j,grassland) = v31_grass_area.l(j,grassland);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov31_grass_area(t,j,grassland,"marginal")           = v31_grass_area.m(j,grassland);
 ov31_cost_grass_expansion(t,j,grassland,"marginal") = v31_cost_grass_expansion.m(j,grassland);
 ov_cost_prod_past(t,i,"marginal")                   = vm_cost_prod_past.m(i);
 oq31_carbon(t,j,ag_pools,stockType,"marginal")      = q31_carbon.m(j,ag_pools,stockType);
 oq31_cost_prod_past(t,i,"marginal")                 = q31_cost_prod_past.m(i);
 oq31_bv_manpast(t,j,potnatveg,"marginal")           = q31_bv_manpast.m(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"marginal")         = q31_bv_rangeland.m(j,potnatveg);
 oq31_pasture_areas(t,j,"marginal")                  = q31_pasture_areas.m(j);
 oq31_prod_pm(t,j,"marginal")                        = q31_prod_pm.m(j);
 oq31_expansion_cost(t,j,grassland,"marginal")       = q31_expansion_cost.m(j,grassland);
 ov31_grass_area(t,j,grassland,"level")              = v31_grass_area.l(j,grassland);
 ov31_cost_grass_expansion(t,j,grassland,"level")    = v31_cost_grass_expansion.l(j,grassland);
 ov_cost_prod_past(t,i,"level")                      = vm_cost_prod_past.l(i);
 oq31_carbon(t,j,ag_pools,stockType,"level")         = q31_carbon.l(j,ag_pools,stockType);
 oq31_cost_prod_past(t,i,"level")                    = q31_cost_prod_past.l(i);
 oq31_bv_manpast(t,j,potnatveg,"level")              = q31_bv_manpast.l(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"level")            = q31_bv_rangeland.l(j,potnatveg);
 oq31_pasture_areas(t,j,"level")                     = q31_pasture_areas.l(j);
 oq31_prod_pm(t,j,"level")                           = q31_prod_pm.l(j);
 oq31_expansion_cost(t,j,grassland,"level")          = q31_expansion_cost.l(j,grassland);
 ov31_grass_area(t,j,grassland,"upper")              = v31_grass_area.up(j,grassland);
 ov31_cost_grass_expansion(t,j,grassland,"upper")    = v31_cost_grass_expansion.up(j,grassland);
 ov_cost_prod_past(t,i,"upper")                      = vm_cost_prod_past.up(i);
 oq31_carbon(t,j,ag_pools,stockType,"upper")         = q31_carbon.up(j,ag_pools,stockType);
 oq31_cost_prod_past(t,i,"upper")                    = q31_cost_prod_past.up(i);
 oq31_bv_manpast(t,j,potnatveg,"upper")              = q31_bv_manpast.up(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"upper")            = q31_bv_rangeland.up(j,potnatveg);
 oq31_pasture_areas(t,j,"upper")                     = q31_pasture_areas.up(j);
 oq31_prod_pm(t,j,"upper")                           = q31_prod_pm.up(j);
 oq31_expansion_cost(t,j,grassland,"upper")          = q31_expansion_cost.up(j,grassland);
 ov31_grass_area(t,j,grassland,"lower")              = v31_grass_area.lo(j,grassland);
 ov31_cost_grass_expansion(t,j,grassland,"lower")    = v31_cost_grass_expansion.lo(j,grassland);
 ov_cost_prod_past(t,i,"lower")                      = vm_cost_prod_past.lo(i);
 oq31_carbon(t,j,ag_pools,stockType,"lower")         = q31_carbon.lo(j,ag_pools,stockType);
 oq31_cost_prod_past(t,i,"lower")                    = q31_cost_prod_past.lo(i);
 oq31_bv_manpast(t,j,potnatveg,"lower")              = q31_bv_manpast.lo(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"lower")            = q31_bv_rangeland.lo(j,potnatveg);
 oq31_pasture_areas(t,j,"lower")                     = q31_pasture_areas.lo(j);
 oq31_prod_pm(t,j,"lower")                           = q31_prod_pm.lo(j);
 oq31_expansion_cost(t,j,grassland,"lower")          = q31_expansion_cost.lo(j,grassland);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

*** EOF postsolve.gms ***
