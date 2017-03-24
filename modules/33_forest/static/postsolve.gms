*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_landdiff_forest(t,"marginal")    = vm_landdiff_forest.m;
 ov33_land(t,j,land33,si,"marginal") = v33_land.m(j,land33,si);
 ov_landdiff_forest(t,"level")       = vm_landdiff_forest.l;
 ov33_land(t,j,land33,si,"level")    = v33_land.l(j,land33,si);
 ov_landdiff_forest(t,"upper")       = vm_landdiff_forest.up;
 ov33_land(t,j,land33,si,"upper")    = v33_land.up(j,land33,si);
 ov_landdiff_forest(t,"lower")       = vm_landdiff_forest.lo;
 ov33_land(t,j,land33,si,"lower")    = v33_land.lo(j,land33,si);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

