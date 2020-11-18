*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

p13_tech_cost_past(t2,i) = p13_tech_cost_past(t2,i) + p13_tech_cost_annuity(i);
pc13_tau(i) = vm_tau.l(i);

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_tau(t,i,"marginal")                 = vm_tau.m(i);
 ov_tech_cost(t,i,"marginal")           = vm_tech_cost.m(i);
 ov_tau(t,i,"level")                    = vm_tau.l(i);
 ov_tech_cost(t,i,"level")              = vm_tech_cost.l(i);
 ov_tau(t,i,"upper")                    = vm_tau.up(i);
 ov_tech_cost(t,i,"upper")              = vm_tech_cost.up(i);
 ov_tau(t,i,"lower")                    = vm_tau.lo(i);
 ov_tech_cost(t,i,"lower")              = vm_tech_cost.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
