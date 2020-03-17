*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov21_excess_dem(t,k_trade,"marginal")            = v21_excess_dem.m(k_trade);
 ov21_excess_prod(t,i,k_trade,"marginal")         = v21_excess_prod.m(i,k_trade);
 ov_cost_trade(t,i,"marginal")                    = vm_cost_trade.m(i);
 ov21_cost_trade_reg(t,i,k_trade,"marginal")      = v21_cost_trade_reg.m(i,k_trade);
 ov21_cost_supply_missing(t,i,k_trade,"marginal") = v21_cost_supply_missing.m(i,k_trade);
 ov21_cost_export(t,i,k_trade,"marginal")         = v21_cost_export.m(i,k_trade);
 ov21_supply_missing(t,i,k_trade,"marginal")      = v21_supply_missing.m(i,k_trade);
 oq21_trade_glo(t,k_trade,"marginal")             = q21_trade_glo.m(k_trade);
 oq21_notrade(t,i,k_notrade,"marginal")           = q21_notrade.m(i,k_notrade);
 oq21_trade_reg(t,i,k_trade,"marginal")           = q21_trade_reg.m(i,k_trade);
 oq21_trade_reg_up(t,i,k_trade,"marginal")        = q21_trade_reg_up.m(i,k_trade);
 oq21_excess_dem(t,k_trade,"marginal")            = q21_excess_dem.m(k_trade);
 oq21_excess_supply(t,i,k_trade,"marginal")       = q21_excess_supply.m(i,k_trade);
 oq21_cost_trade(t,i,"marginal")                  = q21_cost_trade.m(i);
 oq21_cost_trade_reg(t,i,k_trade,"marginal")      = q21_cost_trade_reg.m(i,k_trade);
 oq21_trade_balance(t,k_trade,"marginal")         = q21_trade_balance.m(k_trade);
 oq21_cost_supply_missing(t,i,k_trade,"marginal") = q21_cost_supply_missing.m(i,k_trade);
 ov21_excess_dem(t,k_trade,"level")               = v21_excess_dem.l(k_trade);
 ov21_excess_prod(t,i,k_trade,"level")            = v21_excess_prod.l(i,k_trade);
 ov_cost_trade(t,i,"level")                       = vm_cost_trade.l(i);
 ov21_cost_trade_reg(t,i,k_trade,"level")         = v21_cost_trade_reg.l(i,k_trade);
 ov21_cost_supply_missing(t,i,k_trade,"level")    = v21_cost_supply_missing.l(i,k_trade);
 ov21_cost_export(t,i,k_trade,"level")            = v21_cost_export.l(i,k_trade);
 ov21_supply_missing(t,i,k_trade,"level")         = v21_supply_missing.l(i,k_trade);
 oq21_trade_glo(t,k_trade,"level")                = q21_trade_glo.l(k_trade);
 oq21_notrade(t,i,k_notrade,"level")              = q21_notrade.l(i,k_notrade);
 oq21_trade_reg(t,i,k_trade,"level")              = q21_trade_reg.l(i,k_trade);
 oq21_trade_reg_up(t,i,k_trade,"level")           = q21_trade_reg_up.l(i,k_trade);
 oq21_excess_dem(t,k_trade,"level")               = q21_excess_dem.l(k_trade);
 oq21_excess_supply(t,i,k_trade,"level")          = q21_excess_supply.l(i,k_trade);
 oq21_cost_trade(t,i,"level")                     = q21_cost_trade.l(i);
 oq21_cost_trade_reg(t,i,k_trade,"level")         = q21_cost_trade_reg.l(i,k_trade);
 oq21_trade_balance(t,k_trade,"level")            = q21_trade_balance.l(k_trade);
 oq21_cost_supply_missing(t,i,k_trade,"level")    = q21_cost_supply_missing.l(i,k_trade);
 ov21_excess_dem(t,k_trade,"upper")               = v21_excess_dem.up(k_trade);
 ov21_excess_prod(t,i,k_trade,"upper")            = v21_excess_prod.up(i,k_trade);
 ov_cost_trade(t,i,"upper")                       = vm_cost_trade.up(i);
 ov21_cost_trade_reg(t,i,k_trade,"upper")         = v21_cost_trade_reg.up(i,k_trade);
 ov21_cost_supply_missing(t,i,k_trade,"upper")    = v21_cost_supply_missing.up(i,k_trade);
 ov21_cost_export(t,i,k_trade,"upper")            = v21_cost_export.up(i,k_trade);
 ov21_supply_missing(t,i,k_trade,"upper")         = v21_supply_missing.up(i,k_trade);
 oq21_trade_glo(t,k_trade,"upper")                = q21_trade_glo.up(k_trade);
 oq21_notrade(t,i,k_notrade,"upper")              = q21_notrade.up(i,k_notrade);
 oq21_trade_reg(t,i,k_trade,"upper")              = q21_trade_reg.up(i,k_trade);
 oq21_trade_reg_up(t,i,k_trade,"upper")           = q21_trade_reg_up.up(i,k_trade);
 oq21_excess_dem(t,k_trade,"upper")               = q21_excess_dem.up(k_trade);
 oq21_excess_supply(t,i,k_trade,"upper")          = q21_excess_supply.up(i,k_trade);
 oq21_cost_trade(t,i,"upper")                     = q21_cost_trade.up(i);
 oq21_cost_trade_reg(t,i,k_trade,"upper")         = q21_cost_trade_reg.up(i,k_trade);
 oq21_trade_balance(t,k_trade,"upper")            = q21_trade_balance.up(k_trade);
 oq21_cost_supply_missing(t,i,k_trade,"upper")    = q21_cost_supply_missing.up(i,k_trade);
 ov21_excess_dem(t,k_trade,"lower")               = v21_excess_dem.lo(k_trade);
 ov21_excess_prod(t,i,k_trade,"lower")            = v21_excess_prod.lo(i,k_trade);
 ov_cost_trade(t,i,"lower")                       = vm_cost_trade.lo(i);
 ov21_cost_trade_reg(t,i,k_trade,"lower")         = v21_cost_trade_reg.lo(i,k_trade);
 ov21_cost_supply_missing(t,i,k_trade,"lower")    = v21_cost_supply_missing.lo(i,k_trade);
 ov21_cost_export(t,i,k_trade,"lower")            = v21_cost_export.lo(i,k_trade);
 ov21_supply_missing(t,i,k_trade,"lower")         = v21_supply_missing.lo(i,k_trade);
 oq21_trade_glo(t,k_trade,"lower")                = q21_trade_glo.lo(k_trade);
 oq21_notrade(t,i,k_notrade,"lower")              = q21_notrade.lo(i,k_notrade);
 oq21_trade_reg(t,i,k_trade,"lower")              = q21_trade_reg.lo(i,k_trade);
 oq21_trade_reg_up(t,i,k_trade,"lower")           = q21_trade_reg_up.lo(i,k_trade);
 oq21_excess_dem(t,k_trade,"lower")               = q21_excess_dem.lo(k_trade);
 oq21_excess_supply(t,i,k_trade,"lower")          = q21_excess_supply.lo(i,k_trade);
 oq21_cost_trade(t,i,"lower")                     = q21_cost_trade.lo(i);
 oq21_cost_trade_reg(t,i,k_trade,"lower")         = q21_cost_trade_reg.lo(i,k_trade);
 oq21_trade_balance(t,k_trade,"lower")            = q21_trade_balance.lo(k_trade);
 oq21_cost_supply_missing(t,i,k_trade,"lower")    = q21_cost_supply_missing.lo(i,k_trade);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
