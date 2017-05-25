*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

p35_secdforest(t,j,ac,"after")$(ord(t) > 1) =
        v35_secdforest.l(j,"new")$(ord(ac) = 1)
        + sum(ac_land35(ac,land35)$(not sameas(land35,"new") AND pc35_secdforest(j,land35) > 0),(v35_secdforest.l(j,land35)/pc35_secdforest(j,land35))*p35_secdforest(t,j,ac,"before"))$(ord(ac) > 1);

*in 1st time step all other land is in highest age-class
v35_other.l(j,land35)$(ord(t) = 1) = 0$(not sameas(land35,"old")) + vm_land.l(j,"other")$(sameas(land35,"old"));
p35_other(t,j,ac,"after")$(ord(t) = 1) = 0$(not sameas(ac,"acx")) + vm_land.l(j,"other")$(sameas(ac,"acx"));

p35_other(t,j,ac,"after")$(ord(t) > 1) =
        v35_other.l(j,"new")$(ord(ac) = 1)
        + sum(ac_land35(ac,land35)$(not sameas(land35,"new") AND pc35_other(j,land35) > 0),(v35_other.l(j,land35)/pc35_other(j,land35))*p35_other(t,j,ac,"before"))$(ord(ac) > 1);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov35_secdforest(t,j,land35,"marginal")         = v35_secdforest.m(j,land35);
 ov35_other(t,j,land35,"marginal")              = v35_other.m(j,land35);
 ov_landdiff_natveg(t,"marginal")               = vm_landdiff_natveg.m;
 oq35_land_secdforest(t,j,"marginal")           = q35_land_secdforest.m(j);
 oq35_land_other(t,j,"marginal")                = q35_land_other.m(j);
 oq35_carbon_primforest(t,j,c_pools,"marginal") = q35_carbon_primforest.m(j,c_pools);
 oq35_carbon_secdforest(t,j,c_pools,"marginal") = q35_carbon_secdforest.m(j,c_pools);
 oq35_carbon_other(t,j,c_pools,"marginal")      = q35_carbon_other.m(j,c_pools);
 oq35_diff(t,"marginal")                        = q35_diff.m;
 ov35_secdforest(t,j,land35,"level")            = v35_secdforest.l(j,land35);
 ov35_other(t,j,land35,"level")                 = v35_other.l(j,land35);
 ov_landdiff_natveg(t,"level")                  = vm_landdiff_natveg.l;
 oq35_land_secdforest(t,j,"level")              = q35_land_secdforest.l(j);
 oq35_land_other(t,j,"level")                   = q35_land_other.l(j);
 oq35_carbon_primforest(t,j,c_pools,"level")    = q35_carbon_primforest.l(j,c_pools);
 oq35_carbon_secdforest(t,j,c_pools,"level")    = q35_carbon_secdforest.l(j,c_pools);
 oq35_carbon_other(t,j,c_pools,"level")         = q35_carbon_other.l(j,c_pools);
 oq35_diff(t,"level")                           = q35_diff.l;
 ov35_secdforest(t,j,land35,"upper")            = v35_secdforest.up(j,land35);
 ov35_other(t,j,land35,"upper")                 = v35_other.up(j,land35);
 ov_landdiff_natveg(t,"upper")                  = vm_landdiff_natveg.up;
 oq35_land_secdforest(t,j,"upper")              = q35_land_secdforest.up(j);
 oq35_land_other(t,j,"upper")                   = q35_land_other.up(j);
 oq35_carbon_primforest(t,j,c_pools,"upper")    = q35_carbon_primforest.up(j,c_pools);
 oq35_carbon_secdforest(t,j,c_pools,"upper")    = q35_carbon_secdforest.up(j,c_pools);
 oq35_carbon_other(t,j,c_pools,"upper")         = q35_carbon_other.up(j,c_pools);
 oq35_diff(t,"upper")                           = q35_diff.up;
 ov35_secdforest(t,j,land35,"lower")            = v35_secdforest.lo(j,land35);
 ov35_other(t,j,land35,"lower")                 = v35_other.lo(j,land35);
 ov_landdiff_natveg(t,"lower")                  = vm_landdiff_natveg.lo;
 oq35_land_secdforest(t,j,"lower")              = q35_land_secdforest.lo(j);
 oq35_land_other(t,j,"lower")                   = q35_land_other.lo(j);
 oq35_carbon_primforest(t,j,c_pools,"lower")    = q35_carbon_primforest.lo(j,c_pools);
 oq35_carbon_secdforest(t,j,c_pools,"lower")    = q35_carbon_secdforest.lo(j,c_pools);
 oq35_carbon_other(t,j,c_pools,"lower")         = q35_carbon_other.lo(j,c_pools);
 oq35_diff(t,"lower")                           = q35_diff.lo;
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
