*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov35_secdforest(t,j,land35,"marginal") = v35_secdforest.m(j,land35);
 ov35_other(t,j,land35,"marginal")      = v35_other.m(j,land35);
 ov_landdiff_natveg(t,"marginal")       = vm_landdiff_natveg.m;
 ov35_secdforest(t,j,land35,"level")    = v35_secdforest.l(j,land35);
 ov35_other(t,j,land35,"level")         = v35_other.l(j,land35);
 ov_landdiff_natveg(t,"level")          = vm_landdiff_natveg.l;
 ov35_secdforest(t,j,land35,"upper")    = v35_secdforest.up(j,land35);
 ov35_other(t,j,land35,"upper")         = v35_other.up(j,land35);
 ov_landdiff_natveg(t,"upper")          = vm_landdiff_natveg.up;
 ov35_secdforest(t,j,land35,"lower")    = v35_secdforest.lo(j,land35);
 ov35_other(t,j,land35,"lower")         = v35_other.lo(j,land35);
 ov_landdiff_natveg(t,"lower")          = vm_landdiff_natveg.lo;
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

