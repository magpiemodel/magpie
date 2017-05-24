*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*in 1st time step all other land is in highest age-class
v35_land.l(j,land35)$(ord(t) = 1) = 0$(not sameas(land35,"old")) + vm_land.l(j,"other")$(sameas(land35,"old"));
p35_land(t,j,ac,"after")$(ord(t) = 1) = 0$(not sameas(ac,"acx")) + vm_land.l(j,"other")$(sameas(ac,"acx"));

p35_land(t,j,ac,"after")$(ord(t) > 1) =
        v35_land.l(j,"new")$(ord(ac) = 1)
        + sum(ac_land35(ac,land35)$(not sameas(land35,"new") AND pc35_land(j,land35) > 0),(v35_land.l(j,land35)/pc35_land(j,land35))*p35_land(t,j,ac,"before"))$(ord(ac) > 1);

*calculate recovered forest based on carbon density; if carbon density > 20 tC/ha then shift from other land to forest land pool
pm_recovered_forest(t,j,ac)$(not sameas(ac,"acx")) = p35_land(t,j,ac,"after")$(pm_carbon_density_ac(t,j,ac,"vegc") > 20);
p35_land(t,j,ac,"after") = p35_land(t,j,ac,"after") - pm_recovered_forest(t,j,ac);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov35_land(t,j,land35,"marginal")    = v35_land.m(j,land35);
 ov_landdiff_other(t,"marginal")     = vm_landdiff_other.m;
 oq35_carbon(t,j,c_pools,"marginal") = q35_carbon.m(j,c_pools);
 oq35_land(t,j,"marginal")           = q35_land.m(j);
 oq35_diff(t,"marginal")             = q35_diff.m;
 ov35_land(t,j,land35,"level")       = v35_land.l(j,land35);
 ov_landdiff_other(t,"level")        = vm_landdiff_other.l;
 oq35_carbon(t,j,c_pools,"level")    = q35_carbon.l(j,c_pools);
 oq35_land(t,j,"level")              = q35_land.l(j);
 oq35_diff(t,"level")                = q35_diff.l;
 ov35_land(t,j,land35,"upper")       = v35_land.up(j,land35);
 ov_landdiff_other(t,"upper")        = vm_landdiff_other.up;
 oq35_carbon(t,j,c_pools,"upper")    = q35_carbon.up(j,c_pools);
 oq35_land(t,j,"upper")              = q35_land.up(j);
 oq35_diff(t,"upper")                = q35_diff.up;
 ov35_land(t,j,land35,"lower")       = v35_land.lo(j,land35);
 ov_landdiff_other(t,"lower")        = vm_landdiff_other.lo;
 oq35_carbon(t,j,c_pools,"lower")    = q35_carbon.lo(j,c_pools);
 oq35_land(t,j,"lower")              = q35_land.lo(j);
 oq35_diff(t,"lower")                = q35_diff.lo;
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
