*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de


*#################### R SECTION START (OUTPUT DEFINITIONS) #####################
 ov_cost_trade(t,i,"marginal")                     = vm_cost_trade.m(i);
 ov21_prod_future_reg_ff(t,i,kforestry,"marginal") = v21_prod_future_reg_ff.m(i,kforestry);
 ov21_excess_prod_ff(t,i,kforestry,"marginal")     = v21_excess_prod_ff.m(i,kforestry);
 ov21_excess_dem_ff(t,kforestry,"marginal")        = v21_excess_dem_ff.m(kforestry);
 ov21_excess_prod_ff(t,i,kforestry,"marginal")     = v21_excess_prod_ff.m(i,kforestry);
 ov21_cost_trade_reg_ff(t,i,kforestry,"marginal")  = v21_cost_trade_reg_ff.m(i,kforestry);
 ov21_cost_trade_forestry_ff(t,i,"marginal")       = v21_cost_trade_forestry_ff.m(i);
 oq21_notrade(t,i,k,"marginal")                    = q21_notrade.m(i,k);
 ov_cost_trade(t,i,"level")                        = vm_cost_trade.l(i);
 ov21_prod_future_reg_ff(t,i,kforestry,"level")    = v21_prod_future_reg_ff.l(i,kforestry);
 ov21_excess_prod_ff(t,i,kforestry,"level")        = v21_excess_prod_ff.l(i,kforestry);
 ov21_excess_dem_ff(t,kforestry,"level")           = v21_excess_dem_ff.l(kforestry);
 ov21_excess_prod_ff(t,i,kforestry,"level")        = v21_excess_prod_ff.l(i,kforestry);
 ov21_cost_trade_reg_ff(t,i,kforestry,"level")     = v21_cost_trade_reg_ff.l(i,kforestry);
 ov21_cost_trade_forestry_ff(t,i,"level")          = v21_cost_trade_forestry_ff.l(i);
 oq21_notrade(t,i,k,"level")                       = q21_notrade.l(i,k);
 ov_cost_trade(t,i,"upper")                        = vm_cost_trade.up(i);
 ov21_prod_future_reg_ff(t,i,kforestry,"upper")    = v21_prod_future_reg_ff.up(i,kforestry);
 ov21_excess_prod_ff(t,i,kforestry,"upper")        = v21_excess_prod_ff.up(i,kforestry);
 ov21_excess_dem_ff(t,kforestry,"upper")           = v21_excess_dem_ff.up(kforestry);
 ov21_excess_prod_ff(t,i,kforestry,"upper")        = v21_excess_prod_ff.up(i,kforestry);
 ov21_cost_trade_reg_ff(t,i,kforestry,"upper")     = v21_cost_trade_reg_ff.up(i,kforestry);
 ov21_cost_trade_forestry_ff(t,i,"upper")          = v21_cost_trade_forestry_ff.up(i);
 oq21_notrade(t,i,k,"upper")                       = q21_notrade.up(i,k);
 ov_cost_trade(t,i,"lower")                        = vm_cost_trade.lo(i);
 ov21_prod_future_reg_ff(t,i,kforestry,"lower")    = v21_prod_future_reg_ff.lo(i,kforestry);
 ov21_excess_prod_ff(t,i,kforestry,"lower")        = v21_excess_prod_ff.lo(i,kforestry);
 ov21_excess_dem_ff(t,kforestry,"lower")           = v21_excess_dem_ff.lo(kforestry);
 ov21_excess_prod_ff(t,i,kforestry,"lower")        = v21_excess_prod_ff.lo(i,kforestry);
 ov21_cost_trade_reg_ff(t,i,kforestry,"lower")     = v21_cost_trade_reg_ff.lo(i,kforestry);
 ov21_cost_trade_forestry_ff(t,i,"lower")          = v21_cost_trade_forestry_ff.lo(i);
 oq21_notrade(t,i,k,"lower")                       = q21_notrade.lo(i,k);
*##################### R SECTION END (OUTPUT DEFINITIONS) ######################
