*** |  (C) 2008-2018 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see AUTHORS file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de


 q21_trade_glo(k_trade).. sum(i2 ,vm_prod_reg(i2,k_trade))
                  =g=
                  sum(i2, vm_supply(i2,k_trade))
                  + sum(ct,f21_trade_balanceflow(ct,k_trade));

 q21_notrade(i2,k_notrade)..    vm_prod_reg(i2,k_notrade)
                               =g=
                               vm_supply(i2,k_notrade);

 q21_trade_reg(i2,k_trade)..     vm_prod_reg(i2,k_trade)
                          =g=
                          (vm_supply(i2,k_trade) + v21_excess_prod(i2,k_trade))*sum(ct,i21_trade_bal_reduction(ct))$(sum(ct,f21_self_suff(ct,i2,k_trade) >= 1))
                          + vm_supply(i2,k_trade)*sum(ct,f21_self_suff(ct,i2,k_trade))*sum(ct,i21_trade_bal_reduction(ct))$(sum(ct,f21_self_suff(ct,i2,k_trade) < 1));

 q21_excess_dem(k_trade).. v21_excess_dem(k_trade)
                   =e=
                   sum(i2, vm_supply(i2,k_trade)*(1 - sum(ct,f21_self_suff(ct,i2,k_trade)))$(sum(ct,f21_self_suff(ct,i2,k_trade)) < 1))
                   + sum(ct,f21_trade_balanceflow(ct,k_trade));

 q21_excess_supply(i2,k_trade)..   v21_excess_prod(i2,k_trade)
                          =e=
                          v21_excess_dem(k_trade)*sum(ct,f21_exp_shr(ct,i2,k_trade));

 q21_cost_trade_reg(i2,k_trade)..  v21_cost_trade_reg(i2,k_trade)
                       =g=
                          (i21_trade_margin(i2,k_trade) + i21_trade_tariff(i2,k_trade))*(vm_prod_reg(i2,k_trade)-vm_supply(i2,k_trade));


 q21_cost_trade(i2)..          vm_cost_trade(i2) =e= sum(k_trade,v21_cost_trade_reg(i2,k_trade));