*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_fore(t,i,"marginal")                        = vm_cost_fore.m(i);
 ov_landdiff_forestry(t,"marginal")                  = vm_landdiff_forestry.m;
 ov32_land(t,j,land32,"marginal")                    = v32_land.m(j,land32);
 ov_cdr_aff(t,j,emis_source_co2_forestry,"marginal") = vm_cdr_aff.m(j,emis_source_co2_forestry);
 ov_cost_fore(t,i,"level")                           = vm_cost_fore.l(i);
 ov_landdiff_forestry(t,"level")                     = vm_landdiff_forestry.l;
 ov32_land(t,j,land32,"level")                       = v32_land.l(j,land32);
 ov_cdr_aff(t,j,emis_source_co2_forestry,"level")    = vm_cdr_aff.l(j,emis_source_co2_forestry);
 ov_cost_fore(t,i,"upper")                           = vm_cost_fore.up(i);
 ov_landdiff_forestry(t,"upper")                     = vm_landdiff_forestry.up;
 ov32_land(t,j,land32,"upper")                       = v32_land.up(j,land32);
 ov_cdr_aff(t,j,emis_source_co2_forestry,"upper")    = vm_cdr_aff.up(j,emis_source_co2_forestry);
 ov_cost_fore(t,i,"lower")                           = vm_cost_fore.lo(i);
 ov_landdiff_forestry(t,"lower")                     = vm_landdiff_forestry.lo;
 ov32_land(t,j,land32,"lower")                       = v32_land.lo(j,land32);
 ov_cdr_aff(t,j,emis_source_co2_forestry,"lower")    = vm_cdr_aff.lo(j,emis_source_co2_forestry);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
