*** (C) 2008-2016 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_landdiff_other(t,"marginal")     = vm_landdiff_other.m;
 ov35_land(t,j,land35,si,"marginal") = v35_land.m(j,land35,si);
 ov_landdiff_other(t,"level")        = vm_landdiff_other.l;
 ov35_land(t,j,land35,si,"level")    = v35_land.l(j,land35,si);
 ov_landdiff_other(t,"upper")        = vm_landdiff_other.up;
 ov35_land(t,j,land35,si,"upper")    = v35_land.up(j,land35,si);
 ov_landdiff_other(t,"lower")        = vm_landdiff_other.lo;
 ov35_land(t,j,land35,si,"lower")    = v35_land.lo(j,land35,si);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

