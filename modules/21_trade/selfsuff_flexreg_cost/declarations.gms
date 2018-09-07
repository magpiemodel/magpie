*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

parameters
 i21_trade_bal_reduction(t)                          trade balance reduction (1)
 i21_trade_bal_reduction_annual(t_all)        annual trade balance reduction (1)
 i21_trade_margin(i,k_trade)                    trade margins
 i21_trade_tariff(i,k_trade)                    trade tariffs
;

positive variables
 v21_excess_dem(k_trade)                 global excess demand (mio. tDM)
 v21_excess_prod(i,k_trade)              regional excess production (mio. tDM)
 vm_cost_trade(i)                        transport costs and taxes for the bilateral trade (Mio USD)
 v21_cost_trade_reg(i,k_trade)           interregional trade costs (mio. USD)
;

equations
 q21_trade_glo(k_trade)                  Global production > demand constraint
 q21_notrade(i,k_notrade)                fix of not traded commodities
 q21_trade_reg(i,k_trade)                regional trade balances i.e. minimum self-suff ratio
 q21_excess_dem(k_trade)                 global excess demand
 q21_excess_supply(i,k_trade)            regional excess production
 q21_cost_trade(i)                       trade costs
 q21_cost_trade_reg(i,k_trade)           interregional trade cost calculation (mio. USD)
;

*#################### R SECTION START (OUTPUT DECLARATIONS) ####################
parameters
 ov21_excess_dem(t,k_trade,type)       global excess demand (mio. tDM)
 ov21_excess_prod(t,i,k_trade,type)    regional excess production (mio. tDM)
 ov_cost_trade(t,i,type)               transport costs and taxes for the bilateral trade (Mio USD)
 ov21_cost_trade_reg(t,i,k_trade,type) interregional trade costs (mio. USD)
 oq21_trade_glo(t,k_trade,type)        Global production > demand constraint
 oq21_notrade(t,i,k_notrade,type)      fix of not traded commodities
 oq21_trade_reg(t,i,k_trade,type)      regional trade balances i.e. minimum self-suff ratio
 oq21_excess_dem(t,k_trade,type)       global excess demand
 oq21_excess_supply(t,i,k_trade,type)  regional excess production
 oq21_cost_trade(t,i,type)             trade costs
 oq21_cost_trade_reg(t,i,k_trade,type) interregional trade cost calculation (mio. USD)
;
*##################### R SECTION END (OUTPUT DECLARATIONS) #####################
