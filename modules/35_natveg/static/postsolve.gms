*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_landdiff_natveg(t,"marginal")   = vm_landdiff_natveg.m;
 ov35_other(t,j,land35,"marginal") = v35_other.m(j,land35);
 ov_landdiff_natveg(t,"level")      = vm_landdiff_natveg.l;
 ov35_other(t,j,land35,"level")    = v35_other.l(j,land35);
 ov_landdiff_natveg(t,"upper")      = vm_landdiff_natveg.up;
 ov35_other(t,j,land35,"upper")    = v35_other.up(j,land35);
 ov_landdiff_natveg(t,"lower")      = vm_landdiff_natveg.lo;
 ov35_other(t,j,land35,"lower")    = v35_other.lo(j,land35);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

