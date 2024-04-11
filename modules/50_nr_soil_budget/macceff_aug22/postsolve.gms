*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

 

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_nr_inorg_fert_reg(t,i,land_ag,"marginal") = vm_nr_inorg_fert_reg.m(i,land_ag);
 ov_nr_inorg_fert_costs(t,i,"marginal")       = vm_nr_inorg_fert_costs.m(i);
 ov_nr_eff(t,i,"marginal")                    = vm_nr_eff.m(i);
 ov_nr_eff_pasture(t,i,"marginal")            = vm_nr_eff_pasture.m(i);
 ov50_nr_inputs(t,i,"marginal")               = v50_nr_inputs.m(i);
 ov50_nr_withdrawals(t,i,kcr,"marginal")      = v50_nr_withdrawals.m(i,kcr);
 ov50_nr_surplus_cropland(t,i,"marginal")     = v50_nr_surplus_cropland.m(i);
 ov50_nr_inputs_pasture(t,i,"marginal")       = v50_nr_inputs_pasture.m(i);
 ov50_nr_withdrawals_pasture(t,i,"marginal")  = v50_nr_withdrawals_pasture.m(i);
 ov50_nr_surplus_pasture(t,i,"marginal")      = v50_nr_surplus_pasture.m(i);
 ov50_nr_deposition(t,i,land,"marginal")      = v50_nr_deposition.m(i,land);
 oq50_nr_cost_fert(t,i,"marginal")            = q50_nr_cost_fert.m(i);
 oq50_nr_bal_crp(t,i,"marginal")              = q50_nr_bal_crp.m(i);
 oq50_nr_withdrawals(t,i,kcr,"marginal")      = q50_nr_withdrawals.m(i,kcr);
 oq50_nr_inputs(t,i,"marginal")               = q50_nr_inputs.m(i);
 oq50_nr_surplus(t,i,"marginal")              = q50_nr_surplus.m(i);
 oq50_nr_bal_pasture(t,i,"marginal")          = q50_nr_bal_pasture.m(i);
 oq50_nr_inputs_pasture(t,i,"marginal")       = q50_nr_inputs_pasture.m(i);
 oq50_nr_withdrawals_pasture(t,i,"marginal")  = q50_nr_withdrawals_pasture.m(i);
 oq50_nr_surplus_pasture(t,i,"marginal")      = q50_nr_surplus_pasture.m(i);
 oq50_nr_deposition(t,i,land,"marginal")      = q50_nr_deposition.m(i,land);
 ov_nr_inorg_fert_reg(t,i,land_ag,"level")    = vm_nr_inorg_fert_reg.l(i,land_ag);
 ov_nr_inorg_fert_costs(t,i,"level")          = vm_nr_inorg_fert_costs.l(i);
 ov_nr_eff(t,i,"level")                       = vm_nr_eff.l(i);
 ov_nr_eff_pasture(t,i,"level")               = vm_nr_eff_pasture.l(i);
 ov50_nr_inputs(t,i,"level")                  = v50_nr_inputs.l(i);
 ov50_nr_withdrawals(t,i,kcr,"level")         = v50_nr_withdrawals.l(i,kcr);
 ov50_nr_surplus_cropland(t,i,"level")        = v50_nr_surplus_cropland.l(i);
 ov50_nr_inputs_pasture(t,i,"level")          = v50_nr_inputs_pasture.l(i);
 ov50_nr_withdrawals_pasture(t,i,"level")     = v50_nr_withdrawals_pasture.l(i);
 ov50_nr_surplus_pasture(t,i,"level")         = v50_nr_surplus_pasture.l(i);
 ov50_nr_deposition(t,i,land,"level")         = v50_nr_deposition.l(i,land);
 oq50_nr_cost_fert(t,i,"level")               = q50_nr_cost_fert.l(i);
 oq50_nr_bal_crp(t,i,"level")                 = q50_nr_bal_crp.l(i);
 oq50_nr_withdrawals(t,i,kcr,"level")         = q50_nr_withdrawals.l(i,kcr);
 oq50_nr_inputs(t,i,"level")                  = q50_nr_inputs.l(i);
 oq50_nr_surplus(t,i,"level")                 = q50_nr_surplus.l(i);
 oq50_nr_bal_pasture(t,i,"level")             = q50_nr_bal_pasture.l(i);
 oq50_nr_inputs_pasture(t,i,"level")          = q50_nr_inputs_pasture.l(i);
 oq50_nr_withdrawals_pasture(t,i,"level")     = q50_nr_withdrawals_pasture.l(i);
 oq50_nr_surplus_pasture(t,i,"level")         = q50_nr_surplus_pasture.l(i);
 oq50_nr_deposition(t,i,land,"level")         = q50_nr_deposition.l(i,land);
 ov_nr_inorg_fert_reg(t,i,land_ag,"upper")    = vm_nr_inorg_fert_reg.up(i,land_ag);
 ov_nr_inorg_fert_costs(t,i,"upper")          = vm_nr_inorg_fert_costs.up(i);
 ov_nr_eff(t,i,"upper")                       = vm_nr_eff.up(i);
 ov_nr_eff_pasture(t,i,"upper")               = vm_nr_eff_pasture.up(i);
 ov50_nr_inputs(t,i,"upper")                  = v50_nr_inputs.up(i);
 ov50_nr_withdrawals(t,i,kcr,"upper")         = v50_nr_withdrawals.up(i,kcr);
 ov50_nr_surplus_cropland(t,i,"upper")        = v50_nr_surplus_cropland.up(i);
 ov50_nr_inputs_pasture(t,i,"upper")          = v50_nr_inputs_pasture.up(i);
 ov50_nr_withdrawals_pasture(t,i,"upper")     = v50_nr_withdrawals_pasture.up(i);
 ov50_nr_surplus_pasture(t,i,"upper")         = v50_nr_surplus_pasture.up(i);
 ov50_nr_deposition(t,i,land,"upper")         = v50_nr_deposition.up(i,land);
 oq50_nr_cost_fert(t,i,"upper")               = q50_nr_cost_fert.up(i);
 oq50_nr_bal_crp(t,i,"upper")                 = q50_nr_bal_crp.up(i);
 oq50_nr_withdrawals(t,i,kcr,"upper")         = q50_nr_withdrawals.up(i,kcr);
 oq50_nr_inputs(t,i,"upper")                  = q50_nr_inputs.up(i);
 oq50_nr_surplus(t,i,"upper")                 = q50_nr_surplus.up(i);
 oq50_nr_bal_pasture(t,i,"upper")             = q50_nr_bal_pasture.up(i);
 oq50_nr_inputs_pasture(t,i,"upper")          = q50_nr_inputs_pasture.up(i);
 oq50_nr_withdrawals_pasture(t,i,"upper")     = q50_nr_withdrawals_pasture.up(i);
 oq50_nr_surplus_pasture(t,i,"upper")         = q50_nr_surplus_pasture.up(i);
 oq50_nr_deposition(t,i,land,"upper")         = q50_nr_deposition.up(i,land);
 ov_nr_inorg_fert_reg(t,i,land_ag,"lower")    = vm_nr_inorg_fert_reg.lo(i,land_ag);
 ov_nr_inorg_fert_costs(t,i,"lower")          = vm_nr_inorg_fert_costs.lo(i);
 ov_nr_eff(t,i,"lower")                       = vm_nr_eff.lo(i);
 ov_nr_eff_pasture(t,i,"lower")               = vm_nr_eff_pasture.lo(i);
 ov50_nr_inputs(t,i,"lower")                  = v50_nr_inputs.lo(i);
 ov50_nr_withdrawals(t,i,kcr,"lower")         = v50_nr_withdrawals.lo(i,kcr);
 ov50_nr_surplus_cropland(t,i,"lower")        = v50_nr_surplus_cropland.lo(i);
 ov50_nr_inputs_pasture(t,i,"lower")          = v50_nr_inputs_pasture.lo(i);
 ov50_nr_withdrawals_pasture(t,i,"lower")     = v50_nr_withdrawals_pasture.lo(i);
 ov50_nr_surplus_pasture(t,i,"lower")         = v50_nr_surplus_pasture.lo(i);
 ov50_nr_deposition(t,i,land,"lower")         = v50_nr_deposition.lo(i,land);
 oq50_nr_cost_fert(t,i,"lower")               = q50_nr_cost_fert.lo(i);
 oq50_nr_bal_crp(t,i,"lower")                 = q50_nr_bal_crp.lo(i);
 oq50_nr_withdrawals(t,i,kcr,"lower")         = q50_nr_withdrawals.lo(i,kcr);
 oq50_nr_inputs(t,i,"lower")                  = q50_nr_inputs.lo(i);
 oq50_nr_surplus(t,i,"lower")                 = q50_nr_surplus.lo(i);
 oq50_nr_bal_pasture(t,i,"lower")             = q50_nr_bal_pasture.lo(i);
 oq50_nr_inputs_pasture(t,i,"lower")          = q50_nr_inputs_pasture.lo(i);
 oq50_nr_withdrawals_pasture(t,i,"lower")     = q50_nr_withdrawals_pasture.lo(i);
 oq50_nr_surplus_pasture(t,i,"lower")         = q50_nr_surplus_pasture.lo(i);
 oq50_nr_deposition(t,i,land,"lower")         = q50_nr_deposition.lo(i,land);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################

