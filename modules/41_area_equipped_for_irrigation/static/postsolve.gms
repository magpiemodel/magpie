*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_AEI(t,i,"marginal")     = vm_cost_AEI.m(i);
 ov41_AEI(t,j,"marginal")        = v41_AEI.m(j);
 oq41_area_irrig(t,j,"marginal") = q41_area_irrig.m(j);
 ov_cost_AEI(t,i,"level")        = vm_cost_AEI.l(i);
 ov41_AEI(t,j,"level")           = v41_AEI.l(j);
 oq41_area_irrig(t,j,"level")    = q41_area_irrig.l(j);
 ov_cost_AEI(t,i,"upper")        = vm_cost_AEI.up(i);
 ov41_AEI(t,j,"upper")           = v41_AEI.up(j);
 oq41_area_irrig(t,j,"upper")    = q41_area_irrig.up(j);
 ov_cost_AEI(t,i,"lower")        = vm_cost_AEI.lo(i);
 ov41_AEI(t,j,"lower")           = v41_AEI.lo(j);
 oq41_area_irrig(t,j,"lower")    = q41_area_irrig.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

