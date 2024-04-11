*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_trade(t,i,"marginal")          = vm_cost_trade.m(i);
 oq21_trade_glo(t,k_trade,"marginal")   = q21_trade_glo.m(k_trade);
 oq21_notrade(t,h,k_notrade,"marginal") = q21_notrade.m(h,k_notrade);
 ov_cost_trade(t,i,"level")             = vm_cost_trade.l(i);
 oq21_trade_glo(t,k_trade,"level")      = q21_trade_glo.l(k_trade);
 oq21_notrade(t,h,k_notrade,"level")    = q21_notrade.l(h,k_notrade);
 ov_cost_trade(t,i,"upper")             = vm_cost_trade.up(i);
 oq21_trade_glo(t,k_trade,"upper")      = q21_trade_glo.up(k_trade);
 oq21_notrade(t,h,k_notrade,"upper")    = q21_notrade.up(h,k_notrade);
 ov_cost_trade(t,i,"lower")             = vm_cost_trade.lo(i);
 oq21_trade_glo(t,k_trade,"lower")      = q21_trade_glo.lo(k_trade);
 oq21_notrade(t,h,k_notrade,"lower")    = q21_notrade.lo(h,k_notrade);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
