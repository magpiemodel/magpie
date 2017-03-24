*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

p33_land(t,j,ac,land33,si,"after")$(pc33_land(j,land33,si) > 0) = (v33_land.l(j,land33,si)/pc33_land(j,land33,si))*p33_land(t,j,ac,land33,si,"before");

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov33_land(t,j,land33,si,"marginal") = v33_land.m(j,land33,si);
 ov_landdiff_forest(t,"marginal")    = vm_landdiff_forest.m;
 oq33_carbon(t,j,c_pools,"marginal") = q33_carbon.m(j,c_pools);
 oq33_land(t,j,si,"marginal")        = q33_land.m(j,si);
 oq33_diff(t,"marginal")             = q33_diff.m;
 oq33_defor(t,i,"marginal")          = q33_defor.m(i);
 ov33_land(t,j,land33,si,"level")    = v33_land.l(j,land33,si);
 ov_landdiff_forest(t,"level")       = vm_landdiff_forest.l;
 oq33_carbon(t,j,c_pools,"level")    = q33_carbon.l(j,c_pools);
 oq33_land(t,j,si,"level")           = q33_land.l(j,si);
 oq33_diff(t,"level")                = q33_diff.l;
 oq33_defor(t,i,"level")             = q33_defor.l(i);
 ov33_land(t,j,land33,si,"upper")    = v33_land.up(j,land33,si);
 ov_landdiff_forest(t,"upper")       = vm_landdiff_forest.up;
 oq33_carbon(t,j,c_pools,"upper")    = q33_carbon.up(j,c_pools);
 oq33_land(t,j,si,"upper")           = q33_land.up(j,si);
 oq33_diff(t,"upper")                = q33_diff.up;
 oq33_defor(t,i,"upper")             = q33_defor.up(i);
 ov33_land(t,j,land33,si,"lower")    = v33_land.lo(j,land33,si);
 ov_landdiff_forest(t,"lower")       = vm_landdiff_forest.lo;
 oq33_carbon(t,j,c_pools,"lower")    = q33_carbon.lo(j,c_pools);
 oq33_land(t,j,si,"lower")           = q33_land.lo(j,si);
 oq33_diff(t,"lower")                = q33_diff.lo;
 oq33_defor(t,i,"lower")             = q33_defor.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
