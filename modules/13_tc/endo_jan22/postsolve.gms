*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Overall TC cost for the current timestep

if((ord(t)>1),
 pc13_tcguess(h,tautype) = (v13_tau_core.l(h,tautype)/pc13_tau(h, tautype))**(1/m_yeardiff(t)) - 1;
);

pc13_tau(h, tautype) = v13_tau_core.l(h, tautype);
pc13_tau_consv(h, tautype) = v13_tau_consv.l(h, tautype);
pcm_tau(j, tautype) = vm_tau.l(j, tautype);


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov13_tau_core(t,h,tautype,"marginal")       = v13_tau_core.m(h,tautype);
 ov_tech_cost(t,i,"marginal")           = vm_tech_cost.m(i);
 ov13_cost_tc(t,i,tautype,"marginal")   = v13_cost_tc.m(i,tautype);
 ov13_tech_cost(t,i,tautype,"marginal") = v13_tech_cost.m(i,tautype);
 ov_tau(t,j,tautype,"marginal")         = vm_tau.m(j,tautype);
 ov13_tau_consv(t,h,tautype,"marginal") = v13_tau_consv.m(h,tautype);
 oq13_tech_cost(t,i,tautype,"marginal") = q13_tech_cost.m(i,tautype);
 oq13_cost_tc(t,i,tautype,"marginal")   = q13_cost_tc.m(i,tautype);
 oq13_tech_cost_sum(t,i,"marginal")     = q13_tech_cost_sum.m(i);
 oq13_tau(t,j,tautype,"marginal")       = q13_tau.m(j,tautype);
 oq13_tau_consv(t,h,tautype,"marginal") = q13_tau_consv.m(h,tautype);
 ov13_tau_core(t,h,tautype,"level")          = v13_tau_core.l(h,tautype);
 ov_tech_cost(t,i,"level")              = vm_tech_cost.l(i);
 ov13_cost_tc(t,i,tautype,"level")      = v13_cost_tc.l(i,tautype);
 ov13_tech_cost(t,i,tautype,"level")    = v13_tech_cost.l(i,tautype);
 ov_tau(t,j,tautype,"level")            = vm_tau.l(j,tautype);
 ov13_tau_consv(t,h,tautype,"level")    = v13_tau_consv.l(h,tautype);
 oq13_tech_cost(t,i,tautype,"level")    = q13_tech_cost.l(i,tautype);
 oq13_cost_tc(t,i,tautype,"level")      = q13_cost_tc.l(i,tautype);
 oq13_tech_cost_sum(t,i,"level")        = q13_tech_cost_sum.l(i);
 oq13_tau(t,j,tautype,"level")          = q13_tau.l(j,tautype);
 oq13_tau_consv(t,h,tautype,"level")    = q13_tau_consv.l(h,tautype);
 ov13_tau_core(t,h,tautype,"upper")          = v13_tau_core.up(h,tautype);
 ov_tech_cost(t,i,"upper")              = vm_tech_cost.up(i);
 ov13_cost_tc(t,i,tautype,"upper")      = v13_cost_tc.up(i,tautype);
 ov13_tech_cost(t,i,tautype,"upper")    = v13_tech_cost.up(i,tautype);
 ov_tau(t,j,tautype,"upper")            = vm_tau.up(j,tautype);
 ov13_tau_consv(t,h,tautype,"upper")    = v13_tau_consv.up(h,tautype);
 oq13_tech_cost(t,i,tautype,"upper")    = q13_tech_cost.up(i,tautype);
 oq13_cost_tc(t,i,tautype,"upper")      = q13_cost_tc.up(i,tautype);
 oq13_tech_cost_sum(t,i,"upper")        = q13_tech_cost_sum.up(i);
 oq13_tau(t,j,tautype,"upper")          = q13_tau.up(j,tautype);
 oq13_tau_consv(t,h,tautype,"upper")    = q13_tau_consv.up(h,tautype);
 ov13_tau_core(t,h,tautype,"lower")          = v13_tau_core.lo(h,tautype);
 ov_tech_cost(t,i,"lower")              = vm_tech_cost.lo(i);
 ov13_cost_tc(t,i,tautype,"lower")      = v13_cost_tc.lo(i,tautype);
 ov13_tech_cost(t,i,tautype,"lower")    = v13_tech_cost.lo(i,tautype);
 ov_tau(t,j,tautype,"lower")            = vm_tau.lo(j,tautype);
 ov13_tau_consv(t,h,tautype,"lower")    = v13_tau_consv.lo(h,tautype);
 oq13_tech_cost(t,i,tautype,"lower")    = q13_tech_cost.lo(i,tautype);
 oq13_cost_tc(t,i,tautype,"lower")      = q13_cost_tc.lo(i,tautype);
 oq13_tech_cost_sum(t,i,"lower")        = q13_tech_cost_sum.lo(i);
 oq13_tau(t,j,tautype,"lower")          = q13_tau.lo(j,tautype);
 oq13_tau_consv(t,h,tautype,"lower")    = q13_tau_consv.lo(h,tautype);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
