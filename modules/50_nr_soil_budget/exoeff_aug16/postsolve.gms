*** (C) 2008-2017 Potsdam Institute for Climate Impact Research (PIK),
*** authors, and contributors see AUTHORS file
*** This file is part of MAgPIE and licensed under GNU AGPL Version 3 
*** or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** Contact: magpie@pik-potsdam.de

 

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_nr_inorg_fert_reg(t,i,"marginal")    = vm_nr_inorg_fert_reg.m(i);
 ov_nr_inorg_fert_costs(t,i,"marginal")  = vm_nr_inorg_fert_costs.m(i);
 ov50_nr_eff(t,i,"marginal")             = v50_nr_eff.m(i);
 ov50_nr_withdrawals(t,i,kcr,"marginal") = v50_nr_withdrawals.m(i,kcr);
 oq50_nr_cost_fert(t,i,"marginal")       = q50_nr_cost_fert.m(i);
 oq50_nr_bal_crp(t,i,"marginal")         = q50_nr_bal_crp.m(i);
 oq50_nr_withdrawals(t,i,kcr,"marginal") = q50_nr_withdrawals.m(i,kcr);
 ov_nr_inorg_fert_reg(t,i,"level")       = vm_nr_inorg_fert_reg.l(i);
 ov_nr_inorg_fert_costs(t,i,"level")     = vm_nr_inorg_fert_costs.l(i);
 ov50_nr_eff(t,i,"level")                = v50_nr_eff.l(i);
 ov50_nr_withdrawals(t,i,kcr,"level")    = v50_nr_withdrawals.l(i,kcr);
 oq50_nr_cost_fert(t,i,"level")          = q50_nr_cost_fert.l(i);
 oq50_nr_bal_crp(t,i,"level")            = q50_nr_bal_crp.l(i);
 oq50_nr_withdrawals(t,i,kcr,"level")    = q50_nr_withdrawals.l(i,kcr);
 ov_nr_inorg_fert_reg(t,i,"upper")       = vm_nr_inorg_fert_reg.up(i);
 ov_nr_inorg_fert_costs(t,i,"upper")     = vm_nr_inorg_fert_costs.up(i);
 ov50_nr_eff(t,i,"upper")                = v50_nr_eff.up(i);
 ov50_nr_withdrawals(t,i,kcr,"upper")    = v50_nr_withdrawals.up(i,kcr);
 oq50_nr_cost_fert(t,i,"upper")          = q50_nr_cost_fert.up(i);
 oq50_nr_bal_crp(t,i,"upper")            = q50_nr_bal_crp.up(i);
 oq50_nr_withdrawals(t,i,kcr,"upper")    = q50_nr_withdrawals.up(i,kcr);
 ov_nr_inorg_fert_reg(t,i,"lower")       = vm_nr_inorg_fert_reg.lo(i);
 ov_nr_inorg_fert_costs(t,i,"lower")     = vm_nr_inorg_fert_costs.lo(i);
 ov50_nr_eff(t,i,"lower")                = v50_nr_eff.lo(i);
 ov50_nr_withdrawals(t,i,kcr,"lower")    = v50_nr_withdrawals.lo(i,kcr);
 oq50_nr_cost_fert(t,i,"lower")          = q50_nr_cost_fert.lo(i);
 oq50_nr_bal_crp(t,i,"lower")            = q50_nr_bal_crp.lo(i);
 oq50_nr_withdrawals(t,i,kcr,"lower")    = q50_nr_withdrawals.lo(i,kcr);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

