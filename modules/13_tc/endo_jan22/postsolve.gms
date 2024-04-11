*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Overall TC cost for the current timestep

if((ord(t)>1),
 pc13_tcguess(h,tautype) = (vm_tau.l(h,tautype)/pcm_tau(h, tautype))**(1/m_yeardiff(t)) - 1;
);

pcm_tau(h, tautype) = vm_tau.l(h, tautype);


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_tau(t,h,tautype,"marginal")         = vm_tau.m(h,tautype);
 ov_tech_cost(t,i,"marginal")           = vm_tech_cost.m(i);
 ov13_cost_tc(t,i,tautype,"marginal")   = v13_cost_tc.m(i,tautype);
 ov13_tech_cost(t,i,tautype,"marginal") = v13_tech_cost.m(i,tautype);
 oq13_tech_cost(t,i,tautype,"marginal") = q13_tech_cost.m(i,tautype);
 oq13_cost_tc(t,i,tautype,"marginal")   = q13_cost_tc.m(i,tautype);
 oq13_tech_cost_sum(t,i,"marginal")     = q13_tech_cost_sum.m(i);
 ov_tau(t,h,tautype,"level")            = vm_tau.l(h,tautype);
 ov_tech_cost(t,i,"level")              = vm_tech_cost.l(i);
 ov13_cost_tc(t,i,tautype,"level")      = v13_cost_tc.l(i,tautype);
 ov13_tech_cost(t,i,tautype,"level")    = v13_tech_cost.l(i,tautype);
 oq13_tech_cost(t,i,tautype,"level")    = q13_tech_cost.l(i,tautype);
 oq13_cost_tc(t,i,tautype,"level")      = q13_cost_tc.l(i,tautype);
 oq13_tech_cost_sum(t,i,"level")        = q13_tech_cost_sum.l(i);
 ov_tau(t,h,tautype,"upper")            = vm_tau.up(h,tautype);
 ov_tech_cost(t,i,"upper")              = vm_tech_cost.up(i);
 ov13_cost_tc(t,i,tautype,"upper")      = v13_cost_tc.up(i,tautype);
 ov13_tech_cost(t,i,tautype,"upper")    = v13_tech_cost.up(i,tautype);
 oq13_tech_cost(t,i,tautype,"upper")    = q13_tech_cost.up(i,tautype);
 oq13_cost_tc(t,i,tautype,"upper")      = q13_cost_tc.up(i,tautype);
 oq13_tech_cost_sum(t,i,"upper")        = q13_tech_cost_sum.up(i);
 ov_tau(t,h,tautype,"lower")            = vm_tau.lo(h,tautype);
 ov_tech_cost(t,i,"lower")              = vm_tech_cost.lo(i);
 ov13_cost_tc(t,i,tautype,"lower")      = v13_cost_tc.lo(i,tautype);
 ov13_tech_cost(t,i,tautype,"lower")    = v13_tech_cost.lo(i,tautype);
 oq13_tech_cost(t,i,tautype,"lower")    = q13_tech_cost.lo(i,tautype);
 oq13_cost_tc(t,i,tautype,"lower")      = q13_cost_tc.lo(i,tautype);
 oq13_tech_cost_sum(t,i,"lower")        = q13_tech_cost_sum.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
