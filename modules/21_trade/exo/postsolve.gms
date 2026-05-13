*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_trade_tariff(t,i,"marginal")        = vm_cost_trade_tariff.m(i);
 ov_cost_trade_margin(t,i,"marginal")        = vm_cost_trade_margin.m(i);
 ov_cost_trade_feasibility(t,i,"marginal")   = vm_cost_trade_feasibility.m(i);
 oq21_notrade(t,h,kall,"marginal")           = q21_notrade.m(h,kall);
 oq21_cost_trade_tariff(t,h,"marginal")      = q21_cost_trade_tariff.m(h);
 oq21_cost_trade_margin(t,h,"marginal")      = q21_cost_trade_margin.m(h);
 ov_cost_trade_tariff(t,i,"level")           = vm_cost_trade_tariff.l(i);
 ov_cost_trade_margin(t,i,"level")           = vm_cost_trade_margin.l(i);
 ov_cost_trade_feasibility(t,i,"level")      = vm_cost_trade_feasibility.l(i);
 oq21_notrade(t,h,kall,"level")              = q21_notrade.l(h,kall);
 oq21_cost_trade_tariff(t,h,"level")         = q21_cost_trade_tariff.l(h);
 oq21_cost_trade_margin(t,h,"level")         = q21_cost_trade_margin.l(h);
 ov_cost_trade_tariff(t,i,"upper")           = vm_cost_trade_tariff.up(i);
 ov_cost_trade_margin(t,i,"upper")           = vm_cost_trade_margin.up(i);
 ov_cost_trade_feasibility(t,i,"upper")      = vm_cost_trade_feasibility.up(i);
 oq21_notrade(t,h,kall,"upper")              = q21_notrade.up(h,kall);
 oq21_cost_trade_tariff(t,h,"upper")         = q21_cost_trade_tariff.up(h);
 oq21_cost_trade_margin(t,h,"upper")         = q21_cost_trade_margin.up(h);
 ov_cost_trade_tariff(t,i,"lower")           = vm_cost_trade_tariff.lo(i);
 ov_cost_trade_margin(t,i,"lower")           = vm_cost_trade_margin.lo(i);
 ov_cost_trade_feasibility(t,i,"lower")      = vm_cost_trade_feasibility.lo(i);
 oq21_notrade(t,h,kall,"lower")              = q21_notrade.lo(h,kall);
 oq21_cost_trade_tariff(t,h,"lower")         = q21_cost_trade_tariff.lo(h);
 oq21_cost_trade_margin(t,h,"lower")         = q21_cost_trade_margin.lo(h);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
