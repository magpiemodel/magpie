*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_yld(t,j,kve,w,"marginal")     = vm_yld.m(j,kve,w);
 oq14_yield(t,j,kve,w,"marginal") = q14_yield.m(j,kve,w);
 ov_yld(t,j,kve,w,"level")        = vm_yld.l(j,kve,w);
 oq14_yield(t,j,kve,w,"level")    = q14_yield.l(j,kve,w);
 ov_yld(t,j,kve,w,"upper")        = vm_yld.up(j,kve,w);
 oq14_yield(t,j,kve,w,"upper")    = q14_yield.up(j,kve,w);
 ov_yld(t,j,kve,w,"lower")        = vm_yld.lo(j,kve,w);
 oq14_yield(t,j,kve,w,"lower")    = q14_yield.lo(j,kve,w);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

