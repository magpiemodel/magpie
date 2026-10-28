*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Overall TC cost for the current timestep

if ((ord(t)>1),
 pc13_tcguess(i,tautype) = (v13_tau_core.l(i,tautype)/pcm_tau_core(i, tautype))**(1/m_yeardiff(t)) - 1;
);

pcm_tau_core(i, tautype) = v13_tau_core.l(i, tautype);
pc13_tau_consv(i, tautype) = v13_tau_consv.l(i, tautype);


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov13_tau_core(t,i,tautype,"marginal")  = v13_tau_core.m(i,tautype);
 ov_tech_cost(t,i,"marginal")           = vm_tech_cost.m(i);
 ov13_cost_tc(t,i,tautype,"marginal")   = v13_cost_tc.m(i,tautype);
 ov13_tech_cost(t,i,tautype,"marginal") = v13_tech_cost.m(i,tautype);
 ov_tau(t,j,tautype,"marginal")         = vm_tau.m(j,tautype);
 ov13_tau_consv(t,i,tautype,"marginal") = v13_tau_consv.m(i,tautype);
 oq13_tech_cost(t,i,tautype,"marginal") = q13_tech_cost.m(i,tautype);
 oq13_cost_tc(t,i,tautype,"marginal")   = q13_cost_tc.m(i,tautype);
 oq13_tech_cost_sum(t,i,"marginal")     = q13_tech_cost_sum.m(i);
 oq13_tau(t,j,tautype,"marginal")       = q13_tau.m(j,tautype);
 oq13_tau_consv(t,i,tautype,"marginal") = q13_tau_consv.m(i,tautype);
 oq13_lower_bound_tau(t,i,"marginal")   = q13_lower_bound_tau.m(i);
 ov13_tau_core(t,i,tautype,"level")     = v13_tau_core.l(i,tautype);
 ov_tech_cost(t,i,"level")              = vm_tech_cost.l(i);
 ov13_cost_tc(t,i,tautype,"level")      = v13_cost_tc.l(i,tautype);
 ov13_tech_cost(t,i,tautype,"level")    = v13_tech_cost.l(i,tautype);
 ov_tau(t,j,tautype,"level")            = vm_tau.l(j,tautype);
 ov13_tau_consv(t,i,tautype,"level")    = v13_tau_consv.l(i,tautype);
 oq13_tech_cost(t,i,tautype,"level")    = q13_tech_cost.l(i,tautype);
 oq13_cost_tc(t,i,tautype,"level")      = q13_cost_tc.l(i,tautype);
 oq13_tech_cost_sum(t,i,"level")        = q13_tech_cost_sum.l(i);
 oq13_tau(t,j,tautype,"level")          = q13_tau.l(j,tautype);
 oq13_tau_consv(t,i,tautype,"level")    = q13_tau_consv.l(i,tautype);
 oq13_lower_bound_tau(t,i,"level")      = q13_lower_bound_tau.l(i);
 ov13_tau_core(t,i,tautype,"upper")     = v13_tau_core.up(i,tautype);
 ov_tech_cost(t,i,"upper")              = vm_tech_cost.up(i);
 ov13_cost_tc(t,i,tautype,"upper")      = v13_cost_tc.up(i,tautype);
 ov13_tech_cost(t,i,tautype,"upper")    = v13_tech_cost.up(i,tautype);
 ov_tau(t,j,tautype,"upper")            = vm_tau.up(j,tautype);
 ov13_tau_consv(t,i,tautype,"upper")    = v13_tau_consv.up(i,tautype);
 oq13_tech_cost(t,i,tautype,"upper")    = q13_tech_cost.up(i,tautype);
 oq13_cost_tc(t,i,tautype,"upper")      = q13_cost_tc.up(i,tautype);
 oq13_tech_cost_sum(t,i,"upper")        = q13_tech_cost_sum.up(i);
 oq13_tau(t,j,tautype,"upper")          = q13_tau.up(j,tautype);
 oq13_tau_consv(t,i,tautype,"upper")    = q13_tau_consv.up(i,tautype);
 oq13_lower_bound_tau(t,i,"upper")      = q13_lower_bound_tau.up(i);
 ov13_tau_core(t,i,tautype,"lower")     = v13_tau_core.lo(i,tautype);
 ov_tech_cost(t,i,"lower")              = vm_tech_cost.lo(i);
 ov13_cost_tc(t,i,tautype,"lower")      = v13_cost_tc.lo(i,tautype);
 ov13_tech_cost(t,i,tautype,"lower")    = v13_tech_cost.lo(i,tautype);
 ov_tau(t,j,tautype,"lower")            = vm_tau.lo(j,tautype);
 ov13_tau_consv(t,i,tautype,"lower")    = v13_tau_consv.lo(i,tautype);
 oq13_tech_cost(t,i,tautype,"lower")    = q13_tech_cost.lo(i,tautype);
 oq13_cost_tc(t,i,tautype,"lower")      = q13_cost_tc.lo(i,tautype);
 oq13_tech_cost_sum(t,i,"lower")        = q13_tech_cost_sum.lo(i);
 oq13_tau(t,j,tautype,"lower")          = q13_tau.lo(j,tautype);
 oq13_tau_consv(t,i,tautype,"lower")    = q13_tau_consv.lo(i,tautype);
 oq13_lower_bound_tau(t,i,"lower")      = q13_lower_bound_tau.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
