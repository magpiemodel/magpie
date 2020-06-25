*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

* Overall TC cost for the current timestep
 p13_oall_cost_tc(t,i) = vm_tech_cost.l(i)*(1+pm_interest(t,i))/pm_interest(t,i);


if((ord(t)>1),
 pc13_tcguess(i) = (vm_tau.l(i)/pc13_tau(i))**(1/m_yeardiff(t)) - 1;
);

pc13_tau(i) = vm_tau.l(i);


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_tau(t,i,"marginal")         = vm_tau.m(i);
 ov_tech_cost(t,i,"marginal")   = vm_tech_cost.m(i);
 ov13_cost_tc(t,i,"marginal")   = v13_cost_tc.m(i);
 oq13_tech_cost(t,i,"marginal") = q13_tech_cost.m(i);
 oq13_cost_tc(t,i,"marginal")   = q13_cost_tc.m(i);
 ov_tau(t,i,"level")            = vm_tau.l(i);
 ov_tech_cost(t,i,"level")      = vm_tech_cost.l(i);
 ov13_cost_tc(t,i,"level")      = v13_cost_tc.l(i);
 oq13_tech_cost(t,i,"level")    = q13_tech_cost.l(i);
 oq13_cost_tc(t,i,"level")      = q13_cost_tc.l(i);
 ov_tau(t,i,"upper")            = vm_tau.up(i);
 ov_tech_cost(t,i,"upper")      = vm_tech_cost.up(i);
 ov13_cost_tc(t,i,"upper")      = v13_cost_tc.up(i);
 oq13_tech_cost(t,i,"upper")    = q13_tech_cost.up(i);
 oq13_cost_tc(t,i,"upper")      = q13_cost_tc.up(i);
 ov_tau(t,i,"lower")            = vm_tau.lo(i);
 ov_tech_cost(t,i,"lower")      = vm_tech_cost.lo(i);
 ov13_cost_tc(t,i,"lower")      = v13_cost_tc.lo(i);
 oq13_tech_cost(t,i,"lower")    = q13_tech_cost.lo(i);
 oq13_cost_tc(t,i,"lower")      = q13_cost_tc.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
