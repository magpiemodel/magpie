*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

** Deactivate this in case you want to use pasture prodn
** Cost even after calibrartion phase
s31_fac_req_past = 0;

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_prod_past(t,i,"marginal")              = vm_cost_prod_past.m(i);
 oq31_prod(t,j,"marginal")                      = q31_prod.m(j);
 oq31_carbon(t,j,ag_pools,stockType,"marginal") = q31_carbon.m(j,ag_pools,stockType);
 oq31_cost_prod_past(t,i,"marginal")            = q31_cost_prod_past.m(i);
 oq31_bv_manpast(t,j,potnatveg,"marginal")      = q31_bv_manpast.m(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"marginal")    = q31_bv_rangeland.m(j,potnatveg);
 ov_cost_prod_past(t,i,"level")                 = vm_cost_prod_past.l(i);
 oq31_prod(t,j,"level")                         = q31_prod.l(j);
 oq31_carbon(t,j,ag_pools,stockType,"level")    = q31_carbon.l(j,ag_pools,stockType);
 oq31_cost_prod_past(t,i,"level")               = q31_cost_prod_past.l(i);
 oq31_bv_manpast(t,j,potnatveg,"level")         = q31_bv_manpast.l(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"level")       = q31_bv_rangeland.l(j,potnatveg);
 ov_cost_prod_past(t,i,"upper")                 = vm_cost_prod_past.up(i);
 oq31_prod(t,j,"upper")                         = q31_prod.up(j);
 oq31_carbon(t,j,ag_pools,stockType,"upper")    = q31_carbon.up(j,ag_pools,stockType);
 oq31_cost_prod_past(t,i,"upper")               = q31_cost_prod_past.up(i);
 oq31_bv_manpast(t,j,potnatveg,"upper")         = q31_bv_manpast.up(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"upper")       = q31_bv_rangeland.up(j,potnatveg);
 ov_cost_prod_past(t,i,"lower")                 = vm_cost_prod_past.lo(i);
 oq31_prod(t,j,"lower")                         = q31_prod.lo(j);
 oq31_carbon(t,j,ag_pools,stockType,"lower")    = q31_carbon.lo(j,ag_pools,stockType);
 oq31_cost_prod_past(t,i,"lower")               = q31_cost_prod_past.lo(i);
 oq31_bv_manpast(t,j,potnatveg,"lower")         = q31_bv_manpast.lo(j,potnatveg);
 oq31_bv_rangeland(t,j,potnatveg,"lower")       = q31_bv_rangeland.lo(j,potnatveg);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

*** EOF postsolve.gms ***
