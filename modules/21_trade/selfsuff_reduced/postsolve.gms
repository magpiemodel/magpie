*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov21_excess_dem(t,k_trade,"marginal")               = v21_excess_dem.m(k_trade);
 ov21_excess_prod(t,h,k_trade,"marginal")            = v21_excess_prod.m(h,k_trade);
 ov21_import_for_feasibility(t,h,k_trade,"marginal") = v21_import_for_feasibility.m(h,k_trade);
 ov_cost_trade_tariff(t,i,"marginal")                = vm_cost_trade_tariff.m(i);
 ov_cost_trade_margin(t,i,"marginal")                = vm_cost_trade_margin.m(i);
 ov_cost_trade_feasibility(t,i,"marginal")           = vm_cost_trade_feasibility.m(i);
 oq21_trade_glo(t,k_trade,"marginal")                = q21_trade_glo.m(k_trade);
 oq21_notrade(t,h,k_notrade,"marginal")              = q21_notrade.m(h,k_notrade);
 oq21_trade_reg(t,h,k_trade,"marginal")              = q21_trade_reg.m(h,k_trade);
 oq21_trade_reg_up(t,h,k_trade,"marginal")           = q21_trade_reg_up.m(h,k_trade);
 oq21_excess_dem(t,k_trade,"marginal")               = q21_excess_dem.m(k_trade);
 oq21_excess_supply(t,h,k_trade,"marginal")          = q21_excess_supply.m(h,k_trade);
 oq21_cost_trade_tariff(t,h,"marginal")              = q21_cost_trade_tariff.m(h);
 oq21_cost_trade_margin(t,h,"marginal")              = q21_cost_trade_margin.m(h);
 oq21_cost_trade_feasibility(t,h,"marginal")         = q21_cost_trade_feasibility.m(h);
 ov21_excess_dem(t,k_trade,"level")                  = v21_excess_dem.l(k_trade);
 ov21_excess_prod(t,h,k_trade,"level")               = v21_excess_prod.l(h,k_trade);
 ov21_import_for_feasibility(t,h,k_trade,"level")    = v21_import_for_feasibility.l(h,k_trade);
 ov_cost_trade_tariff(t,i,"level")                   = vm_cost_trade_tariff.l(i);
 ov_cost_trade_margin(t,i,"level")                   = vm_cost_trade_margin.l(i);
 ov_cost_trade_feasibility(t,i,"level")              = vm_cost_trade_feasibility.l(i);
 oq21_trade_glo(t,k_trade,"level")                   = q21_trade_glo.l(k_trade);
 oq21_notrade(t,h,k_notrade,"level")                 = q21_notrade.l(h,k_notrade);
 oq21_trade_reg(t,h,k_trade,"level")                 = q21_trade_reg.l(h,k_trade);
 oq21_trade_reg_up(t,h,k_trade,"level")              = q21_trade_reg_up.l(h,k_trade);
 oq21_excess_dem(t,k_trade,"level")                  = q21_excess_dem.l(k_trade);
 oq21_excess_supply(t,h,k_trade,"level")             = q21_excess_supply.l(h,k_trade);
 oq21_cost_trade_tariff(t,h,"level")                 = q21_cost_trade_tariff.l(h);
 oq21_cost_trade_margin(t,h,"level")                 = q21_cost_trade_margin.l(h);
 oq21_cost_trade_feasibility(t,h,"level")            = q21_cost_trade_feasibility.l(h);
 ov21_excess_dem(t,k_trade,"upper")                  = v21_excess_dem.up(k_trade);
 ov21_excess_prod(t,h,k_trade,"upper")               = v21_excess_prod.up(h,k_trade);
 ov21_import_for_feasibility(t,h,k_trade,"upper")    = v21_import_for_feasibility.up(h,k_trade);
 ov_cost_trade_tariff(t,i,"upper")                   = vm_cost_trade_tariff.up(i);
 ov_cost_trade_margin(t,i,"upper")                   = vm_cost_trade_margin.up(i);
 ov_cost_trade_feasibility(t,i,"upper")              = vm_cost_trade_feasibility.up(i);
 oq21_trade_glo(t,k_trade,"upper")                   = q21_trade_glo.up(k_trade);
 oq21_notrade(t,h,k_notrade,"upper")                 = q21_notrade.up(h,k_notrade);
 oq21_trade_reg(t,h,k_trade,"upper")                 = q21_trade_reg.up(h,k_trade);
 oq21_trade_reg_up(t,h,k_trade,"upper")              = q21_trade_reg_up.up(h,k_trade);
 oq21_excess_dem(t,k_trade,"upper")                  = q21_excess_dem.up(k_trade);
 oq21_excess_supply(t,h,k_trade,"upper")             = q21_excess_supply.up(h,k_trade);
 oq21_cost_trade_tariff(t,h,"upper")                 = q21_cost_trade_tariff.up(h);
 oq21_cost_trade_margin(t,h,"upper")                 = q21_cost_trade_margin.up(h);
 oq21_cost_trade_feasibility(t,h,"upper")            = q21_cost_trade_feasibility.up(h);
 ov21_excess_dem(t,k_trade,"lower")                  = v21_excess_dem.lo(k_trade);
 ov21_excess_prod(t,h,k_trade,"lower")               = v21_excess_prod.lo(h,k_trade);
 ov21_import_for_feasibility(t,h,k_trade,"lower")    = v21_import_for_feasibility.lo(h,k_trade);
 ov_cost_trade_tariff(t,i,"lower")                   = vm_cost_trade_tariff.lo(i);
 ov_cost_trade_margin(t,i,"lower")                   = vm_cost_trade_margin.lo(i);
 ov_cost_trade_feasibility(t,i,"lower")              = vm_cost_trade_feasibility.lo(i);
 oq21_trade_glo(t,k_trade,"lower")                   = q21_trade_glo.lo(k_trade);
 oq21_notrade(t,h,k_notrade,"lower")                 = q21_notrade.lo(h,k_notrade);
 oq21_trade_reg(t,h,k_trade,"lower")                 = q21_trade_reg.lo(h,k_trade);
 oq21_trade_reg_up(t,h,k_trade,"lower")              = q21_trade_reg_up.lo(h,k_trade);
 oq21_excess_dem(t,k_trade,"lower")                  = q21_excess_dem.lo(k_trade);
 oq21_excess_supply(t,h,k_trade,"lower")             = q21_excess_supply.lo(h,k_trade);
 oq21_cost_trade_tariff(t,h,"lower")                 = q21_cost_trade_tariff.lo(h);
 oq21_cost_trade_margin(t,h,"lower")                 = q21_cost_trade_margin.lo(h);
 oq21_cost_trade_feasibility(t,h,"lower")            = q21_cost_trade_feasibility.lo(h);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
