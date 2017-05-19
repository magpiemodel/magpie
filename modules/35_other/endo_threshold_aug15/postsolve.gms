*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*in 1st time step all other land is in highest age-class
v35_land.l(j,land35,si)$(ord(t) = 1) = 0$(not sameas(land35,"old")) + vm_land.l(j,"other",si)$(sameas(land35,"old"));
p35_land(t,j,ac,si,"after")$(ord(t) = 1) = 0$(not sameas(ac,"acx")) + vm_land.l(j,"other",si)$(sameas(ac,"acx"));

p35_land(t,j,ac,si,"after")$(ord(t) > 1) =
        v35_land.l(j,"new",si)$(ord(ac) = 1)
        + sum(ac_land35(ac,land35)$(not sameas(land35,"new") AND pc35_land(j,land35,si) > 0),(v35_land.l(j,land35,si)/pc35_land(j,land35,si))*p35_land(t,j,ac,si,"before"))$(ord(ac) > 1);

*calculate recovered forest based on carbon density; if carbon density > 20 tC/ha then shift from other land to forest land pool
pm_recovered_forest(t,j,ac,si)$(not sameas(ac,"acx")) = p35_land(t,j,ac,si,"after")$(pm_carbon_density_ac(t,j,ac,"vegc") > 20);
p35_land(t,j,ac,si,"after") = p35_land(t,j,ac,si,"after") - pm_recovered_forest(t,j,ac,si);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov35_land(t,j,land35,si,"marginal") = v35_land.m(j,land35,si);
 ov_landdiff_other(t,"marginal")     = vm_landdiff_other.m;
 oq35_carbon(t,j,c_pools,"marginal") = q35_carbon.m(j,c_pools);
 oq35_land(t,j,si,"marginal")        = q35_land.m(j,si);
 oq35_diff(t,"marginal")             = q35_diff.m;
 ov35_land(t,j,land35,si,"level")    = v35_land.l(j,land35,si);
 ov_landdiff_other(t,"level")        = vm_landdiff_other.l;
 oq35_carbon(t,j,c_pools,"level")    = q35_carbon.l(j,c_pools);
 oq35_land(t,j,si,"level")           = q35_land.l(j,si);
 oq35_diff(t,"level")                = q35_diff.l;
 ov35_land(t,j,land35,si,"upper")    = v35_land.up(j,land35,si);
 ov_landdiff_other(t,"upper")        = vm_landdiff_other.up;
 oq35_carbon(t,j,c_pools,"upper")    = q35_carbon.up(j,c_pools);
 oq35_land(t,j,si,"upper")           = q35_land.up(j,si);
 oq35_diff(t,"upper")                = q35_diff.up;
 ov35_land(t,j,land35,si,"lower")    = v35_land.lo(j,land35,si);
 ov_landdiff_other(t,"lower")        = vm_landdiff_other.lo;
 oq35_carbon(t,j,c_pools,"lower")    = q35_carbon.lo(j,c_pools);
 oq35_land(t,j,si,"lower")           = q35_land.lo(j,si);
 oq35_diff(t,"lower")                = q35_diff.lo;
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
