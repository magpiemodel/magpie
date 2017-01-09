*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

p32_land_fore(t,j,ac,si,"after") =
         v32_land.l(j,"new",si)$(ord(ac) = 1)
         + sum(ac_land32(ac,land32)$(not sameas(land32,"new") AND pc32_land_fore(j,land32,si) > 0),(v32_land.l(j,land32,si)/pc32_land_fore(j,land32,si))*p32_land_fore(t,j,ac,si,"before"))$(ord(ac) > 1);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_fore(t,i,"marginal")                          = vm_cost_fore.m(i);
 ov32_land(t,j,land32,si,"marginal")                   = v32_land.m(j,land32,si);
 ov_landdiff_forestry(t,"marginal")                    = vm_landdiff_forestry.m;
 ov_cdr_aff(t,j,emis_source_co2_forestry,"marginal")   = vm_cdr_aff.m(j,emis_source_co2_forestry);
 oq32_cost_fore_ac(t,i,"marginal")                     = q32_cost_fore_ac.m(i);
 oq32_land(t,j,si,"marginal")                          = q32_land.m(j,si);
 oq32_cdr_aff(t,j,emis_source_co2_forestry,"marginal") = q32_cdr_aff.m(j,emis_source_co2_forestry);
 oq32_carbon(t,j,c_pools,"marginal")                   = q32_carbon.m(j,c_pools);
 oq32_diff(t,"marginal")                               = q32_diff.m;
 oq32_min_aff(t,i,"marginal")                          = q32_min_aff.m(i);
 oq32_max_aff(t,"marginal")                            = q32_max_aff.m;
 ov_cost_fore(t,i,"level")                             = vm_cost_fore.l(i);
 ov32_land(t,j,land32,si,"level")                      = v32_land.l(j,land32,si);
 ov_landdiff_forestry(t,"level")                       = vm_landdiff_forestry.l;
 ov_cdr_aff(t,j,emis_source_co2_forestry,"level")      = vm_cdr_aff.l(j,emis_source_co2_forestry);
 oq32_cost_fore_ac(t,i,"level")                        = q32_cost_fore_ac.l(i);
 oq32_land(t,j,si,"level")                             = q32_land.l(j,si);
 oq32_cdr_aff(t,j,emis_source_co2_forestry,"level")    = q32_cdr_aff.l(j,emis_source_co2_forestry);
 oq32_carbon(t,j,c_pools,"level")                      = q32_carbon.l(j,c_pools);
 oq32_diff(t,"level")                                  = q32_diff.l;
 oq32_min_aff(t,i,"level")                             = q32_min_aff.l(i);
 oq32_max_aff(t,"level")                               = q32_max_aff.l;
 ov_cost_fore(t,i,"upper")                             = vm_cost_fore.up(i);
 ov32_land(t,j,land32,si,"upper")                      = v32_land.up(j,land32,si);
 ov_landdiff_forestry(t,"upper")                       = vm_landdiff_forestry.up;
 ov_cdr_aff(t,j,emis_source_co2_forestry,"upper")      = vm_cdr_aff.up(j,emis_source_co2_forestry);
 oq32_cost_fore_ac(t,i,"upper")                        = q32_cost_fore_ac.up(i);
 oq32_land(t,j,si,"upper")                             = q32_land.up(j,si);
 oq32_cdr_aff(t,j,emis_source_co2_forestry,"upper")    = q32_cdr_aff.up(j,emis_source_co2_forestry);
 oq32_carbon(t,j,c_pools,"upper")                      = q32_carbon.up(j,c_pools);
 oq32_diff(t,"upper")                                  = q32_diff.up;
 oq32_min_aff(t,i,"upper")                             = q32_min_aff.up(i);
 oq32_max_aff(t,"upper")                               = q32_max_aff.up;
 ov_cost_fore(t,i,"lower")                             = vm_cost_fore.lo(i);
 ov32_land(t,j,land32,si,"lower")                      = v32_land.lo(j,land32,si);
 ov_landdiff_forestry(t,"lower")                       = vm_landdiff_forestry.lo;
 ov_cdr_aff(t,j,emis_source_co2_forestry,"lower")      = vm_cdr_aff.lo(j,emis_source_co2_forestry);
 oq32_cost_fore_ac(t,i,"lower")                        = q32_cost_fore_ac.lo(i);
 oq32_land(t,j,si,"lower")                             = q32_land.lo(j,si);
 oq32_cdr_aff(t,j,emis_source_co2_forestry,"lower")    = q32_cdr_aff.lo(j,emis_source_co2_forestry);
 oq32_carbon(t,j,c_pools,"lower")                      = q32_carbon.lo(j,c_pools);
 oq32_diff(t,"lower")                                  = q32_diff.lo;
 oq32_min_aff(t,i,"lower")                             = q32_min_aff.lo(i);
 oq32_max_aff(t,"lower")                               = q32_max_aff.lo;
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
