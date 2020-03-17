*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_trade(t,i,"marginal")            = vm_cost_trade.m(i);
 ov21_manna_from_heaven(t,i,k,"marginal") = v21_manna_from_heaven.m(i,k);
 oq21_notrade(t,i,k,"marginal")           = q21_notrade.m(i,k);
 oq21_cost_trade(t,i,"marginal")          = q21_cost_trade.m(i);
 ov_cost_trade(t,i,"level")               = vm_cost_trade.l(i);
 ov21_manna_from_heaven(t,i,k,"level")    = v21_manna_from_heaven.l(i,k);
 oq21_notrade(t,i,k,"level")              = q21_notrade.l(i,k);
 oq21_cost_trade(t,i,"level")             = q21_cost_trade.l(i);
 ov_cost_trade(t,i,"upper")               = vm_cost_trade.up(i);
 ov21_manna_from_heaven(t,i,k,"upper")    = v21_manna_from_heaven.up(i,k);
 oq21_notrade(t,i,k,"upper")              = q21_notrade.up(i,k);
 oq21_cost_trade(t,i,"upper")             = q21_cost_trade.up(i);
 ov_cost_trade(t,i,"lower")               = vm_cost_trade.lo(i);
 ov21_manna_from_heaven(t,i,k,"lower")    = v21_manna_from_heaven.lo(i,k);
 oq21_notrade(t,i,k,"lower")              = q21_notrade.lo(i,k);
 oq21_cost_trade(t,i,"lower")             = q21_cost_trade.lo(i);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
