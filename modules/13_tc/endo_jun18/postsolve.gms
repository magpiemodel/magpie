*** |  (C) 2008-2021 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Overall TC cost for the current timestep

if((ord(t)>1),
 pc13_tcguess(h) = (vm_tau.l(h)/pcm_tau(h))**(1/m_yeardiff(t)) - 1;
);

pcm_tau(h) = vm_tau.l(h);


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_tau(t,h,"marginal")         = vm_tau.m(h);
 ov_tech_cost(t,i,"marginal")   = vm_tech_cost.m(i);
 ov13_cost_tc(t,i,"marginal")   = v13_cost_tc.m(i);
 oq13_tech_cost(t,i,"marginal") = q13_tech_cost.m(i);
 oq13_cost_tc(t,i,"marginal")   = q13_cost_tc.m(i);
 ov_tau(t,h,"level")            = vm_tau.l(h);
 ov_tech_cost(t,i,"level")      = vm_tech_cost.l(i);
 ov13_cost_tc(t,i,"level")      = v13_cost_tc.l(i);
 oq13_tech_cost(t,i,"level")    = q13_tech_cost.l(i);
 oq13_cost_tc(t,i,"level")      = q13_cost_tc.l(i);
 ov_tau(t,h,"upper")            = vm_tau.up(h);
 ov_tech_cost(t,i,"upper")      = vm_tech_cost.up(i);
 ov13_cost_tc(t,i,"upper")      = v13_cost_tc.up(i);
 oq13_tech_cost(t,i,"upper")    = q13_tech_cost.up(i);
 oq13_cost_tc(t,i,"upper")      = q13_cost_tc.up(i);
 ov_tau(t,h,"lower")            = vm_tau.lo(h);
 ov_tech_cost(t,i,"lower")      = vm_tech_cost.lo(i);
 ov13_cost_tc(t,i,"lower")      = v13_cost_tc.lo(i);
 oq13_tech_cost(t,i,"lower")    = q13_tech_cost.lo(i);
 oq13_cost_tc(t,i,"lower")      = q13_cost_tc.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
