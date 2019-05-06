*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_fore(t,i,"marginal")       = vm_cost_fore.m(i);
 ov_landdiff_forestry(t,"marginal") = vm_landdiff_forestry.m;
 ov32_land(t,j,land32,"marginal")   = v32_land.m(j,land32);
 ov_cdr_aff(t,j,"marginal")         = vm_cdr_aff.m(j);
 ov_cost_fore(t,i,"level")          = vm_cost_fore.l(i);
 ov_landdiff_forestry(t,"level")    = vm_landdiff_forestry.l;
 ov32_land(t,j,land32,"level")      = v32_land.l(j,land32);
 ov_cdr_aff(t,j,"level")            = vm_cdr_aff.l(j);
 ov_cost_fore(t,i,"upper")          = vm_cost_fore.up(i);
 ov_landdiff_forestry(t,"upper")    = vm_landdiff_forestry.up;
 ov32_land(t,j,land32,"upper")      = v32_land.up(j,land32);
 ov_cdr_aff(t,j,"upper")            = vm_cdr_aff.up(j);
 ov_cost_fore(t,i,"lower")          = vm_cost_fore.lo(i);
 ov_landdiff_forestry(t,"lower")    = vm_landdiff_forestry.lo;
 ov32_land(t,j,land32,"lower")      = v32_land.lo(j,land32);
 ov_cdr_aff(t,j,"lower")            = vm_cdr_aff.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
