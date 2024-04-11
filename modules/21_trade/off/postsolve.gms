*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_trade(t,i,"marginal")     = vm_cost_trade.m(i);
 oq21_notrade(t,h,kall,"marginal") = q21_notrade.m(h,kall);
 ov_cost_trade(t,i,"level")        = vm_cost_trade.l(i);
 oq21_notrade(t,h,kall,"level")    = q21_notrade.l(h,kall);
 ov_cost_trade(t,i,"upper")        = vm_cost_trade.up(i);
 oq21_notrade(t,h,kall,"upper")    = q21_notrade.up(h,kall);
 ov_cost_trade(t,i,"lower")        = vm_cost_trade.lo(i);
 oq21_notrade(t,h,kall,"lower")    = q21_notrade.lo(h,kall);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
