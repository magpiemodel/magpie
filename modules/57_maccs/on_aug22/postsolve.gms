*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de



*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_maccs_costs(t,i,factors,"marginal") = vm_maccs_costs.m(i,factors);
 oq57_labor_costs(t,i,"marginal")       = q57_labor_costs.m(i);
 oq57_capital_costs(t,i,"marginal")     = q57_capital_costs.m(i);
 ov_maccs_costs(t,i,factors,"level")    = vm_maccs_costs.l(i,factors);
 oq57_labor_costs(t,i,"level")          = q57_labor_costs.l(i);
 oq57_capital_costs(t,i,"level")        = q57_capital_costs.l(i);
 ov_maccs_costs(t,i,factors,"upper")    = vm_maccs_costs.up(i,factors);
 oq57_labor_costs(t,i,"upper")          = q57_labor_costs.up(i);
 oq57_capital_costs(t,i,"upper")        = q57_capital_costs.up(i);
 ov_maccs_costs(t,i,factors,"lower")    = vm_maccs_costs.lo(i,factors);
 oq57_labor_costs(t,i,"lower")          = q57_labor_costs.lo(i);
 oq57_capital_costs(t,i,"lower")        = q57_capital_costs.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
