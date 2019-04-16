*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

* Disaggregation of forestry land after optimization from `land32`to `ac`.
* after(ac) = growth_rate(flt)*before(ac)
p32_land(t,j,ac,"after") =
         (v32_land.l(j,"new")+v32_land.l(j,"new_ndc"))$(ord(ac) = 1)
         + sum(ac_land32(ac,land32)$(not sameas(land32,"new") 
         AND not sameas(land32,"new_ndc") 
         AND pc32_land(j,land32) > 0),
         (v32_land.l(j,land32)/pc32_land(j,land32))*p32_land(t,j,ac,"before"))$(ord(ac) > 1);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_fore(t,i,"marginal")               = vm_cost_fore.m(i);
 ov32_land(t,j,land32,"marginal")           = v32_land.m(j,land32);
 ov_landdiff_forestry(t,"marginal")         = vm_landdiff_forestry.m;
 ov32_land_expansion(t,j,land32,"marginal") = v32_land_expansion.m(j,land32);
 ov32_land_reduction(t,j,land32,"marginal") = v32_land_reduction.m(j,land32);
 ov_cdr_aff(t,j,"marginal")                 = vm_cdr_aff.m(j);
 oq32_cost_fore_ac(t,i,"marginal")          = q32_cost_fore_ac.m(i);
 oq32_land(t,j,"marginal")                  = q32_land.m(j);
 oq32_cdr_aff(t,j,"marginal")               = q32_cdr_aff.m(j);
 oq32_carbon(t,j,c_pools,"marginal")        = q32_carbon.m(j,c_pools);
 oq32_land_diff(t,"marginal")               = q32_land_diff.m;
 oq32_land_expansion(t,j,land32,"marginal") = q32_land_expansion.m(j,land32);
 oq32_land_reduction(t,j,land32,"marginal") = q32_land_reduction.m(j,land32);
 oq32_max_aff(t,"marginal")                 = q32_max_aff.m;
 oq32_aff_pol(t,j,"marginal")               = q32_aff_pol.m(j);
 ov_cost_fore(t,i,"level")                  = vm_cost_fore.l(i);
 ov32_land(t,j,land32,"level")              = v32_land.l(j,land32);
 ov_landdiff_forestry(t,"level")            = vm_landdiff_forestry.l;
 ov32_land_expansion(t,j,land32,"level")    = v32_land_expansion.l(j,land32);
 ov32_land_reduction(t,j,land32,"level")    = v32_land_reduction.l(j,land32);
 ov_cdr_aff(t,j,"level")                    = vm_cdr_aff.l(j);
 oq32_cost_fore_ac(t,i,"level")             = q32_cost_fore_ac.l(i);
 oq32_land(t,j,"level")                     = q32_land.l(j);
 oq32_cdr_aff(t,j,"level")                  = q32_cdr_aff.l(j);
 oq32_carbon(t,j,c_pools,"level")           = q32_carbon.l(j,c_pools);
 oq32_land_diff(t,"level")                  = q32_land_diff.l;
 oq32_land_expansion(t,j,land32,"level")    = q32_land_expansion.l(j,land32);
 oq32_land_reduction(t,j,land32,"level")    = q32_land_reduction.l(j,land32);
 oq32_max_aff(t,"level")                    = q32_max_aff.l;
 oq32_aff_pol(t,j,"level")                  = q32_aff_pol.l(j);
 ov_cost_fore(t,i,"upper")                  = vm_cost_fore.up(i);
 ov32_land(t,j,land32,"upper")              = v32_land.up(j,land32);
 ov_landdiff_forestry(t,"upper")            = vm_landdiff_forestry.up;
 ov32_land_expansion(t,j,land32,"upper")    = v32_land_expansion.up(j,land32);
 ov32_land_reduction(t,j,land32,"upper")    = v32_land_reduction.up(j,land32);
 ov_cdr_aff(t,j,"upper")                    = vm_cdr_aff.up(j);
 oq32_cost_fore_ac(t,i,"upper")             = q32_cost_fore_ac.up(i);
 oq32_land(t,j,"upper")                     = q32_land.up(j);
 oq32_cdr_aff(t,j,"upper")                  = q32_cdr_aff.up(j);
 oq32_carbon(t,j,c_pools,"upper")           = q32_carbon.up(j,c_pools);
 oq32_land_diff(t,"upper")                  = q32_land_diff.up;
 oq32_land_expansion(t,j,land32,"upper")    = q32_land_expansion.up(j,land32);
 oq32_land_reduction(t,j,land32,"upper")    = q32_land_reduction.up(j,land32);
 oq32_max_aff(t,"upper")                    = q32_max_aff.up;
 oq32_aff_pol(t,j,"upper")                  = q32_aff_pol.up(j);
 ov_cost_fore(t,i,"lower")                  = vm_cost_fore.lo(i);
 ov32_land(t,j,land32,"lower")              = v32_land.lo(j,land32);
 ov_landdiff_forestry(t,"lower")            = vm_landdiff_forestry.lo;
 ov32_land_expansion(t,j,land32,"lower")    = v32_land_expansion.lo(j,land32);
 ov32_land_reduction(t,j,land32,"lower")    = v32_land_reduction.lo(j,land32);
 ov_cdr_aff(t,j,"lower")                    = vm_cdr_aff.lo(j);
 oq32_cost_fore_ac(t,i,"lower")             = q32_cost_fore_ac.lo(i);
 oq32_land(t,j,"lower")                     = q32_land.lo(j);
 oq32_cdr_aff(t,j,"lower")                  = q32_cdr_aff.lo(j);
 oq32_carbon(t,j,c_pools,"lower")           = q32_carbon.lo(j,c_pools);
 oq32_land_diff(t,"lower")                  = q32_land_diff.lo;
 oq32_land_expansion(t,j,land32,"lower")    = q32_land_expansion.lo(j,land32);
 oq32_land_reduction(t,j,land32,"lower")    = q32_land_reduction.lo(j,land32);
 oq32_max_aff(t,"lower")                    = q32_max_aff.lo;
 oq32_aff_pol(t,j,"lower")                  = q32_aff_pol.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
