*** |  (C) 2008-2020 Potsdam Institute for Climate Impact Research (PIK)
*** |  authors, and contributors see CITATION.cff file. This file is part
*** |  of MAgPIE and licensed under AGPL-3.0-or-later. Under Section 7 of
*** |  AGPL-3.0, you are granted additional permissions described in the
*** |  MAgPIE License Exception, version 1.0 (see LICENSE file).
*** |  Contact: magpie@pik-potsdam.de

 q21_notrade(i2,k).. vm_prod_reg(i2,k) =g= vm_supply(i2,k) + sum(ct,f21_trade_balance(ct,i2,k)) - v21_manna_from_heaven(i2,k);

*' The regional production must be bigger than the regional demand plus exports
*' from that region (or minus imports in case of a negative trade balance). As
*' the trade balance in this realization is exogenously defined there is the
*' imminent risk of infeasibilities. To get results even in case of infeasble
*' trade balance conditions `v21_manna_from_heaven` is introduced. It is an
*' unlimited, but heavily expensive resource which can be used as last resort,
*' if in any other case the model would become infeasible.

 q21_cost_trade(i2).. vm_cost_trade(i2) =e= 10**6 * sum(k,v21_manna_from_heaven(i2,k));

*' After each run trade costs `vm_cost_trade` as well as `v21_manna_from_heaven`
*' should be checked for non-zero values as these will indicate inconsistencies
*' between model simulation and exogenously provided trade balances.
