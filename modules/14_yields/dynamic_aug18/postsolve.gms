*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de




*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_yld(t,j,kve,w,"marginal")          = vm_yld.m(j,kve,w);
 oq14_yield_crop(t,j,kcr,w,"marginal") = q14_yield_crop.m(j,kcr,w);
 oq14_yield_past(t,j,w,"marginal")     = q14_yield_past.m(j,w);
 ov_yld(t,j,kve,w,"level")             = vm_yld.l(j,kve,w);
 oq14_yield_crop(t,j,kcr,w,"level")    = q14_yield_crop.l(j,kcr,w);
 oq14_yield_past(t,j,w,"level")        = q14_yield_past.l(j,w);
 ov_yld(t,j,kve,w,"upper")             = vm_yld.up(j,kve,w);
 oq14_yield_crop(t,j,kcr,w,"upper")    = q14_yield_crop.up(j,kcr,w);
 oq14_yield_past(t,j,w,"upper")        = q14_yield_past.up(j,w);
 ov_yld(t,j,kve,w,"lower")             = vm_yld.lo(j,kve,w);
 oq14_yield_crop(t,j,kcr,w,"lower")    = q14_yield_crop.lo(j,kcr,w);
 oq14_yield_past(t,j,w,"lower")        = q14_yield_past.lo(j,w);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

