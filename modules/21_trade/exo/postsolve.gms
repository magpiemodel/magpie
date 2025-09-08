*** |  (C) 2008-2025 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_trade(t,i,"marginal")               = vm_cost_trade.m(i);
 ov21_cost_trade_reg(t,h,k_trade,"marginal") = v21_cost_trade_reg.m(h,k_trade);
 oq21_notrade(t,h,kall,"marginal")           = q21_notrade.m(h,kall);
 oq21_cost_trade(t,h,"marginal")             = q21_cost_trade.m(h);
 oq21_cost_trade_reg(t,h,k_trade,"marginal") = q21_cost_trade_reg.m(h,k_trade);
 ov_cost_trade(t,i,"level")                  = vm_cost_trade.l(i);
 ov21_cost_trade_reg(t,h,k_trade,"level")    = v21_cost_trade_reg.l(h,k_trade);
 oq21_notrade(t,h,kall,"level")              = q21_notrade.l(h,kall);
 oq21_cost_trade(t,h,"level")                = q21_cost_trade.l(h);
 oq21_cost_trade_reg(t,h,k_trade,"level")    = q21_cost_trade_reg.l(h,k_trade);
 ov_cost_trade(t,i,"upper")                  = vm_cost_trade.up(i);
 ov21_cost_trade_reg(t,h,k_trade,"upper")    = v21_cost_trade_reg.up(h,k_trade);
 oq21_notrade(t,h,kall,"upper")              = q21_notrade.up(h,kall);
 oq21_cost_trade(t,h,"upper")                = q21_cost_trade.up(h);
 oq21_cost_trade_reg(t,h,k_trade,"upper")    = q21_cost_trade_reg.up(h,k_trade);
 ov_cost_trade(t,i,"lower")                  = vm_cost_trade.lo(i);
 ov21_cost_trade_reg(t,h,k_trade,"lower")    = v21_cost_trade_reg.lo(h,k_trade);
 oq21_notrade(t,h,kall,"lower")              = q21_notrade.lo(h,kall);
 oq21_cost_trade(t,h,"lower")                = q21_cost_trade.lo(h);
 oq21_cost_trade_reg(t,h,k_trade,"lower")    = q21_cost_trade_reg.lo(h,k_trade);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
