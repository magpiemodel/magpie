*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_trade(t,i,"marginal")               = vm_cost_trade.m(i);
 ov21_manna_from_heaven(t,i,kall,"marginal") = v21_manna_from_heaven.m(i,kall);
 oq21_notrade(t,i,kall,"marginal")           = q21_notrade.m(i,kall);
 oq21_cost_trade(t,i,"marginal")             = q21_cost_trade.m(i);
 ov_cost_trade(t,i,"level")                  = vm_cost_trade.l(i);
 ov21_manna_from_heaven(t,i,kall,"level")    = v21_manna_from_heaven.l(i,kall);
 oq21_notrade(t,i,kall,"level")              = q21_notrade.l(i,kall);
 oq21_cost_trade(t,i,"level")                = q21_cost_trade.l(i);
 ov_cost_trade(t,i,"upper")                  = vm_cost_trade.up(i);
 ov21_manna_from_heaven(t,i,kall,"upper")    = v21_manna_from_heaven.up(i,kall);
 oq21_notrade(t,i,kall,"upper")              = q21_notrade.up(i,kall);
 oq21_cost_trade(t,i,"upper")                = q21_cost_trade.up(i);
 ov_cost_trade(t,i,"lower")                  = vm_cost_trade.lo(i);
 ov21_manna_from_heaven(t,i,kall,"lower")    = v21_manna_from_heaven.lo(i,kall);
 oq21_notrade(t,i,kall,"lower")              = q21_notrade.lo(i,kall);
 oq21_cost_trade(t,i,"lower")                = q21_cost_trade.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
