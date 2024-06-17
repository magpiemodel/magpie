*** |  (C) 2008-2024 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

*' @equations
*' In the comparative advantage pool, the main constraint is that the global supply is larger or equal to demand.
*' This means that production can be freely allocated globally based on comparative advantages.

 q21_trade_glo(k_trade)..
  sum(i2 ,vm_prod_reg(i2,k_trade)) =g=
  sum(i2, vm_supply(i2,k_trade)) + sum(ct,f21_trade_balanceflow(ct,k_trade));
  
*'
*' For non-tradable commodites, the superregional supply should be larger or equal to the superregional demand.
 q21_notrade(h2,k_notrade)..
  sum(supreg(h2,i2),vm_prod_reg(i2,k_notrade)) =g= sum(supreg(h2,i2), vm_supply(i2,k_notrade));

*'
*' The following equations define the production band.
*' The share of demand that has to be fulfilled through the self-sufficiency pool is
*' determined by a trade balance reduction factor for each commodity  `i21_trade_bal_reduction(ct,k_trade)`
*' [@schmitz_trading_2012]. If the trade balance reduction equals 1, all demand enters the self-sufficiency pool.
*' If it equals 0, all demand enters the comparative advantage pool.
*' Note that `m21_baseline_production` is a macro defined in core/macros.gms.

*' Lower bound for production.

 q21_trade_reg(h2,k_trade)..
 sum(supreg(h2,i2),vm_prod_reg(i2,k_trade)) =g=
  m21_baseline_production(vm_supply, v21_excess_prod, f21_self_suff)
  * sum(ct,i21_trade_bal_reduction(ct,k_trade))
  - v21_import_for_feasibility(h2,k_trade);

*' Upper bound for production.

 q21_trade_reg_up(h2,k_trade) ..
 sum(supreg(h2,i2),vm_prod_reg(i2,k_trade)) =l=
  m21_baseline_production(vm_supply, v21_excess_prod, f21_self_suff)
  / sum(ct,i21_trade_bal_reduction(ct,k_trade));

*' The global excess demand of each tradable good `v21_excess_demad` equals to
*' the sum over all the imports of importing superregions.

 q21_excess_dem(k_trade)..
 v21_excess_dem(k_trade) =g=
 sum(h2, sum(supreg(h2,i2),vm_supply(i2,k_trade))*(1 - sum(ct,f21_self_suff(ct,h2,k_trade)))
 $(sum(ct,f21_self_suff(ct,h2,k_trade)) < 1))
 + sum(ct,f21_trade_balanceflow(ct,k_trade)) + sum(h2, v21_import_for_feasibility(h2,k_trade));

*' Distributing the global excess demand to exporting superregions is based on export shares [@schmitz_trading_2012].
*' Export shares are derived from FAO data (see @schmitz_trading_2012 for details). They are 0 for importing superregions.

 q21_excess_supply(h2,k_trade)..
 v21_excess_prod(h2,k_trade) =e=
 v21_excess_dem(k_trade)*sum(ct,f21_exp_shr(ct,h2,k_trade));

* Trade costs are associated with exporting superregions. They are dependent on net exports, trade margin, and tariffs.

 q21_cost_trade_reg(h2,k_trade)..
 v21_cost_trade_reg(h2,k_trade) =g=
 (i21_trade_margin(h2,k_trade) + i21_trade_tariff(h2,k_trade))
 *sum(supreg(h2,i2), vm_prod_reg(i2,k_trade)-vm_supply(i2,k_trade)) 
 + v21_import_for_feasibility(h2,k_trade) * s21_cost_import;

* Superregional trade costs are the costs for each superregion aggregated over all the tradable commodities.

 q21_cost_trade(h2)..
 sum(supreg(h2,i2),vm_cost_trade(i2)) =e= sum(k_trade,v21_cost_trade_reg(h2,k_trade));
