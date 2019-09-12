*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_trade(t,i,"marginal")                    = vm_cost_trade.m(i);
 ov_prod_future_reg_ff(t,i,kforestry,"marginal")  = vm_prod_future_reg_ff.m(i,kforestry);
 ov21_excess_prod_ff(t,i,kforestry,"marginal")    = v21_excess_prod_ff.m(i,kforestry);
 ov21_excess_dem_ff(t,kforestry,"marginal")       = v21_excess_dem_ff.m(kforestry);
 ov21_excess_prod_ff(t,i,kforestry,"marginal")    = v21_excess_prod_ff.m(i,kforestry);
 ov21_cost_trade_reg_ff(t,i,kforestry,"marginal") = v21_cost_trade_reg_ff.m(i,kforestry);
 ov_cost_trade_forestry_ff(t,i,"marginal")        = vm_cost_trade_forestry_ff.m(i);
 oq21_trade_glo(t,k_trade,"marginal")             = q21_trade_glo.m(k_trade);
 oq21_notrade(t,i,k_notrade,"marginal")           = q21_notrade.m(i,k_notrade);
 ov_cost_trade(t,i,"level")                       = vm_cost_trade.l(i);
 ov_prod_future_reg_ff(t,i,kforestry,"level")     = vm_prod_future_reg_ff.l(i,kforestry);
 ov21_excess_prod_ff(t,i,kforestry,"level")       = v21_excess_prod_ff.l(i,kforestry);
 ov21_excess_dem_ff(t,kforestry,"level")          = v21_excess_dem_ff.l(kforestry);
 ov21_excess_prod_ff(t,i,kforestry,"level")       = v21_excess_prod_ff.l(i,kforestry);
 ov21_cost_trade_reg_ff(t,i,kforestry,"level")    = v21_cost_trade_reg_ff.l(i,kforestry);
 ov_cost_trade_forestry_ff(t,i,"level")           = vm_cost_trade_forestry_ff.l(i);
 oq21_trade_glo(t,k_trade,"level")                = q21_trade_glo.l(k_trade);
 oq21_notrade(t,i,k_notrade,"level")              = q21_notrade.l(i,k_notrade);
 ov_cost_trade(t,i,"upper")                       = vm_cost_trade.up(i);
 ov_prod_future_reg_ff(t,i,kforestry,"upper")     = vm_prod_future_reg_ff.up(i,kforestry);
 ov21_excess_prod_ff(t,i,kforestry,"upper")       = v21_excess_prod_ff.up(i,kforestry);
 ov21_excess_dem_ff(t,kforestry,"upper")          = v21_excess_dem_ff.up(kforestry);
 ov21_excess_prod_ff(t,i,kforestry,"upper")       = v21_excess_prod_ff.up(i,kforestry);
 ov21_cost_trade_reg_ff(t,i,kforestry,"upper")    = v21_cost_trade_reg_ff.up(i,kforestry);
 ov_cost_trade_forestry_ff(t,i,"upper")           = vm_cost_trade_forestry_ff.up(i);
 oq21_trade_glo(t,k_trade,"upper")                = q21_trade_glo.up(k_trade);
 oq21_notrade(t,i,k_notrade,"upper")              = q21_notrade.up(i,k_notrade);
 ov_cost_trade(t,i,"lower")                       = vm_cost_trade.lo(i);
 ov_prod_future_reg_ff(t,i,kforestry,"lower")     = vm_prod_future_reg_ff.lo(i,kforestry);
 ov21_excess_prod_ff(t,i,kforestry,"lower")       = v21_excess_prod_ff.lo(i,kforestry);
 ov21_excess_dem_ff(t,kforestry,"lower")          = v21_excess_dem_ff.lo(kforestry);
 ov21_excess_prod_ff(t,i,kforestry,"lower")       = v21_excess_prod_ff.lo(i,kforestry);
 ov21_cost_trade_reg_ff(t,i,kforestry,"lower")    = v21_cost_trade_reg_ff.lo(i,kforestry);
 ov_cost_trade_forestry_ff(t,i,"lower")           = vm_cost_trade_forestry_ff.lo(i);
 oq21_trade_glo(t,k_trade,"lower")                = q21_trade_glo.lo(k_trade);
 oq21_notrade(t,i,k_notrade,"lower")              = q21_notrade.lo(i,k_notrade);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
