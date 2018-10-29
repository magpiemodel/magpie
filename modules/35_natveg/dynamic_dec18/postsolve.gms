*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

if((ord(t) = 1),
* Reshuffling of agricultural land in the 1st timestep results in an artificial increase of v35_other(j,"new").
* This would result in carbon uptake (negative emissions) due to regrowth of vegetation.
* To avoid this artificial effect on CO2 emissions we reset age-classes after the optimization of the 1st time step.
	v35_other.l(j,land35) = 0;
	v35_other.l(j,"old") = vm_land.l(j,"other");
	p35_other(t,j,ac,"after") = 0;
	p35_other(t,j,"acx","after") = vm_land.l(j,"other");
else
*other land age class calculation
	p35_other(t,j,ac,"after") =
        v35_other.l(j,"new")$(ord(ac) = 1)
        + sum(ac_land35(ac,land35)$(not sameas(land35,"new") AND pc35_other(j,land35) > 0),(v35_other.l(j,land35)/pc35_other(j,land35))*p35_other(t,j,ac,"before"))$(ord(ac) > 1);
);

*secdforest age class calculation
p35_secdforest(t,j,ac,"after") =
        v35_secdforest.l(j,"new")$(ord(ac) = 1)
        + sum(ac_land35(ac,land35)$(not sameas(land35,"new") AND pc35_secdforest(j,land35) > 0),(v35_secdforest.l(j,land35)/pc35_secdforest(j,land35))*p35_secdforest(t,j,ac,"before"))$(ord(ac) > 1);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov35_secdforest(t,j,land35,"marginal")           = v35_secdforest.m(j,land35);
 ov35_other(t,j,land35,"marginal")                = v35_other.m(j,land35);
 ov_landdiff_natveg(t,"marginal")                 = vm_landdiff_natveg.m;
 ov35_other_expansion(t,j,land35,"marginal")      = v35_other_expansion.m(j,land35);
 ov35_other_reduction(t,j,land35,"marginal")      = v35_other_reduction.m(j,land35);
 ov35_secdforest_reduction(t,j,land35,"marginal") = v35_secdforest_reduction.m(j,land35);
 ov35_primforest_reduction(t,j,"marginal")        = v35_primforest_reduction.m(j);
 oq35_land_secdforest(t,j,"marginal")             = q35_land_secdforest.m(j);
 oq35_land_other(t,j,"marginal")                  = q35_land_other.m(j);
 oq35_carbon_primforest(t,j,c_pools,"marginal")   = q35_carbon_primforest.m(j,c_pools);
 oq35_carbon_secdforest(t,j,c_pools,"marginal")   = q35_carbon_secdforest.m(j,c_pools);
 oq35_carbon_other(t,j,c_pools,"marginal")        = q35_carbon_other.m(j,c_pools);
 oq35_landdiff(t,"marginal")                      = q35_landdiff.m;
 oq35_other_expansion(t,j,land35,"marginal")      = q35_other_expansion.m(j,land35);
 oq35_other_reduction(t,j,land35,"marginal")      = q35_other_reduction.m(j,land35);
 oq35_secdforest_reduction(t,j,land35,"marginal") = q35_secdforest_reduction.m(j,land35);
 oq35_primforest_reduction(t,j,"marginal")        = q35_primforest_reduction.m(j);
 oq35_min_forest(t,j,"marginal")                  = q35_min_forest.m(j);
 oq35_min_other(t,j,"marginal")                   = q35_min_other.m(j);
 ov35_secdforest(t,j,land35,"level")              = v35_secdforest.l(j,land35);
 ov35_other(t,j,land35,"level")                   = v35_other.l(j,land35);
 ov_landdiff_natveg(t,"level")                    = vm_landdiff_natveg.l;
 ov35_other_expansion(t,j,land35,"level")         = v35_other_expansion.l(j,land35);
 ov35_other_reduction(t,j,land35,"level")         = v35_other_reduction.l(j,land35);
 ov35_secdforest_reduction(t,j,land35,"level")    = v35_secdforest_reduction.l(j,land35);
 ov35_primforest_reduction(t,j,"level")           = v35_primforest_reduction.l(j);
 oq35_land_secdforest(t,j,"level")                = q35_land_secdforest.l(j);
 oq35_land_other(t,j,"level")                     = q35_land_other.l(j);
 oq35_carbon_primforest(t,j,c_pools,"level")      = q35_carbon_primforest.l(j,c_pools);
 oq35_carbon_secdforest(t,j,c_pools,"level")      = q35_carbon_secdforest.l(j,c_pools);
 oq35_carbon_other(t,j,c_pools,"level")           = q35_carbon_other.l(j,c_pools);
 oq35_landdiff(t,"level")                         = q35_landdiff.l;
 oq35_other_expansion(t,j,land35,"level")         = q35_other_expansion.l(j,land35);
 oq35_other_reduction(t,j,land35,"level")         = q35_other_reduction.l(j,land35);
 oq35_secdforest_reduction(t,j,land35,"level")    = q35_secdforest_reduction.l(j,land35);
 oq35_primforest_reduction(t,j,"level")           = q35_primforest_reduction.l(j);
 oq35_min_forest(t,j,"level")                     = q35_min_forest.l(j);
 oq35_min_other(t,j,"level")                      = q35_min_other.l(j);
 ov35_secdforest(t,j,land35,"upper")              = v35_secdforest.up(j,land35);
 ov35_other(t,j,land35,"upper")                   = v35_other.up(j,land35);
 ov_landdiff_natveg(t,"upper")                    = vm_landdiff_natveg.up;
 ov35_other_expansion(t,j,land35,"upper")         = v35_other_expansion.up(j,land35);
 ov35_other_reduction(t,j,land35,"upper")         = v35_other_reduction.up(j,land35);
 ov35_secdforest_reduction(t,j,land35,"upper")    = v35_secdforest_reduction.up(j,land35);
 ov35_primforest_reduction(t,j,"upper")           = v35_primforest_reduction.up(j);
 oq35_land_secdforest(t,j,"upper")                = q35_land_secdforest.up(j);
 oq35_land_other(t,j,"upper")                     = q35_land_other.up(j);
 oq35_carbon_primforest(t,j,c_pools,"upper")      = q35_carbon_primforest.up(j,c_pools);
 oq35_carbon_secdforest(t,j,c_pools,"upper")      = q35_carbon_secdforest.up(j,c_pools);
 oq35_carbon_other(t,j,c_pools,"upper")           = q35_carbon_other.up(j,c_pools);
 oq35_landdiff(t,"upper")                         = q35_landdiff.up;
 oq35_other_expansion(t,j,land35,"upper")         = q35_other_expansion.up(j,land35);
 oq35_other_reduction(t,j,land35,"upper")         = q35_other_reduction.up(j,land35);
 oq35_secdforest_reduction(t,j,land35,"upper")    = q35_secdforest_reduction.up(j,land35);
 oq35_primforest_reduction(t,j,"upper")           = q35_primforest_reduction.up(j);
 oq35_min_forest(t,j,"upper")                     = q35_min_forest.up(j);
 oq35_min_other(t,j,"upper")                      = q35_min_other.up(j);
 ov35_secdforest(t,j,land35,"lower")              = v35_secdforest.lo(j,land35);
 ov35_other(t,j,land35,"lower")                   = v35_other.lo(j,land35);
 ov_landdiff_natveg(t,"lower")                    = vm_landdiff_natveg.lo;
 ov35_other_expansion(t,j,land35,"lower")         = v35_other_expansion.lo(j,land35);
 ov35_other_reduction(t,j,land35,"lower")         = v35_other_reduction.lo(j,land35);
 ov35_secdforest_reduction(t,j,land35,"lower")    = v35_secdforest_reduction.lo(j,land35);
 ov35_primforest_reduction(t,j,"lower")           = v35_primforest_reduction.lo(j);
 oq35_land_secdforest(t,j,"lower")                = q35_land_secdforest.lo(j);
 oq35_land_other(t,j,"lower")                     = q35_land_other.lo(j);
 oq35_carbon_primforest(t,j,c_pools,"lower")      = q35_carbon_primforest.lo(j,c_pools);
 oq35_carbon_secdforest(t,j,c_pools,"lower")      = q35_carbon_secdforest.lo(j,c_pools);
 oq35_carbon_other(t,j,c_pools,"lower")           = q35_carbon_other.lo(j,c_pools);
 oq35_landdiff(t,"lower")                         = q35_landdiff.lo;
 oq35_other_expansion(t,j,land35,"lower")         = q35_other_expansion.lo(j,land35);
 oq35_other_reduction(t,j,land35,"lower")         = q35_other_reduction.lo(j,land35);
 oq35_secdforest_reduction(t,j,land35,"lower")    = q35_secdforest_reduction.lo(j,land35);
 oq35_primforest_reduction(t,j,"lower")           = q35_primforest_reduction.lo(j);
 oq35_min_forest(t,j,"lower")                     = q35_min_forest.lo(j);
 oq35_min_other(t,j,"lower")                      = q35_min_other.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
