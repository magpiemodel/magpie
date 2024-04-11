*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_AEI(t,i,"marginal")     = vm_cost_AEI.m(i);
 ov_AEI(t,j,"marginal")          = vm_AEI.m(j);
 oq41_area_irrig(t,j,"marginal") = q41_area_irrig.m(j);
 ov_cost_AEI(t,i,"level")        = vm_cost_AEI.l(i);
 ov_AEI(t,j,"level")             = vm_AEI.l(j);
 oq41_area_irrig(t,j,"level")    = q41_area_irrig.l(j);
 ov_cost_AEI(t,i,"upper")        = vm_cost_AEI.up(i);
 ov_AEI(t,j,"upper")             = vm_AEI.up(j);
 oq41_area_irrig(t,j,"upper")    = q41_area_irrig.up(j);
 ov_cost_AEI(t,i,"lower")        = vm_cost_AEI.lo(i);
 ov_AEI(t,j,"lower")             = vm_AEI.lo(j);
 oq41_area_irrig(t,j,"lower")    = q41_area_irrig.lo(j);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
