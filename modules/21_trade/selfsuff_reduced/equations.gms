*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' In the comparative advantage pool, the only active constraint is that the global supply is larger or equal to demand.
*' This means that production can be freely allocated globally based on comparative advantages.

 q21_trade_glo(k_trade)..
  sum(i2 ,vm_prod_reg(i2,k_trade)) =g=
  sum(i2, vm_supply(i2,k_trade)) + sum(ct,f21_trade_balanceflow(ct,k_trade));
*'
*' For non-tradable commodites, the regional supply should be larger or equal to the regional demand.
 q21_notrade(i2,k_notrade)..
  vm_prod_reg(i2,k_notrade) =g= vm_supply(i2,k_notrade);

*' The following equation indicates the regional trade constraint for the self-sufficiency pool.
*' The share of regional demand that has to be fulfilled through the self-sufficiency pool is
*' determined by a trade balance reduction factor for each commodity  `i21_trade_bal_reduction(ct,k_trade)`
*' according to the following equations [@schmitz_trading_2012].
*' If the trade balance reduction equals 1 (`f21_self_suff(ct,i2,k_trade) = 1`), all demand enters the self-sufficiency pool.
*' If it equals 0, all demand enters the comparative advantage pool.


 q21_trade_reg(i2,k_trade)..
 vm_prod_reg(i2,k_trade) =g=
 (vm_supply(i2,k_trade) + v21_excess_prod(i2,k_trade))
 *sum(ct,i21_trade_bal_reduction(ct,k_trade))
 $(sum(ct,f21_self_suff(ct,i2,k_trade) >= 1))
 + vm_supply(i2,k_trade)*sum(ct,f21_self_suff(ct,i2,k_trade))
 *sum(ct,i21_trade_bal_reduction(ct,k_trade))
 $(sum(ct,f21_self_suff(ct,i2,k_trade) < 1));



 q21_trade_reg_up(i2,k_trade)..
 vm_prod_reg(i2,k_trade) =l=
 ((vm_supply(i2,k_trade) + v21_excess_prod(i2,k_trade))/sum(ct,i21_trade_bal_reduction(ct,k_trade)))
 $(sum(ct,f21_self_suff(ct,i2,k_trade) >= 1))
 + (vm_supply(i2,k_trade)*sum(ct,f21_self_suff(ct,i2,k_trade))/sum(ct,i21_trade_bal_reduction(ct,k_trade)))
 $(sum(ct,f21_self_suff(ct,i2,k_trade) < 1));

*' The global excess demand of each tradable good `v21_excess_demad` equals to
*' the sum over all the imports of importing regions.

 q21_excess_dem(k_trade)..
 v21_excess_dem(k_trade) =g=
 sum(i2, vm_supply(i2,k_trade)*(1 - sum(ct,f21_self_suff(ct,i2,k_trade)))
 $(sum(ct,f21_self_suff(ct,i2,k_trade)) < 1))
 + sum(ct,f21_trade_balanceflow(ct,k_trade));

*' Distributing the global excess demand to exporting regions is based on regional export shares [@schmitz_trading_2012].
*' Export shares are derived from FAO data (see @schmitz_trading_2012 for details). They are 0 for importing regions.

 q21_excess_supply(i2,k_trade)..
 v21_excess_prod(i2,k_trade) =e=
 v21_excess_dem(k_trade)*sum(ct,f21_exp_shr(ct,i2,k_trade));

* Trade costs are associated with exporting regions. They are dependent on net exports, trade margin, and tariffs.
 q21_cost_trade_reg(i2,k_trade)..
 v21_cost_trade_reg(i2,k_trade) =g=
 (i21_trade_margin(i2,k_trade) + i21_trade_tariff(i2,k_trade))
 *(vm_prod_reg(i2,k_trade)-vm_supply(i2,k_trade));

* Regional trade costs are the costs for each region aggregated over all the tradable commodities.
 q21_cost_trade(i2)..
 vm_cost_trade(i2) =e= sum(k_trade,v21_cost_trade_reg(i2,k_trade));
