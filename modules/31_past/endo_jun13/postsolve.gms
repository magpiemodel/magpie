*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

s31_fac_req_past = 0;

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 oq31_prod(t,j,"marginal")            = q31_prod.m(j);
 oq31_carbon(t,j,ag_pools,"marginal") = q31_carbon.m(j,ag_pools);
 oq31_cost_prod_past(t,i,"marginal")  = q31_cost_prod_past.m(i);
 oq31_prod(t,j,"level")               = q31_prod.l(j);
 oq31_carbon(t,j,ag_pools,"level")    = q31_carbon.l(j,ag_pools);
 oq31_cost_prod_past(t,i,"level")     = q31_cost_prod_past.l(i);
 oq31_prod(t,j,"upper")               = q31_prod.up(j);
 oq31_carbon(t,j,ag_pools,"upper")    = q31_carbon.up(j,ag_pools);
 oq31_cost_prod_past(t,i,"upper")     = q31_cost_prod_past.up(i);
 oq31_prod(t,j,"lower")               = q31_prod.lo(j);
 oq31_carbon(t,j,ag_pools,"lower")    = q31_carbon.lo(j,ag_pools);
 oq31_cost_prod_past(t,i,"lower")     = q31_cost_prod_past.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

*** EOF postsolve.gms ***
