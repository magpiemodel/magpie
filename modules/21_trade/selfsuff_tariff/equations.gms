*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @equations

*' Domestic supply is production minus exports

 q21_trade(i2,k_trade)..   vm_prod_reg(i2,k_trade)
                           - v21_export(i2,k_trade)
                           + v21_import(i2,k_trade)
                           =e=
                           vm_supply(i2,k_trade);

*' Exports have to equal imports. To meet FAO, a balanceflow is introduced
*' which accounts for mismatch of global imports and exports - this can happen
*' in reality for example because more ships leave harbours in a year than
*' ships arrive if the trade volumen increases.
*' We also used a greater than to allow the model a bit more flexibility.
*' It should however not be attractive to export more than it imports.

 q21_trade_glo(k_trade)..
                  sum(i2 , v21_export(i2,k_trade))
                  =g=
                  sum(i2, v21_import(i2,k_trade))
                  + sum(ct,f21_trade_balanceflow(ct,k_trade));

* some products are not traded.

 q21_notrade(i2,k_notrade)..
                   vm_prod_reg(i2,k_notrade)
                   =g=
                   vm_supply(i2,k_notrade);

*' Production for importing countries has to be larger than the historical
*' self sufficiency multiplied by a scenario reduction factor accounting
*' for liberal trade.
*' Production of exporting countries has to settle excess production (see below)
*' multiplied by a scenario reduction factor accounting for liberal trade.

 q21_trade_reg(i2,k_trade)..
                  vm_prod_reg(i2,k_trade)
                  =g=
                  (vm_supply(i2,k_trade) + v21_excess_prod(i2,k_trade))
                  *sum(ct,i21_trade_bal_reduction(ct))$(sum(ct,f21_self_suff(ct,i2,k_trade) >= 1))
                  +
                  vm_supply(i2,k_trade)*sum(ct,f21_self_suff(ct,i2,k_trade))
                  *sum(ct,i21_trade_bal_reduction(ct))$(sum(ct,f21_self_suff(ct,i2,k_trade) < 1));

*' Excess demand is the sum of all imports from net-importing countries

 q21_excess_dem(k_trade).. v21_excess_dem(k_trade)
                   =g=
                   sum(i2, vm_supply(i2,k_trade)
                   *(1 - sum(ct,f21_self_suff(ct,i2,k_trade)))$(sum(ct,f21_self_suff(ct,i2,k_trade)) < 1))
                   +
                   sum(ct,f21_trade_balanceflow(ct,k_trade));

*' Excess production is distributing the excess demand to historical exporting
*' countries according to their historical share within global total exports.

 q21_excess_supply(i2,k_trade)..
                  v21_excess_prod(i2,k_trade)
                  =e=
                  v21_excess_dem(k_trade)*sum(ct,f21_exp_shr(ct,i2,k_trade));

*' Trade costs consist of a trade margin (transport costs etc)
*' export tariffs and import tariffs.
*' Tariffs only apply to net-trade, as countries with export-subsidies
*' otherwhise buy their own stuff

 q21_cost_trade(i2)..
                  vm_cost_trade(i2)
                  =e=
                  sum(k_trade,
                     f21_trade_margin(i2,k_trade) * v21_export(i2,k_trade)
                     + f21_tariff_export(i2,k_trade) * s21_trade_tariff * (v21_export(i2,k_trade)-v21_import(i2,k_trade))
                     + f21_tariff_import(i2,k_trade) * s21_trade_tariff * (v21_import(i2,k_trade)-v21_export(i2,k_trade))
                  );
